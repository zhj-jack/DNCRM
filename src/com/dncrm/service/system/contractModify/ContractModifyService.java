package com.dncrm.service.system.contractModify;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;

/**
 *类名:ContractModifyService
 *创建人:arisu
 *创建时间:2017年1月18日 
 */
@Service("contractModifyService")
public class ContractModifyService {
    @Resource(name="daoSupport")
    private DaoSupport dao;
    
    
    /**
     *根据项目列表合同变更 
     */
    public List<PageData> list(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.list", pd);
    }
    
    /**
     *查询列表页面头信息(项目名称/客户名称) 
     */
    public PageData findHeadMsg(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("contractModifyMapper.findHeadMsg", pd);
    }
    
    /**
     *查询新增编辑页面头信息 
     */
    public PageData findHeadInfo(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("contractModifyMapper.findHeadInfo", pd);
    }
    
    /**
     *根据合同主键查询电梯列表 
     */
    public List<PageData>findDtinfoForAdd(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.findDtinfoForAdd", pd);
    }
    
    
    /**
     *根据合同主键查询付款方式
     */
    public List<PageData>findFkfsForAdd(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.findFkfsForAdd", pd);
    }
    
    /**
     *保存合同变更 
     */
    public void saveContractModify(PageData pd)throws Exception{
    	dao.save("contractModifyMapper.saveContractModify", pd);
    }
    
    /**
     *保存合同变更电梯信息 
     */
    public void saveCmElev(PageData pd)throws Exception{
    	dao.save("contractModifyMapper.saveCmElev", pd);
    }
    
    
    /**
     *保存合同变更付款方式信息 
     */
    public void saveCmFkfs(PageData pd)throws Exception{
    	dao.save("contractModifyMapper.saveCmFkfs", pd);
    }
    
    /**
     *根据Id查询 
     */
    public PageData findContractModify(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("contractModifyMapper.findContractModify", pd);
    }
    
    /**
     *修改流程key 
     */
    public void editActKey(PageData pd)throws Exception{
    	dao.update("contractModifyMapper.editActKey", pd);
    }
    
    /**
     *修改流程status
     */
    public void editActStatus(PageData pd)throws Exception{
    	dao.update("contractModifyMapper.editActStatus", pd);
    }
}


