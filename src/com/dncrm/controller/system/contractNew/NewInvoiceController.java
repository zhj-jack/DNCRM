package com.dncrm.controller.system.contractNew;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.collect.CollectService;
import com.dncrm.service.system.contractNewAz.ContractNewAzService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

import javax.annotation.Resource;

@RequestMapping("/newInvoice")
@Controller
public class NewInvoiceController extends BaseController {
	
	
	
	/**
	 * 应收款信息列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/invoiceList")
	public ModelAndView invoiceList(Page page) {
		ModelAndView mv =new ModelAndView();
		try 
		{
			
			mv.setViewName("system/contractNew/newinvoice_list");	
			
		}
		catch(Exception e)
		{
		  logger.error(e.getMessage(), e);	
		}
		
		return mv;
	}
	
	@RequestMapping("/invoice_add")
	public ModelAndView contract_sel(Page page) {
		ModelAndView mv =new ModelAndView();
		try {
			mv.setViewName("system/contractNew/newcontract_sellist");		
			
		}catch(Exception e){
		logger.error(e.getMessage(), e);	
		}
		
		return mv;
	}
	
	
	
	
	@RequestMapping("/invoiceInfo")
	public ModelAndView invoiceInfo() {
		ModelAndView mv =new ModelAndView();
		PageData pd;
		try {
		pd=this.getPageData();
//		String item_id = pd.get("item_id").toString();
//	   	Map <String,String> map=new HashMap();
//	   	map.put("project_number", item_id);
//	   	map.put("customer_name", "万科");
//	   	map.put("project_name", "四季花园");
//		map.put("Final_user", "001");
//	   	map.put("nstallation_address", "广州市东风路");
//	   	
//		map.put("invoice_type", "增值税");
//	   	map.put("invoice_value", "100");
//	   	map.put("ticket_opening", "邮寄");
//	  	
//	   	map.put("tax_item", "电梯设备");
//	   	map.put("ticket_holder", "张三");
//	   	map.put("tax_day", "2018-01-01");
//	  	
//		map.put("invoice_number", "001");
//	   	map.put("amount_money", "100000");
//		map.put("time_money", "2018-01-01");
//		
//	   	map.put("salesman", "张三");
//		map.put("bond", "100000");
//	   	map.put("remarks", "无");
//	   	
//		List <String> list=new ArrayList();
//		list.add("1");//"receivables_number"
//		list.add("订金");//"receivables_type"
//		list.add("2018-01-01");//"receivables_date"
//		list.add("1");//"deviation_date"
//		list.add("50");//"payment_ratio"
//		list.add("100000");//"receivables_money"
//		list.add("无");//"receivables_remarks"
//	   	
//		mv.addObject("info",map);
//		mv.addObject("table",list);
		mv.setViewName("system/contractNew/newinvoice_draft");	
		}catch(Exception e){
			logger.error(e.getMessage(), e);		
		}
		
		return mv;
	}	
	
	@RequestMapping("/invoice_examine")
	public ModelAndView invoice_examine() {
		ModelAndView mv =new ModelAndView();
		PageData pd;
		try {
		pd=this.getPageData();
//		String item_id = pd.get("item_id").toString();
//	   	Map <String,String> map=new HashMap();
//	   	map.put("project_number", item_id);
//	   	map.put("customer_name", "万科");
//	   	map.put("project_name", "四季花园");
//		map.put("Final_user", "001");
//	   	map.put("nstallation_address", "广州市东风路");
//	   	
//		map.put("invoice_type", "增值税");
//	   	map.put("invoice_value", "100");
//	   	map.put("ticket_opening", "邮寄");
//	  	
//	   	map.put("tax_item", "电梯设备");
//	   	map.put("ticket_holder", "张三");
//	   	map.put("tax_day", "2018-01-01");
//	  	
//		map.put("invoice_number", "001");
//	   	map.put("amount_money", "100000");
//		map.put("time_money", "2018-01-01");
//		
//	   	map.put("salesman", "张三");
//		map.put("bond", "100000");
//	   	map.put("remarks", "无");
//	   	
//		List <String> list=new ArrayList();
//		list.add("1");//"receivables_number"
//		list.add("订金");//"receivables_type"
//		list.add("2018-01-01");//"receivables_date"
//		list.add("1");//"deviation_date"
//		list.add("50");//"payment_ratio"
//		list.add("100000");//"receivables_money"
//		list.add("无");//"receivables_remarks"
//	   	
//		mv.addObject("info",map);
//		mv.addObject("table",list);
		mv.setViewName("system/contractNew/newinvoice_examine");	
		}catch(Exception e){
			logger.error(e.getMessage(), e);		
		}
		
		return mv;
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
