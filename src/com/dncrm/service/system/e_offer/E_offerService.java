package com.dncrm.service.system.e_offer;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("e_offerService")
public class E_offerService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
		
		/**
		 * 查询所有报价信息
		 * stone 17.07.05
		 * @param page
		 * @return
		 * @throws Exception
		 */
		 @SuppressWarnings("unchecked")
		public List<PageData> e_offerlistPage(Page page) throws Exception {
		        return (List<PageData>) dao.findForList("E_offerMapper.e_offerlistPage", page);
		    }
		 /**
			 * 查询所有项目状态为~报价 的项目信息
			 * stone 17.07.05
			 * @param page
			 * @return
			 * @throws Exception
			 */
			 @SuppressWarnings("unchecked")
			public List<PageData> itemlistpage(Page page) throws Exception {
			        return (List<PageData>) dao.findForList("E_offerMapper.itemlistPage", page);
			        }
            /**
             * 根据项目编号 获取项目信息
             * stone 17.07.05		
             * @param pd
             * @return
             * @throws Exception
             */
		    public PageData findItemById(PageData pd) throws Exception {
			        return (PageData) dao.findForObject("E_offerMapper.findItemById", pd);
			    }
		    
		    /**
			 * 根据项目id获取电梯信息
			 * stone 17.07.14
			 * @param page
			 * @return
			 * @throws Exception
			 */
			 @SuppressWarnings("unchecked")
			public List<PageData> elevatorlistPage(Page page) throws Exception {
			        return (List<PageData>) dao.findForList("E_offerMapper.elevatorlistPage", page);
			        }
			 
			 /**
             * 获取最后一个录入的报价编号
             * stone 17.07.05		
             * @param pd
             * @return
             * @throws Exception
             */
		    public PageData E_offer_NO(PageData pd) throws Exception {
			        return (PageData) dao.findForObject("E_offerMapper.E_offer_NO", pd);
			    }
		    /**
		     * 根据编号删除信息
		     * @param pd the pd
		     * @throws Exception the exception
		     */
		    public void deleteOffer(PageData pd) throws Exception {
		        dao.delete("E_offerMapper.deleteOffer", pd);
		    }
		    
		  //编辑报价信息
		    public void editS(PageData pd) throws Exception
		    {
		    	dao.update("E_offerMapper.editS", pd);
		    }
		    
		    // 补充项目信息
		    public void editItem(PageData pd) throws Exception
		    {
		    	dao.update("E_offerMapper.editItem", pd);
		    }
		    
		  //查询流程是否存在
		    @SuppressWarnings("unchecked")
			public List<PageData> instance_key(PageData pd) throws Exception
		    {
		    	return (List<PageData>) dao.findForList("E_offerMapper.instance_key", pd);
		    }
		    
		  //保存报价信息
		    public void saveS(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveS", pd);
		    }


		    
			/**
		     *根据类型查询扶梯配置 
		     */
		    public List<PageData> findEscalatorConfigByType(String type)throws Exception{
		    	return (List<PageData>) dao.findForList("E_offerMapper.findEscalatorConfigByType", type);
		    }
		    
		    public List<PageData> findChildEscalatorConfig(String id)throws Exception{
		    	return (List<PageData>) dao.findForList("E_offerMapper.findChildEscalatorConfig", id);
		    }
		    
		    public Integer findEscalatorStandardPrice(String id)throws Exception{
		    	String price = (String)dao.findForObject("E_offerMapper.findEscalatorStandardPrice", id); 
		    	return Integer.parseInt(price);
		    }
		    
		    public String findEscalatorConfigName(String id)throws Exception{
		    	return (String)dao.findForObject("E_offerMapper.findEscalatorConfigName", id);
		    }
		    
		    /**
		     *查询字段价格类型 
		     */
		    public String findPriceTypeByKeyWord(String keyword)throws Exception{
		    	return (String) dao.findForObject("E_offerMapper.findPriceTypeByKeyWord", keyword);
		    }
		    
		    /**
		     *根据关键字查询价格和加价公式 
		     */
		    public PageData findElevatorKeyword(PageData pd)throws Exception{
		    	
		    	List<PageData> pdList = (List<PageData>)dao.findForList("E_offerMapper.findElevatorKeyword", pd);
		    	return new PageData();
		    }
		    
		    /**
		     *根据字段的选项查询对应价格 
		     */
		    public PageData findPriceOption(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findPriceOption", pd);
		    }
		    
		    /**
		     *根据字段的选项组查询对应价格总价
		     */
		    public PageData findPriceOptions(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findPriceOptions", pd);
		    }
		    
		    /**
		     *根据字段名查询对应的加价公式 
		     */
		    public PageData findPriceFormula(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findPriceFormula", pd);
		    }
		    
		    
		    /**
		     *根据字段名查询对应的单价 
		     */
		    public PageData findPriceUnit(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findPriceUnit", pd);
		    }
		    
		    
		    /**
		     *保存报价明细 
		     */
		    public void saveEscalator(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveEscalator", pd);
		    }
		    
		    
		    /**
		     *根据电梯配置ID查询电梯标准 
		     */
		    public PageData findEscalatorStandard(String id)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findEscalatorStandard", id);
		    }



		 
		  //根据报价编号查询信息
		    public PageData findOfferById(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("E_offerMapper.findOfferById", pd);
		    }
		    //根据item_id和models_id查询电梯信息
		    @SuppressWarnings("unchecked")
			public List<PageData> findEleBYmodels_id(PageData pd) throws Exception {
		        return (List<PageData>) dao.findForList("E_offerMapper.findEleBYmodels_id", pd);
		    }
		    //修改流程状态
		    public void editInstance_status(PageData pd) throws Exception
		    {
		    	dao.update("E_offerMapper.editInstance_status", pd);
		    }
		    //根据uuid查询信息
		    public PageData findByuuId(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("E_offerMapper.findByuuId", pd);
		    }
		    
		    //查询运输价格
		    public PageData findTrans(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findTrans", pd);
		    }
		    
		    //查询目的地
		    public List<PageData> findAllDestinByProvinceId(PageData pd)throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findAllDestinByProvinceId", pd);
		    }
		    
		    //更新电梯
		    public void updateElevatorDetails(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateElevatorDetails", pd);
		    }
		    
		    //保存飞尚梯
		    public void saveFeishang(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeishang", pd);
		    }
		    
		    
	    /**
		 * 根据项目ID获取BJC 信息
		 * stone 17.12.21
		 * @param pd
		 * @return
		 * @throws Exception
		 */
		 @SuppressWarnings("unchecked")
		public List<PageData> bjc_list(PageData pd) throws Exception {
		        return (List<PageData>) dao.findForList("E_offerMapper.bjc_list", pd);
		    }	    
		    
		    
		    //保存飞扬MRL无机房
		    public void saveFeiyangMRL(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyangMRL", pd);
		    }
		    
		    //保存报价池信息
		    public void saveBjc(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveBjc", pd);
		    }
		    
		    //保存飞扬消防梯
		    public void saveFeiyangXF(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyangXF", pd);
		    }
		    
		    //保存飞扬3000有机房
		    public void saveFeiyang(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyang", pd);
		    }
		    
		  //保存飞越有机房
		    public void saveFeiyue(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyue", pd);
		    }
		    
		  //保存飞越无机房
		    public void saveFeiyueMRL(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyueMRL", pd);
		    }
		    
		  //保存扶梯
		    public void saveDnp9300(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveDnp9300", pd);
		    }
		    
		  //保存人行道
		    public void saveDnr(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveDnr", pd);
		    }
		    
		  //保存曳引货梯
		    public void saveShiny(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveShiny", pd);
		    }
		    
		    
		    //根据项目ID查询报价池信息
		    public List<PageData> findBjc(PageData pd)throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findBjc", pd);
		    }
		    
		  //根据ITEM_ID获取报价池内的折扣和梯型
		    @SuppressWarnings("unchecked")
			public List<PageData> findBjcByItemId(PageData pd)throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findBjcByItemId", pd);
		    }
		    
		    //查询飞尚梯参考报价
		    public List<PageData> findFeishangCbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeishangCbj", "");
		    }
		    
		  //查询飞扬梯参考报价
		    public List<PageData> findFeiyangCbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangCbj", "");
		    }
		  //查询飞扬无机房梯参考报价
		    public List<PageData> findFeiyangMRLCbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangMRLCbj", "");
		    }
		  //查询飞扬消防梯参考报价
		    public List<PageData> findFeiyangXFCbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangXFCbj", "");
		    }
		  //查询飞越梯参考报价
		    public List<PageData> findFeiyueCbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyueCbj", "");
		    }
		  //查询飞越MRL梯参考报价
		    public List<PageData> findFeiyueMRLCbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyueMRLCbj", "");
		    }
		  //查询曳引梯参考报价
		    public List<PageData> findShinyCbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findShinyCbj", "");
		    }
		  //查询曳引梯参考报价
		    public List<PageData> findDnp9300Cbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findDnp9300Cbj", "");
		    }
		  //查询曳引梯参考报价
		    public List<PageData> findDnrCbj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findDnrCbj", "");
		    }
		    
		  //查询飞尚梯参考报价
		    public List<PageData> findFeishangZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeishangZhj", "");
		    }
		  //查询飞扬梯参考报价
		    public List<PageData> findFeiyangZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangZhj", "");
		    }
		  //查询飞扬无机房梯参考报价
		    public List<PageData> findFeiyangMRLZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangMRLZhj", "");
		    }
		    //查询飞扬消防梯参考报价
		    public List<PageData> findFeiyangXFZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangXFZhj", "");
		    }
		  //查询飞越梯参考报价
		    public List<PageData> findFeiyueZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyueZhj", "");
		    }
		    //查询飞越MRL梯参考报价
		    public List<PageData> findFeiyueMRLZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyueMRLZhj", "");
		    }
		    //查询曳引梯参考报价
		    public List<PageData> findShinyZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findShinyZhj", "");
		    }
		  //查询扶梯参考报价
		    public List<PageData> findDnp9300Zhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findDnp9300Zhj", "");
		    }
		    //查询扶梯参考报价
		    public List<PageData> findDnrZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findDnrZhj", "");
		    }
		    
		  //根据报价池ID查询飞尚COD信息
		    public PageData findFeishangCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeishangCOD", pd);
		    }
		    
		    //根据报价池ID查询飞扬COD信息
		    public PageData findFeiyangCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangCOD", pd);
		    }
		  //根据报价池ID查询飞扬无机房COD信息
		    public PageData findFeiyangMRLCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangMRLCOD", pd);
		    }
		    //根据报价池ID查询飞扬消防COD信息
		    public PageData findFeiyangXFCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangXFCOD", pd);
		    }
		    //根据报价池ID查询飞越COD信息
		    public PageData findFeiyueCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyueCOD", pd);
		    }
		  //根据报价池ID查询飞越COD信息
		    public PageData findFeiyueMRLCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyueMRLCOD", pd);
		    }
		  //根据报价池ID查询SHINYCOD信息
		    public PageData findShinyCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findShinyCOD", pd);
		    }
		    //根据报价池ID查询SHINYCOD信息
		    public PageData findDnp9300COD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findDnp9300COD", pd);
		    }
		  //根据报价池ID查询dnr COD信息
		    public PageData findDnrCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findDnrCOD", pd);
		    }
		    
		    //根据主键获取飞尚COD
		    public PageData findFeishang(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeishang", pd);
		    }
		    
		  //根据主键获取飞扬COD
		    public PageData findFeiyang(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyang", pd);
		    }
		  //根据主键获取飞扬COD
		    public PageData findFeiyangMRL(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangMRL", pd);
		    }
		  //根据主键获取飞扬COD
		    public PageData findFeiyangXF(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangXF", pd);
		    }
		  //根据主键获取飞越COD
		    public PageData findFeiyue(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyue", pd);
		    }
		    //根据主键获取飞越mrlCOD
		    public PageData findFeiyueMRL(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyueMRL", pd);
		    }
		    //根据主键获取SHINY COD
		    public PageData findShiny(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findShiny", pd);
		    }
		  //根据主键获取DNP9300 COD
		    public PageData findDnp9300(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findDnp9300", pd);
		    }
		  //根据主键获取DNR COD
		    public PageData findDnr(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findDnr", pd);
		    }
		    
		  //根据报价池ID获取型号
		    public PageData findModels(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findModels", pd);
		    }
		    
		    //更新电梯报价状态信息
		    public void updateDetails(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateDetails", pd);
		    }
		    
		    
		    //--编辑部分
		    
		    //编辑报价池
		    public void updateBjc(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateBjc", pd);
		    }
		    //编辑飞尚
		    public void updateFeishang(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeishang", pd);
		    }
		    
		    //编辑飞扬
		    public void updateFeiyang(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyang", pd);
		    }

		  //编辑飞扬MRL
		    public void updateFeiyangMRL(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyangMRL", pd);
		    }
		    
		  //编辑飞扬消防
		    public void updateFeiyangXF(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyangXF", pd);
		    }
		    
		    //编辑飞越
		    public void updateFeiyue(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyue", pd);
		    }
		    
		    //编辑飞越MRL
		    public void updateFeiyueMRL(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyueMRL", pd);
		    }
		    
		    //编辑曳引
		    public void updateShiny(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateShiny", pd);
		    }
		    
		    //编辑扶梯
		    public void updateDnp9300(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateDnp9300", pd);
		    }
		    
		    
		    //编辑人行道
		    public void updateDnr(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateDnr", pd);
		    }
		    
		    //删除报价池
		    public void deleteBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteBjc", pd);
		    }
		    
		    //初始化电梯表状态
		    public void initDetails(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.initDetails", pd);
		    }
		    
		    //根据主键查询报价池信息
		    public PageData selectBjc(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.selectBjc", pd);
		    }
		    
		    //根据报价池ID删除飞尚
		    public void deleteFeishangByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeishangByBjc", pd);
		    }
		    //根据报价池ID删除feiyang
		    public void deleteFeiyangByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyangByBjc", pd);
		    }
		    //根据报价池ID删除feiyangmrl
		    public void deleteFeiyangMRLByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyangMRLByBjc", pd);
		    }
		    //根据报价池ID删除feiyangxf
		    public void deleteFeiyangXFByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyangXFByBjc", pd);
		    }
		    //根据报价池ID删除feiyue
		    public void deleteFeiyueByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyueByBjc", pd);
		    }
		    //根据报价池ID删除feiyuemrl
		    public void deleteFeiyueMRLByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyueMRLByBjc", pd);
		    }
		    //根据报价池ID删除dnp9300
		    public void deleteDnp9300ByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteDnp9300ByBjc", pd);
		    }
		    //根据报价池ID删除dnr
		    public void deleteDnrByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteDnrByBjc", pd);
		    }
		    //根据报价池ID删除shiny
		    public void deleteShinyByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteShinyByBjc", pd);
		    }
		    
		    
}
