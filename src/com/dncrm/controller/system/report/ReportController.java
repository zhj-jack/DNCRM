package com.dncrm.controller.system.report;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.service.system.report.ReportService;
import com.dncrm.util.PageData;
import com.dncrm.util.echarts.Echarts;
import com.github.abel533.echarts.Option;
import com.github.abel533.echarts.json.GsonOption;


@RequestMapping("/report")
@Controller
public class ReportController extends BaseController {
	
	@Resource(name="reportService")
	private ReportService reportService;
	
	@RequestMapping(value="reportInfo")
	public ModelAndView reportInfo(){
		ModelAndView mv = new ModelAndView();
		try{
			mv.setViewName("system/report/report");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *根据选择类型生成报表数据
	 */
	@RequestMapping(value="setByType",produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Object setByType(){
		PageData pd = new PageData();
		GsonOption option = new GsonOption();
		Echarts echarts = new Echarts();
		try{
			pd = this.getPageData();
			List<PageData> list = new ArrayList<PageData>();
			String type = pd.get("type").toString();
			String xAxisName = "";
			String yAxisName = "(Num)";
			if(type.equals("year")){
				list = reportService.customerYearNum();
				xAxisName="(年)";
			}else if(type.equals("month")){
				String year = new SimpleDateFormat("yyyy").format(new Date());
				list = reportService.customerMonthNum(year);
				//option = echarts.setXAxisMonth(option);
				xAxisName="(月份)";
			}else if(type.equals("quarter")){
				String year = new SimpleDateFormat("yyyy").format(new Date());
				list = reportService.customerQuarterNum(year);
				//option = echarts.setXAxisQuarter(option);
				xAxisName="(季度)";
			}
			Map<String, String> legendMap = new HashMap<String, String>();
			legendMap.put("category", "date");
			legendMap.put("战略客户", "coreNum");
			legendMap.put("小业主", "merchantNum");
			legendMap.put("开发商", "ordinaryNum");
			option = echarts.setOption(list, legendMap);
			echarts.setYAxisName(option, yAxisName);
			echarts.setXAxisName(option, xAxisName);
			
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return option.toString();
	}
}
