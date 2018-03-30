package com.dncrm.service.system.workflow;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;
import java.util.List;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * The type Task Assign service.
 */
@Service("taskAssignService")
public class TaskAssignService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * get  taskAssign by key.
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public List<PageData> getTaskAssignByKey(PageData pd) throws Exception {

		return (List<PageData>) dao.findForList("TaskAssignMapper.getTaskAssignByKey", pd);
	}
	/**
	 * 根据流程定义id及任务id查询角色权限。
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public List<PageData> getTaskAssignByRole(PageData pd) throws Exception {

		return (List<PageData>) dao.findForList("TaskAssignMapper.getTaskAssignByRole", pd);
	}

	/**
	 * 保存数据
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public void save(PageData pd) throws Exception {

		dao.save("TaskAssignMapper.save", pd);
	}

	/**
	 * 删除数据
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public void del(PageData pd) throws Exception {

		 dao.delete("TaskAssignMapper.delete", pd);
	}
	/**
	 * get  userinfo by key.
	 *
	 * @param pd the page data
	 * @return the list
	 * @throws Exception the exception
	 */
	public List<PageData> getUserInfoByGroupId(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("TaskAssignMapper.getUserInfoByGroupId", pd);
	}

}
