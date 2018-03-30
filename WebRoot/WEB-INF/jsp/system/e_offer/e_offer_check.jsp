<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>

<base href="<%=basePath%>">


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>${pd.SYSNAME}</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>

<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>

<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
$(document).ready(function () {
/* 图片 */
$('.fancybox').fancybox({
   openEffect: 'none',
   closeEffect: 'none'
});
</script>
</head>
<body class="gray-bg">
    <div id="ElevatorParam" class="animated fadeIn"></div>
	<form action="e_offer/${msg}.do" name="e_offerForm" id="e_offerForm" method="post">
	    <input type="hidden" name="item_id" id="item_id" value="${pd.item_id}" /> 
	    <input type="hidden" name="offer_no" id="offer_no" value="${pd.offer_no}" /> 
	    <input type="hidden" name="jsonStr" id="jsonStr">
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<!-- 页面内容开始 -->
								<div class="form-group form-inline">
									<label style="margin-top: 15px; margin-left: 20px; width: 8%">报价编号:</label>
									<label style="width: 22%">${pd.offer_no}</label> 
									<label style="width: 30%; margin-left: 15px">版本: 01 </label>

									<!-- <button class="btn btn-primary btn-sm" style="width: 9%; margin-left: 20px; height:31px"
									 title="保存" type="button" onclick="save();">保存</button>
									<button class="btn btn-primary btn-sm" style="width: 9%; margin-left: 8px; height:31px"
									 title="提交" type="button">提交</button> -->
									<!-- <button class="btn btn-danger" style="width:6%; height:31px; margin-left:27%;"
									 title="关闭" type="button" onclick="javascript:CloseSUWin('EditShops');">关闭</button> -->
								</div>
								<div class="form-group form-inline">
									<label style="margin-left: 20px; width: 8%">项目名称:</label> 
									<label style="width: 22%">${pd.item_name}</label> 
										
									<label style="width: 8%; margin-left: 15px">销售类型:</label> 
									<c:if test="${pd.sale_type == 1}">
									  <label style="width: 22%">经销</label>
									</c:if>
									<c:if test="${pd.sale_type == 2}">
									  <label style="width: 22%">直销</label>
									</c:if>
									<c:if test="${pd.sale_type == 3}">
									  <label style="width: 22%">代销</label>
									</c:if>
									
									<label style="width: 8%; margin-left: 20px">客户名称:</label> 
									<label style="width: 22%">${pd.customer_name}</label>
								</div>
								<div class="panel-heading">內容补充</div>
								<div class="panel-body">
									<div class="form-group form-inline">
										<span style="color: red;">*</span> <label style="width: 8%">合同可能:</label>
										<select style="width: 22%" class="form-control" id="agreement_possible" name="agreement_possible" disabled="disabled">
										  <option value=""  ${pd.agreement_possible==""?"selected":""}>请选择</option>
				                          <option value="1" ${pd.agreement_possible=="1"?"selected":""}>50%</option>
                                       	  <option value="2" ${pd.agreement_possible=="2"?"selected":""}>60%</option>
                                       	  <option value="3" ${pd.agreement_possible=="3"?"selected":""}>70%</option>
                                       	  <option value="4" ${pd.agreement_possible=="4"?"selected":""}>80%</option>
                                       	  <option value="5" ${pd.agreement_possible=="5"?"selected":""}>90%</option>
                                       	  <option value="6" ${pd.agreement_possible=="6"?"selected":""}>100%</option>
										</select>
										<span style="color: red; margin-left: 10px">*</span> 
										<label style="width: 10%;">市场区分:</label> 
										<select style="width: 20%" class="form-control" id="market_type" name="market_type" disabled="disabled">
										  <option value="" ${pd.market_type==""?"selected":""}>请选择</option>
				                          <option value="1" ${pd.market_type=="1"?"selected":""}>住宅</option>
				                          <option value="2" ${pd.market_type=="2"?"selected":""}>工厂</option>
				                          <option value="3" ${pd.market_type=="3"?"selected":""}>医院</option>
				                          <option value="4" ${pd.market_type=="4"?"selected":""}>商业</option>
				                          <option value="5" ${pd.market_type=="5"?"selected":""}>政府机关</option>
				                          <option value="6" ${pd.market_type=="6"?"selected":""}>别墅</option>
				                          <option value="7" ${pd.market_type=="7"?"selected":""}>公寓</option>
				                          <option value="8" ${pd.market_type=="8"?"selected":""}>学校</option>
				                          <option value="9" ${pd.market_type=="9"?"selected":""}>公共交通</option>
				                          <option value="10" ${pd.market_type=="10"?"selected":""}>酒店</option>
				                          <option value="11" ${pd.market_type=="11"?"selected":""}>小业主</option>
				                          <option value="12" ${pd.market_type=="12"?"selected":""}>总包方</option>
				                          <option value="13" ${pd.market_type=="13"?"selected":""}>OEM</option>
										</select> 
										<span style="color: red; margin-left: 19px">*</span>
										<label style="width: 10%;">我司劣势:</label> 
										<select style="width: 20%" class="form-control" id="self_inferiority" name="self_inferiority" disabled="disabled">
										  <option value="" ${pd.self_inferiority==""?"selected":""}>请选择</option>
				                          <option value="1" ${pd.self_inferiority=="1"?"selected":""}>价格</option>
                                       	  <option value="2" ${pd.self_inferiority=="2"?"selected":""}>品牌</option>
                                       	  <option value="3" ${pd.self_inferiority=="3"?"selected":""}>关系</option>
                                       	  <option value="4" ${pd.self_inferiority=="4"?"selected":""}>技术</option>
									   </select>
									</div>
								</div>
								<div class="panel-heading">报价信息</div>
								<div class="panel-body">
									<div class="form-group form-inline">
										<div class="table-responsive">
										  <label style="margin-left:10px;">项目电梯信息:</label>
											<table class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
														<th><input type="checkbox" name="zcheckbox"
															id="zcheckbox" class="i-checks"></th>
														<th style="text-align: center;">电梯规格</th>
														<th style="text-align: center;">项目台数</th>
														<th style="text-align: center;">已报台数</th>
														<th style="text-align: center;">未报台数</th>
														<th style="text-align: center;">报价台数</th>
														<th style="text-align: center;">操作</th>
													</tr>
												</thead>
												<tbody>
													<!-- 开始循环 -->
													<c:choose>
														<c:when test="${not empty elevatorList}">
															<c:if test="${QX.cha == 1 }">
																<c:forEach items="${elevatorList}" var="ele" varStatus="vs">
																	<tr>
																		<td class='center' style="width: 30px;"><label>
																				<input class="i-checks" type='checkbox' name='ids'
																				value="${ele.item_no}" id="${ele.item_no}"
																				alt="${ele.item_no}" /> <span class="lbl"></span>
																		</label></td>
																		<td style="text-align: center;">${ele.models_name}</td>
																		<td style="text-align: center;">${ele.modelsNum}</td>
																		<td style="text-align: center;">${ele.YNum}</td>
																		<td style="text-align: center;">${ele.WNum}</td>
																		<td style="text-align: center;">
																		  <div contentEditable="true"></div>
																		  <!-- <input type="text" name="houses_faxes" id="houses_faxes"> -->
																		</td>
																		<td style="text-align: center;width: 15%">
																		    <input type="hidden" value="${ele.elevID}"/>
																			<button class="btn  btn-primary btn-sm" title="加入报价池" disabled="disabled"
																				type="button" onclick="addoffer(this,'${ele.models_id}','${ele.flag}','${ele.elevator_id}','${ele.models_name}')">加入报价池</button>
																		    
																		</td>
																	</tr>

																</c:forEach>
															</c:if>
														</c:when>
														<c:otherwise>
															<tr class="main_info">
																<td colspan="100" class="center">没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
												</tbody>
											</table>
											<!-- ↓↓↓-报价池相关-↓↓↓↓ -->
											<label style="margin-left:10px;">报价池:</label>
											<table class="table table-striped table-bordered table-hover" id="tab1" name="tab1">
												<thead>
													<tr>
														<th><input type="checkbox" name="zcheckbox"
															id="zcheckbox" class="i-checks"></th>
														<th style="text-align: center;">产品名称</th>
														<th style="text-align: center;">数量</th>
														<th style="text-align: center;">层/站</th>
														<th style="text-align: center;">设备价</th>
														<th style="text-align: center;">折扣</th>
														<th style="text-align: center;">折后设备价</th>
														<th style="text-align: center;">安装费</th>
														<th style="text-align: center;">运输费</th>
														<th style="text-align: center;">实际报价</th>
														<th style="text-align: center;">操作</th>
													</tr>
												</thead>
												<tbody id="123">
													<!-- 开始循环 -->
													<c:choose>
														<c:when test="${not empty bjcList}">
															<c:if test="${QX.cha == 1 }">
																<c:forEach items="${bjcList}" var="bjc" varStatus="vs">
																	<tr>
																		<td class='center' style="width: 30px;"><label>
																				<input class="i-checks" type='checkbox' name='ids'
																				 /> <span class="lbl"></span>
																		</label></td>
																		<td style="text-align: center;">${bjc.MODELS_}</td>
																		<td style="text-align: center;">${bjc.SL_}</td>
																		<td style="text-align: center;">${bjc.CZM_}</td>
																		<td style="text-align: center;">${bjc.SBJ_}</td>
																		<td style="text-align: center;">${bjc.ZK_}</td>
																		<td style="text-align: center;">${bjc.ZHSBJ_}</td>
																		<td style="text-align: center;">${bjc.AZF_}</td>
																		<td style="text-align: center;">${bjc.YSF_}</td>
																		<td style="text-align: center;">${bjc.SJBJ_}</td>
																		<td style="text-align: center;">
																			<button class="btn  btn-primary btn-sm" title="查看"  type="button">查看</button>
																		</td>
																	</tr>

																</c:forEach>
															</c:if>
														</c:when>
														<c:otherwise>
															<tr id="no_data" class="main_info">
																<td colspan="100" class="center">没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="panel-heading">商务信息</div>
								<div class="panel-body">
								     <label style="margin-left:10px">设备付款比例</label></br>
								    <div class="form-group form-inline">
								          <label style="width:9%;margin-left:10px">是否发货前付清:</label> 
										  <select style="width: 21%" class="form-control" id="SWXX_SFFHQFQ" name="SWXX_SFFHQFQ" disabled="disabled">
											  <option value=""  ${pd.SWXX_SFFHQFQ==""?"selected":""}>请选择</option>
					                          <option value="1" ${pd.SWXX_SFFHQFQ=="1"?"selected":""}>是</option>
	                                       	  <option value="2" ${pd.SWXX_SFFHQFQ=="2"?"selected":""}>否</option>
										  </select>
										  
										  <label style="width:9%;margin-left:28px">定金:</label> 
										  <input style="width:21%" type="text" id="SWXX_DJ" name="SWXX_DJ" value="${pd.SWXX_DJ}" class="form-control" disabled="disabled" placeholder="请输入定金比例">
										 
										  <label style="width:9%;margin-left:28px">排产款:</label> 
										  <input style="width:21%" type="text" id="SWXX_PCK" name="SWXX_PCK" value="${pd.SWXX_PCK}" class="form-control" disabled="disabled" placeholder="请输入排产款比例"> 
								    </div>
								    <div class="form-group form-inline">
								          <label style="width:9%;margin-left:10px">发货款:</label> 
										  <input style="width:21%" type="text" id="SWXX_FHK" name="SWXX_FHK" value="${pd.SWXX_FHK}" class="form-control" disabled="disabled" placeholder="请输入发货款比例">
										  
										  <label style="width:9%;margin-left:28px">货到工地款:</label> 
										  <input style="width:21%" type="text" id="SWXX_HDGDK" name="SWXX_HDGDK" value="${pd.SWXX_HDGDK}" class="form-control" disabled="disabled" placeholder="请输入货到工地款比例">
										 
										  <label style="width:9%;margin-left:28px">验收款:</label> 
										  <input style="width:21%" type="text" id="SWXX_YSK" name="SWXX_YSK" value="${pd.SWXX_YSK}" class="form-control" disabled="disabled" placeholder="请输入验收款比例"> 
								    </div>
								    
								    <label style="margin-left:10px">安装付款比例</label></br>
								    <div class="form-group form-inline">
								       <label style="width:9%;margin-left:10px">发货前:</label> 
									   <input style="width:21%" type="text" id="SWXX_FKBL_FHQ" name="SWXX_FKBL_FHQ" value="${pd.SWXX_FKBL_FHQ}" class="form-control" disabled="disabled" placeholder="请输入发货前比例">
									   
									   <label style="width:9%;margin-left:28px">货到工地:</label> 
									   <input style="width:21%" type="text" id="SWXX_FKBL_HDGD" name="SWXX_FKBL_HDGD" value="${pd.SWXX_FKBL_HDGD}" class="form-control" disabled="disabled" placeholder="请输入货到工地比例">
									   
									   <label style="width:9%;margin-left:28px">验收合格:</label> 
									   <input style="width:21%" type="text" id="SWXX_FKBL_YSHG" name="SWXX_FKBL_YSHG" value="${pd.SWXX_FKBL_YSHG}" class="form-control" disabled="disabled" placeholder="请输入验收合格比例">
								    </div>
								    
								    <label style="margin-left:10px">保函类别</label></br>
								     <div class="form-group form-inline">
								        <label style="width:9%;margin-left:10px">投标保函:</label> 
								        <input style="width:10%" type="text" id="SWXX_TBBH_BL" name="SWXX_TBBH_BL" value="${pd.SWXX_TBBH_BL}" class="form-control" disabled="disabled" placeholder="比例">
								        <input style="width:10%;margin-left:8px" type="text" id="SWXX_TBBH_SX" name="SWXX_TBBH_SX" value="${pd.SWXX_TBBH_SX}" class="form-control" disabled="disabled" placeholder="时效">
								        
								        <label style="width:9%;margin-left:28px">预付款保函:</label> 
								        <input style="width:10%" type="text" id="SWXX_YFKBH_BL" name="SWXX_YFKBH_BL" value="${pd.SWXX_YFKBH_BL}" class="form-control" disabled="disabled" placeholder="比例">
								        <input style="width:10%;margin-left:8px" type="text" id="SWXX_YFKBH_SX" name="SWXX_YFKBH_SX" value="${pd.SWXX_YFKBH_SX}" class="form-control" disabled="disabled" placeholder="时效">
								    </div>
								    <div class="form-group form-inline">
								        <label style="width:9%;margin-left:10px">履约保函:</label> 
								        <input style="width:10%" type="text" id="SWXX_LYBH_BL" name="SWXX_LYBH_BL" value="${pd.SWXX_LYBH_BL}" class="form-control" disabled="disabled" placeholder="比例">
								        <input style="width:10%;margin-left:8px" type="text" id="SWXX_LYBH_SX" name="SWXX_LYBH_SX" value="${pd.SWXX_LYBH_SX}" class="form-control" disabled="disabled" placeholder="时效">
								        
								        <label style="width:9%;margin-left:28px">质量保函:</label> 
								        <input style="width:10%" type="text" id="SWXX_ZLBH_BL" name="SWXX_ZLBH_BL" value="${pd.SWXX_ZLBH_BL}" class="form-control" disabled="disabled" placeholder="比例">
								        <input style="width:10%;margin-left:8px" type="text" id="SWXX_ZLBH_SX" name="SWXX_ZLBH_SX" value="${pd.SWXX_ZLBH_SX}" class="form-control" disabled="disabled" placeholder="时效">
								    </div>
								   
								    <label style="margin-left:10px">质保信息</label></br>
								     <div class="form-group form-inline">
								        <label style="width:9%;margin-left:10px">质保金比例:</label> 
								        <input style="width:21%" type="text" id="SWXX_ZBJBL" name="SWXX_ZBJBL" value="${pd.SWXX_ZBJBL}" class="form-control" disabled="disabled" placeholder="请输入质保金比例">
								        
								        <label style="width:9%;margin-left:28px">免保期限（年）:</label>
								        <input style="width:21%" type="text" id="SWXX_MBQX" name="SWXX_MBQX" value="${pd.SWXX_MBQX}" class="form-control" disabled="disabled" placeholder="请输入免保期限"> 
								    </div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</form>
</body>
<script type="text/javascript">
    //关闭当前页面
    function CloseSUWin(id) {
	  window.parent.$("#" + id).data("kendoWindow").close();
    }
  //加入报价池
  function addoffer(obj,modelsId,flag,elevator_id,modelsName,item_id)
  {
	  var YNum=new Number($(obj).parent().parent().find("td").eq("3").text());//已报台数
	  var WNum=new Number($(obj).parent().parent().find("td").eq("4").text());//未报台数 
	  var offer_num=new Number($(obj).parent().parent().find("td").eq("5").find("div").eq("0").text());//报价台数
	  var models_name=modelsName;//型号名称
	  //该型号全部电梯id
	  var elevIds=$(obj).prev().val();
	  var AllElevID=elevIds.split(","); 
	  var elev_ids="";
	  for(var i=0;i<AllElevID.length;i++)
	  {
	      if(i<offer_num)
	      {
	    	  elev_ids+=AllElevID[i]+",";
	    	  AllElevID[i]="";
	      }
		  
	  }
	  for(var i=0;i<AllElevID.length;i++)
	  {
	      if(AllElevID[i]==""||typeof(AllElevID[i]) == "undefined")
	      {
	    	  AllElevID.splice(i,1);
	    	  i=i-1;
	      }
		  
	  }
	  $(obj).prev().val(AllElevID);
	  
	  if(isNaN(offer_num))
		 {
			 alert("报价台数只能是数字！");
		 }
		 else
		 {
			if(offer_num<=0 || offer_num>WNum)
		    {
			   alert("请填写正确的报价台数！");
		    }
		    else
		    {
		     var a=WNum-offer_num;
		     $(obj).parent().parent().find("td").eq("4").text(a);
		     $(obj).parent().parent().find("td").eq("3").text(YNum+offer_num);
			 $("#123").append('<tr>'+
						'<td class="center" style="width: 30px;"><label>'+
						'<input class="i-checks" type="checkbox" name="ids"'+
						'value="${i.item_no}" id="${i.item_no}"'+
						'alt="${i.item_no}" /> <span class="lbl"></span>'+
				'</label></td>'+
				'<td style="text-align: center;">'+models_name+'</td>'+
				'<td style="text-align: center;">'+offer_num+'</td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;">'+
					'<button class="btn  btn-primary btn-sm" title="编辑"'+
					'onclick="edit(this,\''+elevator_id+'\',\''+modelsId+'\',\''+flag+'\',\''+offer_num+'\',\''+elev_ids+'\')" type="button">编辑</button>'+
					'<button class="btn btn-danger btn-sm" title="查看"'+
					'	style="margin-left:5px;" type="button">删除</button>'+
				'</td>'+
			'</tr>');
			 
			 $('#no_data').hide();
		    }
		 }
  }
  //编辑
  function edit(obj,elevator_id,modelsId,flag,offer_num,elev_ids)
  {
  	var rowIndex = $(obj).parent().parent().index();
  	var url;
	if(elevator_id=='1')
	{
		  
	}
	else if(elevator_id=='2')
	{
		 
	}
	else if(elevator_id=='3')
	{
		 
	}
	else if(elevator_id=='4')
	{
		 url = "<%=basePath%>e_offer/escalatorParam.do?elevator_id="+elevator_id+"&modelsId="+modelsId+"&flag="+flag+"&offer_num="+offer_num+"&rowIndex="+rowIndex+"&elev_ids="+elev_ids;
	}
	else
	{
	  alert("电梯梯种错误！");
	}
	$("#ElevatorParam").kendoWindow({
        width: "1000px",
        height: "600px",
        title: "报价清单",
        actions: ["Close"],
        content: url,
        modal : true,
		visible : false,
		resizable : true
    }).data("kendoWindow").maximize().open();
	  
  }
//保存信息
	function save() 
	{
		if ($("#agreement_possible").val() == "" && $("#agreement_possible").val() == "") {
			$("#agreement_possible").focus();
			$("#agreement_possible").tips({
				side : 3,
				msg : "请选择合同可能性",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
	
		if ($("#market_type").val() == "" && $("#market_type").val() == "") {
			$("#market_type").focus();
			$("#market_type").tips({
				side : 3,
				msg : "请选择市场区分",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		
		if ($("#self_inferiority").val() == "" && $("#self_inferiority").val() == "") {
			$("#self_inferiority").focus();
			$("#self_inferiority").tips({
				side : 3,
				msg : "请选择我司劣势",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		//获取jsonStr数组
		var jsonStr="[";
		$("#tab1 tr:gt(1)").each(function(){
			jsonStr += $(this).find("td").eq("0").find("input").eq("0").val()+"},";
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
		$("#jsonStr").val(jsonStr);
		$("#e_offerForm").submit();
	}

</script>
</html>
