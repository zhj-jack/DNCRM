<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- 图片插件 -->
        <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
        <!-- Check Box -->
        <link href="static/js/iCheck/custom.css" rel="stylesheet">
        <!-- Sweet Alert -->
        <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
        <title>${pd.SYSNAME}</title>
    </head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div id="handleLeave" class="animated fadeIn"></div>
    <div class="row">
        <div id="top" name="top">
            <div class="col-sm-6">

                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>待办任务</h5>
                    </div>
                    <div class="ibox-content1">

                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>项目名称</th>
                                <th>发布时间</th>
                                <th>发布人</th>
                                <th>当前节点</th>
                                <th>任务类别</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                               <!-- 开始循环 -->
								<c:choose>
								  <c:when test="${not empty Tasks}">
									  <c:forEach items="${Tasks}" var="e" varStatus="vs">
										<tr>		
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td>${e.item_name}</td>
											<td>${e.offer_data}</td>
											<td>${e.offer_user}</td>
											<td>${e.task_name}</td>
											<td>
											    ${e.TASK_TYPE=="1"?"报价折扣审核":""}
											    ${e.TASK_TYPE=="2"?"分包商审核":""}
											    ${e.TASK_TYPE=="3"?"代理商审核":""}
											</td>
											<td style="text-align:center;">
												<!-- 1.报价-->
												<c:if test="${e.TASK_TYPE == 1 }">
													<button class="btn  btn-info btn-sm" title="办理" type="button" onclick="offerAudit();">办理</button>
												</c:if>
												<!-- 2.代理商 -->
												<c:if test="${e.TASK_TYPE == 2 }">
													<button class="btn  btn-info btn-sm" title="办理" type="button" onclick="viewHistory('${e.instance_id}');">审核记录</button>
												</c:if>
												<!-- 5.分包商 -->
												<c:if test="${e.TASK_TYPE == 3 }">
													<button class="btn  btn-info btn-sm" title="办理" type="button" onclick="viewHistory('${e.instance_id}');">审核记录</button>
												</c:if>
												
										  </td>
									  </tr>
									</c:forEach>
							    </c:when>
							<c:otherwise>
								<tr class="main_info">
									<td colspan="100" class="center">没有相关数据</td>
								</tr>
							</c:otherwise>
						</c:choose>
                        </tbody>

                        </table>
                            <tr>
                                <!-- <a style="float:right">更多>></a> -->
                            </tr>

                    </div>
                </div>
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>图表1</h5>

                    </div>
                    <div class="ibox-content1">
                        <div id="morris-bar-chart"></div>
                    </div>
                </div>
            </div>
        <div class="col-sm-6">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>图表2</h5>
                </div>
                <div class="ibox-content1">
                    <div id="morris-one-line-chart"></div>
                </div>
            </div>

            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>图表3</h5>
                </div>
                <div class="ibox-content1">
                    <div id="morris-donut-chart"></div>
                </div>
            </div>
        </div>
        </div>
    </div>
</div>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>
<!-- iCheck -->
<script src="static/js/iCheck/icheck.min.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<%--morris--%>
<script src="static/js/morris/morris.js"></script>
<script src="static/js/morris/raphael-2.1.0.min.js"></script>
<script src="static/js/demo/morris-demo.js"></script>
<script type="text/javascript">
function offerAudit()
{
	 $("#handleLeave").kendoWindow({
		 width: "600px",
		 height: "400px",
		 title: "办理任务",
		 actions: ["Close"],
		 content: '<%=basePath%>e_offer/e_offerAudit.do',
		 modal : true,
		 visible : false,
		 resizable : true
	 }).data("kendoWindow").maximize().open();
}




</script>
</body>
</html>


