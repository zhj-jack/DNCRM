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
 <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
<!-- Sweet Alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">

<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
</head>
<body class="gray-bg">
	<!-- 合同变更 -->
	<div id="ChangeIncontractHTML" class="animated fadeIn"></div>
	
	<form action="contractModify/${msg}.do" name="cmForm" id="cmForm" method="post">
		<input type="hidden" name="item_id" id="item_id" value="${pd.item_id}">
		<input type="hidden" name="contract_id" id="contract_id" value="${pd.ht_uuid}">
		<input type="hidden" name="dtInfoJson" id="dtInfoJson" value="${pd.dtInfoJson}">
		<input type="hidden" name="fkfsJson" id="fkfsJson" value="${pd.fkfsJson}">
		<div class="wrapper wrapper-content">
			<div class="row">
			
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
					<div class="ibox-content1">
							<!-- 头部  Start-->
							<div style="padding-bottom:40px;">
								<div class="form-inline" style="width:350px;font-size:16px;float:left;margin-top:8px;">
									变更协议号:${bgxy.BGXYH}
								</div>
								<div class="form-group form-inline" style="float:right;margin-right:20px;">
			                         <input type="button" class="btn btn-sm btn-primary" title="保存" value="保存" 
										onclick="save();">
									 <button class="btn btn-sm btn-success" title="提交"
										type="button" onclick="CNsubmit();">提交
									</button>
									<button class="btn btn-sm btn-danger" title="关闭"
										type="button" onclick="CNdel();">关闭
									</button>
									<button class="btn btn-sm" title="预览" 
										style="background:#999999;color:white;"
										type="button" onclick="CNpreview();">预览
									</button>
			             		</div>
		             		</div>
							<!-- 头部  End-->
							
							<!-- 主信息 Start -->
							<div class="panel panel-primary">
								<div class="panel-heading">变更协议信息</div>
								<div class="panel-body">
								<div class="row" style="margin-left: 10px">
								
								<!-- 10 22 - 10 22 -10 22 -->
								<!-- 第一层 -->
								<div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>项目名称:</label>
                                     	<input style="width:35%" type="text" value="${headInfo.item_name}"  
                                     	title="项目名称" class="form-control">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>客户名称:</label>
                                 		<input style="width:35%" type="text" readonly="readonly"
										value="${headInfo.customer_name}"
										title="客户名称" class="form-control" />
			                    </div>
			                    <!-- 第二层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>安装地址:</label>
                                     	<input style="width:35%" type="text" value="${headInfo.province_name}${headInfo.city_name}${headInfo.county_name}${headInfo.address_info}"  
                                     	placeholder="请输入安装地址" title="安装地址" class="form-control">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>最终用户:</label>
                                 		<input style="width:35%" type="text" readonly="readonly"
										 value="${headInfo.end_user}"
										 title="最终用户" class="form-control" />
			                    </div>
			                    <!-- 第三层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>合同签订日期:</label>
                                     	<input style="width:35%" type="text" 
                                     	value="${headInfo.ht_qdrq}"  
                                     	title="合同签订日期" class="form-control" onclick="laydate()">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>变更次第:</label>
                                 		<input style="width:35%" type="text" name="squence" 
										id="squence" value="${pd.squence}"
										placeholder="请输入变更次第" title="变更次第" class="form-control" />
			                    </div>
			                    <!-- 第四层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>变更原因:</label>
                                     	<input style="width:80%" type="text" name="reason" 
                                     	id="reason" value="${pd.reason}"  
                                     	placeholder="请输入变更原因" title="变更原因" class="form-control">
			                    </div>
			                    <!-- 第五层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>变更内容:</label>
                                     	<input style="width:80%" type="text" name="content" 
                                     	id="content" value="${pd.content}"  
                                     	placeholder="请输入变更内容" title="变更内容" class="form-control">
			                    </div>
			                   	<!-- 第六层 -->
			                   	<div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>特殊性概述:</label>
                                     	<input style="width:22%" type="text" name="special_desc" 
                                     	id="special_desc" value="${pd.special_desc}"  
                                     	placeholder="请输入特殊性概述" title="特殊性概述" class="form-control">
			                    </div>
								<!-- 第七层 -->
			                    <div class="form-group form-inline"> 
			                    	<label style="width:10%;">
                              			<span><font color="red">*</font></span>交货期(天):</label>
                                     	<input style="width:35%" type="text" name="date_deil" 
                                     	id="date_deil" value="${pd.date_deli}"  
                                     	placeholder="请输入交货期" title="交货期" class="form-control">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>其他约定:</label>
                                 		<input style="width:35%" type="text" name="other"
										id="other" value="${pd.other}"
										placeholder="请输入其他约定" title="其他约定" class="form-control" />
								</div>					
	
							<!-- row -->		   
							</div>
						<!-- panel-body -->
						</div>
					<!-- panel panel-primary -->
					</div>
					<!-- 主信息 End -->
						
					<!-- 电梯信息 Start -->	
					<div class="panel panel-primary">
						<!-- 头  -->
						<div class="panel-heading" style="padding-right:30px;">电梯信息</div>
						<div class="panel-body">
						<div class="row" style="margin-left: 10px">	
							<table class="table table-striped table-bordered table-hover" id="elevTable">
								<thead>
									<tr>
										<th>序号</th>
										<th>梯号</th>
										<th>产品名称</th>
										<th>层/站/门(提升高度)</th>
										<th>设备单价(元/台)</th>
										<th>变更金额</th>
										<th>安装单价(元/台)</th>
										<th>变更金额</th>
										<th>小计(元/台)</th>
										<th>变更后小计</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty dtInfoList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${dtInfoList}" var="dt" varStatus="vs">
													<tr>
														<td>${vs.index+1}</td>
														<td><input type="hidden">${dt.DT_TH}</td>
														<td>--</td>
														<td>${dt.DT_CZM}</td>
														<td>${dt.DT_SBDJ}</td>
														<td><input type="text" class="form-control" style="width: 50px" onkeyup="setChangeElevTotal();"></td>
														<td>${dt.DT_AZDJ}</td>
														<td><input type="text" class="form-control" style="width: 50px" onkeyup="setChangeElevTotal();"></td>
														<td>${dt.DT_XJ}</td>
														<td><input type="text" class="form-control" style="width: 50px"></td>
														<td>
															<button class="btn btn-sm btn-primary" title="增加"
																type="button" onclick="CNDTXX_add();">增加
															</button>
															<button class="btn btn-sm btn-danger" title="删除"
																	type="button" onclick="CNDTXX_del();">删除
															</button>
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<!-- 权限设置 -->
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
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
							<div class="form-inline" style="font-size:16px;float:left;padding-left:10px;">
								<input type="hidden" name="total" id="total" value="${pd.total}">
								原总金额:<span id="elevTotal"></span>&nbsp&nbsp&nbsp<font color="red">变更金额:<span id="changeElevTotal"></span></font>&nbsp&nbsp&nbsp变更后总额:<span id="afterElevTotal"></span>
							</div>
						<!-- 结尾 -->
						</div>
						</div>
						</div>
						<!-- 电梯信息 End -->
						
						<!-- 付款方式 Start -->	
						<div class="panel panel-primary">
						<!-- 头  -->
						<div class="panel-heading" style="padding-right:30px;">付款方式 </div>
						<div class="panel-body">
						<div class="form-group form-inline" style="float:right;margin-right:20px;margin-bottom:0px;">
	                         <button class="btn btn-sm btn-primary" title="添加"
								type="button" onclick="CNFKFSadd();">添加
							 </button>
	             		</div>
						<div class="row" style="margin-left: 10px">	
							<table class="table table-striped table-bordered table-hover" id="contractNewFKFSTab">
								<thead>
									<tr>
										<th>期次</th>
										<th>阶段</th>
										<th>偏差日期</th>
										<th>付款比例(%)</th>
										<th>金额(元)</th>
										<th>已开票金额</th>
										<th>已收款金额</th>
										<th>备注</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty fkfsList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${fkfsList}" var="f" varStatus="vs">
													<tr>
														<td>${vs.index+1}</td>
														<td>
															<input type="hidden" value="${f.FKFS_UUID}">
															<select class="form-control" name='FKFS_KX'>
										                        <option value="1" ${f.FKFS_KX=='1'?'selected':''}>订金</option>
										                        <option value="2" ${f.FKFS_KX=='2'?'selected':''}>排产款</option>
										                        <option value="3" ${f.FKFS_KX=='3'?'selected':''}>发货款</option>
										                        <option value="4" ${f.FKFS_KX=='4'?'selected':''}>货到现场款</option>
										                        <option value="5" ${f.FKFS_KX=='5'?'selected':''}>安装发货款</option>
										                        <option value="6" ${f.FKFS_KX=='6'?'selected':''}>安装开工款</option>
										                        <option value="7" ${f.FKFS_KX=='7'?'selected':''}>验收款</option>
										                    </select>
														</td>
														<td><input type="text" value="${f.FKFS_PCRQ}" class="form-control"></td>
														<td><input type="text" value="${f.FKFS_FKBL}" class="form-control"></td>
														<td>
														<input style="width:90%" type="text" class="form-control" value="${f.FKFS_JE}"/>%
														</td>
														<td>--</td>
														<td>--</td>
														<td><input type="text" class="form-control"></td>
														<td>
															<button class="btn btn-sm btn-danger" title="删除"
																	type="button" onclick="CNFKFSdel(this);">删除
															</button>
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<!-- 权限设置 -->
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<!-- <tr class="main_info">
												<td colspan="100" class="center">没有相关数据</td>
											</tr> -->
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						<!-- 结尾 -->
						</div>
						</div>
						</div>
						<!-- 付款方式  End -->
						
						<!-- 审批信息 Start -->	
						<div class="panel panel-primary">
						<!-- 头  -->
						<div class="panel-heading" style="padding-right:30px;">审批信息 </div>
						<div class="panel-body">
						<div class="row" style="margin-left: 10px">	
							<table class="table table-striped table-bordered table-hover" id="">
								<thead>
									<tr>
										<th style="width:20%;">审批环节</th>
										<th style="width:20%;">审批人</th>
										<th style="width:20%;">审批结果</th>
										<th style="width:20%;">审批意见</th>
										<th style="width:20%;">审批时间</th>
									</tr>
								</thead>
								<tbody>
								<!-- 开始循环 -->
								<c:choose>
									<c:when test="${not empty contractNewListSP}">
										<c:if test="${QX.cha == 1 }">
											<c:forEach items="${contractNewListSP}" var="con" varStatus="vs">
												<tr>
													<td>${con.SPHJ}</td>
													<td>${con.SPR}</td>
													<td>
													<select class="form-control" id="" name='FKFSKXPDRQ'>
									                        <option value='同意' ${con.SPJG=='同意'?'selected':''}>同意</option>
									                        <option value='拒绝' ${con.SPJG=='拒绝'?'selected':''}>拒绝</option>
									                </select>
													</td>
													<td>
													<input style="width:100%" type="text" name="SPSPYJ" id="" 
														value="${con.SPYJ}" class="form-control" />
													</td>
													<td>${con.SPSJ}</td>
												</tr>
											</c:forEach>
										</c:if>
										<!-- 权限设置 -->
										<c:if test="${QX.cha == 0 }">
											<tr>
												<td colspan="100" class="center">您无权查看</td>
											</tr>
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
							<div class="form-group form-inline" style="float:right;margin-right:20px;margin-bottom:0px;">
		                         <button class="btn btn-sm btn-success" title="提交"
									type="button" onclick="">提交
								 </button>
		             		</div>
						<!-- 结尾 -->
						</div>
						</div>
						</div>
						<!-- 审批信息  End -->
					</div>
				</div>
			</div>
	</form>

