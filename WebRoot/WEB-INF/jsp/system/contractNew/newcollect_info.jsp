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
<!-- Check Box -->
<link href="static/js/iCheck/custom.css" rel="stylesheet">


<title>信息查看</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>

<!-- iCheck -->
<script src="static/js/iCheck/icheck.min.js"></script>
<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		//loading end
		parent.layer.closeAll('loading');
		/* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });

        setElevator();

	});
	

	//修改合同变更类型
	function setType(){
		setElevator();
	}

	//设置电梯
	function setElevator(){
		var c_id = $("#c_id").val();
		$("#type_1").show();
		$.post("<%=basePath%>contractModify/setElevator.do?c_id="+c_id,
			function(data){
				var jsonStr = "<option value=''>请选择电梯</option>"; 
				for(var i=0;i<data.list.length;i++){
					jsonStr += "<option value='"+data.list[i].id+"'>"+data.list[i].no+"</option>";
				}
				//$("#elevator").append(jsonStr);
				$("select[name='elevator']").append(jsonStr);
			}
		);
	}

	//加载电梯详细信息
	function loadElevatorInfo(obj){
		var elevator_id = $(obj).val();
		$.post("<%=basePath%>contractModify/loadElevatorInfo.do?elevator_id="
				+ elevator_id, function(data) {
			$(obj).parent().parent().find("td").eq(2).text(data.data.total);
		});
	}
	

	//保存
	function save() {
		/*var str;
		$("input[name='type']:checked").each(function(){
			alert($(this).val());
			str+=$(this).val()+",";
		});
		str = str.substring(0,str.length-1);
		$("#type").val(str);*/
		setElevatorJson();
		$("#modifyForm").submit();
	}

	//处理电梯
	function setElevatorJson() {
		var elevatorId;
		var elevatorStatus;
		var elevatorTotal;
		var elevatorDescript;

		var jsonStr = "[";
		$("#tab tr:not(:first)").each(
				function() {
					elevatorId = $(this).find("td").eq(0).find("select").eq(0)
							.val();
					elevatorStatus = $(this).find("td").eq(1).html();
					elevatorTotal = $(this).find("td").eq(2).html();
					elevatorDescript = $(this).find("td").eq(3).find("input")
							.eq(0).val();
					jsonStr += "{\'elevator_id\':\'" + elevatorId
							+ "\',\'elevator_status\':\'" + elevatorStatus
							+ "\',\'elevator_total\':\'" + elevatorTotal
							+ "\',\'elevator_descript\':\'" + elevatorDescript
							+ "\'},";
				});
		jsonStr = jsonStr.substring(0, jsonStr.length - 1) + "]";

		console.log(jsonStr);

		$("#elevatorJson").val(jsonStr);

	}

	//添加行
	function addRow() {
		var tr = $("#tab").find("tr").eq(1).clone();
		$(tr)
				.find("td:last")
				.html("")
				.append(
						"<td><input type='button' value='删除' onclick='delRow(this)'></td>");
		$("#tab").append(tr);
	}

	//删除行
	function delRow(obj) {
		$(obj).parent().parent().parent().remove();
	}

	//上传下载部分
	function upload(e, v) {
		var filePath = $(e).val();
		var arr = filePath.split("\\");
		var fileName = arr[arr.length - 1];
		var suffix = filePath.substring(filePath.lastIndexOf("."))
				.toLowerCase();
		/*var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|"; */
		if (filePath == null || filePath == "") {
			$(v).val("");
			return false;
			/*if(fileType.indexOf(suffix+"|")==-1){
			}
			    var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
			    $(e).val("");
			    alert(ErrMsg);
			    return false;
			}*/

			//var data = new FormData($("#agentForm")[0]);
			var data = new FormData();

			data.append("file", $(e)[0].files[0]);

			$.ajax({
				url : "contractModify/upload.do",
				type : "POST",
				data : data,
				cache : false,
				processData : false,
				contentType : false,
				success : function(result) {
					if (result.success) {
						$(v).val(result.filePath);
					} else {
						alert(result.errorMsg);
					}
				}
			});
		}
	}
	// 下载文件   e代表当前路径值 
	function downFile(e) {
		var downFile = $(e).val();
		window.location.href = "customer/down?downFile=" + downFile;
	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
</script>
</head>

<body class="gray-bg">
	<form action="contractNew/.do" name="infoForm" id="infoForm"
		method="post">
		<%-- 
<input type="hidden" name="id" id="id" value="${pd.id}"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
<input type="hidden" name="elevatorJson" id="elevatorJson">
<input type="hidden" name="type" id="type">
--%>
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">

						<div class="row">
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">项目信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">项目号:</label> <input
												style="width: 30%" type="text" name="project_number"
												readonly="readonly" id="project_number"
												value="${info.project_number}" title="项目号"
												class="form-control" /> <label
												style="width: 15%; margin-left: 10px;">客户名称:</label> <input
												style="width: 30%" type="text" name="customer_name"
												readonly="readonly" id="customer_name"
												value="${info.customer_name}" title="客户名称"
												class="form-control" />
										</div>

										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">项目名称:</label> <input
												style="width: 30%" type="text" name="project_name"
												readonly="readonly" id="project_name"
												value="${info.project_name}" title="项目名称"
												class="form-control" /> <label
												style="width: 15%; margin-left: 10px;">最终用户:</label> <input
												style="width: 30%" type="text" name="Final_user"
												readonly="readonly" id="Final_user"
												value="${info.Final_user}" title="最终用户"
												class="form-control" />
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">安装地址:</label> <input
												style="width: 30%" type="text" name="nstallation_address"
												readonly="readonly" id="nstallation_address"
												value="${info.nstallation_address}" title="安装地址"
												class="form-control" /> 
										</div>
										
										
										
									</div>
								</div>
							</div>
						</div>


						<div class="row" >
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">收款信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<table id="tab"
												class="table table-striped table-bordered table-hover">
												<tr>
													<th style="width:5%;">期数</th>
													<th style="width:15%;">款项</th>
													<th style="width:15%;">判断日期</th>
													<th style="width:15%;">偏差日期</th>
													<th style="width:15%;">付款比例</th>
													<th style="width:15%;">金额</th>
													<th style="width:20%;">备注</th>
												</tr>
												<tbody>
										          <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty table}">
										<tr>
												<c:forEach items="${table}" var="var">
														<td>${var}</td>
												</c:forEach>
										</tr>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose> 
									
									</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>


						<div class="row">
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">开票信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">发票类型:</label> <input
												style="width: 20%" type="text" name="invoice_type"
												readonly="readonly" id="invoice_type"
												value="${info.invoice_type}" title="发票类型"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">开票金额:</label> <input
												style="width: 20%" type="text" name="invoice_value"
												readonly="readonly" id="invoice_value"
												value="${info.invoice_value}" title="开票金额"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">出票方式:</label> <input
												style="width: 20%" type="text" name="ticket_opening"
												readonly="readonly" id="ticket_opening"
												value="${info.ticket_opening}" title="出票方式"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">税目:</label> <input
												style="width: 20%" type="text" name="tax_item"
												readonly="readonly" id="tax_item"
												value="${info.tax_item}" title="税目"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">开票人:</label> <input
												style="width: 20%" type="text" name="ticket_holder"
												readonly="readonly" id="ticket_holder"
												value="${info.ticket_holder}" title="开票人"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">出票时间:</label> <input
												style="width: 20%" type="text" name="tax_day"
												readonly="readonly" id="tax_day"
												value="${info.tax_day}" title="出票时间"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">发票号:</label> <input
												style="width: 20%" type="text" name="invoice_number"
												readonly="readonly" id="invoice_number"
												value="${info.invoice_number}" title="发票号"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">来款金额:</label> <input
												style="width: 20%" type="text" name="amount_money"
												readonly="readonly" id="amount_money"
												value="${info.amount_money}" title="来款金额"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">来款时间:</label> <input
												style="width: 20%" type="text" name="time_money"
												readonly="readonly" id="time_money"
												value="${info.time_money}" title="来款时间"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">业务员:</label> <input
												style="width: 20%" type="text" name="salesman"
												readonly="readonly" id="salesman"
												value="${info.salesman}" title="业务员"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">保证金:</label> <input
												style="width: 20%" type="text" name="bond"
												readonly="readonly" id="bond"
												value="${info.bond}" title="保证金"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">备注:</label> <input
												style="width: 20%" type="text" name="remarks"
												readonly="readonly" id="remarks"
												value="${info.remarks}" title="备注"
												class="form-control" />
												
										</div>
									</div>
								</div>
							</div>
						</div>

<%-- 
						<tr>
							<td><a class="btn btn-primary"
								style="width: 150px; height: 34px; float: left;"
								onclick="save();">保存</a></td>
							<td><a class="btn btn-danger"
								style="width: 150px; height: 34px; float: right;"
								onclick="javascript:CloseSUWin('EditModify');">关闭</a></td>
						</tr>
--%>						
					</div>
				</div>

			</div>
		</div>
	</form>
</body>

</html>
