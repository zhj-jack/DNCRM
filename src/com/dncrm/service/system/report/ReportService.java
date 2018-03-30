package com.dncrm.service.system.report;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;

@Service("reportService")
public class ReportService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public List<PageData> customerYearNum()throws Exception{
		return (List<PageData>)dao.findForList("ReportMapper.customerYearNum", "");
	}
	
	public List<PageData> customerMonthNum(String year)throws Exception{
		return (List<PageData>)dao.findForList("ReportMapper.customerMonthNum", year);
	}
	
	public List<PageData> customerQuarterNum(String year)throws Exception{
		return (List<PageData>)dao.findForList("ReportMapper.customerQuarterNum", year);
	}
}
