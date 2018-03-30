package com.dncrm.service.system.contractNew;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

/**
 *类名:contractNewService
 *创建人:stone
 *创建时间:2018年1月18日 
 */
@Service("contractNewService")
public class ContractNewService 
{
    @Resource(name="daoSupport")
    private DaoSupport dao;
    
    /**
	 * 查询所有合同信息
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> SoContractlistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.SoContractlistPage", page);
	    }
	 
	 /**
	 * 查询不存在合同表的报价信息
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> e_offerlistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.e_offerlistPage", page);
	    }
	 
	 /**
     * 根据合同UUID 获取合同信息
     */
    public PageData findSoConByUUid(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewMapper.findSoConByUUid", pd);
	    }
	 
    /**
     * 根据项目编号 获取项目信息
     */
    public PageData findItemById(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewMapper.findItemById", pd);
	    }
    
    /**
     * 根据项目编号 获取电梯信息
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findBJCByItemId(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findBJCByItemId", pd);
	    }
		
    
    /**
     * 根据电梯ID 获取电梯信息
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findElevById(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findElevById", pd);
	    }
  
    /**
     * 根据项目id 获取电梯数量
     */
    public PageData findElevByItemId(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewMapper.findElevByItemId", pd);
	    }
    
    /**
     * 根据项目id 获取报价金额
     */
    public PageData findOfferByItemId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractNewMapper.findOfferByItemId", pd);
    }
  
    /**
     * 根据合同id获取 tb_so_dtinfo信息
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findDtInfoByHtId(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findDtInfoByHtId", pd);
	    }
    
    /**
     * 根据合同id获取 tb_so_fkfs
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findFkfsByHtId(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findFkfsByHtId", pd);
	    }
    
    /**
     * 根据合同ID 删除 tb_so_dtInfo
     */
    public void deleteDtInfo(PageData pd) throws Exception {
        dao.delete("ContractNewMapper.deleteDtInfo", pd);
    }
    
    /**
     * 根据HT_UUID 删除tb_so_fkfs
     */
    public void deleteFkfs(PageData pd) throws Exception {
        dao.delete("ContractNewMapper.deleteFkfs", pd);
    }
    
    /**
     * 根据HT_UUID 删除tb_so_contract 
     */
    public void deleteContract(PageData pd) throws Exception {
        dao.delete("ContractNewMapper.deleteContract", pd);
    }
    
    //保存 新增合同信息
    public void save(PageData pd)throws Exception{
    	dao.save("ContractNewMapper.save", pd);
    }
    
    //保存 电梯信息
    public void saveDt(PageData pd)throws Exception{
    	dao.save("ContractNewMapper.saveDt", pd);
    }
    
    //保存 付款方式
    public void saveFkfs(PageData pd)throws Exception{
    	dao.save("ContractNewMapper.saveFkfs", pd);
    }
    
    //编辑合同信息
    public void edit(PageData pd) throws Exception
    {
    	dao.update("ContractNewMapper.edit", pd);
    }
    
    /*
	 *获取梯形
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> getElevatorType(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.getElevatorType", page);
	}
	
	/*
	 *飞尚COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEISHANG_COD(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEISHANG_COD", page);
	}
	
	/*
	 *飞逸COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printSHINY_COD(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printSHINY_COD", page);
	}
	
	/*
	 *新飞越COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEIYUE_COD(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEIYUE_COD", page);
	}
	
	/*
	 *飞扬3000+无机房COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEIYANG_MRL_COD(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEIYANG_MRL_COD", page);
	}
	
	/*
	 *飞扬3000小机房COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEIYANG_COD(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEIYANG_COD", page);
	}
	
	/*
	 *飞扬消防梯COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEIYANGXF_COD(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEIYANGXF_COD", page);
	}
	
	/*
	 *扶梯COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printDNP9300_COD(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printDNP9300_COD", page);
	}
	
	/*
	 *人行道COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printDNR_COD(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printDNR_COD", page);
	}
    
    //查询流程是否存在
    @SuppressWarnings("unchecked")
	public List<PageData> SelAct_Key(PageData pd) throws Exception
    {
    	return (List<PageData>) dao.findForList("ContractNewMapper.SelAct_Key", pd);
    }
    
    //修改流程key
    public void editAct_Key(PageData pd) throws Exception
    {
    	dao.update("ContractNewMapper.editAct_Key", pd);
    }
    
    //修改流程状态
    public void editAct_Status(PageData pd) throws Exception
    {
    	dao.update("ContractNewMapper.editAct_Status", pd);
    }
    
    //根据报价id查询信息
    public PageData findOfferById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractNewMapper.findOfferById", pd);
    }
}
    

