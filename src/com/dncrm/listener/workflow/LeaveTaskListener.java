package com.dncrm.listener.workflow;

/**
 * Created by Simon on 16/7/28.
 */

import com.dncrm.dao.DaoSupport;
import com.dncrm.service.system.workflow.TaskAssignService;
import com.dncrm.util.Logger;
import com.dncrm.util.PageData;
import com.dncrm.util.SpringContextHolder;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.context.ApplicationContext;

import java.util.List;

/**
 * 请假任务监听器
 *
 * @author Simon
 * @create 2016-07-28 上午10:34
 **/
public class LeaveTaskListener implements TaskListener
{

    private ApplicationContext app;
    private DaoSupport dao;

    @Override
    public void notify(DelegateTask delegateTask) {
        //设置任务处理人
        //获取当前任务定义的用户id

       /* ServletContext sc = null;
        HttpSession session = ContextHolderUtils.getSession();
        sc=session.getServletContext();
        ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);*/

        String user_id = (String)delegateTask.getVariable("user_id");
        //流程定义key
        String task_def_key = delegateTask.getTaskDefinitionKey();
        String process_definition_id = delegateTask.getProcessDefinitionId();

        //根据task_def_key and processDefintionId查询对应的下一个任务的处理者所在的group
        PageData pd = new PageData();
        pd.put("task_def_key",task_def_key);
        pd.put("process_definition_id",process_definition_id);
        try {
            TaskAssignService taskAssignService = SpringContextHolder.getBean("taskAssignService");
            List <PageData> list = taskAssignService.getTaskAssignByKey(pd);
            if(list!=null&&list.size()>0){
                for (PageData taskAssign:list) {
                    String group_id = taskAssign.getString("group_id");
                   delegateTask.addCandidateGroup(group_id);
                }
            }
        } catch (Exception e) {
            Logger logger = Logger.getLogger(this.getClass());
            logger.error(e.toString(), e);
        }

        System.out.println("task listener");
        System.out.println("delegateTask -->"+delegateTask);
    }

}
