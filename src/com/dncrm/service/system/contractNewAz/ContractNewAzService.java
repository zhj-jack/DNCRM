package com.dncrm.service.system.contractNewAz;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

/**
 *类名:contractNewAzService
 *创建人:stone
 *创建时间:2018年1月18日 
 */
@Service("contractNewAzService")
public class ContractNewAzService 
{
    @Resource(name="daoSupport")
    private DaoSupport dao;
    
    /**
	 * 查询 设备合同信息(合同类型为 设备安装分开)
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> SoContractlistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewAzMapper.SoContractlistPage", page);
	    }
	 
	 /**
	 * 查询所有  安装合同信息
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> AzContractlistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewAzMapper.AzContractlistPage", page);
	    }
	 
	 /**
     * 根据安装合同UUID 获取合同信息
     */
    public PageData findAzConByUUid(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewAzMapper.findAzConByUUid", pd);
	    }
	 
    /**
     * 根据合同id获取 tb_so_fkfs
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findFkfsByHtId(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewAzMapper.findFkfsByHtId", pd);
	    }
 
    //保存 新增合同信息
    public void save(PageData pd)throws Exception{
    	dao.save("ContractNewAzMapper.save", pd);
    }
    /**
     * 根据AZ_UUID 删除tb_az_contract 
     */
    public void deleteContract(PageData pd) throws Exception {
        dao.delete("ContractNewAzMapper.deleteContract", pd);
    }
    
    /**
     * 根据AZ_UUID 删除tb_so_fkfs
     */
    public void deleteFkfs(PageData pd) throws Exception {
        dao.delete("ContractNewAzMapper.deleteFkfs", pd);
    }
  
    //编辑合同信息
    public void edit(PageData pd) throws Exception
    {
    	dao.update("ContractNewAzMapper.edit", pd);
    }

    //修改流程key
    public void editAct_Key(PageData pd) throws Exception
    {
    	dao.update("ContractNewAzMapper.editAct_Key", pd);
    }
    
    //修改流程状态
    public void editAct_Status(PageData pd) throws Exception
    {
    	dao.update("ContractNewAzMapper.editAct_Status", pd);
    }
    
    //保存 新增合同信息
    public void saveYsk(PageData pd)throws Exception{
    	dao.save("ContractNewAzMapper.saveYsk", pd);
    }
    
    /**
   	 * 查询 应收款信息
   	 */
   	 @SuppressWarnings("unchecked")
   	public List<PageData> SoYsklistPage(Page page) throws Exception {
   	        return (List<PageData>) dao.findForList("ContractNewAzMapper.SoYsklistPage", page);
   	    }
    
}
    

