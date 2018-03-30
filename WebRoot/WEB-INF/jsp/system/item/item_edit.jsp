<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>

<base href="<%=basePath%>">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
    <!-- ztree样式 -->
    
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
    <style type="text/css">
		.ztree li span.button.add {
			margin-left: 2px;
			margin-right: -1px;
			background-position: -144px 0;
			vertical-align: top;
			*vertical-align: middle
		}
	</style>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
	<script type="text/javascript">
	
	var index = layer.load(1);
	$(document).ready(function(){
		for(var i=1;i<=4;i++){
			var province_id = $("#province_id"+i+" option:selected").val();
			if(province_id!=null && province_id!=""){
				$("#city_id"+i).attr("disabled",false);
			}
			var city_id = $("#city_id"+i+" option:selected").val();
			if(city_id !=null && city_id != ""){
				$("#county_id"+i).attr("disabled",false);
			}
			/*var county_id = $("#county_id"+i+" option:selected").val();
			if(county_id !=null && county_id != ""){
				$("#county_id"+i).attr("disabled",false);
			}*/
		}

		$.fn.zTree.init($("#area_zTree"), area_setting, AreazNodes);
		var AreazTree = $.fn.zTree.getZTreeObj("area_zTree");
		AreazTree.expandAll(true);

		//编辑时加载电梯信息
		var elevatorInfo = $("#elevator_info").val();
		if(elevatorInfo!=""){
			setElevatorInfo(elevatorInfo);
		}
		//编辑时加载订购单位信息
		var saleType = $("#sale_type").val();
		if(saleType!=""){
			setOrderOrg();
		}else{
			$("#order_org").empty();
			$("#order_org").append("<option value=''>请先选择销售类型</option>");
			$("#order_org").selectpicker("refresh");
		}

		/*parent.layer.closeAll('loading');*/
	});
	//日期范围限制
    var start = {
        elem: '#start_time',
        format: 'YYYY/MM/DD hh:mm:ss',
        max: '2099-06-16 23:59:59', //最大日期
        istime:true,
        istoday: false,
        choose: function (datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#end_time',
        format: 'YYYY/MM/DD hh:mm:ss',
        max: '2099-06-16 23:59:59',
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);

    //跳转添加最终用户
    function toAddCustomer(){
    	$("#EditCustomer").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "编辑客户信息",
		        actions: ["Close"],
		        content: '<%=basePath%>customer/goAddCustomer.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
    }
	
	//修改最终用户时改变客户编号
	function setCustomerNo(){
		var str = $("#end_user").val();
		if(str.indexOf("_")>-1){
			str = str.substring(str.indexOf("_")+1,str.length);	
		}else{
			str="";
		}
		$("#customer_no").val(str);
	}
	//修改负责人时改变职位和电话信息
	function setUserInfo(){
		var USER_ID = $("#item_manager").val();
		$.post("<%=basePath%>item/getUserInfo.do",
				{
					"USER_ID":USER_ID
				},
				function(data){
					$("#manager_duty").empty();
					$("#manager_duty").append("<option value='"+data.POSITION_ID+"'>"+data.POSITION_NAME+"</option>");
					$("#manager_phone").val(data.PHONE);
				}
			);
	}

	//加载编辑页面时改变职位
	function setUserInfoWhenEdit(){
		var USER_ID = $("#item_manager").val();
		$.post("<%=basePath%>item/getUserInfo.do",
				{
					"USER_ID":USER_ID
				},
				function(data){
					var position_name = data.POSITION_NAME;
					if(typeof(position_name)=="undefined"){
						position_name = "暂无";
					}
					$("#manager_duty").empty();
					$("#manager_duty").append("<option value='"+data.POSITION_ID+"'>"+position_name+"</option>");
				}
			);
	}

	//修改是否跨区时加载分子公司列表
	function setCrossRegion(){
		var flag = $("#is_cross_region").val();
		if(flag=="1"){
			$("#subBranchDiv").show();
			var itemSubBranch = $("#item_sub_branch").val();
			settingSubBranch(itemSubBranch);
		}else{
			$("#subBranchDiv").hide();
			$("#item_install_sub_branch").val();
			$("#item_install_sub_branch_text").val();
		}
	}

	//检测项目名称是否存在
	function checkItemName(){
		var name = $("#item_name").val();
		var old_name = $("#old_item_name").val();
		var operateType = $("#operateType").val();
		$.post("<%=basePath%>item/checkItemName.do?item_name="+name+"&old_item_name="+old_name+"&operateType="+operateType,
			function(data){
				if(data.msg=='isExsit'){
					$("#item_name").focus();
					$("#item_name").tips({
							side:3,
				            msg:"项目名称已存在",
				            bg:'#AE81FF',
				            time:2
				        });
				}

			}
		);
	}

	//保存
	function save(){
		$("#item_name").focus();
		if($("#item_name").val()==""){
			$("#item_name").tips({
					side:3,
		            msg:"输入项目名称",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#sale_type").focus();
		if($("#sale_type").val()==""){
			$("#sale_type").tips({
					side:3,
		            msg:"选择销售类型",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#contract_type").focus();
		if($("#contract_type").val()==""){
			$("#contract_type").tips({
					side:3,
		            msg:"选择合同类型",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#end_user").focus();
		if($("#end_user").val()==""){
			$("#end_user").tips({
					side:3,
		            msg:"选择最终用户",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#order_org").focus();
		if($("#order_org").val()==""){
			$("#order_org").tips({
					side:3,
		            msg:"选择订购单位",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#item_status").focus();
		if($("#item_status").val()==""){
			$("#item_status").tips({
					side:3,
		            msg:"选择项目状态",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#item_area_text").focus();
		if($("#item_area").val()==""){
			$("#item_area_text").tips({
					side:3,
		            msg:"选择归属区域",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#item_sub_branch_text").focus();
		if($("#item_sub_branch").val()==""){
			$("#item_sub_branch_text").tips({
					side:3,
		            msg:"选择归属分子公司",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#is_cross_region").focus();
		if($("#is_cross_region").val()==""){
			$("#is_cross_region").tips({
					side:3,
		            msg:"选择是否跨区",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#item_install_sub_branch_text").focus();
		if($("#is_cross_region").val()=="1"&&$("#item_install_sub_branch").val()==""){
			$("#item_install_sub_branch_text").tips({
					side:3,
		            msg:"选择安装管辖分子公司",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		$("#cross_region_num").focus();
		if($("#is_cross_region").val()=="1"&&$("#cross_region_num").val()==""){
			$("#cross_region_num").tips({
					side:3,
		            msg:"输入跨区台量",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
		}
		//处理电梯信息
		setElevatorStr();
		//提交表单
		$("#itemForm").submit();
	}

	//处理电梯信息
	function setElevatorStr(){
		var elevatorType = "";
		var elevatorModel = "";
		var elevatorNum = "";
		var elevatorNo = "";
		var jsonStr = "[";

		$("#elevatorTable tr:not(:first)").each(function(){
			elevatorType = $(this).find("td").eq(0).find("select").eq(0).val();
			elevatorModel = $(this).find("td").eq(1).find("select").eq(0).val();
			elevatorNum = $(this).find("td").eq(2).find("input").eq(0).val();
			elevatorNo = $(this).find("td").eq(2).find("input").eq(1).val();
			jsonStr += "{\'elevatorType\':\'"+elevatorType+"\',\'elevatorModel\':\'"+elevatorModel+"\',\'elevatorNum\':\'"+elevatorNum+"\',\'elevatorNo\':\'"+elevatorNo+"\'},";
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
		$("#elevator_info").val(jsonStr);
	}

	//编辑时加载电梯信息
	function setElevatorInfo(str){
		var obj = eval("("+str+")");
		for(var j = 0;j<obj.length-1;j++){
			addRow();
		}
		for(var i = 0;i<obj.length;i++){
			$("table tr:not(:first)").eq(i).each(function(){
				$(this).find("td").eq(0).find("select").eq(0).val(obj[i].elevatorType);
				$(this).find("td").eq(1).find("select").eq(0).val(obj[i].elevatorModel);
				$(this).find("td").eq(2).find("input").eq(0).val(obj[i].elevatorNum);
				$(this).find("td").eq(2).find("input").eq(1).val(obj[i].elevatorNo);
			});
		}
		setElevatorModelWhenEdit(obj.length-1,obj);
	}

	function setElevatorModelWhenEdit(index,obj){
		var elevatorId;
		var elevatorVal;
		var selected = "";
		$("table tr:not(:first)").eq(index).each(function(){
				elevatorId = obj[index].elevatorType;
				elevatorVal = obj[index].elevatorModel;
		});
		$.post("<%=basePath%>item/findElevatorModels.do?elevator_id="+elevatorId,
				function(data){
					var jsonObj = data.modelList;
					var str = "<option value=''>请选择</option>";
					for(var i =0;i<jsonObj.length;i++){
						if(jsonObj[i].models_id==elevatorVal){
							selected = "selected";
						}else{
							selected = "";
						}
						str += "<option value='"+jsonObj[i].models_id+"' "+selected+" >"+jsonObj[i].models_name+"</option>";
					}
					$("table tr:not(:first)").eq(index).find("td").eq("1").find("select").eq("0").html(str);
				}
		);
		if(!index-1<0){
			setElevatorModelWhenEdit(index-1,obj);
		}

	}

	//改变销售类型时修改订购单位
	function setOrderOrg(){
		var saleType = $("#sale_type").val();
		var orderOrgId = $("#order_org_text").val();
		if(saleType!=""){
			$.post("<%=basePath%>item/getOrderOrg.do?sale_type="+saleType,
					function(data){
						var obj = eval("("+data.orderOrgs+")");
						var optStr = "<option value=''>请选择订购单位</option>";
						for(var i = 0;i<obj.length;i++){
							optStr += "<option value='"+obj[i].id+"'";
							if(obj[i].id==orderOrgId){
								optStr += " selected ";
							}
							optStr +=  ">"+obj[i].name+"</option>";
						}
						$("#order_org").empty();
						$("#order_org").append(optStr);
						$("#order_org").selectpicker("refresh");
					}
			);
		}
	}


	function checkOperateType() {
		setCrossRegion();
		if($("#operateType").val()=="sel"){
			setUserInfoWhenEdit();
			var inputs = document.getElementsByTagName("input");
			for(var i = 0;i<inputs.length;i++){
				inputs[i].setAttribute("disabled","true");
			}
			var textareas = document.getElementsByTagName("textarea");
			for(var i = 0;i<textareas.length;i++){
				textareas[i].setAttribute("disabled","true");
			}
			var selects = document.getElementsByTagName("select");
			for(var i = 0;i<selects.length;i++){
				selects[i].setAttribute("disabled","true");
			}
		}else if($("#operateType").val()=="edit"){
			setUserInfoWhenEdit();
		}else if($("#operateType").val()=="add"){
			//默认选中登录人区域和公司信息
			$("#item_area").val('${areaId}');
			$("#item_area_text").val('${areaName}');
			$("#item_sub_branch").val('${branchId}');
			$("#item_sub_branch_text").val('${branchName}');
			settingBranch('${areaId}');
		}
		layer.close(index);

	}
	//添加行,录入电梯信息
	function addRow(){
		var tr = $("table tr").eq(1).clone();
		$(tr).find("td").eq(0).find("select").eq(0).val("");
		$(tr).find("td").eq(1).find("input").eq(0).val("");
		$(tr).find("td").eq(2).find("input").eq(0).val("");
		$(tr).find("td").eq(2).find("input").eq(1).val("");
		$(tr).find("td:last").html("").append("<td><input type='button' value='梯号' onclick='setTh(this);'><input type='button' value='删除' onclick='delRow(this)'></td>");
		$("#elevatorTable").append(tr);
	}

	//修改电梯种类时改变电梯型号
	function setElevatorModel(obj){
		var elevatorId = $(obj).val();
		$.post("<%=basePath%>item/findElevatorModels.do?elevator_id="+elevatorId,
				function(data){
					var jsonObj = data.modelList;
					var str = "<option value=''>请选择</option>";
					for(var i =0;i<jsonObj.length;i++){
						str += "<option value='"+jsonObj[i].models_id+"'>"+jsonObj[i].models_name+"</option>";
					}
					$(obj).parent().parent().find("td").eq("1").find("select").eq("0").html(str);
				}
		);
	}

	//删除行
	function delRow(obj){
		$(obj).parent().parent().parent().remove();
	}
	
	function CloseSUWin(id) {	
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}

	</script>
</head>

<body class="gray-bg" onload="checkOperateType();" onclick="hideMenu();">
<div id="EditCustomer" class="animated fadeIn"></div>
<div id="SetElevNo" class="animated fadeIn"></div>
<form action="item/${msg}.do" name="itemForm" id="itemForm" method="post">
<input type="hidden" name="input_user"  id="input_user" value="${input_user}"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType }"/>
<input type="hidden" name="item_id"  id="item_id" value="${pd.item_id }"/>
<input type="hidden" name="elevator_num" id="elevator_num" value=${pd.elevator_num}/>
<input type="hidden" name="ids" id="ids"/>
<input type="hidden" name="cross_region_text" id="cross_region_text" value=${pd.cross_region_text}/>
<input type="hidden" name="old_item_name" id="old_item_name" value="${pd.item_name}"/>
<!-- 电梯信息 -->
<input type="hidden" name="elevator_info" id="elevator_info" value="${pd.elevator_info}">
<!-- 订购单位 -->
<input type="hidden" name="order_org_text" id="order_org_text" value="${pd.order_org}">

<%--用户地址 --%>
<!-- 项目安装地址 -->
<input type="hidden" name="item_install_address" id="item_install_address" value="${pd.item_install_address }">
<input type="hidden" id="address_name1" name="address_name1" value="${pd.address_name1 }">
<!-- 设计院地址 -->
<input type="hidden" name="design_address" id="design_address"  value="${pd.design_address}">
<input type="hidden" id="address_name2" name="address_name2" value="${pd.address_name2 }">
<!-- 项目地址 -->
<input type="hidden" name="item_address" id="item_address"  value="${pd.item_address}">
<input type="hidden" id="address_name3" name="address_name3" value="${pd.address_name3 }">


    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        项目基本信息
			                                        <c:if test="${showAddEndUser == true}">
			                                        	<button class="btn btn-default btn-xs btn-outline" title="添加最终用户" type="button" style="float: right;" onclick="toAddCustomer()">添加最终用户</button>
			                                        </c:if>
			                                    </div>
                                    			<div class="panel-body">        
			                                        <div class="form-group form-inline">                                
	                                    				<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>项目名称:</label>
				                                        <input style="width:22%" placeholder="这里输入项目名称" type="text" name="item_name" id="item_name" value="${pd.item_name }"  title="项目名称" class="form-control" onblur="checkItemName();">
				                                    	<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>销售类型:</label>
				                                    	<select style="width:22%;margin-top:16px" name="sale_type" id="sale_type" class="form-control m-b" onchange="setOrderOrg();">
				                                    		<option value="">请选择销售类型</option>
				                                    		<option value="1" ${pd.sale_type=='1'?'selected':''}>经销</option>
				                                    		<option value="2" ${pd.sale_type=='2'?'selected':''}>直销</option>
				                                    		<option value="3" ${pd.sale_type=='3'?'selected':''}>代销</option>
				                                    	</select>
				                                    	<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font>合同类型</span></label>
				                                    	<select style="width: 24%;margin-top: 10px" name="contract_type" id="contract_type" class="form-control m-b">
				                                    		<option value="">请选择合同类型</option>
				                                    		<option value="1" ${pd.contract_type=='1'?'selected':''}>安装合同</option>
				                                    		<option value="2" ${pd.contract_type=='2'?'selected':''}>设备合同</option>
				                                    		<option value="3" ${pd.contract_type=='3'?'selected':''}>总包合同</option>
				                                    	</select>
				                                    </div>
			                                        <div class="form-group form-inline">
	                                    				<label style="width:10%;"><span><font color="red">*</font></span>最终用户:</label>
	                                    				<select style="width:22%;margin-top:16px" name="end_user" id="end_user" onchange="setCustomerNo();" class="selectpicker" data-live-search="true">
	                                    					<option value="">请选择最终用户</option>
	                                    					<c:forEach items="${customerList}" var="var">
	                                    						<option value="${var.customer_id}_${var.customer_no}" ${pd.end_user==var.customer_id?"selected":""}>${var.customer_name}</option>
	                                    					</c:forEach>
	                                    				</select>
	                                    				<label style="width:10%;"><span><font color="red">*</font></span>客户编号:</label>
				                                        <input style="width:22%" placeholder="这里输入客户编号" type="text" name="customer_no" id="customer_no" value="${pd.customer_no }"  title="客户编号" readonly="readonly" class="form-control">
			                                    		<c:if test="${operateType=='edit'}">
			                                    			<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>项目编号:</label>
				                                    		<input style="width:24%" readonly="readonly" type="text" name="item_no" id="item_no" value="${pd.item_no }"  title="项目编号" class="form-control">
			                                    		</c:if>
	                                        		</div>
		                                    	</div>
		                                	</div>
		                            	</div>
                                    </div>
                                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        安装地址
			                                    </div>
                                    			<div class="panel-body">
	                                    			<div class="form-group form-inline">
			                                    		<label style="width:10%;margin-top: 25px;margin-bottom: 10px">安装地址:</label>
			                                        	<select style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" name="province_id1" id="province_id1" title="区域" onchange="provinceChange('1');">
				                                        	<option value="">请选择</option>
												    		<c:forEach var="province" items="${provinceList}" >
												    		<option value="${province.id }" <c:if test="${pd.province_id1 eq province.id }">selected</c:if>  >${province.name }</option>
												    		</c:forEach>
														</select>
														<select style="width:20%;margin-top: 25px;margin-bottom: 10px" id="city_id1" name="city_id1" class="form-control" disabled="disabled" title="城市" onchange="cityChange('1');">
															<option value="">请选择</option>
													    	<c:forEach var="city" items="${cityList}" >
													    		<option value="${city.id }" <c:if test="${pd.city_id1 eq city.id }">selected</c:if>  >${city.name }</option>
													    	</c:forEach>
														</select>
				                                        <select style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" name="county_id1" id="county_id1" title="郡/县" disabled="disabled">
				                                        	<option value="">请选择</option>
													    	<c:forEach var="coundty" items="${coundtyList}" >
													    		<option value="${coundty.id }" <c:if test="${pd.county_id1 eq coundty.id }">selected</c:if>  >${coundty.name }</option>
													    	</c:forEach>
														</select>
                                        				<input style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" type="text" name="address_info1" id="address_info1" placeholder="这里输入地址" value="${pd.address_info1}"  />
                                    				</div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
				                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        电梯信息
			                                    </div>
                                    			<div class="panel-body">
	                                    			<div class="table-responsive">
							                            <table class="table table-striped table-bordered table-hover" id="elevatorTable">
							                                    <tr>
							                                        <th style="width:10%;">电梯种类</th>
							                                        <th style="width:10%;">规格描述</th>
							                                        <th style="width:10%;">需求数量</th>
							                                        <th style="width:10%;">操作</th>
							                                    </tr>
							                                	<tr>
							                                		<td>
							                                			<select style="width: 100%;margin-top:16px" class="form-control m-b" onchange="setElevatorModel(this);">
							                                    			<option value=''>请选择</option>
							                                    			<c:forEach items="${elevatorList}" var="var">
							                                    				<option value="${var.elevator_id}">${var.elevator_name}</option>
							                                    			</c:forEach>
																		</select>
							                                		</td>
							                                		<td>
							                                			<select style="width: 100%;margin-top:16px" class="form-control m-b">
							                                				<option value=''>请选择</option>
							                                			</select>
							                                		</td>
							                                		<td><input type="text" class="form-control">
							                                			<input type="hidden">
							                                		</td>
							                                		<td><input type="button" value="梯号" onclick="setTh(this);"><input type="button" value="添加" onclick="addRow();"></td>
							                                	</tr>
							                            </table>
							                        </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
                                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        项目信息
			                                    </div>
                                    			<div class="panel-body">
				                                    <div class="form-group form-inline">
				                                        <!-- <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>订购单位:</label>
				                                        <select style="width:22%;margin-top:16px" name="order_org" id="order_org" class="form-control m-b">
	                                    					<option value="">请选择订购单位</option>
	                                    				</select> -->

	                                    				<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>订购单位:</label>
				                                        <select style="width:22%;margin-top:16px" name="order_org" id="order_org" class="selectpicker" data-live-search="true">
	                                    					<option value="">请选择订购单位</option>
	                                    				</select>

				                                        <label style="width:10%">联系人:</label>
				                                        <input style="width:22%" style="width:170px" style="width:170px" type="text" name="order_org_contact" id="order_org_contact"  value="${pd.order_org_contact}" placeholder="这里输入联系人" title="联系人"   class="form-control">
				                                        <label style="width:10%">联系电话:</label>
				                                        <input style="width:22%" type="text" name="order_org_phone" id="order_org_phone"  value="${pd.order_org_phone}"  placeholder="这里输入联系电话" title="联系电话"  class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
														<label style="width:10%">项目负责人:</label>
	                                    				<select style="width:22%;margin-top: 16px" name="item_manager" id="item_manager" onchange="setUserInfo();" class="selectpicker" data-live-search="true">
	                                    					<option value="">请选择项目负责人</option>
	                                    					<c:forEach items="${userList}" var="var">
	                                    						<option value="${var.USER_ID}" ${pd.item_manager==var.USER_ID?"selected":""}>${var.NAME}</option>
	                                    					</c:forEach>
	                                    				</select>
	                                    				<label style="width:10%;"><!-- 启动时间: -->预计预约时间:</label>
				                                        <input style="width:22%" type="text" name="start_date" id="start_date"  value="${pd.start_date}" placeholder="这里输入预计预约时间"  title="预计预约时间"   class="form-control layer-date" onclick="laydate()">
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
				                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        项目区域信息
			                                    </div>
                                    			<div class="panel-body">
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%">市场标志:</label>
				                                        <select style="width:22%;margin-top: 16px" name="market_flag" id="market_flag" class="form-control m-b">
				                                        	<option value="">请选择市场标志</option>
				                                        	<option value="国内" ${pd.market_flag=="国内"?"selected":""}>国内</option>
				                                        	<option value="国外" ${pd.market_flag=="国外"?"selected":""}>国外</option>
				                                        </select>
				                                        <label style="width:10%">信息来源:</label>
				                                        <select style="width:22%;margin-top:16px" name="mes_source" id="mes_source" class="form-control m-b">
				                                        	<option value="">请选择信息来源</option>
				                                        	<option value="设计院" ${pd.mes_source=="设计院"?"selected":""}>设计院</option>
				                                        	<option value="装修公司" ${pd.mes_source=="装修公司"?"selected":""}>装修公司</option>
				                                        	<option value="代理商" ${pd.mes_source=="代理商"?"selected":""}>代理商</option>
				                                        	<option value="400电话" ${pd.mes_source=="400电话"?"selected":""}>400电话</option>
				                                        	<option value="老客户" ${pd.mes_source=="老客户"?"selected":""}>老客户</option>
				                                        	<option value="物业公司" ${pd.mes_source=="物业公司"?"selected":""}>物业公司</option>
				                                        </select>
				                                        <span><font color="red">*</font></span>
				                                        <label style="width:10%;">项目状态:</label>
				                                        <select style="width:22%;margin-top:16px" name="item_status" id="item_status" class="form-control m-b">
				                                        	<option value="">请选择项目状态</option>
				                                        	<option value="1" ${pd.item_status=="1"?"selected":""}>信息</option>
				                                        	<option value="2" ${pd.item_status=="2"?"selected":""}>报价</option>
				                                        	<option value="3" ${pd.item_status=="3"?"selected":""}>投标</option>
				                                        	<option value="4" ${pd.item_status=="4"?"selected":""}>洽谈</option>
				                                        	<option value="5" ${pd.item_status=="5"?"selected":""}>合同</option>
				                                        	<option value="6" ${pd.item_status=="6"?"selected":""}>中标</option>
				                                        	<option value="7" ${pd.item_status=="7"?"selected":""}>失标</option>
				                                        	<option value="8" ${pd.item_status=="8"?"selected":""}>取消</option>
				                                        	<option value="9" ${pd.item_status=="9"?"selected":""}>生效</option>
				                                        </select>
				                                        <label style="width:10%;display:none">启用状态:</label>
				                                        <select style="width:22%;display:none" name="enable_status" id="enable_status" class="form-control m-b">
				                                        	<option value="">请选择启用状态</option>
				                                        	<option value="1" ${pd.enable_status=="1"?"selected":""}>启用</option>
				                                        	<option value="0" ${pd.enable_status=="0"?"selected":""}>禁用</option>
				                                        </select>
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>归属区域:</label>
				                                        <input style="width:22%" type="text" readonly="readonly" name="item_area_text" id="item_area_text"  value="${pd.item_area_text}" placeholder="这里输入项目归属区域"  title="项目归属区域"  onclick="showAreaMenu();" class="form-control">
				                                        <input type="hidden" name="item_area" id="item_area" value="${pd.item_area}">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>归属分子公司:</label>
				                                        <input style="width:22%" type="text" readonly="readonly" name="item_sub_branch_text" id="item_sub_branch_text"  value="${pd.item_sub_branch_text}" placeholder="这里输入项目归属分子公司"  title="项目归属分子公司" onclick="showBranchMenu();"  class="form-control">
				                                        <input type="hidden" name="item_sub_branch" id="item_sub_branch" value="${pd.item_sub_branch}">
				                                    	<label style="width:10%"><span><font color="red">*</font></span>是否跨区:</label>
				                                    	<select class="form-control m-b" name="is_cross_region" id="is_cross_region" onchange="setCrossRegion();" style="width:24%;margin-top: 16px">
				                                    		<option value="">请选择是否跨区</option>
				                                    		<option value="1" ${pd.is_cross_region=="1"?"selected":""}>是</option>
				                                    		<option value="0" ${pd.is_cross_region=="0"?"selected":""}>否</option>
				                                    	</select>
				                                    </div>
				                                    <div id="subBranchDiv" class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>安装管辖公司:</label>
				                                        <input type="text" style="width:22%" readonly="readonly" name="item_install_sub_branch_text" id="item_install_sub_branch_text" value="${pd.item_install_sub_branch_text}" placeholder="这里输入安装管辖分子公司"  title="安装管辖分子公司" class="form-control" onclick="showSubMenu()">
				                                        <input type="hidden" name="item_install_sub_branch" id="item_install_sub_branch" value="${pd.item_install_sub_branch}">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>跨区台量:</label>
				                                        <input style="width:22%" type="text" name="cross_region_num" id="cross_region_num"  value="${pd.cross_region_num}"  placeholder="这里输入跨区台量" title="跨区台量"  class="form-control">
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
                            		<div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        备注信息
			                                    </div>
                                    			<div class="panel-body">
				                                    <div class="form-group">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">备注:</label>
				                                        <textarea rows="3" cols="13" name="remark" id="remark" class="form-control" placeholder="这里输入备注">${pd.remark }</textarea>
				                                    </div>
				                    			</div>
				                    		</div>
				                    	</div>
				                    </div>
                            		<div class="row">
	                            		<div class="col-sm-12">
	                                		<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        项目预计信息
			                                    </div>
		                            			<div class="panel-body">        
			                                        <div class="form-group form-inline">                                
		                                				<label style="width:10%;margin-top: 25px;margin-bottom: 10px">完工时间:</label>
				                                        <input style="width:22%" placeholder="这里输入预计项目完工时间" type="text" name="plan_complete" id="plan_complete" value="${pd.plan_complete }"  title="预计项目完工时间" class="form-control layer-date" onclick="laydate()">
				                                        <label style="width:10%">使用时间:</label>
				                                        <input style="width:22%" placeholder="这里输入预计设备投入使用时间" type="text" name="plan_comeinto" id="plan_comeinto" value="${pd.plan_comeinto }"  title="预计设备投入使用时间" class="form-control layer-date" onclick="laydate()">
				                                    	<label style="width:10%">签约时间:</label>
				                                    	<input style="width:24%" placeholder="这里输入预计签约时间" type="text" name="plan_contract" id="plan_contract" value="${pd.plan_contract }"  title="预计签约时间" class="form-control layer-date" onclick="laydate()">
		                                    		</div>
			                                        <div class="form-group form-inline" style="display:none">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">收取定金时间:</label>
				                                        <input style="width:22%" type="text" name="plan_deposit" id="plan_deposit"  value="${pd.plan_deposit}" placeholder="这里输入预计收取定金时间"  title="预计收取定金时间"   class="form-control layer-date" onclick="laydate()">
			                                    	</div>
		                                    	</div>
			                                </div>
			                            </div>
		                            </div>
				                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        设计院信息
			                                    </div>
                                    			<div class="panel-body">
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">名称:</label>
				                                        <input style="width:22%" type="text" name="design_name" id="design_name"  value="${pd.design_name}" placeholder="这里输入设计院名称" title="设计院名称"  class="form-control">
				                                        <label style="width:10%">电话:</label>
				                                        <input style="width:22%" type="text" name="design_phone" id="design_phone"  value="${pd.design_phone}" placeholder="这里输入设计院电话" title="设计院电话"  class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">传真:</label>
				                                        <input style="width:24%" type="text" name="design_fax" id="design_fax"  value="${pd.design_fax}"  title="设计院传真"  placeholder="这里输入设计院传真" class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">项目设计:</label>
				                                        <input style="width:22%" type="text" name="item_design" id="item_design"  value="${pd.item_design}" placeholder="这里输入项目设计" title="项目设计"  class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系电话:</label>
				                                        <input style="width:22%" type="text" name="item_design_phone" id="item_design_phone"  value="${pd.item_design_phone}" placeholder="这里输入项目设计联系电话" title="项目设计联系电话"   class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">项目总工:</label>
				                                        <input style="width:22%" type="text" name="item_engineer" id="item_engineer"  value="${pd.item_engineer}" placeholder="这里输入项目总工" title="项目总工"  class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">总工电话:</label>
				                                        <input style="width:22%" type="text" name="item_engineer_phone" id="item_engineer_phone"  value="${pd.item_engineer_phone}" placeholder="这里输入项目总工联系电话" title="项目总工联系电话"   class="form-control">
				                                    </div>
				                                    <div class="form-group">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">技术特别要求:</label>
				                                        <textarea rows="3" cols="13" name="special_require" id="special_require" class="form-control" placeholder="这里输入技术特别要求">${pd.special_require }</textarea>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
				                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        设计院地址
			                                    </div>
                                    			<div class="panel-body">
			                                    	<div class="form-group form-inline">
			                                    		<label style="width:10%;margin-top: 25px;margin-bottom: 10px">地址:</label>
			                                        	<select style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" name="province_id2" id="province_id2" title="区域" onchange="provinceChange('2');">
				                                        	<option value="">请选择</option>
												    		<c:forEach var="province" items="${provinceList}" >
												    		<option value="${province.id }" <c:if test="${pd.province_id2 eq province.id }">selected</c:if>  >${province.name }</option>
												    		</c:forEach>
														</select>
														<select style="width:20%;margin-top: 25px;margin-bottom: 10px" id="city_id2" name="city_id2" class="form-control" disabled="disabled" title="城市" onchange="cityChange('2');">
															<option value="">请选择</option>
													    	<c:forEach var="city" items="${cityList}" >
													    		<option value="${city.id }" <c:if test="${pd.city_id2 eq city.id }">selected</c:if>  >${city.name }</option>
													    	</c:forEach>
														</select>
				                                        <select style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" name="county_id2" id="county_id2" title="郡/县" disabled="disabled">
				                                        	<option value="">请选择</option>
													    	<c:forEach var="coundty" items="${coundtyList}" >
													    		<option value="${coundty.id }" <c:if test="${pd.county_id2 eq coundty.id }">selected</c:if>  >${coundty.name }</option>
													    	</c:forEach>
														</select>
                                        				<input style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" type="text" name="address_info2" id="address_info2" placeholder="这里输入地址" value="${pd.address_info2}"  />
                                    				</div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
                                    <div class="row" style="display:none">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        项目其他信息
			                                    </div>
                                    			<div class="panel-body">
			                                        <div class="form-group form-inline" style="display:none">
	                                    				<label style="width:10%;margin-top: 25px;margin-bottom: 10px">项目单位:</label>
				                                        <input style="width:22%" placeholder="这里输入项目单位" type="text" name="item_org" id="item_org" value="${pd.item_org }"  title="项目单位" class="form-control">
				                                        <label style="width:10%;">单位联系人:</label>
				                                        <input style="width:22%" placeholder="这里输入单位联系人" type="text" name="item_org_contact" id="item_org_contact" value="${pd.item_org_contact }"  title="单位联系人" class="form-control">
				                                    	<label style="width:10%;">单位电话:</label>
				                                    	<input style="width:24%" placeholder="这里输入单位联系电话" type="text" name="item_org_phone" id="item_org_phone" value="${pd.item_org_phone }"  title="单位联系电话" class="form-control">
	                                        		</div>
			                                        <div class="form-group form-inline" style="display:none">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系人:</label>
				                                        <input style="width:22%" placeholder="这里输入联系人" type="text" name="item_contact" id="item_contact" value="${pd.item_contact }"  title="联系人" class="form-control">
				                                    	<label style="width:10%;">联系电话:</label>
				                                    	<input style="width:22%" placeholder="这里输入联系电话" type="text" name="item_contact_phone" id="item_contact_phone" value="${pd.item_contact_phone }"  title="联系电话" class="form-control">
				                                        <!-- <label style="width:10%;">启动时间:</label>
				                                        <input style="width:24%" type="text" name="start_date" id="start_date"  value="${pd.start_date}" placeholder="这里输入启动时间"  title="启动时间"   class="form-control layer-date" onclick="laydate()"> -->
			                                    	</div>
				                                    <div class="form-group form-inline" style="display:none">
	                                    				<!-- <label style="width:10%">项目负责人:</label>
	                                    				<select style="width:22%" name="item_manager" id="item_manager" onchange="setUserInfo();" class="selectpicker" data-live-search="true">
	                                    					<option value="">请选择项目负责人</option>
	                                    					<c:forEach items="${userList}" var="var">
	                                    						<option value="${var.USER_ID}" ${pd.item_manager==var.USER_ID?"selected":""}>${var.NAME}</option>
	                                    					</c:forEach>
	                                    				</select> -->
				                                        <label style="width:10%;">负责人职位:</label>
				                                        <select  style="width:22%;margin-top: 16px" placeholder="这里输入负责人职位"  name="manager_duty" id="manager_duty" value="${pd.manager_duty }"  title="负责人职位" class="form-control">
				                                        </select>   
	                                    				<label style="width:10%;margin-bottom: 10px;margin-top:25px">负责人电话:</label>
				                                        <input style="width:24%" placeholder="这里输入负责人电话" type="text" name="manager_phone" id="manager_phone" value="${pd.manager_phone }"  title="负责人电话" class="form-control">
				                                    </div>
			                                        <div class="form-group form-inline" style="display:none">
				                                        <label style="width:10%">合同可能:</label>
				                                        <input style="width:22%" type="text" name="agreement_possible" id="agreement_possible"  value="${pd.agreement_possible}" placeholder="这里输入合同可能性"  title="合同可能性"   class="form-control">
				                                        <label style="width:10%">市场区分:</label>
				                                        <select style="width:22%;margin-top: 16px" name="market_type" id="market_type" class="form-control m-b">
				                                        	<option value="">请选择市场区分</option>
				                                        	<option value="住宅" ${pd.market_type=="住宅"?"selected":""}>住宅</option>
				                                        	<option value="工厂" ${pd.market_type=="工厂"?"selected":""}>工厂</option>
				                                        	<option value="医院" ${pd.market_type=="医院"?"selected":""}>医院</option>
				                                        	<option value="商业" ${pd.market_type=="商业"?"selected":""}>商业</option>
				                                        	<option value="政府机关" ${pd.market_type=="政府机关"?"selected":""}>政府机关</option>
				                                        	<option value="别墅" ${pd.market_type=="别墅"?"selected":""}>别墅</option>
				                                        	<option value="公寓" ${pd.market_type=="公寓"?"selected":""}>公寓</option>
				                                        	<option value="学校" ${pd.market_type=="学校"?"selected":""}>学校</option>
				                                        	<option value="公共交通" ${pd.market_type=="公共交通"?"selected":""}>公共交通</option>
				                                        	<option value="酒店" ${pd.market_type=="酒店"?"selected":""}>酒店</option>
				                                        	<option value="小业主" ${pd.market_type=="小业主"?"selected":""}>小业主</option>
				                                        	<option value="总包方" ${pd.market_type=="总包方"?"selected":""}>总包方</option>
				                                        	<option value="OEM" ${pd.market_type=="OEM"?"selected":""}>OEM</option>
				                                        </select>
				                                    	<label style="width:10%;margin-top: 25px;margin-bottom: 10px">我司劣势:</label>
				                                        <select style="width:24%;margin-top: 16px" name="self_inferiority" id="self_inferiority" class="form-control m-b">
				                                        	<option value="">请选择我司劣势</option>
				                                        	<option value="价格" ${pd.self_inferiority=="价格"?"selected":""}>价格</option>
				                                        	<option value="品牌" ${pd.self_inferiority=="品牌"?"selected":""}>品牌</option>
				                                        	<option value="关系" ${pd.self_inferiority=="关系"?"selected":""}>关系</option>
				                                        	<option value="技术" ${pd.self_inferiority=="技术"?"selected":""}>技术</option>
				                                        </select>
			                                    	</div>
			                                        <div class="form-group form-inline" style="display:none">
				                                        <label style="width:10%">项目总额:</label>
				                                        <input style="width:22%"  type="text" name="item_total" id="item_total"  value="${pd.item_total}" placeholder="这里输入项目总额"  title="项目总额"   class="form-control">
			                                    	</div>
		                                    	</div>
		                                	</div>
		                            	</div>
                                    </div>
                                    <div class="row" style="display:none">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        项目地址
			                                    </div>
                                    			<div class="panel-body">
			                                    	<div class="form-group form-inline">
		                                        		<span style="color: red">*</span>
			                                    		<label style="width:10%;margin-top: 25px;margin-bottom: 10px">项目地址:</label>
			                                        	<select style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" name="province_id3" id="province_id3" title="区域" onchange="provinceChange('3');">
				                                        	<option value="">请选择</option>
												    		<c:forEach var="province" items="${provinceList}" >
												    		<option value="${province.id }" <c:if test="${pd.province_id3 eq province.id }">selected</c:if>  >${province.name }</option>
												    		</c:forEach>
														</select>
														<select style="width:20%;margin-top: 25px;margin-bottom: 10px" id="city_id3" name="city_id3" class="form-control" disabled="disabled" title="城市" onchange="cityChange('3');">
															<option value="">请选择</option>
													    	<c:forEach var="city" items="${cityList}" >
													    		<option value="${city.id }" <c:if test="${pd.city_id3 eq city.id }">selected</c:if>  >${city.name }</option>
													    	</c:forEach>
														</select>
				                                        <select style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" name="county_id3" id="county_id3" title="郡/县" disabled="disabled">
				                                        	<option value="">请选择</option>
													    	<c:forEach var="coundty" items="${coundtyList}" >
													    		<option value="${coundty.id }" <c:if test="${pd.county_id3 eq coundty.id }">selected</c:if>  >${coundty.name }</option>
													    	</c:forEach>
														</select>
                                        				<input style="width:20%;margin-top: 25px;margin-bottom: 10px" class="form-control" type="text" name="address_info3" id="address_info3" placeholder="这里输入地址" value="${pd.address_info3}"  />
                                    				</div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<c:if test="${operateType!='sel'}">
							<td>
								<a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
							</td>					
						</c:if>	
						<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditItem');">关闭</a>
						</td>
						</tr>
					</div>
				</div>
			</div>
		</div>   
 </div>
 </form>
 <!-- ztree区域显示模块 -->
 <div class="ibox float-e-margins" id="areaContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
	<div class="ibox-content">
		<div>
			<ul id="area_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
		</div>
	</div>
 </div>
 <!-- ztree公司显示模块 -->
 <div class="ibox float-e-margins" id="branchContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
	<div class="ibox-content">
		<div>
			<ul id="branch_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
		</div>
	</div>
 </div>
 <!-- ztree安装管辖分子公司显示模块 -->
 <div class="ibox float-e-margins" id="subContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
	<div class="ibox-content">
		<div>
			<ul id="sub_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
		</div>
	</div>
 </div>
 <%--zTree--%>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
	//--------------------------------------------------------
	function setTh(obj){
		var rowIndex = parseInt($(obj).parent().parent().parent().index());
		if(rowIndex==0){
			rowIndex = 1;
		}
		var num = $("#elevatorTable").find("tr").eq(rowIndex).find("td").eq(2).find("input").eq(0).val();
		var th = $("#elevatorTable").find("tr").eq(rowIndex).find("td").eq(2).find("input").eq(1).val();
		$("#SetElevNo").kendoWindow({
	        width: "500px",
	        height: "250px",
	        title: "录入梯号",
	        actions: ["Close"],
	        content: "<%=basePath%>item/setTh.do?rowIndex="+rowIndex+"&num="+num+"&th="+th,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").center().open();
	}

	function provinceChange(id){
		var province_id = $("#province_id"+id+" option:selected").val();
		if(province_id!=null && province_id!=""){
    		$.post("city/findAllCityByProvinceId.do",{province_id:province_id},function(result){
    			$("#city_id"+id).empty();
    			$("#county_id"+id).empty();
    			if(result.length>0){
    				$("#city_id"+id).attr("disabled",false);
    				$("#city_id"+id).append("<option value=''>请选择</option>");
    				$.each(result,function(key,value){						
    					$("#city_id"+id).append("<option value='"+value.id+"'  >"+value.name+"</option>");
    				});
    				$("#county_id"+id).attr("disabled",true);
    			}else{
    				$("#city_id"+id).attr("disabled",true);
    			}
    			
    		});
		}else{
			$("#city_id"+id).empty();
			$("#city_id"+id).attr("disabled",true);
			$("#county_id"+id).empty();
			$("#county_id"+id).attr("disabled",true);
		}
	}

	function cityChange(id){
		var city_id = $("#city_id"+id+" option:selected").val();
		if(city_id !=null && city_id !=""){
    		$.post("city/findAllCountyByCityId.do",{city_id:city_id},function(result){
    			$("#county_id"+id).empty();
    			if(result.length>0){
    				$("#county_id"+id).attr("disabled",false);
    				$("#county_id"+id).append("<option value=''>请选择</option>");
    				$.each(result,function(key,value){
    					$("#county_id"+id).append("<option value='"+value.id+"'>"+value.name+"</option>");
    				});
    			}else{
    				$("#county_id"+id).attr("disabled",true);
    			}
    		});
		}else{
			$("#county_id"+id).empty();
			$("#county_id"+id).attr("disabled",true);
		}
	}


	//归属区域显示
	var area_setting = {
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClickArea,
			onClick: onClickArea
		}
	};
	


	var AreazNodes =${areas};
	var log, className = "dark";
	
	
	
	function beforeClickArea(treeId, treeNode) {
		var url = "<%=basePath%>item/checkAreaNode.do?id="+treeNode.id;
		$.post(
			url,
			function(data){
				if(data.msg=='success'){
					$("#item_area").val(treeNode.id);
					$("#item_area_text").val(treeNode.name);
					$("#areaContent").hide();
					settingBranch(treeNode.id);
					return true;
				}
			}
		);
	}

	function onClickArea(e, treeId, treeNode) {
		
	}
	
	function showAreaMenu() {
		var areaObj = $("#item_area");
		var areaOffset = $("#item_area_text").offset();
		$("#areaContent").css({left:(areaOffset.left+6) + "px", top:areaOffset.top + areaObj.outerHeight() + "px"}).slideDown("fast");
		/*$("body").bind("mousedown", onBodyDown);*/
	}

	function settingBranch(areaId){
		//归属分公司显示
		var branch_setting = {
				view: {
					dblClickExpand: false
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					beforeClick: beforeClickBranch,
					onClick: onClickBranch
				}
			};
		$.post("<%=basePath%>item/getBranchCompany?parentId="+areaId,
				function(data){
					var BranchzNodes =eval('('+data.branchs+')');
					var log, className = "dark";

					$.fn.zTree.init($("#branch_zTree"), branch_setting, BranchzNodes);
					var BranchzTree = $.fn.zTree.getZTreeObj("branch_zTree");
					BranchzTree.expandAll(true);
				}
			);
	}

	function settingSubBranch(id){
		//安装管辖分子公司显示
		var sub_setting = {
				view: {
					dblClickExpand: false
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					beforeClick: beforeClickSub,
					onClick: onClickSub
				}
			};
		$.post("<%=basePath%>item/getItemSubBranch?id="+id,
				function(data){
					var SubzNodes =eval('('+data.subs+')');
					var log, className = "dark";

					$.fn.zTree.init($("#sub_zTree"), sub_setting, SubzNodes);
					var SubzTree = $.fn.zTree.getZTreeObj("sub_zTree");
					SubzTree.expandAll(true);
				}
			);
	}

	function beforeClickBranch(treeId, treeNode) {
		var url = "<%=basePath%>item/checkSubCompanyNode.do?id="+treeNode.id;
		$.post(
			url,
			function(data){
				if(data.msg=='success'){
					$("#item_sub_branch").val(treeNode.id);
					$("#item_sub_branch_text").val(treeNode.name);
					$("#branchContent").hide();
					return true;
				}
			}
		);
	}
	function beforeClickSub(treeId, treeNode) {
		var url = "<%=basePath%>item/checkSubCompanyNode.do?id="+treeNode.id;
		$.post(
			url,
			function(data){
				if(data.msg=='success'){
					$("#item_install_sub_branch").val(treeNode.id);
					$("#item_install_sub_branch_text").val(treeNode.name);
					$("#subContent").hide();
					return true;
				}
			}
		);
	}

	function onClickBranch(e, treeId, treeNode) {}
	function onClickSub(e, treeId, treeNode) {}

	function showBranchMenu() {
		var branchObj = $("#item_sub_branch");
		var branchOffset = $("#item_sub_branch_text").offset();
		$("#branchContent").css({left:(branchOffset.left+6) + "px", top:branchOffset.top + branchObj.outerHeight() + "px"}).slideDown("fast");
		/*$("body").bind("mousedown", onBodyDown);*/
	}
	function showSubMenu() {
		var subObj = $("#item_install_sub_branch");
		var subOffset = $("#item_install_sub_branch_text").offset();
		$("#subContent").css({left:(subOffset.left+6) + "px", top:subOffset.top + subObj.outerHeight() + "px"}).slideDown("fast");
		/*$("body").bind("mousedown", onBodyDown);*/
	}

	function hideMenu(event){
		event  =  event  ||  window.event; // 事件 
        var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
        var  obj  =  target.getAttribute('id');
        if(obj!='item_area_text'){
			$("#areaContent").hide();
        }
        if(obj!='item_sub_branch_text'){
			$("#branchContent").hide();
        }
        if(obj!='item_install_sub_branch_text'){
			$("#subContent").hide();
        }
	}
</script>
</body>

</html>