<script type="text/javascript">
     $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });

            //打开页面时计算电梯原总金额
            setElevTotal();
        });

    //计算电梯总金额
    function setElevTotal(){
    	var elev_total = 0;
    	$("#elevTable tr:not(:first)").each(function(){
			elev_total += isNaN(parseInt($(this).find("td").eq(8).text()))?0:parseInt($(this).find("td").eq(8).text());
		});
    	$("#elevTotal").text(elev_total);
    }
    //计算变更金额
    function setChangeElevTotal(){
    	var change_elev_total = 0;//变更金额
    	var after_elev_total = 0;//变更后总金额
    	$("#elevTable tr:not(:first)").each(function(){

    		var sbdj_ = $(this).find("td").eq(4).text();
    		var sbdj_change = $(this).find("td").eq(5).find("input").eq(0).val();

    		var azdj_ = $(this).find("td").eq(6).text();
    		var azdj_change = $(this).find("td").eq(7).find("input").eq(0).val();

    		sbdj_change = isNaN(sbdj_change)?0:sbdj_change;
    		azdj_change = isNaN(azdj_change)?0:azdj_change;

    		if((sbdj_change!=""&&!isNaN(sbdj_change))&&(azdj_change!=""&&!isNaN(azdj_change))){
	    		//变更后小计
	    		var afterTotal = parseInt(sbdj_change)+parseInt(azdj_change);
	    		$(this).find("td").eq(9).find("input").eq(0).val(afterTotal);
	    		//累加每行的变更金额差价
	    		var changeTotal = (parseInt(sbdj_change)-parseInt(sbdj_))+(parseInt(azdj_change)-parseInt(azdj_));

	    		change_elev_total += changeTotal;
	    		after_elev_total += afterTotal;
    		}
		});
    	$("#changeElevTotal").text(change_elev_total);
    	$("#afterElevTotal").text(after_elev_total);
    	$("#total").val(after_elev_total);
    	setFkbl();
    }

    //计算已付款比例
    function setFkbl(){
    	var afterElevTotal = $("#afterElevTotal").text();
    	if(afterElevTotal!=""&&!isNaN(afterElevTotal)){
    		//循环获取当前已付款金额
    		$("#contractNewFKFSTab tr:not(:first)").each(function(){
    			var je_ = $(this).find("td").eq(4).find("input").eq(0).val();
    			var pp_ = Math.ceil((parseInt(je_)/parseInt(afterElevTotal))*100);
    			$(this).find("td").eq(3).find("input").eq(0).val(pp_);
    		});
    	}
    }

    //修改付款比例时计算金额
    function setFkfsJe(obj){
    	var afterElevTotal = parseInt($("#afterElevTotal").text());
    	var pp_ = parseInt($(obj).val());
    	var je_ = (parseInt(pp_)/100)*afterElevTotal;
    	$(obj).parent().parent().find("td").eq(4).find("input").eq(0).val(je_);
    }


	  //---------------------------xcx-------------------------Start
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

	    function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
			/* 	window.parent.location.reload(); */
		}
	    
	    //保存
	    function CNsubmit(){
	    	
	    }
	    
	    //关闭
	    function CNdel(){
	    	
	    }
	    
	    //预览
	    function CNpreview(){
	    	
	    }
	    
	    //电梯信息  增加
	    function CNDTXX_add(){
	    	
	    }
	    
	    //电梯信息  删除
	    function CNDTXX_del(){
	    	swal({
	             title: "您确定要删除此条付款方式的信息吗？",
	             text: "删除后将无法恢复，请谨慎操作！",
	             type: "warning",
	             showCancelButton: true,
	             confirmButtonColor: "#DD6B55",
	             confirmButtonText: "删除",
	             cancelButtonText: "取消",
	             closeOnConfirm: false,
	             closeOnCancel: false
	         },
	         function (isConfirm) {
	             if (isConfirm) {
	             	var url = "";
	 				$.get(url,function(data){
	 					if(data.msg=='success'){
	 						swal({   
	 				        	title: "删除成功！",
	 				        	text: "您已经成功删除了这条信息。",
	 				        	type: "success",  
	 				        	 }, 
	 				        	function(){   
	 				        		delTab(obj); 
	 				        	 });
	 					}else{
	 						swal("删除失败", "您的删除操作失败了！", "error");
	 					}
	 				});
	             } else {
	                 swal("已取消", "您取消了删除操作！", "error");
	             }
	         });
	    	
	    	function delTab(obj){
				$(obj).parent().parent().remove();
				//重新标记序号
				var trNum = $("#contractNewDTXXTab tr").length;
				for(var i=1;i<=trNum;i++){
					$("#contractNewDTXXTab").find("tr").eq(i).find("td").eq(0).html(i);  
				}; 
			}
	    }
	    
	    //付款方式  增加
	    function CNFKFSadd(){
	    	var trNum = $("#contractNewFKFSTab tr").length;
			//克隆第一行
			var tr='<tr>'+
			'<td>'+trNum+'</td>'+
			'<td>'+
			'   <input type="hidden">'+
			'	<select class="form-control" name='+"'"+'FKFSKX'+"'"+'>'+
            '        <option value='+"'"+'1'+"'"+'>订金</option>'+
            '        <option value='+"'"+'2'+"'"+'>排产款</option>'+
            '        <option value='+"'"+'3'+"'"+'>发货款</option>'+
            '        <option value='+"'"+'4'+"'"+'>货到现场款</option>'+
            '        <option value='+"'"+'5'+"'"+'>安装发货款</option>'+
            '        <option value='+"'"+'6'+"'"+'>安装开工款</option>'+
            '        <option value='+"'"+'7'+"'"+'>验收款</option>'+
            '    </select>'+
			'</td>'+
			'<td>'+
			'   <input type="text" class="form-control">'+
	        '</td>'+
			'<td>'+
			'   <input type="text" class="form-control" onkeyup="setFkfsJe(this);">'+
	        '</td>'+
			'<td>'+
			'	<input style="width:90%" type="text" class="form-control" />%'+
			'</td>'+
			'<td>'+
			'--'+
			'</td>'+
			'<td>'+
			'--'+
			'</td>'+
			'<td>'+
			'   <input type="text" class="form-control">'+
			'</td>'+
			'<td>'+
			'	<button class="btn btn-sm btn-danger" title="删除"'+
			'			type="button" onclick="CNFKFSdel(this);">删除'+
			'	</button>'+
			'</td>'+
			'</tr>';
			$("#contractNewFKFSTab").append(tr);
	    }
	    
	  	//付款方式  删除
	    function CNFKFSdel(obj){
	    	var fxfsId_ = $(obj).parent().parent().find("td").eq(1).find("input").eq(0).val();
	    	swal({
	             title: "您确定要删除此条付款方式的信息吗？",
	             text: "删除后将无法恢复，请谨慎操作！",
	             type: "warning",
	             showCancelButton: true,
	             confirmButtonColor: "#DD6B55",
	             confirmButtonText: "删除",
	             cancelButtonText: "取消",
	             closeOnConfirm: false,
	             closeOnCancel: false
	         },
	         function (isConfirm) {
	             if (isConfirm) {
	             	//删除时,判断是否删除数据库
	             	if(fxfsId_==""){
	             		swal({   
 				        	title: "删除成功！",
 				        	text: "您已经成功删除了这条信息。",
 				        	type: "success",  
 				        	 }, 
 				        	function(){   
 				        		delTab(obj); 
 				        	 });
	             	}else{
		             	var url = "";
		 				$.get(url,function(data){
		 					if(data.msg=='success'){
		 						swal({   
		 				        	title: "删除成功！",
		 				        	text: "您已经成功删除了这条信息。",
		 				        	type: "success",  
		 				        	 }, 
		 				        	function(){   
		 				        		delTab(obj); 
		 				        	 });
		 					}else{
		 						swal("删除失败", "您的删除操作失败了！", "error");
		 					}
		 				});
	             	}
	             } else {
	                 swal("已取消", "您取消了删除操作！", "error");
	             }
	         });
	    	
	    	function delTab(obj){
				$(obj).parent().parent().remove();
				//重新标记序号
				var trNum = $("#contractNewFKFSTab tr").length;
				for(var i=1;i<=trNum;i++){
					$("#contractNewFKFSTab").find("tr").eq(i).find("td").eq(0).html(i);  
				}; 
			}
	  	}
	    
	    //---------------------------xcx-------------------------End
	    
	    //保存
	    function save(){

	    	var dtInfoJson = "[";
	    	//获取电梯信息
	    	$("#elevTable tr:not(:first)").each(function(){
	    		var dtInfoId = $(this).find("td").eq(1).find("input").eq(0).val();
	    		var dtSbdj = $(this).find("td").eq(5).find("input").eq(0).val();
	    		var dtAzdj = $(this).find("td").eq(7).find("input").eq(0).val();
	    		var dtTotal = $(this).find("td").eq(9).find("input").eq(0).val();
	    		dtInfoJson += "{'dtInfoId':'"+dtInfoId+"','dtSbdj':'"+dtSbdj+"','dtAzdj':'"+dtAzdj+"','dtTotal':'"+dtTotal+"'},";
	    	});
	    	dtInfoJson = dtInfoJson.substring(0,dtInfoJson.length-1)+"]";
	    	$("#dtInfoJson").val(dtInfoJson);

	    	var fkfsJson = "[";
	    	//获取付款方式信息
	    	$("#contractNewFKFSTab tr:not(:first)").each(function(){
	    		var period = $(this).find("td").eq(0).text();
	    		var so_fkfs = $(this).find("td").eq(1).find("input").eq(0).val();
	    		var stage = $(this).find("td").eq(1).find("input").eq(1).val();
	    		var date_devi = $(this).find("td").eq(2).find("input").eq(0).val();
	    		var pay_percent = $(this).find("td").eq(3).find("input").eq(0).val();
	    		var price = $(this).find("td").eq(4).find("input").eq(0).val();
	    		var remark = $(this).find("td").eq(7).find("input").eq(0).val();
	    		var type = so_fkfs==""?"0":"1";
	    		fkfsJson += "{'period':'"+period+"','so_fkfs':'"+so_fkfs+"','stage':'"+stage+"','date_devi':'"+date_devi+"','pay_percent':'"+pay_percent+"','price':'"+price+"','remark':'"+remark+"','type':'"+type+"'},";
	    	});
	    	fkfsJson = fkfsJson.substring(0,fkfsJson.length-1)+"]";
	    	$("#fkfsJson").val(fkfsJson);

	    	$("#cmForm").submit();
	    }
</script>	
</body>
</html>
