package com.dncrm.controller.system.workflow;

import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.dncrm.common.WorkFlow;
import com.dncrm.entity.system.Menu;
import com.dncrm.entity.system.Role;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.service.system.workflow.TaskAssignService;
import com.dncrm.service.system.workflow.WorkflowTraceService;
import com.dncrm.util.RightsHelper;
import com.dncrm.util.Tools;
import net.sf.json.JSONArray;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.history.HistoricDetail;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.UserQuery;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.activiti.engine.impl.persistence.entity.MembershipEntity;
import org.activiti.engine.impl.persistence.entity.UserEntity;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.apache.commons.collections.map.HashedMap;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.workflow.WorkFlowService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;

import net.sf.json.JSONObject;

@RequestMapping("/workflow")
@Controller
public class WorkFlowController extends BaseController {
    @Resource(name = "workFlowService")
    private WorkFlowService workFlowService;

    @Resource(name = "workflowTraceService")
    private WorkflowTraceService workflowTraceService;

    @Resource(name = "taskAssignService")
    private TaskAssignService taskAssignService;

    @Resource(name = "sysUserService")
    private com.dncrm.service.system.sysUser.sysUserService sysUserService;


    /**
     * 显示流程定义列表
     *
     * @return
     */
    @RequestMapping("/listWorkFlows")
    public ModelAndView listWorkFlows(Page page) {
        ModelAndView mv = this.getModelAndView();
        try {
            PageData pd = this.getPageData();
            page.setPd(pd);
            List<ProcessDefinition> processDefinitions= workFlowService.listProcessDefinitions(page);
            mv.setViewName("system/workflow/workflow_list");
            mv.addObject("processDefinitions", processDefinitions);
            mv.addObject("pd", pd);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**
     * 删除deployment一条数据
     *
     */
    @RequestMapping("/delDeployment")
    @ResponseBody
    public Object delDeployment() {
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        try {
            String deploymentId = (String)pd.get("deploymentId");
            if (!StringUtils.isEmpty(deploymentId)) {
            	boolean isDeleted = workFlowService.deleteDeploymentById(deploymentId);;
            	if (isDeleted) {
            		map.put("msg", "success");
				}else{
					 map.put("msg", "failed");
					 map.put("err", "删除失败");
				}
			}else{
				 map.put("msg", "failed");
				 map.put("err", "无法获取部署ID");
			}
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "删除失败");
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 批量删除已部署流程
     */
    @RequestMapping(value = "/delAllDeployment")
    @ResponseBody
    public Object delAllDeployment() {
        logBefore(logger, "批量删除Articles");
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            pd = this.getPageData();
            List<PageData> pdList = new ArrayList<PageData>();
            String deployment_ids = pd.getString("deployment_ids");
            if (!StringUtils.isEmpty(deployment_ids)) {
                String ArrayDATA_IDS[] = deployment_ids.split(",");
                String successIds = "";
                String failedIds = "";
                for (int i = 0; i < ArrayDATA_IDS.length; i++) {
                	boolean isDeleted = workFlowService.deleteDeploymentById(ArrayDATA_IDS[i]);
                	if (isDeleted) {//成功删除一条记录
						if (successIds=="") {
							successIds=ArrayDATA_IDS[i];
						}else{
							successIds=successIds+","+ArrayDATA_IDS[i];
						}
					}else{//删除一条记录失败
						if (failedIds=="") {
							failedIds=ArrayDATA_IDS[i];
						}else{
							failedIds=failedIds+","+ArrayDATA_IDS[i];
						}
					}
				}
                if (successIds!="") {
                	if (failedIds!="") {//部分删除成功
                		map.put("msg", "partSuccess");
                		map.put("successIds", successIds);
						map.put("failedIds", failedIds);
					}else{//全部删除成功
						map.put("msg", "success");
					}
				}else{
					map.put("msg", "failed");
					map.put("err", "删除失败");
				}
            } else {
            	map.put("msg", "failed");
				map.put("err", "删除失败");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 显示部署流程列表
     *
     * @return
     */
    @RequestMapping("/listDeploymment")
    public ModelAndView listDeploymment(Page page) {
        ModelAndView mv = this.getModelAndView();
        try {
            PageData pd = this.getPageData();
            page.setPd(pd);
            List<Deployment> deployments= workFlowService.listDeployment(page);
            mv.setViewName("system/workflow/deployment_list");
            mv.addObject("deployments", deployments);
            mv.addObject("pd", pd);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**
     * 显示流程实例列表
     *
     * @return
     */
    @RequestMapping("/listProcessInstance")
    public ModelAndView listProcessInstance(Page page) {
        ModelAndView mv = this.getModelAndView();
        try {
            PageData pd = this.getPageData();
            page.setPd(pd);
            List<ProcessInstance> processInstances= workFlowService.listProcessInstance(page);

            mv.setViewName("system/workflow/processInstance_list");
            mv.addObject("processInstances", processInstances);
            mv.addObject("pd", pd);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /***
     * 跳转到部署流程页面
     * 
     */
    @RequestMapping("/goDeployWorkFlow")
    public ModelAndView goDeployWorkFlow() throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("system/workflow/deployment_edit");
        return mv;
    }
    /**
     * 部署流程 with zip
     *
     * @return
     */
    @RequestMapping("/deployWorkFlowWithZip")
    public ModelAndView deployWorkFlowWithZip(
    		@RequestParam(value = "delployFile") MultipartFile file,
            @RequestParam(value = "delployName") String deployName) {
        ModelAndView mv = this.getModelAndView();
        try {
            Deployment deployment = workFlowService.deployActivitiWithZip(deployName, file);
            if (deployment==null) {
            	mv.addObject("msg", "failed");
			}else{
				 mv.addObject("msg", "success");
			}
        } catch (Exception e) {
        	mv.addObject("msg", "failed");
            logger.error(e.toString(), e);
        }
        mv.addObject("id", "deployWorkFlow");
        mv.addObject("form", "workflowForm1");
        mv.setViewName("save_result");
        return mv;
    }
    /**
     * 部署流程 with path
     *
     * @return
     */
    @RequestMapping("/deployWorkFlowWithPath")
    public ModelAndView deployWorkFlowWithPath() {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        try {
        	
            Deployment deployment = workFlowService.deployActivitiWithClassPath(pd.getString("name"), pd.getString("bpmnPath"), pd.getString("pngPath"));
            if (deployment==null) {
            	mv.addObject("msg", "failed");
			}else{
				 mv.addObject("msg", "success");
			}
        } catch (Exception e) {
        	mv.addObject("msg", "failed");
            logger.error(e.toString(), e);
        }
        mv.addObject("id", "deployWorkFlow");
        mv.addObject("form", "workflowForm2");
        mv.setViewName("save_result");
        return mv;
    }
    /**
     * 启动流程
     *
     */
    @RequestMapping("/startDeployment")
    @ResponseBody
    public Object startDeployment() {
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        try {
            String deploymentId = (String)pd.get("deploymentId");
            if (!StringUtils.isEmpty(deploymentId)) {
            	ProcessInstance processInstance = workFlowService.startProcessInstanceWithDeploymentId(deploymentId);
            	if (processInstance!=null) {
            		map.put("msg", "success");
            		map.put("processInstanceId", processInstance.getId());
				}else{
					 map.put("msg", "failed");
					 map.put("err", "启动失败");
				}
			}else{
				 map.put("msg", "failed");
				 map.put("err", "无法获取部署ID");
			}
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "启动失败");
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 查看流程定义图片
     *
     * @return
     */
    @RequestMapping("/viewDiagram")
    public ModelAndView viewDiagram(String path) {
        ModelAndView mv = this.getModelAndView();
        try {
//            PageData pd = this.getPageData();
//            page.setPd(pd);
//            List<ProcessDefinition> processDefinitions= workFlowService.listProcessDefinitions(page);
//            mv.setViewName("system/workflow/workflow_list");
//            mv.addObject("processDefinitions", processDefinitions);
//            mv.addObject("pd", pd);
//            mv.addObject("page",page);
//            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 通过流程ID,读取资源
     *
     */
    @RequestMapping("/getProcessResourceWithPid")
    public void getProcessResourceWithPid(@RequestParam("type") String resourceType, @RequestParam("pid") String processInstanceId, HttpServletResponse response) {
        try {
            if (!StringUtils.isEmpty(processInstanceId)) {
                WorkFlow workFlow = new WorkFlow();
                //根据id获取流程实例
                ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                //根据流程实例id获取流程定义
                ProcessDefinition processDefinition = workFlow.getRepositoryService().createProcessDefinitionQuery().processDefinitionId(processInstance.getProcessDefinitionId()).singleResult();

                String resourceNmae = "";
                if (resourceType.equals("image")){
                    resourceNmae = processDefinition.getDiagramResourceName();
                }else if(resourceType.equals("xml")){
                    resourceNmae = processDefinition.getResourceName();
                }
                InputStream resourceAsStream = null;
                resourceAsStream = workFlow.getRepositoryService().getResourceAsStream(processDefinition.getDeploymentId(),resourceNmae);
                byte[] b = new byte[1024];
                int len = -1;
                while ((len=resourceAsStream.read(b,0,1024))!=-1){
                    response.getOutputStream().write(b,0,len);
                }
            }else{
                logger.error("获取流程资源失败:pid为空");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }
    /**
     * 通过流程定义ID,读取资源
     *
     */
    @RequestMapping("/getProcessResourceWithDefID")
    public void getProcessResourceWithDefID(@RequestParam("type") String resourceType, @RequestParam("pdid") String processDefinitionId, HttpServletResponse response) {
        try {
            if (!StringUtils.isEmpty(processDefinitionId)) {

                WorkFlow workFlow = new WorkFlow();
                RepositoryService repositoryService = workFlow.getRepositoryService();

                //根据流程实例id获取流程定义
                ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();

                String resourceNmae = "";
                if (resourceType.equals("image")){
                    resourceNmae = processDefinition.getDiagramResourceName();
                }else if(resourceType.equals("xml")){
                    resourceNmae = processDefinition.getResourceName();
                }
                InputStream resourceAsStream = null;
                resourceAsStream = workFlow.getRepositoryService().getResourceAsStream(processDefinition.getDeploymentId(),resourceNmae);
                byte[] b = new byte[1024];
                int len = -1;
                while ((len=resourceAsStream.read(b,0,1024))!=-1){
                    response.getOutputStream().write(b,0,len);
                }
            }else{
                logger.error("获取流程资源失败:pdid为空");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /***
     * 跳转到查看流程图页面
     *
     */
    @RequestMapping("/goViewDiagram")
    public ModelAndView goViewDiagram() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        mv.setViewName("system/workflow/diagram_view");
        mv.addObject("pd",pd);
        return mv;
    }
    /***
     * 跳转到查看流程图页面with proccessInstance ID
     *
     */
    @RequestMapping("/goViewDiagramWithPid")
    public ModelAndView goViewDiagramWithPid(@RequestParam("type") String resourceType, @RequestParam("pid") String processDefinitionId) throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        mv.setViewName("system/workflow/flow_diagram_view");
        List<Map<String, Object>> activityInfos = workflowTraceService.traceProcess(processDefinitionId);
        mv.addObject("pd",pd);
        mv.addObject("activityInfos",activityInfos);
        return mv;
    }
    /**
     * 输出跟踪流程信息
     *
     * @param processInstanceId
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/traceProcess")
    @ResponseBody
    public List<Map<String, Object>> traceProcess(@RequestParam("pid") String processInstanceId) throws Exception {
        List<Map<String, Object>> activityInfos = workflowTraceService.traceProcess(processInstanceId);
        return activityInfos;
    }
    /**
     * 输出跟踪流程信息with process def id in English
     *
     * @param processDefinitionId
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/traceProcessWithPdidInEn")
    @ResponseBody
    public List<Map<String, Object>> traceProcessWithPdidInEn(@RequestParam("pdid") String processDefinitionId) throws Exception {
        List<Map<String, Object>> activityInfos = workflowTraceService.traceProcessWithPdidInEn(processDefinitionId);
        return activityInfos;
    }
    /**
     * 输出跟踪流程信息with process def id in Chinese
     *
     * @param processDefinitionId
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/traceProcessWithPdidInCh")
    @ResponseBody
    public List<Map<String, Object>> traceProcessWithPdidInCh(@RequestParam("pdid") String processDefinitionId) throws Exception {
        List<Map<String, Object>> activityInfos = workflowTraceService.traceProcessWithPdidInCh(processDefinitionId);
        return activityInfos;
    }
    /***
     * 跳转到查看历史记录页面
     *
     */
    @RequestMapping("/goViewHistory")
    public ModelAndView goViewHistory( @RequestParam("pid") String processInstanceId) throws Exception {
        ModelAndView mv = new ModelAndView();
        WorkFlow workFlow = new WorkFlow();
        PageData pd = this.getPageData();
        //获取历史instance记录
        List<HistoricProcessInstance> historicProcessInstances = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).list();
        mv.addObject("historicProcessInstances",historicProcessInstances);
        List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().processInstanceId(processInstanceId).list();

        List<Map> list = new ArrayList<>();
        for (HistoricTaskInstance historicTaskInstance:historicTaskInstances
             ) {
            Map<String ,Object> map = new HashMap<String,Object>();
            map.put("task_name",historicTaskInstance.getName());

            String claim_time = Tools.date2Str(historicTaskInstance.getClaimTime(),"yyyy-MM-dd HH:mm:ss");
            String complete_time = Tools.date2Str(historicTaskInstance.getEndTime(),"yyyy-MM-dd HH:mm:ss");
            map.put("claim_time",claim_time);
            map.put("complete_time",complete_time);
            if (historicTaskInstance.getAssignee()!=null){
                //获取用户信息
                String user_id = historicTaskInstance.getAssignee();
                PageData tmp = new PageData();
                tmp.put("USER_ID",user_id);
                tmp = sysUserService.findByUiId(tmp);
                if (tmp!=null&&tmp.getString("NAME")!=null){
                    String user_name = tmp.getString("NAME");
                    map.put("user_name",user_name);
                }
            }
            //获取comment
            List<Comment> comments =  workFlow.getTaskService().getTaskComments(historicTaskInstance.getId());
            String comment = "";
            for (Comment msg :
                    comments) {
                comment = msg.getFullMessage();
            }
            map.put("comment",comment);
            //获取变量
            List<HistoricVariableInstance> historicVariableInstances = workFlow.getHistoryService().createHistoricVariableInstanceQuery().taskId(historicTaskInstance.getId()).list();
            String action ="";
            for (HistoricVariableInstance historicVariableInstance :historicVariableInstances
                    ) {
                if (historicVariableInstance.getVariableName().equals("action")){
                    action = (String) historicVariableInstance.getValue();
                }
            }
            map.put("action",action);
            list.add(map);

        }
        pd.put("historys",list);
        mv.addObject("pd",pd);
        mv.setViewName("system/workflow/workflow_history");
        return mv;
    }
    /***
     * 跳转到流程设置页面
     *
     */
    @RequestMapping("/goWorkFlowSetUp")
    public ModelAndView goWorkFlowSetUp(@RequestParam("type") String resourceType, @RequestParam("pdid") String processDefinitionId) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("system/workflow/workflow_setup");
        PageData pd = this.getPageData();
        mv.addObject("pd",pd);
        return mv;
    }

//    /***
//     * 跳转到流程设置编辑页面
//     *
//     */
//    @RequestMapping("/goWorkFlowSetUpEdit")
//    public ModelAndView goWorkFlowSetUpEdit(@RequestParam("activityId") String activityId, @RequestParam("activityName") String activityName, @RequestParam("pdid") String processDefinitionId) throws Exception {
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("system/workflow/workflow_setup_edit");
//        PageData pd = this.getPageData();
//        mv.addObject("pd",pd);
//        return mv;
//    }

    /**
     * 跳转到流程设置编辑页面
     */
    @RequestMapping(value = "/goWorkFlowSetUpEdit")
    public ModelAndView goWorkFlowSetUpEdit() throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            PageData pd = this.getPageData();
            List<PageData> list = taskAssignService.getTaskAssignByRole(pd);
            JSONArray arr = JSONArray.fromObject(list);
            String json = arr.toString();
            mv.addObject("zTreeNodes", json);
            mv.addObject("pd", pd);
            mv.setViewName("system/workflow/workflow_setup_edit");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**
     * 保存流程定义权限
     */
    @RequestMapping(value = "/saveSetUp")
    @ResponseBody
    public Object saveSetUp() throws Exception {
        HashMap map = new HashMap();
        try{
            PageData pd = this.getPageData();
            String str = pd.getString("treeIds");
            JSONArray jsonArray = JSONArray.fromObject(str);
            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject json = (JSONObject) jsonArray.get(i);
                JSONArray child;
                try {
                    child = (JSONArray) json.get("children");
                } catch (Exception e) {
                    child = null;
                }
                boolean checked = json.getBoolean("checked");
                String aId = json.getString("aId");
                String id = json.getString("id");
                boolean isNull = StringUtils.isEmpty(aId);
                if (checked && isNull) {//之前未选中的,现在被选中,save
                    PageData ppd = new PageData();
                    ppd.put("id", UUID.randomUUID().toString());
                    ppd.put("task_def_key", pd.getString("activityId"));
                    ppd.put("group_id", id);
                    ppd.put("process_definition_id", pd.getString("pdid"));
                    taskAssignService.save(ppd);
                } else if (!checked && !isNull) {//之前被选中,现在被取消,delete
                    PageData ppd = new PageData();
                    ppd.put("id", aId);
                    taskAssignService.del(ppd);
                }
                //有子节点
                if (child != null) {
                    for (int j = 0; j < child.size(); j++) {
                        JSONObject childern = (JSONObject) child.get(j);
                        boolean c_checked = childern.getBoolean("checked");
                        String c_aId = childern.getString("aId");
                        String c_id = childern.getString("id");
                        boolean c_isNull = StringUtils.isEmpty(c_aId);
                        if (c_checked && c_isNull) {//之前未选中的,现在被选中,save
                            PageData cpd = new PageData();
                            cpd.put("id", UUID.randomUUID().toString());
                            cpd.put("task_def_key", pd.getString("activityId"));
                            cpd.put("group_id", c_id);
                            cpd.put("process_definition_id", pd.getString("pdid"));
                            taskAssignService.save(cpd);
                        } else if (!c_checked && !c_isNull) {//之前被选中,现在被取消,delete
                            PageData cpd = new PageData();
                            cpd.put("id", c_aId);
                            taskAssignService.del(cpd);
                        }
                    }
                }
            }
            map.put("msg","success");
        }catch (Exception e){
            logger.error(e);
            map.put("msg","failed");
            map.put("err","修改错误");
        }
        return JSONObject.fromObject(map);

    }
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
}
