package com.dncrm.controller.system.contractModify;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.contractModify.ContractModifyService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;


@Controller
@RequestMapping(value = "/contractModify")
public class ContractModifyController extends BaseController{

	@Resource(name = "contractModifyService")
	private ContractModifyService contractModifyService;
	
	/**
	 *列表 
	 */
	@RequestMapping(value="list")
	public ModelAndView list(){
		PageData pd = new PageData();
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			List<PageData> pdList = contractModifyService.list(pd);
			PageData headMsg = contractModifyService.findHeadMsg(pd);
			mv.addObject("pd", pd);
			mv.addObject("contractModifyList", pdList);
			mv.addObject("headMsg", headMsg);
			mv.setViewName("system/contractModify/contractNewChangeInContract_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到变更协议新增页面 
	 */
	@RequestMapping(value="goAdd")
	public ModelAndView goAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			//加载项目id-合同id
			pd = this.getPageData();
			//加载页面默认带出头信息
			PageData headInfo = contractModifyService.findHeadInfo(pd);
			//加载电梯列表
			List<PageData> dtInfoList = contractModifyService.findDtinfoForAdd(pd);
			//加载付款列表
			List<PageData> fkfsList = contractModifyService.findFkfsForAdd(pd);
			mv.addObject("headInfo", headInfo);
			mv.addObject("dtInfoList", dtInfoList);
			mv.addObject("fkfsList", fkfsList);
			mv.addObject("pd", pd);
			mv.addObject("msg", "saveContractModify");
			mv.setViewName("system/contractModify/contractNewChangeTheAgreement_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *保存
	 */
	@RequestMapping(value="saveContractModify")
	public ModelAndView saveContractModify(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try{
			
			//保存合同变更
			String contractModifyId = this.get32UUID();
			pd.put("id", contractModifyId);
			pd.put("serial_number", "001");
			pd.put("modify_number", "cm001");
			pd.put("input_user", this.getUser().getUSERNAME());
			pd.put("input_date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			contractModifyService.saveContractModify(pd);
			
			//保存电梯信息
			String dtInfoJson = pd.getString("dtInfoJson");
			JSONArray jsonArray = JSONArray.fromObject(dtInfoJson);
			for(int i =0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				PageData cmElevPd = new PageData();
				cmElevPd.put("id", this.get32UUID());
				cmElevPd.put("so_dtinfo", jsonObj.get("dtInfoId").toString());
				cmElevPd.put("contract_modify_id", contractModifyId);
				cmElevPd.put("modify_sbdj", jsonObj.get("dtSbdj").toString());
				cmElevPd.put("modify_azdj", jsonObj.get("dtAzdj").toString());
				cmElevPd.put("modify_total", jsonObj.get("dtTotal").toString());
				contractModifyService.saveCmElev(cmElevPd);
			}
			
			//保存付款方式
			String fkfsJson = pd.getString("fkfsJson");
			JSONArray jsonArray2 = JSONArray.fromObject(fkfsJson);
			for(int i =0;i<jsonArray2.size();i++){
				JSONObject jsonObj = jsonArray2.getJSONObject(i);
				PageData cmFkfsPd = new PageData();
				cmFkfsPd.put("id", this.get32UUID());
				cmFkfsPd.put("so_fkfs", jsonObj.get("so_fkfs").toString());
				cmFkfsPd.put("contract_modify_id", contractModifyId);
				cmFkfsPd.put("period", jsonObj.get("period").toString());
				cmFkfsPd.put("stage", jsonObj.get("stage").toString());
				cmFkfsPd.put("date_devi", jsonObj.get("date_devi").toString());
				cmFkfsPd.put("pay_percent", jsonObj.get("pay_percent").toString());
				cmFkfsPd.put("price", jsonObj.get("price").toString());
				cmFkfsPd.put("remark", jsonObj.get("remark").toString());
				cmFkfsPd.put("type", jsonObj.get("type").toString());
				contractModifyService.saveCmFkfs(cmFkfsPd);
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *编辑 
	 */
	/*@RequestMapping(value="")*/
	
	
    /**
     * 获取权限
     *
     * @return
     */
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
    /* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
    /* ===============================用户================================== */

}
