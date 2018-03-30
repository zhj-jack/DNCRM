package com.dncrm.controller.system.e_offer;

import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import org.activiti.engine.IdentityService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.service.system.city.CityService;
import com.dncrm.service.system.e_offer.E_offerService;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.regelevStandard.RegelevStandardService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.PageData;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RequestMapping("/e_offer")
@Controller
public class E_offerController extends BaseController
{
	//引入service层
    @Resource(name="e_offerService")
	private E_offerService e_offerService;
	@Resource(name="cityService")
	private CityService cityService;
	@Resource(name="modelsService")
	private ModelsService modelsService;
	@Resource(name="regelevStandardService")
	private RegelevStandardService regelevStandardService;
    
    // test
 	@SuppressWarnings("unused")
 	private DaoSupport dao;
 	
    /**
     * 显示全部报价信息
     * Stone 17.07.05
     * @param page
     * @return
     */
	@RequestMapping("/e_offerList")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		 //shiro管理的session
 		Subject currentUser = SecurityUtils.getSubject();
 		Session session = currentUser.getSession();
 		PageData pds = new PageData();
 		pds = (PageData) session.getAttribute("userpds");
 		String USER_ID = pds.getString("USER_ID");
		try {
			List<String> userList = getRoleSelect();
    		String roleType = getRoleType();
    		pd.put("userList", userList);
    		pd.put("roleType", roleType);
    		page.setPd(pd);
			List<PageData> e_offerList = e_offerService.e_offerlistPage(page);
			if(!e_offerList.isEmpty()){
              	for(PageData con : e_offerList){
              		String instance_id = con.getString("instance_id");
              		if(instance_id!=null && !"".equals(instance_id)){
              			WorkFlow workFlow = new WorkFlow();
              			List<Task> task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).active().list();
              			if(task!=null&& task.size()>0){
              				for(Task task1:task)
              				{
              				con.put("task_id",task1.getId());
              				con.put("task_name",task1.getName());
              				}
              			}
              		}
              	}
              }
			mv.setViewName("system/e_offer/e_offer");
			mv.addObject("e_offerList", e_offerList);
			mv.addObject("pd", pd);
    		mv.addObject("page", page);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
     * 显示全部状态为 报价  的项目信息
     * Stone 17.07.05
     * @param page
     * @return
     */
	@RequestMapping("/itemList")
	public ModelAndView Itemlist(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> itemList = e_offerService.itemlistpage(page);
			mv.setViewName("system/e_offer/e_offer_item");
			mv.addObject("itemList", itemList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
     * 对项目进行报价
     * 请求跳转（新增报价页面）
     * Stone 17.07.05
     * @param page
     * @return
     */
	@RequestMapping("/addEoffer")
	public ModelAndView addEoffer( ) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			pd=e_offerService.findItemById(pd);//项目信息
			Page page=new Page();
			page.setPd(pd);
			//所属该项目的电梯信息
			List<PageData> elevatorList=e_offerService.elevatorlistPage(page);
			//根据项目id查询报价池
			List<PageData> bjcList = e_offerService.bjc_list(pd);
			mv.addObject("bjcList", bjcList);
			PageData elev=new PageData();
			for(int i=0;i<elevatorList.size();i++)
			{
				String elevID="";
				elev.put("item_id",elevatorList.get(i).get("item_id").toString());
				elev.put("models_id",elevatorList.get(i).get("models_id").toString());
				//根据item_id和models_id获取电梯ID
				List<PageData> elevList =  e_offerService.findEleBYmodels_id(elev);
				for(int j=0;j<elevList.size();j++)
				{
					if(j+1<elevList.size())
					{
						elevID+=elevList.get(j).get("elevID").toString()+",";
					}
					else
					{
						elevID+=elevList.get(j).get("elevID").toString();
					}
				}
				elevatorList.get(i).put("elevID", elevID);
			}
			
			mv.addObject("elevatorList", elevatorList);
			
			String offer_no = null;
			String str = new SimpleDateFormat("yyMMdd").format(new Date());
			PageData OfferNo=e_offerService.E_offer_NO(pd);
			if(OfferNo!=null)
			{
				String no=OfferNo.get("offer_no").toString();
				String v = no.substring(no.indexOf("B") + 1);
				String v1 = v.substring(0, 6);
				if(v1.equals(str))
				{
					DecimalFormat mFormat = new DecimalFormat("000");//确定格式，把1转换为001  
					String a = no.substring(no.indexOf("_") + 1);
					String b = a.substring(0, 3);
					int c=Integer.parseInt(b);
					String d = mFormat.format(c+1);
					offer_no="B"+str+"_"+d+"01";
				}
				else
				{
					offer_no="B"+str+"_00101";
				}
			}
			else
			{
				offer_no="B"+str+"_00101";
			}
			
			pd.put("offer_no", offer_no);//报价编号
			mv.setViewName("system/e_offer/e_offer_edit");
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			mv.addObject("msg","saveS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
     * 查看报价信息
     * Stone 17.08.11
     * @param page
     * @return
     */
	@RequestMapping("/SeeEoffer")
	public ModelAndView SeeEoffer() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData selBjcPd = new PageData();
		selBjcPd.put("ITEM_ID", pd.get("item_id").toString());
		try {
			//报价信息，以及项目信息
			pd=e_offerService.findOfferById(pd);
			List<PageData> bjcList = e_offerService.findBjc(selBjcPd);
			Page page=new Page();
			page.setPd(pd);
			List<PageData> elevatorList=e_offerService.elevatorlistPage(page);//所属该项目的电梯信息
	        mv.addObject("elevatorList", elevatorList);
	        mv.addObject("bjcList", bjcList);
			mv.setViewName("system/e_offer/e_offer_check");
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			mv.addObject("msg","saveS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/**
	 *调用参考报价 
	 */
	@RequestMapping(value="selCbj")
	public ModelAndView selCbj(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		List<PageData> cbjList = new ArrayList<PageData>();
		try{
			pd = this.getPageData();
			String models = pd.getString("models");
			if(models.equals("feishang")){
				cbjList = e_offerService.findFeishangCbj();
			}else if(models.equals("feiyang")){
				cbjList = e_offerService.findFeiyangCbj();
			}else if(models.equals("feiyangmrl")){
				cbjList = e_offerService.findFeiyangMRLCbj();
			}else if(models.equals("feiyangxf")){
				cbjList = e_offerService.findFeiyangXFCbj();
			}else if(models.equals("feiyue")){
				cbjList = e_offerService.findFeiyueCbj();
			}else if(models.equals("feiyuemrl")){
				cbjList = e_offerService.findFeiyueMRLCbj();
			}else if(models.equals("shiny")){
				cbjList = e_offerService.findShinyCbj();
			}else if(models.equals("dnp9300")){
				cbjList = e_offerService.findDnp9300Cbj();
			}else if(models.equals("dnr")){
				cbjList = e_offerService.findDnrCbj();
			}
			mv.addObject("cbjList", cbjList);
			mv.addObject("pd", pd);
			mv.setViewName("system/e_offer/cbj_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *调用装潢价格
	 */
	@RequestMapping(value="selZhj")
	public ModelAndView selZhj(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		List<PageData> zhjList = new ArrayList<PageData>();
		try{
			pd = this.getPageData();
			String models = pd.getString("models");
			if(models.equals("feishang")){
				zhjList = e_offerService.findFeishangZhj();
			}else if(models.equals("feiyang")){
				zhjList = e_offerService.findFeiyangZhj();
			}else if(models.equals("feiyangmrl")){
				zhjList = e_offerService.findFeiyangMRLZhj();
			}else if(models.equals("feiyangxf")){
				zhjList = e_offerService.findFeiyangXFZhj();
			}else if(models.equals("feiyue")){
				zhjList = e_offerService.findFeiyueZhj();
			}else if(models.equals("feiyuemrl")){
				zhjList = e_offerService.findFeiyueMRLZhj();
			}else if(models.equals("shiny")){
				zhjList = e_offerService.findShinyZhj();
			}
			mv.addObject("zhjList", zhjList);
			mv.addObject("pd", pd);
			mv.setViewName("system/e_offer/zhj_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 * 删除数据
	 * @param binder
	 */
	@RequestMapping("/delE_offer")
	@ResponseBody
	public Object delE_offer() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			e_offerService.deleteOffer(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	/**
	 * 删除多条数据
	 * @param binder
	 */
	@RequestMapping("/deleteAllS")
	@ResponseBody
	public Object delE_Offer() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		try {
			page.setPd(pd);
			String offer_nos = (String) pd.get("offer_nos");
			for (String offer_no : offer_nos.split(",")) {
				pd.put("offer_no", offer_no);
				e_offerService.deleteOffer(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
     * 保存新增报价信息
     * @return
     */
	@RequestMapping("/saveS")
	public ModelAndView saveS() 
	{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		String df=DateUtil.getTime().toString(); //获取系统时间
		
		pd=this.getPageData();
		Subject currentUser=SecurityUtils.getSubject();
		Session session=currentUser.getSession();
		PageData pds=new PageData();
		pds=(PageData) session.getAttribute("userpds");
		String USER_ID=pds.getString("USER_ID");
		try 
		{
			//获取项目包含的报价池信息
			List<PageData> bjcList=e_offerService.findBjcByItemId(pd);
			int ZHEKOU=100;
			//获取最低的折扣
			for(PageData con : bjcList)
			{
				int BJC_ZK=Integer.parseInt(con.getString("BJC_ZK"));
				/*double BJC_ZK = Double.parseDouble(con.getString("BJC_ZK")); 
				double a=BJC_ZK*100;*/
				if(BJC_ZK<ZHEKOU)
				{
					ZHEKOU=(int) BJC_ZK;
				}
			}
			if(ZHEKOU>68)
			{
				pd.put("offer_id", UUID.randomUUID().toString());
				pd.put("instance_status", 6);          //6代表不走流程
				pd.put("instance_id","");              //流程的key
				pd.put("offer_user", USER_ID);         //录入信息请求启动的用户ID
				pd.put("offer_date", df);              //录入时间
				pd.put("KEY", ""); 
				pd.put("ZHEKOU", ZHEKOU);
				
				//保存报价信息
				e_offerService.saveS(pd);
				
				//补充项目信息
				e_offerService.editItem(pd);
				mv.addObject("msg", "success");
			}
			else
			{
				pd.put("ZHEKOU", ZHEKOU);	
				//调用生成流程实例
				liucheng(pd);
				mv.addObject("msg", "success");
			}
			
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "e_offerForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	//生成流程实例
	public void liucheng(PageData pd)
	{
		ModelAndView mv=new ModelAndView();
		//获取系统时间
		String df=DateUtil.getTime().toString(); 
		//获取系统当前登录人
		Subject currentUser=SecurityUtils.getSubject();
		Session session=currentUser.getSession();
		PageData pds=new PageData();
		pds=(PageData) session.getAttribute("userpds");
		String USER_ID=pds.getString("USER_ID");
		try 
		{
			//获取项目包含的梯种 根据梯种启动流程
			List<PageData> bjcList=e_offerService.findBjcByItemId(pd);
			String changgui=null;
			String futi=null;
			
			for(PageData con : bjcList)
			{
				String elevator_id = con.getString("elevator_id");
				if(elevator_id.equals("1"))
				{
					changgui="1";
				}
				else if(elevator_id.equals("2"))
				{
					futi="1";
				}
				
			}
			
			//-----------------生成流程相关
			String processDefinitionKey="";   //存放流程的key
			
			//根据梯种启动流程
			if(changgui!=null && futi!=null)
			{
				processDefinitionKey="offer_futi";
			}
			else if(futi!=null)
			{
				processDefinitionKey="offer_futi";
			}
			else if(changgui!=null)
			{
				processDefinitionKey="offer_changgui";
			}
			
			PageData offerPd=new PageData();
			offerPd.put("KEY", processDefinitionKey);
			//查询流程是否存在
			List<PageData> straList = e_offerService.instance_key(offerPd);
			if(straList!=null)
			{
				pd.put("offer_id", UUID.randomUUID().toString());
				pd.put("instance_status", 1);          //流程状态 1代表待启动
				pd.put("instance_id",processDefinitionKey);         //流程的key
				pd.put("offer_user", USER_ID);         //录入信息请求启动的用户ID
				pd.put("offer_date", df);              //录入时间
				pd.put("KEY", processDefinitionKey);
				
				//保存报价信息
				e_offerService.saveS(pd);
			}
			else
			{
				mv.addObject("msg", "流程不存在");
			}
			
			//-----生成流程实例
			WorkFlow workFlow=new WorkFlow();
			IdentityService identityService=workFlow.getIdentityService();
			identityService.setAuthenticatedUserId(USER_ID);
			Object uuId=pd.get("offer_id");
			String businessKey="tb_e_offer.offer_id."+uuId;
			Map<String,Object> variables = new HashMap<String,Object>();
			variables.put("user_id", USER_ID);
			ProcessInstance proessInstance=null; //存放生成的流程实例id
			if(processDefinitionKey!=null && !"".equals(processDefinitionKey))
			{
				proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
			}
			if(proessInstance!=null)
			{
				pd.put("instance_id", proessInstance.getId());
				//修改报价信息  （流程的key该为流程实例id）
				e_offerService.editS(pd);
				//补充项目信息
				e_offerService.editItem(pd);
				mv.addObject("msg", "success");
			}
			else
			{
				e_offerService.deleteOffer(pd);//删除报价信息
				mv.addObject("msg", "failed");
				mv.addObject("err", "没有生成流程实例");
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
	}
	
	
	
	
	
	
	
	/**
	 * 启动流程
	 * @return
	 */
    @RequestMapping("/apply")
    @ResponseBody
    public Object apply(){
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String,Object> map = new HashMap<>();
    	try{
    		//shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
            String instance_id = pd.getString("instance_id");       //流程实例id
            // 如果流程的实例id存在，启动流程
            if(instance_id!=null && !"".equals(instance_id)){
            	WorkFlow workFlow = new WorkFlow();
            	// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            	workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
            	Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
            	Map<String,Object> variables = new HashMap<String,Object>();
            	//设置任务角色
            	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
            	//签收任务
            	workFlow.getTaskService().claim(task.getId(), USER_ID);
            	//设置流程变量
            	variables.put("action", "提交申请");
            	
            	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
            	pd.put("instance_status", 2);   //流程状态  2代表流程启动,等待审核
            	e_offerService.editInstance_status(pd);//更新流程状态
            	workFlow.getTaskService().complete(task.getId());
            	//获取下一个任务的信息
                Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
                map.put("task_name",tasks.getName());
                map.put("status", "1");
            }
            if((instance_id !=null && !"".equals(instance_id))){
            	map.put("status", "3");
            }
            map.put("msg", "success");
    	}catch(Exception e){
    		logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
    	}
    	return JSONObject.fromObject(map);
    }

    /**
     * 显示待我处理的
     * @param page
     * @return
     */
    @RequestMapping(value= "/e_offerAudit")
    public ModelAndView listPendingContractor(Page page){
    	  ModelAndView mv = this.getModelAndView();
          PageData pd = new PageData();
          pd = this.getPageData();
          try{
        	  //shiro管理的session
              Subject currentUser = SecurityUtils.getSubject();
              Session session = currentUser.getSession();
              PageData pds = new PageData();
              pds = (PageData) session.getAttribute("userpds");
              String USER_ID = pds.getString("USER_ID");
              page.setPd(pds);
              mv.setViewName("system/e_offer/e_offer_audit");
              mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
              //存放任务集合
              List<PageData> e_offers = new ArrayList<>();
              WorkFlow workFlow = new WorkFlow();
              // 等待处理的任务
              //设置分页数据
              int firstResult;//开始游标
              int maxResults;//结束游标
              int showCount = page.getShowCount();//默认为10
              int currentPage = page.getCurrentPage();//默认为0
              if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                  firstResult = currentPage;//从0开始
                  currentPage+=1;//当前为第一页
                  maxResults = showCount;
              }else{
                  firstResult = showCount*(currentPage-1);
                  maxResults = firstResult+showCount;
              }
              List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_changgui").orderByTaskCreateTime().desc().active().list();
              List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_changgui").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
                 for (Task task : toHandleList) {
                  PageData e_offer = new PageData();
                  String processInstanceId = task.getProcessInstanceId();
                  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                  String businessKey = processInstance.getBusinessKey();
                  if (!StringUtils.isEmpty(businessKey)){
                      //leave.leaveId.
                      String[] info = businessKey.split("\\.");
                      e_offer.put(info[1],info[2]);
                      //根据uuiid查询信息
                      e_offer = e_offerService.findByuuId(e_offer);
                      e_offer.put("task_name",task.getName());
                      e_offer.put("task_id",task.getId());
                      if(task.getAssignee()!=null){
                    	  e_offer.put("type","1");//待处理
                      }else{
                    	  e_offer.put("type","0");//待签收
                      }
                  }
                  e_offers.add(e_offer);
              }
                 
             List<Task> toHandleListCount2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_futi").orderByTaskCreateTime().desc().active().list();
             List<Task> toHandleList2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_futi").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
                for (Task task : toHandleList2) {
                 PageData e_offer = new PageData();
                 String processInstanceId = task.getProcessInstanceId();
                 ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                 String businessKey = processInstance.getBusinessKey();
                 if (!StringUtils.isEmpty(businessKey)){
                     //leave.leaveId.
                     String[] info = businessKey.split("\\.");
                     e_offer.put(info[1],info[2]);
                     //根据uuiid查询信息
                     e_offer = e_offerService.findByuuId(e_offer);
                     e_offer.put("task_name",task.getName());
                     e_offer.put("task_id",task.getId());
                     if(task.getAssignee()!=null){
                   	  e_offer.put("type","1");//待处理
                     }else{
                   	  e_offer.put("type","0");//待签收
                     }
                 }
                 e_offers.add(e_offer);
             }
                 
              //设置分页数据
              int totalResult = toHandleListCount.size()+toHandleListCount2.size();
              if (totalResult<=showCount) {
                  page.setTotalPage(1);
              }else{
                  int count = Integer.valueOf(totalResult/showCount);
                  int  mod= totalResult%showCount;
                  if (mod>0) {
                      count =count+1;
                  }
                  page.setTotalPage(count);
              }
              page.setTotalResult(totalResult);
              page.setCurrentResult(e_offers.size());
              page.setCurrentPage(currentPage);
              page.setShowCount(showCount);
              page.setEntityOrField(true);
              //如果有多个form,设置第几个,从0开始
              page.setFormNo(1);
              page.setPageStrForActiviti(page.getPageStrForActiviti());
              //待处理任务的count
              pd.put("count",totalResult);
              pd.put("isActive2","1");
              mv.addObject("pd",pd);
              mv.addObject("e_offers", e_offers);
              mv.addObject("userpds", pds);
          }catch(Exception e){
        	  logger.error(e.toString(), e);
          }
          return mv;
    }
    /**
     * 签收任务
     *
     * @return
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/claim")
    @ResponseBody
    public Object claim() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");	
            workFlow.getTaskService().claim(task_id,user_id);
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","签收失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 跳到办理任务页面
     * @return
     * @throws Exception
     */
    @RequestMapping("/goHandStra")
    public ModelAndView goHandleAgent() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        mv.setViewName("system/e_offer/e_offer_handle");
        mv.addObject("pd", pd);
        return mv;
    }
    /**
     * 办理任务
     * @return
     */
    @RequestMapping("/handleAgent")
    public ModelAndView handleAgent(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try{
        	 //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            
            int zhekou = 0;
            PageData offerPd = e_offerService.findByuuId(pd);
            String KEY=offerPd.getString("OFFER_KEY");
            if(KEY.equals("offer_changgui"))
            {
            	String ZHEKOU=offerPd.getString("ZHEKOU");
            	int ZK = Integer.parseInt(ZHEKOU);
				if(ZK>=60 && ZK<68)
				{
					zhekou=1;
				}
				else if(ZK>=50 && ZK<60)
				{
					zhekou=2;
				}
				else if(ZK<50)
				{
					zhekou=3;
				}
            	
            }
            else if(KEY.equals("offer_futi"))
            {
            	String ZHEKOU=offerPd.getString("ZHEKOU");
            	int ZK = Integer.parseInt(ZHEKOU);
				if(ZK>=58 && ZK<65)
				{
					zhekou=1;
				}
				else if(ZK>=50 && ZK<58)
				{
					zhekou=2;
				}
				else if(ZK<50)
				{
					zhekou=3;
				}
            }
            
            // 办理任务
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            Map<String,Object> variables = new HashMap<String ,Object>();
            boolean isApproved = false;
            boolean isEnd=false;
            String action = pd.getString("action");
            @SuppressWarnings("unused")
			int status;
            if (action.equals("approve")){
                Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
                if (task.getTaskDefinitionKey().equals("XiaoShouTask"))
                {
                	status = 2;    //已完成
                    pd.put("instance_status",3);             //流程状态  3.审核中
                    variables.put("approved", true);
                    variables.put("zhekou", zhekou);
                    isApproved=true;
                    e_offerService.editInstance_status(pd);  //修改流程状态
                }
                else if(task.getTaskDefinitionKey().equals("ZiGongSiTask"))
                {
                	 status = 2;    //已完成
                     pd.put("instance_status",4);             //流程状态   4.已通过
                     variables.put("approved", true);
                     isApproved=true;
                     isEnd=true;
                     e_offerService.editInstance_status(pd);  //修改流程状态
                }
                else if(task.getTaskDefinitionKey().equals("YingXiaoTask"))
                {
                	 status = 2;    //已完成
                     pd.put("instance_status",4);             //流程状态   4.已通过
                     variables.put("approved", true);
                     isApproved=true;
                     isEnd=true;
                     e_offerService.editInstance_status(pd);  //修改流程状态
                }
                else if(task.getTaskDefinitionKey().equals("GuFenTask"))
                {
                	 status = 2;    //已完成
                     pd.put("instance_status",4);             //流程状态   4.已通过
                     variables.put("approved", true);
                     isApproved=true;
                     isEnd=true;
                     e_offerService.editInstance_status(pd);  //修改流程状态
                }
                else
                {
                	status = 2;    //已完成
                    pd.put("instance_status",3);             //流程状态  3.审核中
                    variables.put("approved", true);
                    isApproved=true;
                    e_offerService.editInstance_status(pd);  //修改流程状态
                }
            }else if(action.equals("reject")) {
                status = 4;   
                pd.put("instance_status",5);             //流程状态  5代表 被驳回
                variables.put("approved", false);
                e_offerService.editInstance_status(pd);  //修改流程状态
            }
            String  comment = (String) pd.get("comment");
            if (isApproved){
                variables.put("action","批准");
            }else{
                variables.put("action","驳回");
            }
            if(isEnd)
            {
            	variables.put("action","通过,流程结束！");
            }
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            workFlow.getTaskService().addComment(task_id,null,comment);
            workFlow.getTaskService().complete(task_id,variables);
            mv.addObject("msg", "success");
        }catch(Exception e){
        	 mv.addObject("msg", "failed");
             mv.addObject("err", "办理失败！");
             logger.error(e.toString(), e);
        }
        mv.addObject("id", "handleLeave");
        mv.addObject("form", "handleLeaveForm");
        mv.setViewName("save_result");
    	return mv;
    }
    
    /**
     * 显示我已经处理的任务
     *
     * @return
     */
    @RequestMapping("/listDoneOffer")
    public ModelAndView listDoneE_offer(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            page.setPd(pds);
            mv.setViewName("system/e_offer/e_offer_audit");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务集合
            List<PageData> e_offers = new ArrayList<>();
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
            
            //获取已处理的任务
            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("offer_changgui").orderByTaskCreateTime().desc().list();
            //移除重复的
            for (HistoricTaskInstance instance:historicTaskInstances)
            {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey,instance);
            }
            
            //获取已处理的任务
            List<HistoricTaskInstance> historicTaskInstances2 = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("offer_futi").orderByTaskCreateTime().desc().list();
            //移除重复的
            for (HistoricTaskInstance instance:historicTaskInstances2)
            {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey,instance);
            }
            
            @SuppressWarnings("rawtypes")
			Iterator iter = map.entrySet().iterator();
            while (iter.hasNext()){
                @SuppressWarnings("rawtypes")
				Map.Entry entry = (Map.Entry) iter.next();
                list.add((HistoricTaskInstance)entry.getValue());
            }
            //设置分页数据
            int firstResult;//开始游标
            int maxResults;//结束游标
            int showCount = page.getShowCount();//默认为10
            int currentPage = page.getCurrentPage();//默认为0
            if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                firstResult = currentPage;//从0开始
                currentPage+=1;//当前为第一页
                maxResults = showCount;
            }else{
                firstResult = showCount*(currentPage-1);
                maxResults = firstResult+showCount;
            }
            int listCount =(list.size()<=maxResults?list.size():maxResults);
            //从分页参数开始
            for (int i = firstResult; i <listCount ; i++) {
                HistoricTaskInstance historicTaskInstance = list.get(i);
                PageData stra = new PageData();
                String processInstanceId = historicTaskInstance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        stra.put(info[1],info[2]);
                        stra = e_offerService.findByuuId(stra);
                        //检查申请者是否是本人,如果是,跳过
                        if (stra.getString("offer_user").equals(USER_ID))
                        continue;
                        //查询当前流程是否还存在
                        List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                        if (stra!=null) {
                        	if (runing==null||runing.size()<=0){
                        		stra.put("isRuning",0);
                            }else{
                            	stra.put("isRuning",1);
                                //正在运行,查询当前的任务信息
                                Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
                                stra.put("task_name",task.getName());
                                stra.put("task_id",task.getId());
                            }
						}
                        e_offers.add(stra);
                }
            }
            //设置分页数据
            int totalResult = list.size();
            if (totalResult<=showCount) {
                page.setTotalPage(1);
            }else{
                int count = Integer.valueOf(totalResult/showCount);
                int  mod= totalResult%showCount;
                if (mod>0) {
                    count =count+1;
                }
                page.setTotalPage(count);
            }
            page.setTotalResult(totalResult);
            page.setCurrentResult(e_offers.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(2);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            //待处理任务的count
            WorkFlow workflow = new WorkFlow();
            List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).orderByTaskCreateTime().desc().active().list();
            pd.put("count",toHandleListCount.size());
            pd.put("isActive3","1");
            mv.addObject("pd",pd);
            mv.addObject("e_offers", e_offers);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    /**
     * 重新提交流程
     *
     * @return
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/restartAgent")
    @ResponseBody
    public Object restartAgent() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");  //流程id
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id,user_id);
            Map<String,Object> variables = new HashMap<String,Object>();
            variables.put("action","重新提交");
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            //处理任务
            workFlow.getTaskService().complete(task_id);
        	//更新业务数据的状态
        	pd.put("instance_status", 2); //流程状态 2.待审核
        	e_offerService.editInstance_status(pd);  //修改流程状态
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     *跳转到常规梯报价单页面 
     */
    @RequestMapping(value="offerView")
    public ModelAndView offerView(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		pd.put("models_id", pd.getString("MODELS_ID"));
    		PageData modelsPd = modelsService.findModelsById(pd);
    		String codName = modelsPd.getString("models_name");
    		if(codName.equals("飞尚GL freight")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEISHANG_ID", codId);
    				pd = e_offerService.findFeishang(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEISHANG_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeishang");
    			mv.setViewName("system/e_offer/feishang");
    		}else if(codName.equals("飞扬3000+MRL")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYANGMRL_ID", codId);
    				pd = e_offerService.findFeiyangMRL(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYANGMRL_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyangMRL");
    			mv.setViewName("system/e_offer/feiyang3000_mrl");
    		}else if(codName.equals("飞扬3000+")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYANG_ID", codId);
    				pd = e_offerService.findFeiyang(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYANG_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyang");
    			mv.setViewName("system/e_offer/feiyang3000");
    		}else if(codName.equals("飞扬消防梯")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYANGXF_ID", codId);
    				pd = e_offerService.findFeiyangXF(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYANGXF_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyangXF");
    			mv.setViewName("system/e_offer/feiyang_xf");
    		}else if(codName.equals("新飞越")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYUE_ID", codId);
    				pd = e_offerService.findFeiyue(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYUE_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyue");
    			mv.setViewName("system/e_offer/feiyue");
    		}else if(codName.equals("新飞越MRL")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYUEMRL_ID", codId);
    				pd = e_offerService.findFeiyueMRL(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYUEMRL_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyueMRL");
    			mv.setViewName("system/e_offer/feiyue_mrl");
    		}else if(codName.equals("DNP9300")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById2(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("DNP9300_ID", codId);
    				pd = e_offerService.findDnp9300(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("DNP9300_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveDnp9300");
    			mv.setViewName("system/e_offer/dnp9300");
    		}else if(codName.equals("DNR")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById2(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("DNR_ID", codId);
    				pd = e_offerService.findDnr(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("DNR_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveDnr");
    			mv.setViewName("system/e_offer/dnr");
    		}else if(codName.equals("曳引货梯")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("SHINY_ID", codId);
    				pd = e_offerService.findShiny(pd);
    				pd.put("BJC_ID", bjcId);
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("SHINY_SL", pd.get("OFFER_NUM").toString());
    			}
    			mv.addObject("pd", pd); 
    			mv.addObject("msg", "saveShiny");
    			mv.setViewName("system/e_offer/shiny");
    		}
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			mv.addObject("cityList", cityList);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    

    @RequestMapping(value="saveFeiyue")
    public ModelAndView saveFeiyue(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyueId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyueId = pd.getString("FEIYUE_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			e_offerService.updateFeiyue(pd);
    			//关联更新报价池
    			PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYUE_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYUE_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYUE_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYUE_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYUE_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYUE_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYUE_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYUE_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYUE_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		feiyueId = this.get32UUID();
	    		pd.put("FEIYUE_ID", feiyueId);
	    		e_offerService.saveFeiyue(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyueId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYUE_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYUE_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYUE_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYUE_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYUE_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYUE_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYUE_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYUE_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEIYUE_SBJ"));
        	srPd.put("zk_", pd.getString("FEIYUE_ZK"));
        	srPd.put("zhsbj_", pd.getString("FEIYUE_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEIYUE_SJBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("FEIYUE_AZF"));
        	srPd.put("ysf_", pd.getString("FEIYUE_YSF"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyueId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	return mv;
    }
    
    @RequestMapping(value="saveFeiyueMRL")
    public ModelAndView saveFeiyueMRL(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyuemrlId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyuemrlId = pd.getString("FEIYUEMRL_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
    			e_offerService.updateFeiyueMRL(pd);
    			//关联更新报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYUEMRL_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYUEMRL_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYUEMRL_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYUEMRL_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYUEMRL_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYUEMRL_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYUEMRL_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYUEMRL_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYUEMRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		feiyuemrlId = this.get32UUID();
	    		pd.put("FEIYUEMRL_ID", feiyuemrlId);
	    		e_offerService.saveFeiyueMRL(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyuemrlId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYUEMRL_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYUEMRL_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYUEMRL_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYUEMRL_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYUEMRL_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYUEMRL_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYUEMRL_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYUEMRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEIYUEMRL_SBJ"));
        	srPd.put("zk_", pd.getString("FEIYUEMRL_ZK"));
        	srPd.put("zhsbj_", pd.getString("FEIYUEMRL_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEIYUEMRL_SJBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("FEIYUEMRL_AZF"));
        	srPd.put("ysf_", pd.getString("FEIYUEMRL_YSF"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyuemrlId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	return mv;
    }
    
    @RequestMapping(value="saveFeiyangXF")
    public ModelAndView saveFeiyangXF(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyangxfId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangxfId = pd.getString("FEIYANGXF_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//编辑飞尚
    			e_offerService.updateFeiyangXF(pd);
    			//关联更新报价池信息
    			PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYANGXF_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANGXF_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYANGXF_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYANGXF_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANGXF_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYANGXF_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYANGXF_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANGXF_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANGXF_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		feiyangxfId = this.get32UUID();
	    		pd.put("FEIYANGXF_ID", feiyangxfId);
	    		e_offerService.saveFeiyangXF(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyangxfId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANGXF_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYANGXF_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYANGXF_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANGXF_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYANGXF_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYANGXF_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANGXF_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANGXF_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEIYANGXF_SBJ"));
        	srPd.put("zk_", pd.getString("FEIYANGXF_ZK"));
        	srPd.put("zhsbj_", pd.getString("FEIYANGXF_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEIYANGXF_SJBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("FEIYANGXF_AZF"));
        	srPd.put("ysf_", pd.getString("FEIYANGXF_YSF"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyangxfId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	return mv;
    }
    
    /**
     * 关联更新电梯状态 
     */
    public void updateDetails(PageData pd){
    	try{
    		String eIds = pd.getString("ELEV_IDS");
    		List<String> eIdList = Arrays.asList(eIds.split(","));
    		PageData updPd = new PageData();
    		updPd.put("list", eIdList);
    		e_offerService.updateDetails(updPd);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    }
    
    @RequestMapping(value="saveFeishang")
    public ModelAndView saveFeishang(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feishangId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feishangId = pd.getString("FEISHANG_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//编辑飞尚
    			e_offerService.updateFeishang(pd);
    			//关联更新报价池信息
    			PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEISHANG_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEISHANG_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEISHANG_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEISHANG_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEISHANG_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEISHANG_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEISHANG_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEISHANG_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEISHANG_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
    			//新增飞尚
	    		feishangId = this.get32UUID();
	    		pd.put("FEISHANG_ID", feishangId);
	        	e_offerService.saveFeishang(pd);
	        	//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
	        	//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feishangId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEISHANG_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEISHANG_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEISHANG_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEISHANG_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEISHANG_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEISHANG_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEISHANG_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEISHANG_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
    		PageData srPd = new PageData();//save_result.jsp
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEISHANG_SBJ"));
        	srPd.put("zk_", pd.getString("FEISHANG_ZK"));
        	srPd.put("zhsbj_", pd.getString("FEISHANG_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEISHANG_SJBJ"));
        	srPd.put("azf_", pd.getString("FEISHANG_AZF"));
        	srPd.put("ysf_", pd.getString("FEISHANG_YSF"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feishangId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    @RequestMapping(value="saveFeiyangMRL")
    public ModelAndView saveFeiyangMRL(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyangMrlId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangMrlId = pd.getString("FEIYANGMRL_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
	    		e_offerService.updateFeiyangMRL(pd);
	    		//关联更新报价池信息
    			PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYANGMRL_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANGMRL_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYANGMRL_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYANGMRL_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANGMRL_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYANGMRL_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYANGMRL_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANGMRL_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANGMRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
    			//保存飞扬MRL
	    		feiyangMrlId = this.get32UUID();
	    		pd.put("FEIYANGMRL_ID", feiyangMrlId);
	        	e_offerService.saveFeiyangMRL(pd);
	        	//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyangMrlId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANGMRL_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYANGMRL_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYANGMRL_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANGMRL_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYANGMRL_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYANGMRL_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANGMRL_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANGMRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	//放入saveresult信息
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEIYANGMRL_SBJ"));
        	srPd.put("zk_", pd.getString("FEIYANGMRL_ZK"));
        	srPd.put("zhsbj_", pd.getString("FEIYANGMRL_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEIYANGMRL_SJBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("FEIYANGMRL_AZF"));
        	srPd.put("ysf_", pd.getString("FEIYANGMRL_YSF"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyangMrlId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    @RequestMapping(value="saveFeiyang")
    public ModelAndView saveFeiyang(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyangId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangId = pd.getString("FEIYANG_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//编辑飞扬
    			e_offerService.updateFeiyang(pd);
    			//关联更新报价池信息
    			PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYANG_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANG_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYANG_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYANG_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANG_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYANG_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYANG_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANG_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANG_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
    			//新增保存飞扬
        		feiyangId = this.get32UUID();
        		pd.put("FEIYANG_ID", feiyangId);
            	e_offerService.saveFeiyang(pd);	        	
            	//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyangId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANG_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYANG_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEIYANG_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANG_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEIYANG_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEIYANG_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANG_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANG_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEIYANG_SBJ"));
        	srPd.put("zk_", pd.getString("FEIYANG_ZK"));
        	srPd.put("zhsbj_", pd.getString("FEIYANG_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEIYANG_SJBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("FEIYANG_AZF"));
        	srPd.put("ysf_", pd.getString("FEIYANG_YSF"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyangId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    
    @RequestMapping(value="saveDnp9300")
    public ModelAndView saveDnp9300(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String dnp9300Id = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			dnp9300Id = pd.getString("DNP9300_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
    			e_offerService.updateDnp9300(pd);
	        	//关联保存报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("DNP9300_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("DNP9300_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("DNP9300_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("DNP9300_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("DNP9300_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("DNP9300_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("DNP9300_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("DNP9300_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("DNP9300_SL").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BZ_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		dnp9300Id = this.get32UUID();
	    		pd.put("DNP9300_ID", dnp9300Id);
	    		e_offerService.saveDnp9300(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", dnp9300Id);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("DNP9300_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("DNP9300_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("DNP9300_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("DNP9300_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("DNP9300_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("DNP9300_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("DNP9300_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("DNP9300_SL").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BZ_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", "--");
        	srPd.put("z_", "--");
        	srPd.put("m_", "--");
        	srPd.put("sbj_", pd.getString("DNP9300_SBJ"));
        	srPd.put("zk_", pd.getString("DNP9300_ZK"));
        	srPd.put("zhsbj_", pd.getString("DNP9300_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("DNP9300_SJBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("DNP9300_AZF"));
        	srPd.put("ysf_", pd.getString("DNP9300_YSF"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+dnp9300Id+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    @RequestMapping(value="saveDnr")
    public ModelAndView saveDnr(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String dnrId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			dnrId = pd.getString("DNR_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
    			e_offerService.updateDnr(pd);
    			//关联保存报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("DNR_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("DNR_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("DNR_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("DNR_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("DNR_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("DNR_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("DNR_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("DNR_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("DNR_SL").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BZ_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		dnrId = this.get32UUID();
	    		pd.put("DNR_ID", dnrId);
	    		e_offerService.saveDnr(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", dnrId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("DNR_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("DNR_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("DNR_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("DNR_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("DNR_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("DNR_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("DNR_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("DNR_SL").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BZ_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", "--");
        	srPd.put("z_", "--");
        	srPd.put("m_", "--");
        	srPd.put("sbj_", pd.getString("DNR_SBJ"));
        	srPd.put("zk_", pd.getString("DNR_ZK"));
        	srPd.put("zhsbj_", pd.getString("DNR_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("DNR_SJBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("DNR_AZF"));
        	srPd.put("ysf_", pd.getString("DNR_YSF"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+dnrId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    @RequestMapping(value="saveShiny")
    public ModelAndView saveShiny(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String shinyId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			shinyId = pd.getString("SHINY_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			e_offerService.updateShiny(pd);
    			//关联保存报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("SHINY_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("SHINY_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("SHINY_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("SHINY_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("SHINY_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("SHINY_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("SHINY_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("SHINY_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("SHINY_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		shinyId = this.get32UUID();
	    		pd.put("SHINY_ID", shinyId);
	    		e_offerService.saveShiny(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", shinyId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("SHINY_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("SHINY_SBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("SHINY_ZK").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("SHINY_ZHSBJ").toString());
	        	bjcPd.put("BJC_AZF", pd.get("SHINY_AZF").toString());
	        	bjcPd.put("BJC_YSF", pd.get("SHINY_YSF").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("SHINY_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("SHINY_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("SHINY_SBJ"));
        	srPd.put("zk_", pd.getString("SHINY_ZK"));
        	srPd.put("zhsbj_", pd.getString("SHINY_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("SHINY_SJBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("SHINY_AZF"));
        	srPd.put("ysf_", pd.getString("SHINY_YSF"));
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+shinyId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     * 调用参考报价
     */
    @RequestMapping(value="setCbj")
    public ModelAndView setCbj(){
    	ModelAndView mv = new ModelAndView();
    	mv.addObject("FLAG", "CBJ");
    	PageData pd = this.getPageData();
    	pd.put("BJC_ID", pd.getString("CBJ_BJC_ID"));
    	PageData codPd = new PageData();
    	PageData modelsPd = new PageData();
    	PageData regelevStandardPd = new PageData();
    	try{
    		//根据报价池ID获取COD数据
    		String MODELS = pd.getString("MODELS");
    		if(MODELS.equals("FEISHANG")){
				codPd = e_offerService.findFeishangCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEISHANG_ID", pd.getString("FEISHANG_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEISHANG_SL", pd.getString("FEISHANG_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
    			mv.addObject("pd", codPd);
    			mv.addObject("modelsPd", modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			mv.addObject("msg", "saveFeishang");
    			mv.setViewName("system/e_offer/feishang");
    		}else if(MODELS.equals("FEIYANG")){
				codPd = e_offerService.findFeiyangCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYANG_ID", pd.getString("FEIYANG_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYANG_SL", pd.getString("FEIYANG_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
    			mv.addObject("pd", codPd);
    			mv.addObject("modelsPd", modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			mv.addObject("msg", "saveFeiyang");
    			mv.setViewName("system/e_offer/feiyang3000");
			}else if(MODELS.equals("FEIYANGMRL")){
				codPd = e_offerService.findFeiyangMRLCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYANGMRL_ID", pd.getString("FEIYANGMRL_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYANGMRL_SL", pd.getString("FEIYANGMRL_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyangMRL");
				mv.setViewName("system/e_offer/feiyang3000_mrl");
			}else if(MODELS.equals("FEIYANGXF")){
				codPd = e_offerService.findFeiyangXFCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYANGXF_ID", pd.getString("FEIYANGXF_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYANGXF_SL", pd.getString("FEIYANGXF_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyangXF");
				mv.setViewName("system/e_offer/feiyang_xf");
			}else if(MODELS.equals("FEIYUE")){
				codPd = e_offerService.findFeiyueCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYUE_ID", pd.getString("FEIYUE_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYUE_SL", pd.getString("FEIYUE_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyue");
				mv.setViewName("system/e_offer/feiyue");
			}else if(MODELS.equals("FEIYUEMRL")){
				codPd = e_offerService.findFeiyueMRLCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYUEMRL_ID", pd.getString("FEIYUEMRL_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYUEMRL_SL", pd.getString("FEIYUEMRL_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyueMRL");
				mv.setViewName("system/e_offer/feiyue_mrl");
			}else if(MODELS.equals("SHINY")){
				codPd = e_offerService.findShinyCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("SHINY_ID", pd.getString("SHINY_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("SHINY_SL", pd.getString("SHINY_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveShiny");
				mv.setViewName("system/e_offer/shiny");
			}else if(MODELS.equals("DNP9300")){
				codPd = e_offerService.findDnp9300COD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("DNP9300_ID", pd.getString("DNP9300_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("DNP9300_SL", pd.getString("DNP9300_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId2(modelsPd);
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveDnp9300");
				mv.setViewName("system/e_offer/dnp9300");
			}else if(MODELS.equals("DNR")){
				codPd = e_offerService.findDnrCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("DNR_ID", pd.getString("DNR_ID"));
				codPd.put("BJC_ID", pd.getString("BJC_ID"));
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("DNR_SL", pd.getString("DNR_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId2(modelsPd);
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveDnr");
				mv.setViewName("system/e_offer/dnr");
			}
    		//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			mv.addObject("provinceList", provinceList);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    } 
    
    
    /**
     * 调用装潢价格
     */
    @RequestMapping(value="setZhj")
    public ModelAndView setZhj(){
    	ModelAndView mv = new ModelAndView();
    	mv.addObject("FLAG", "ZHJ");
    	PageData pd = this.getPageData();
    	PageData codPd = new PageData();
    	PageData regelevStandardPd = new PageData();
    	try{
    		//根据报价池ID获取COD数据
    		String MODELS = pd.getString("MODELS");
    		if(MODELS.equals("FEISHANG")){
    				pd.put("FEISHANG_ID", pd.getString("ID"));
    				//查询出装潢价格调用对象的COD
    				codPd = e_offerService.findFeishang(pd);
    				//放入装潢价格部分
    				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
    				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
    				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
    				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
    				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
    				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
    				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
    				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
    				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
    				pd.put("JXZH_BXGDD", codPd.containsKey("JXZH_BXGDD")?codPd.getString("JXZH_BXGDD").toString():"");
    				pd.put("JXZH_BXGDB", codPd.containsKey("JXZH_BXGDB")?codPd.getString("JXZH_BXGDB").toString():"");
    				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
    				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
    				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
    				pd.put("JXZH_FZTXH", codPd.containsKey("JXZH_FZTXH")?codPd.getString("JXZH_FZTXH").toString():"");
    				pd.put("JXZH_FZTAZWZ", codPd.containsKey("JXZH_FZTAZWZ")?codPd.getString("JXZH_FZTAZWZ").toString():"");
    				/*codPd.put("FEISHANG_SL", pd.get("FEISHANG_SL").toString());
    				codPd.put("FEISHANG_ZK", pd.get("FEISHANG_ZK").toString());*/
    				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
    				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
    				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
    				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
    				regelevStandardPd.put("C", pd.getString("BZ_C"));
    				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
    				regelevStandardPd.put("M", pd.getString("BZ_M"));
    				regelevStandardPd.put("PRICE", pd.getString("FEISHANG_SBJ"));
        			mv.addObject("pd", pd);
        			mv.addObject("regelevStandardPd", regelevStandardPd);
        			mv.addObject("msg", "saveFeishang");
        			mv.setViewName("system/e_offer/feishang");
    		}else if(MODELS.equals("FEIYANG")){
    			pd = this.getPageData();
				pd.put("FEIYANG_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyang(pd);//放入装潢价格部分
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_AQC", codPd.containsKey("JXZH_AQC")?codPd.getString("JXZH_AQC").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYANG_SL", pd.getString("FEIYANG_SL"));
				codPd.put("FEIYANG_ZK", pd.getString("FEIYANG_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYANG_SBJ"));
    			mv.addObject("pd", pd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			mv.addObject("msg", "saveFeiyang");
    			mv.setViewName("system/e_offer/feiyang3000");
			}else if(MODELS.equals("FEIYANGMRL")){
				pd = this.getPageData();
				pd.put("FEIYANGMRL_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyangMRL(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_AQC", codPd.containsKey("JXZH_AQC")?codPd.getString("JXZH_AQC").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYANGMRL_SL", pd.getString("FEIYANGMRL_SL"));
				codPd.put("FEIYANGMRL_ZK", pd.getString("FEIYANGMRL_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYANGMRL_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyangMRL");
				mv.setViewName("system/e_offer/feiyang3000_mrl");
			}else if(MODELS.equals("FEIYANGXF")){
				pd = this.getPageData();
				pd.put("FEIYANGXF_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyangXF(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYANGXF_SL", pd.getString("FEIYANGXF_SL"));
				codPd.put("FEIYANGXF_ZK", pd.getString("FEIYANGXF_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYANGXF_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyangXF");
				mv.setViewName("system/e_offer/feiyang_xf");
			}else if(MODELS.equals("FEIYUE")){
				pd = this.getPageData();
				pd.put("FEIYUE_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyue(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_AQC", codPd.containsKey("JXZH_AQC")?codPd.getString("JXZH_AQC").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYUE_SL", pd.getString("FEIYUE_SL"));
				codPd.put("FEIYUE_ZK", pd.getString("FEIYUE_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYUE_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyue");
				mv.setViewName("system/e_offer/feiyue");
			}else if(MODELS.equals("FEIYUEMRL")){
				pd = this.getPageData();
				pd.put("FEIYUEMRL_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyueMRL(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_AQC", codPd.containsKey("JXZH_AQC")?codPd.getString("JXZH_AQC").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYUEMRL_SL", pd.getString("FEIYUEMRL_SL"));
				codPd.put("FEIYUEMRL_ZK", pd.getString("FEIYUEMRL_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYUEMRL_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyueMRL");
				mv.setViewName("system/e_offer/feiyue_mrl");
			}else if(MODELS.equals("SHINY")){
				pd = this.getPageData();
				pd.put("SHINY_ID", pd.getString("ID"));
				codPd = e_offerService.findShiny(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_JDAQC", codPd.containsKey("JXZH_JDAQC")?codPd.getString("JXZH_JDAQC").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_FZTXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FZTAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				/*codPd.put("SHINY_SL", pd.getString("SHINY_SL"));
				codPd.put("SHINY_ZK", pd.getString("SHINY_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("SHINY_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveShiny");
				mv.setViewName("system/e_offer/shiny");
			}
    		//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			mv.addObject("provinceList", provinceList);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    } 
    
    
    /**
     * 删除报价池信息
     */
    @RequestMapping(value="deleteBjc")
    @ResponseBody
    public Object deleteBjc(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	PageData pd = this.getPageData();
    	try{
    		PageData bjcPd = e_offerService.selectBjc(pd);
    		//电梯id
    		List<String> eIdList = Arrays.asList(bjcPd.getString("BJC_ELEV").split(","));
    		pd.put("list", eIdList);
    		PageData modelsPd = e_offerService.findModels(pd);
    		String modelsName = modelsPd.getString("models_name");
    		if(modelsName.equals("飞尚GL freight")){
    			e_offerService.deleteFeishangByBjc(pd);
    		}else if(modelsName.equals("飞扬3000+")){
    			e_offerService.deleteFeiyangByBjc(pd);
    		}else if(modelsName.equals("飞扬3000+MRL")){
    			e_offerService.deleteFeiyangMRLByBjc(pd);
    		}else if(modelsName.equals("飞扬消防梯")){
    			e_offerService.deleteFeiyangXFByBjc(pd);
    		}else if(modelsName.equals("新飞越")){
    			e_offerService.deleteFeiyueByBjc(pd);
    		}else if(modelsName.equals("新飞越MRL")){
    			e_offerService.deleteFeiyueMRLByBjc(pd);
    		}else if(modelsName.equals("DNP9300")){
    			e_offerService.deleteDnp9300ByBjc(pd);
    		}else if(modelsName.equals("DNR")){
    			e_offerService.deleteDnrByBjc(pd);
    		}else if(modelsName.equals("曳引货梯")){
    			e_offerService.deleteShinyByBjc(pd);
    		}
			e_offerService.deleteBjc(pd);
			e_offerService.initDetails(pd);
    		map.put("msg", "success");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    
    /**
     *跳转到家用梯报价单页面 
     */
    @RequestMapping(value="homeelevParam")
    public ModelAndView homeelevParam(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		//获取电梯id
			String elev_ids = pd.getString("elev_ids");
			//获取该行数的下标
			String rowIndex = pd.getString("rowIndex");
			//获取标准型号id
			String models_id = pd.getString("modelsId");
			//获取数量
			Integer offer_num = Integer.parseInt(pd.getString("offer_num"));
			mv.setViewName("system/e_offer/homeelev");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
	
	/**
	 *跳转到扶梯报价单页面 
	 */
	@RequestMapping(value="escalatorParam")
	public ModelAndView escalatorParam(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//获取电梯id
			String elev_ids = pd.getString("elev_ids");
			//获取该行数的下标
			String rowIndex = pd.getString("rowIndex");
			//获取标准型号id
			String models_id = pd.getString("modelsId");
			//获取数量
			Integer offer_num = Integer.parseInt(pd.getString("offer_num"));
			//获取设备名
			String name = e_offerService.findEscalatorConfigName(models_id);
			//加载设备基础价
			Integer price = e_offerService.findEscalatorStandardPrice(models_id);
			//计算基础设备总价格
			Integer countBasePrice = offer_num*price;
			//获取电梯标准信息
			PageData stdPd = e_offerService.findEscalatorStandard(models_id);
			
			//获取折扣
			//--
			//基础报价信息部分放入PD
			PageData basePd = new PageData();
			basePd.put("rowIndex", (Integer.parseInt(rowIndex)+1));
			basePd.put("models_id", models_id);
			basePd.put("elev_ids", elev_ids);
			basePd.put("offer_num", offer_num);
			basePd.put("price", price);
			basePd.put("name", name);
			basePd.put("stdPd", stdPd);
			basePd.put("countBasePrice", countBasePrice);
			
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			mv.addObject("cityList", cityList);
			
			mv.addObject("basePd", basePd);
			mv.setViewName("system/e_offer/escalator");
			
			mv.addObject("msg", "escalatorAdd");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *查询价格 
	 */
	@RequestMapping(value="setPrice")
	@ResponseBody
	public Object setPrice(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		PageData dataPd = new PageData();
		try{
			pd = this.getPageData();
			String keyword = pd.getString("keyword");
			String price_type= e_offerService.findPriceTypeByKeyWord(keyword);
			if(price_type.equals("1")){//选项类型,总价
				dataPd = e_offerService.findPriceOption(pd);
				//获取该选项总价
				float price = Float.parseFloat((String)dataPd.get("price"));
				//获取单位
				String unit = (String)dataPd.get("unit");
				//获取备注
				String remark = (String)dataPd.get("remark");
				//获取交货期
				String dlvr_date = (String)dataPd.get("dlvr_date");
				
				//计算总价之后放入map
				map.put("price", price);
				map.put("unit", unit==null?"--":unit);
				map.put("remark", remark==null?"--":remark);
				map.put("dlvr_date", dlvr_date==null?"--":dlvr_date);
			}else if(price_type.equals("2")){//单价
				dataPd = e_offerService.findPriceUnit(pd);
				//获取单价
				float unitPrice = Float.parseFloat((String)dataPd.get("price"));
				//获取数量
				Integer num = Integer.parseInt((String)pd.get("param"));
				//获取单位
				String unit = (String)dataPd.get("unit");
				//获取备注
				String remark = (String)dataPd.get("remark");
				//获取交货期
				String dlvr_date = (String)dataPd.get("dlvr_date");
				
				//计算总价之后放入map
				map.put("price", unitPrice*num);
				map.put("unit", unit==null?"--":unit);
				map.put("remark", remark==null?"--":remark);
				map.put("dlvr_date", dlvr_date==null?"--":dlvr_date);
			}else if(price_type.equals("0")){//加价公式
				dataPd = e_offerService.findPriceFormula(pd);
				//获取加价公式
				String formula = (String)dataPd.get("formula");
				//获取页面传入参数
				String param = (String)pd.get("param");
				//获取单位
				String unit = (String)dataPd.get("unit");
				//获取备注
				String remark = (String)dataPd.get("remark");
				//获取交货期
				String dlvr_date = (String)dataPd.get("dlvr_date");
				formula = formula.replaceAll("H", param);
				ScriptEngineManager manager = new ScriptEngineManager();  
		        ScriptEngine engine = manager.getEngineByName("js");  
				float price = Float.parseFloat(engine.eval(formula).toString());
				
				//计算总价之后放入map
				map.put("price", price);
				map.put("unit", unit==null?"--":unit);
				map.put("remark", remark==null?"--":remark);
				map.put("dlvr_date", dlvr_date==null?"--":dlvr_date);
			}else if(price_type.equals("3")){//单价选项,固定数量为1
				dataPd = e_offerService.findPriceUnit(pd);
				//获取单价
				float price = Float.parseFloat((String)dataPd.get("price"));
				//获取单位
				String unit = (String)dataPd.get("unit");
				//获取备注
				String remark = (String)dataPd.get("remark");
				//获取交货期
				String dlvr_date = (String)dataPd.get("dlvr_date");
				
				//计算总价之后放入map
				map.put("price", price);
				map.put("unit", unit==null?"--":unit);
				map.put("remark", remark==null?"--":remark);
				map.put("dlvr_date", dlvr_date==null?"--":dlvr_date);
			}else if(price_type.equals("4")){//选项类型,多选
				String param = pd.get("param").toString();
				List<String> paramList = Arrays.asList(param.split(","));
				pd.put("list", paramList);
				dataPd = e_offerService.findPriceOptions(pd);
				//获取单价
				if(dataPd!=null){
					float price = Float.parseFloat(dataPd.get("price").toString());
					//计算总价之后放入map
					map.put("price", price);
				}else{
					map.put("price", "--");
				}
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return map;
	}
	
	@RequestMapping(value="escalatorAdd")
	public ModelAndView escalatorAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			//获取页面
			pd = this.getPageData();
			//拼接基本参数json
			String BASE_SPTJ = pd.get("BASE_SPTJ").toString();
			String BASE_TSGD = pd.get("BASE_TSGD").toString();
			String BASE_SPKJ = pd.get("BASE_SPKJ").toString();
			String BASE_YXSD = pd.get("BASE_YXSD").toString();
			String BASE_SXDY = pd.get("BASE_SXDY").toString();
			String BASE_ZMDY = pd.get("BASE_ZMDY").toString();
			String BASE_PL = pd.get("BASE_PL").toString();
			String BASE_AZHJ = pd.get("BASE_AZHJ").toString();
			String BASE_FSLX = pd.get("BASE_FSLX").toString();
			String BASE_FSGD = pd.get("BASE_FSGD").toString();
			String BASE_ZJZCSL = pd.get("BASE_ZJZCSL").toString();
			String BASE_BZXS = pd.get("BASE_BZXS").toString();
			String BASE_YSFS = pd.get("BASE_YSFS").toString();
			String BASE_JHXT = pd.get("BASE_JHXT").toString();
			String BASE_TJSDJC = pd.get("BASE_TJSDJC").toString();
			String BASE_TJXDJC = pd.get("BASE_TJXDJC").toString();
			String baseJsonStr = "{'BASE_SPTJ':'"+BASE_SPTJ+"','BASE_TSGD':'"+BASE_TSGD+"','BASE_SPKJ':'"+BASE_SPKJ+"','BASE_YXSD':'"+BASE_YXSD+"','BASE_SXDY':'"
					+BASE_SXDY+"','BASE_ZMDY':'"+BASE_ZMDY+"','BASE_PL':'"+BASE_PL+"','BASE_AZHJ':'"+BASE_AZHJ+"','BASE_FSLX':'"+BASE_FSLX+"','BASE_FSGD':'"
					+BASE_FSGD+"','BASE_ZJZCSL':'"+BASE_ZJZCSL+"','BASE_BZXS':'"+BASE_BZXS+"','BASE_YSFS':'"+BASE_YSFS+"','BASE_JHXT':'"+BASE_JHXT+"','BASE_TJSDJC':'"
					+BASE_TJSDJC+"','BASE_TJXDJC':'"+BASE_TJXDJC+"'}";
			System.out.println(baseJsonStr);
			
			//拼接部件参数json
			String PART_JSJ = pd.get("PART_JSJ").toString();
			String PART_TJLX = pd.get("PART_TJLX").toString();
			String PART_TJYS = pd.get("PART_TJYS").toString();
			String PART_TJZFX = pd.containsKey("PART_TJZFX")?pd.get("PART_TJZFX").toString():"0";
			String PART_TJBKCZ = pd.get("PART_TJBKCZ").toString();
			String PART_FSDGCZ = pd.get("PART_FSDGCZ").toString();
			String PART_FSDGG = pd.get("PART_FSDGG").toString();
			String PART_WQBCZ = pd.get("PART_WQBCZ").toString();
			String PART_NWGBCZ = pd.get("PART_NWGBCZ").toString();
			String PART_SCTBJHDGB = pd.get("PART_SCTBJHDGB").toString();
			String PART_SCB = pd.get("PART_SCB").toString();
			String PART_QDFS = pd.get("PART_QDFS").toString();
			String partJsonStr = "{'PART_JSJ':'"+PART_JSJ+"','PART_TJLX':'"+PART_TJLX+"','PART_TJYS':'"+PART_TJYS+"','PART_TJZFX':'"+PART_TJZFX+"','PART_TJBKCZ':'"
					+PART_TJBKCZ+"','PART_FSDGCZ':'"+PART_FSDGCZ+"','PART_FSDGG':'"+PART_FSDGG+"','PART_WQBCZ':'"+PART_WQBCZ+"','PART_NWGBCZ':'"
					+PART_NWGBCZ+"','PART_SCTBJHDGB':'"+PART_SCTBJHDGB+"','PART_SCB':'"+PART_SCB+"','PART_QDFS':'"+PART_QDFS+"'}";
			System.out.println(partJsonStr);
			
			//保存标准参数json
			String STD_JTAN = pd.containsKey("STD_JTAN")?pd.get("STD_JTAN").toString():"0";
			String STD_YSKG = pd.containsKey("STD_YSKG")?pd.get("STD_YSKG").toString():"0";
			String STD_FSJCKBHKG = pd.containsKey("STD_FSJCKBHKG")?pd.get("STD_FSJCKBHKG").toString():"0";
			String STD_TJLDLBHKG = pd.containsKey("STD_TJLDLBHKG")?pd.get("STD_TJLDLBHKG").toString():"0";
			String STD_TJXXBH = pd.containsKey("STD_TJXXBH")?pd.get("STD_TJXXBH").toString():"0";
			String STD_QXJCXBH = pd.containsKey("STD_QXJCXBH")?pd.get("STD_QXJCXBH").toString():"0";
			String STD_DJHZBH = pd.containsKey("STD_DJHZBH")?pd.get("STD_DJHZBH").toString():"0";
			String STD_JFHB = pd.containsKey("STD_JFHB")?pd.get("STD_JFHB").toString():"0";
			String STD_DJGZBH = pd.containsKey("STD_DJGZBH")?pd.get("STD_DJGZBH").toString():"0";
			String STD_DJGRBH = pd.containsKey("STD_DJGRBH")?pd.get("STD_DJGRBH").toString():"0";
			String STD_SCBHKG = pd.containsKey("STD_SCBHKG")?pd.get("STD_SCBHKG").toString():"0";
			String STD_WXSDZZ = pd.containsKey("STD_WXSDZZ")?pd.get("STD_WXSDZZ").toString():"0";
			String STD_QDJL = pd.containsKey("STD_QDJL")?pd.get("STD_QDJL").toString():"0";
			String STD_FNZBH = pd.containsKey("STD_FNZBH")?pd.get("STD_FNZBH").toString():"0";
			String STD_FSDFJDL = pd.containsKey("STD_FSDFJDL")?pd.get("STD_FSDFJDL").toString():"0";
			String STD_GZZDQJKKG = pd.containsKey("STD_GZZDQJKKG")?pd.get("STD_GZZDQJKKG").toString():"0";
			String STD_TJFJDS = pd.containsKey("STD_TJFJDS")?pd.get("STD_TJFJDS").toString():"0";
			String STD_QDLDLBH = pd.containsKey("STD_QDLDLBH")?pd.get("STD_QDLDLBH").toString():"0";
			String STD_SDJXCZ = pd.containsKey("STD_SDJXCZ")?pd.get("STD_SDJXCZ").toString():"0";
			String STD_SDPCZZ = pd.containsKey("STD_SDPCZZ")?pd.get("STD_SDPCZZ").toString():"0";
			String STD_GBJXKG = pd.containsKey("STD_GBJXKG")?pd.get("STD_GBJXKG").toString():"0";
			String STD_WQMS = pd.containsKey("STD_WQMS")?pd.get("STD_WQMS").toString():"0";
			String STD_FSDSDJK = pd.containsKey("STD_FSDSDJK")?pd.get("STD_FSDSDJK").toString():"0";
			String STD_TJYSBH = pd.containsKey("STD_TJYSBH")?pd.get("STD_TJYSBH").toString():"0";
			String STD_TJCSBH = pd.containsKey("STD_TJCSBH")?pd.get("STD_TJCSBH").toString():"0";
			String STD_ZDJLCXBJ = pd.containsKey("STD_ZDJLCXBJ")?pd.get("STD_ZDJLCXBJ").toString():"0";
			String STD_GZXS = pd.containsKey("STD_GZXS")?pd.get("STD_GZXS").toString():"0";
			String STD_TJJXZM = pd.containsKey("STD_TJJXZM")?pd.get("STD_TJJXZM").toString():"0";
			String STD_SXJFTB = pd.containsKey("STD_SXJFTB")?pd.get("STD_SXJFTB").toString():"0";
			String STD_FJZDQ = pd.containsKey("STD_FJZDQ")?pd.get("STD_FJZDQ").toString():"0";
			String STD_JXSB = pd.containsKey("STD_JXSB")?pd.get("STD_JXSB").toString():"0";
			String STD_JXXD = pd.containsKey("STD_JXXD")?pd.get("STD_JXXD").toString():"0";
			String STD_WQAQZZ = pd.containsKey("STD_WQAQZZ")?pd.get("STD_WQAQZZ").toString():"0";
			String STD_FSDDDBH = pd.containsKey("STD_FSDDDBH")?pd.get("STD_FSDDDBH").toString():"0";
			String STD_DLFDLJQ = pd.containsKey("STD_DLFDLJQ")?pd.get("STD_DLFDLJQ").toString():"0";

			String stdJsonStr = "{'STD_JTAN':'"+STD_JTAN+"','STD_YSKG':'"+STD_YSKG+"','STD_FSJCKBHKG':'"+STD_FSJCKBHKG+"','STD_TJLDLBHKG':'"+STD_TJLDLBHKG+"','STD_TJXXBH':'"
					+STD_TJXXBH+"','STD_QXJCXBH':'"+STD_QXJCXBH+"','STD_DJHZBH':'"+STD_DJHZBH+"','STD_JFHB':'"+STD_JFHB+"','STD_DJGZBH':'"
					+STD_DJGZBH+"','STD_DJGRBH':'"+STD_DJGRBH+"','STD_SCBHKG':'"+STD_SCBHKG+"','STD_WXSDZZ':'"+STD_WXSDZZ+"','STD_QDJL':'"
					+STD_QDJL+"'STD_FNZBH':'"+STD_FNZBH+"','STD_FSDFJDL':'"+STD_FSDFJDL+"','STD_GZZDQJKKG':'"+STD_GZZDQJKKG+"','STD_TJFJDS':'"+STD_TJFJDS+"','STD_QDLDLBH':'"
					+STD_QDLDLBH+"','STD_SDJXCZ':'"+STD_SDJXCZ+"','STD_SDPCZZ':'"+STD_SDPCZZ+"','STD_GBJXKG':'"+STD_GBJXKG+"','STD_WQMS':'"+STD_WQMS+"','STD_FSDSDJK':'"
					+STD_FSDSDJK+"','STD_TJYSBH':'"+STD_TJYSBH+"','STD_TJCSBH':'"+STD_TJCSBH+"','STD_ZDJLCXBJ':'"+STD_ZDJLCXBJ+"','STD_GZXS':'"+STD_GZXS+"','STD_TJJXZM':'"
					+STD_TJJXZM+"','STD_SXJFTB':'"+STD_SXJFTB+"','STD_FJZDQ':'"+STD_FJZDQ+"','STD_JXSB':'"+STD_JXSB+"','STD_JXXD':'"+STD_JXXD+"','STD_WQAQZZ':'"
					+STD_WQAQZZ+"','STD_FSDDDBH':'"+STD_FSDDDBH+"','STD_DLFDLJQ':'"+STD_DLFDLJQ+"'}";
			System.out.println(stdJsonStr);
			
			//保存选配参数
			String OPT_AQZDQ = pd.containsKey("OPT_AQZDQ")?pd.get("OPT_AQZDQ").toString():"0";
			String OPT_GCD = pd.containsKey("OPT_GCD")?pd.get("OPT_GCD").toString():"0";
			String OPT_JTLXD = pd.containsKey("OPT_JTLXD")?pd.get("OPT_JTLXD").toString():"0";
			String OPT_ZDQMSJK = pd.containsKey("OPT_ZDQMSJK")?pd.get("OPT_ZDQMSJK").toString():"0";
			String OPT_ZDJY = pd.containsKey("OPT_ZDJY")?pd.get("OPT_ZDJY").toString():"0";
			String OPT_QDLLZ = pd.containsKey("OPT_QDLLZ")?pd.get("OPT_QDLLZ").toString():"0";
			String OPT_WQZM = pd.containsKey("OPT_WQZM")?pd.get("OPT_WQZM").toString():"0";
			String OPT_TJFTBH = pd.containsKey("OPT_TJFTBH")?pd.get("OPT_TJFTBH").toString():"0";
			String OPT_FSDDDBHZZ = pd.containsKey("OPT_FSDDDBHZZ")?pd.get("OPT_FSDDDBHZZ").toString():"0";
			String OPT_ZDWQJXKG = pd.containsKey("OPT_ZDWQJXKG")?pd.get("OPT_ZDWQJXKG").toString():"0";
			String OPT_SCZM = pd.containsKey("OPT_SCZM")?pd.get("OPT_SCZM").toString():"0";
			String OPT_YSFLQ = pd.containsKey("OPT_YSFLQ")?pd.get("OPT_YSFLQ").toString():"0";
			String OPT_FHBH = pd.containsKey("OPT_FHBH")?pd.get("OPT_FHBH").toString():"0";
			String OPT_TJLFHZ = pd.containsKey("OPT_TJLFHZ")?pd.get("OPT_TJLFHZ").toString():"0";
			String OPT_WZSWZ = pd.get("OPT_WZSWZ").toString();
			String OPT_ZSBCL = pd.get("OPT_ZSBCL").toString();
			String OPT_ZSBHD = pd.get("OPT_ZSBHD").toString();
			String OPT_WXHL = pd.get("OPT_WXHL").toString();
			String OPT_DZGSS = pd.get("OPT_DZGSS").toString();
			String OPT_FPZZ = pd.containsKey("OPT_FPZZ")?pd.get("OPT_FPZZ").toString():"0";
			String OPT_HJJR = pd.containsKey("OPT_HJJR")?pd.get("OPT_HJJR").toString():"0";
			String OPT_SCJR = pd.containsKey("OPT_SCJR")?pd.get("OPT_SCJR").toString():"0";
			String OPT_FSJR = pd.containsKey("OPT_FSJR")?pd.get("OPT_FSJR").toString():"0";
			String optJsonStr = "{'OPT_AQZDQ':'"+OPT_AQZDQ+"','OPT_GCD':'"+OPT_GCD+"','OPT_JTLXD':'"+OPT_JTLXD+"','OPT_ZDQMSJK':'"+OPT_ZDQMSJK+"','OPT_ZDJY':'"
					+OPT_ZDJY+"','OPT_QDLLZ':'"+OPT_QDLLZ+"','OPT_WQZM':'"+OPT_WQZM+"','OPT_TJFTBH':'"+OPT_TJFTBH+"','OPT_FSDDDBHZZ':'"
					+OPT_FSDDDBHZZ+"','OPT_ZDWQJXKG':'"+OPT_ZDWQJXKG+"','OPT_SCZM':'"+OPT_SCZM+"','OPT_YSFLQ':'"+OPT_YSFLQ+"','OPT_FHBH':'"
					+OPT_FHBH+"'OPT_TJLFHZ':'"+OPT_TJLFHZ+"','OPT_WZSWZ':'"+OPT_WZSWZ+"','OPT_ZSBCL':'"+OPT_ZSBCL+"','OPT_ZSBHD':'"+OPT_ZSBHD+"','OPT_WXHL':'"
					+OPT_WXHL+"','OPT_DZGSS':'"+OPT_DZGSS+"','OPT_FPZZ':'"+OPT_FPZZ+"','OPT_HJJR':'"+OPT_HJJR+"','OPT_SCJR':'"+OPT_SCJR+"','OPT_FSJR':'"
					+OPT_FSJR+"'}";
			System.out.println(optJsonStr);
			
			//保存室内外环境参数
			String ENV_ZDJY = pd.get("ENV_ZDJY_VAL").toString();
			String ENV_DJ = pd.get("ENV_DJ_VAL").toString();
			String ENV_KZXT = pd.get("ENV_KZXT_VAL").toString();
			String ENV_HDGBLJC = pd.get("ENV_HDGBLJC_VAL").toString();
			String ENV_SWXFSD = pd.get("ENV_SWXFSD_VAL").toString();
			String ENV_NWGBBXG = pd.get("ENV_NWGBBXG_VAL").toString();
			String ENV_WQBXG = pd.get("ENV_WQBXG_VAL").toString();
			String ENV_WZSBBXG = pd.get("ENV_WZSBBXG_VAL").toString();
			String ENV_FSDGBXG = pd.get("ENV_FSDGBXG_VAL").toString();
			String ENV_JSGJPSBYQ = pd.get("ENV_JSGJPSBYQ_VAL").toString();
			String ENV_JSGJRJDX = pd.get("ENV_JSGJRJDX_VAL").toString();
			String ENV_FXCL = pd.get("ENV_FXCL_VAL").toString();
			String ENV_DKLCL = pd.get("ENV_DKLCL_VAL").toString();
			String ENV_BQZ = pd.get("ENV_BQZ_VAL").toString();
			String ENV_YSFLQZZ = pd.get("ENV_YSFLQZZ_VAL").toString();
			String ENV_FHBH = pd.get("ENV_FHBH_VAL").toString();
			String ENV_TJLFHZ = pd.get("ENV_TJLFHZ_VAL").toString();
			String ENV_HJJR = pd.get("ENV_HJJR_VAL").toString();
			String ENV_SCJR = pd.get("ENV_SCJR_VAL").toString();
			String ENV_FSJR = pd.get("ENV_FSJR_VAL").toString();

			String envJsonStr = "{'ENV_ZDJY':'"+ENV_ZDJY+"','ENV_DJ':'"+ENV_DJ+"','ENV_KZXT':'"+ENV_KZXT+"','ENV_HDGBLJC':'"+ENV_HDGBLJC+"','ENV_SWXFSD':'"
					+ENV_SWXFSD+"','ENV_NWGBBXG':'"+ENV_NWGBBXG+"','ENV_WQBXG':'"+ENV_WQBXG+"','ENV_WZSBBXG':'"+ENV_WZSBBXG+"','ENV_FSDGBXG':'"
					+ENV_FSDGBXG+"','ENV_JSGJPSBYQ':'"+ENV_JSGJPSBYQ+"','ENV_JSGJRJDX':'"+ENV_JSGJRJDX+"','ENV_FXCL':'"+ENV_FXCL+"','ENV_DKLCL':'"
					+ENV_DKLCL+"'ENV_BQZ':'"+ENV_BQZ+"','ENV_YSFLQZZ':'"+ENV_YSFLQZZ+"','ENV_FHBH':'"+ENV_FHBH+"','ENV_TJLFHZ':'"+ENV_TJLFHZ+"','ENV_HJJR':'"
					+ENV_HJJR+"','ENV_SCJR':'"+ENV_SCJR+"','ENV_FSJR':'"+ENV_FSJR+"'}";
			System.out.println(envJsonStr);
			//保存报价明细
			//e_offerService.saveEscalator(pd);
			//是否有非标项
			
			String rowIndex = pd.get("rowIndex").toString();
			String elev_ids = pd.get("elev_ids").toString();
			String models_id = pd.get("models_id").toString();
			String esca_angle = pd.get("esca_angle").toString();
			String esca_spec = pd.get("esca_spec").toString();
			String esca_width = pd.get("esca_width").toString();
			String esca_num = pd.get("esca_num").toString();
			String discount = pd.get("discount").toString();
			String floor = pd.get("floor").toString();
			String eqpt_price = pd.get("eqpt_price").toString();
			String disc_price = pd.get("disc_price").toString();
			String install_price = pd.get("install_price").toString();
			String trans_price = pd.get("trans_price").toString();
			String last_offer = pd.get("last_offer").toString();
			
			//清单数据拼接json,编辑/保存用
			/*String jsonStr = "{'models_id':"+models_id+"','elev_ids':'"+elev_ids+"','rowIndex':'"+rowIndex+"','esca_angle':'"+esca_angle+"','esca_spec':'"+esca_spec+"','esca_width':'"+esca_width+"','esca_num':'"
					+esca_num+"','discount':'"+discount+"','floor':'"+floor+"','eqpt_price':'"+eqpt_price+"','disc_price':'"+disc_price+"','install_price':'"+install_price+"','trans_price':'"+trans_price+"','last_offer':'"+last_offer+"',"
					+"'esca_base':'"+baseJsonStr+"','esca_part':'"+partJsonStr+"','esca_std':'"+stdJsonStr+"','esca_opt':'"+optJsonStr+"','esca_env':'"+envJsonStr+"'}";*/
			String jsonStr = "{\\\"models_id\\\":\\\""+models_id+"\\\",\\\"elev_ids\\\":\\\""+elev_ids+"\\\",\\\"rowIndex\\\":\\\""+rowIndex+"\\\",\\\"esca_angle\\\":\\\""+esca_angle+"\\\",\\\"esca_spec\\\":\\\""+esca_spec+"\\\",\\\"esca_width\\\":\\\""+esca_width+"\\\",\\\"esca_num\\\":\\\""
					+esca_num+"\\\",\\\"discount\\\":\\\""+discount+"\\\",\\\"floor\\\":\\\""+floor+"\\\",\\\"eqpt_price\\\":\\\""+eqpt_price+"\\\",\\\"disc_price\\\":\\\""+disc_price+"\\\",\\\"install_price\\\":\\\""+install_price+"\\\",\\\"trans_price\\\":\\\""+trans_price+"\\\",\\\"last_offer\\\":\\\""+last_offer+"\\\","
					+"\\\"esca_base\\\":\\\""+baseJsonStr+"\\\",\\\"esca_part\\\":\\\""+partJsonStr+"\\\",\\\"esca_std\\\":\\\""+stdJsonStr+"\\\",\\\"esca_opt\\\":\\\""+optJsonStr+"\\\",\\\"esca_env\\\":\\\""+envJsonStr+"\\\"}";
			System.out.println(jsonStr);
			
			mv.addObject("jsonStr", jsonStr);
			mv.addObject("escalatorPd", pd);
			mv.addObject("rowIndex", rowIndex);
			mv.addObject("floor", floor);
			mv.addObject("discount", discount);
			mv.addObject("eqpt_price", eqpt_price);
			mv.addObject("disc_price", disc_price);
			mv.addObject("install_price", install_price);
			mv.addObject("trans_price", trans_price);
			mv.addObject("last_offer", last_offer);
			mv.addObject("id", "ElevatorParam");
			mv.setViewName("system/e_offer/save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	//改变省份联动城市
	@RequestMapping(value="setCity")
	@ResponseBody
	public Object setCity(){
		JSONArray result = new JSONArray();
		try{
			PageData pd = this.getPageData();
			List<PageData> destinList = e_offerService.findAllDestinByProvinceId(pd);
			result.addAll(destinList);
			return result;
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return result;
	}
	
	/**
	 *计算运输价格 
	 */
	@RequestMapping(value="setPriceTrans")
	@ResponseBody
	public Object setPriceTrans(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try{
			Integer countPrice = 0;
			PageData pd = this.getPageData();
			String transType= pd.get("transType").toString();
			PageData transPd = e_offerService.findTrans(pd);
			if(transType.equals("1")){//整车
				String zcStr = pd.get("zcStr").toString();
				JSONArray jsonArray = JSONArray.fromObject(zcStr);
				for(int i =0;i<jsonArray.size();i++){
					JSONObject jsonObj = jsonArray.getJSONObject(i);
					String carType = jsonObj.get("carType").toString();
					Integer num = Integer.parseInt(jsonObj.get("num").toString());
					Integer price = 0;
					if(carType.equals("5")){
						price = Integer.parseInt(transPd.get("five_t").toString());
					}else if(carType.equals("8")){
						price = Integer.parseInt(transPd.get("eight_t").toString());
					}else if(carType.equals("10")){
						price = Integer.parseInt(transPd.get("ten_t").toString());
					}else if(carType.equals("20")){
						price = Integer.parseInt(transPd.get("twenty_t").toString());
					}
					countPrice += price*num;
				}
			}else if(transType.equals("2")){//零担
				Integer price = Integer.parseInt(transPd.get("less_carLoad").toString());
				Integer less_num = Integer.parseInt(pd.get("less_num").toString());
				countPrice = price*less_num;
			}
			map.put("countPrice", countPrice);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}

    // 生成报价价格表
	@RequestMapping("/offer_count")
	@ResponseBody
	public Object transformPDf() throws DocumentException, IOException {
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		//pdf------
		Document doc = new Document();
		PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream("C:\\text.pdf")); // 创建pdf文件
		BaseFont bfTitle = BaseFont.createFont("C:/WINDOWS/Fonts/SIMSUN.TTC,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		Font title = new Font(bfTitle, 18, Font.BOLD);// 标题字体
		Font mintitle = new Font(bfTitle, 14, Font.NORMAL);// 小标题字体
		Font titleFont = new Font(bfTitle, 12, Font.NORMAL);// 内容字体
		
		doc.open(); 
		Paragraph titleP = new Paragraph("项目报价价格表\n\n", mintitle);
		titleP.setAlignment(titleP.ALIGN_CENTER);
		doc.add(titleP);
		
		PdfPTable table = new PdfPTable(12); // 创建表格对象 12代表列
		PdfPCell cell = new PdfPCell();
		table.setWidthPercentage(100);
		table.setWidthPercentage(100);
		// 第0行
		table.addCell(new Paragraph("梯号", titleFont)); 
		table.addCell(new Paragraph("型号", titleFont));
		table.addCell(new Paragraph("载重", titleFont)); 
		table.addCell(new Paragraph("速度", titleFont)); 
		table.addCell(new Paragraph("层站", titleFont)); 
		table.addCell(new Paragraph("提升高度", titleFont)); 
		table.addCell(new Paragraph("数量", titleFont)); 
		table.addCell(new Paragraph("设备费单价", titleFont)); 
		table.addCell(new Paragraph("安装费单价", titleFont)); 
		table.addCell(new Paragraph("运保费单价", titleFont)); 
		table.addCell(new Paragraph("单价", titleFont)); 
		table.addCell(new Paragraph("总价", titleFont)); 
		
		
		//查询出该项目的报价信息
		try 
		{
			List<PageData> bjc_list=e_offerService.bjc_list(pd);
			
			for(int i=0;i<bjc_list.size();i++)
			{
				PageData pdel = bjc_list.get(i);
				double JCJ =Double.parseDouble(pdel.getString("BJC_SBJ"));//基础价格
				double ZHJ =Double.parseDouble(pdel.getString("BJC_ZHJ"));//装潢价
				double SBJ=JCJ+ZHJ; //设备价
				
				double AZJ=Double.parseDouble(pdel.getString("BJC_AZF"));//安装价
				double YSJ=Double.parseDouble(pdel.getString("BJC_YSF"));//运输价
				double DJ=AZJ+YSJ+SBJ;//最终单价
				
				table.addCell(new Paragraph("" + pdel.getString("BJC_ELEV"), titleFont)); //梯号
				table.addCell(new Paragraph("" + pdel.getString("BJC_MODELS"), titleFont));//型号
				table.addCell(new Paragraph("" + pdel.getString("BJC_ZZ"), titleFont));//载重
				table.addCell(new Paragraph("" + pdel.getString("BJC_SD"), titleFont));//速度
				table.addCell(new Paragraph("" + pdel.getString("BJC_C")+"/"+pdel.getString("BJC_Z"), titleFont));
				table.addCell(new Paragraph("" + pdel.getString("BJC_TSGD"), titleFont));//提升高度
				table.addCell(new Paragraph("" + pdel.getString("BJC_SL"), titleFont));//数量
				table.addCell(new Paragraph("" + SBJ, titleFont));//设备费单价
				table.addCell(new Paragraph("" + pdel.getString("BJC_AZF"), titleFont));//安装费
				table.addCell(new Paragraph("" + pdel.getString("BJC_YSF"), titleFont));//运输费
				table.addCell(new Paragraph("" + DJ, titleFont));//单价
				table.addCell(new Paragraph("" + pdel.getString("BJC_SJBJ"), titleFont));//总价
				
			}
			
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		// 合计
		PdfPCell cell13 = new PdfPCell(new Phrase("合计", titleFont));
		PdfPCell cell14 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell15 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell16 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell17 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell18 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell19 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell20 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell21 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell22 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell23 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell24 = new PdfPCell(new Phrase("", titleFont));
		table.addCell(cell13);
		table.addCell(cell14);
		table.addCell(cell15);
		table.addCell(cell16);
		table.addCell(cell17);
		table.addCell(cell18);
		table.addCell(cell19);
		table.addCell(cell20);
		table.addCell(cell21);
		table.addCell(cell22);
		table.addCell(cell23);
		table.addCell(cell24);
		
		// 总计
		PdfPCell cell25 = new PdfPCell(new Phrase("总计:", titleFont));
		cell25.setColspan(12);
		table.addCell(cell25);
		
		
		doc.add(table);
		
		String sixteen = "";
		doc.add(new Paragraph(sixteen, mintitle));
		
		doc.close();
		
		return JSONObject.fromObject(map); 
	}
   
	
	
	/* ===============================用户查询权限================================== */
    public List<String> getRoleSelect() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
    }
    public String getRoleType(){
    	Subject currentUser = SecurityUtils.getSubject();
    	Session session = currentUser.getSession();
    	return (String)session.getAttribute(Const.SESSION_ROLE_TYPE);
    }
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
}
