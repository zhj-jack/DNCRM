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
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
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

    </script>
</head>

<body class="gray-bg">
    <div id="cbjView" class="animated fadeIn"></div>
    <form action="e_offer/${msg}.do" name="dnrForm" id="dnrForm" method="post">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="DNR_ID" id="DNR_ID" value="${pd.DNR_ID}">
    <input type="hidden" name="FLAG" id="FLAG" value="${FLAG}">
    <input type="hidden" name="rowIndex" id="rowIndex" value="${pd.rowIndex}">
    <input type="hidden" name="UNSTD" id="UNSTD">
    <input type="hidden" name="MODELS_ID" id="MODELS_ID" value="${pd.MODELS_ID}">
    <input type="hidden" name="ITEM_ID" id="ITEM_ID" value="${pd.ITEM_ID}">
    <input type="hidden" name="ELEV_IDS" id="ELEV_IDS" value="${pd.ELEV_IDS}">
    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        报价信息
                                        <input type="button" value="调用参考报价" onclick="selCbj();" class="btn-sm btn-success">
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>梯种</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="tz_" name="tz_">
                                                <option value="DNR">DNR</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>倾斜角度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_QXJD" name="BZ_QXJD">
                                                <option value="">请选择</option>
                                                <option value="10" ${regelevStandardPd.QXJD=='10'?'selected':''}>10°</option>
                                                <option value="11" ${regelevStandardPd.QXJD=='11'?'selected':''}>11°</option>
                                                <option value="12" ${regelevStandardPd.QXJD=='12'?'selected':''}>12°</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">踏板宽度(mm):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_TBKD" name="BZ_TBKD" onchange="setSbj();">
                                                <option value="">请选择</option>
                                                <option value="800" ${regelevStandardPd.TBKD=='800'?'selected':''}>800</option>
                                                <option value="1000" ${regelevStandardPd.TBKD=='1000'?'selected':''}>1000</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <!-- <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>水平梯级数</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_SPTJ" name="BZ_SPTJ">
                                                <option value="">请选择</option>
                                                <option value="2" ${regelevStandardPd.SPTJ=='2'?'selected':''}>2</option>
                                                <option value="3" ${regelevStandardPd.SPTJ=='3'?'selected':''}>3</option>
                                            </select> -->

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>速度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_SD" name="BZ_SD">
                                                <option value="">--</option>
                                                <option value="0.5" ${regelevStandardPd.SD=='0.5'?'selected':''}>0.5</option>
                                            </select>
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">规格:</label>
                                            <select class="form-control m-b" style="width:7%" name="BZ_GG" id="BZ_GG" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:5%;margin-top: 25px;margin-bottom: 10px">提升高度:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="BZ_TSGD" name="BZ_TSGD" value="${pd.BZ_TSGD}"></label>
                                            <label style="width:5%;margin-top: 25px;margin-bottom: 10px">数量:</label>
                                            <label style="width:20%;margin-left:57px"><input type="text" class="form-control m-b" id="DNR_SL" name="DNR_SL" value="${pd.DNR_SL}" readonly="readonly"></label>
                                            <label style="width:9%;margin-top: 25px;margin-bottom: 10px;margin-left: 20px">折扣申请:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="DNR_ZK" name="DNR_ZK" value="${pd.DNR_ZK}" onkeyup="countZhj();"></label>%
                                            <!-- <select  class="form-control m-b" id="DNR_ZK" name="DNR_ZK" onchange="countZhj();">
                                                <option value="1">请选择折扣</option>
                                                <option value="0.9" ${pd.DNR_ZK=='0.9'?'selected':''}>90%</option>
                                                <option value="0.6" ${pd.DNR_ZK=='0.6'?'selected':''}>60%</option>
                                                <option value="0.5" ${pd.DNR_ZK=='0.5'?'selected':''}>50%</option>
                                            </select> -->
                                        </div>
                                        <div class="form-group form-inline">
                                            <table class="table table-striped table-bordered table-hover" id="tab" name="tab">
                                                <tr bgcolor="#CCCCCC">
                                                    <th>产品名称</th>
                                                    <th>数量</th>
                                                    <th>层/站/门</th>
                                                    <th>装潢价</th>
                                                    <th>设备价</th>
                                                    <th>折扣</th>
                                                    <th>折后设备价</th>
                                                    <th>安装费</th>
                                                    <th>运输费</th>
                                                    <th>实际报价</th>
                                                </tr>
                                                <tr>
                                                    <td>${modelsPd.models_name}</td>
                                                    <td>${pd.DNR_SL}</td>
                                                    <td>
                                                        --
                                                        /
                                                        --
                                                        /
                                                        --
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNR_ZHJ" id="DNR_ZHJ" value="${pd.DNR_ZHJ}"></td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNR_SBJ" id="DNR_SBJ" value="${regelevStandardPd.PRICE}">
                                                    <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}">
                                                    </td>
                                                    <td><font color="red"><span id="zk_">${DNR_ZK}</span></font></td>
                                                    <td><font color="red"><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNR_ZHSBJ" id="DNR_ZHSBJ" value="${pd.DNR_ZHSBJ}"></font></td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" name="DNR_AZF" id="DNR_AZF" value="${pd.DNR_AZF}"  style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' onkeyup="countZhj();" />
                                                        </font>
                                                    </td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNR_YSF" id="DNR_YSF" value="${pd.DNR_YSF}">
                                                        </font>
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNR_SJBJ" id="DNR_SJBJ" value="${pd.DNR_SJBJ}"></td>
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="form-group form-inline">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#tab-1" class="active">基本参数</a></li> 
                                                <li class=""><a data-toggle="tab" href="#tab-2">部件参数</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-3">标准功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-4">选配功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-5">环境配置</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <!-- 基本参数 -->
                                                        <table width="718" height="326" border="1" class="table table-striped table-bordered table-hover">
                                                          <tr>
                                                            <td colspan="2">1.水平跨距(DBE)</td>
                                                            <td>
                                                                <select name="BASE_SPKJ" id="BASE_SPKJ">
                                                                  <option value="">请选择</option>
                                                                  <option value="10800" ${pd.BASE_SPKJ=='10800'?'selected':''}>10800</option>
                                                                </select>mm 
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">2.电源-三相电压/照明电压/频率</td>
                                                            <td><input type="hidden" name="BASE_DY" id="BASE_DY" value="380±5%V/220±10%V/50±2%Hz">380±5%V/220±10%V/50±2%Hz</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">3.安装环境</td>
                                                            <td>
                                                                <select name="BASE_AZHJ" id="BASE_AZHJ">
                                                                  <option value="室内">室内</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="117" rowspan="2">4.扶手装置</td>
                                                            <td width="197">扶手类型</td>
                                                            <td>
                                                                <select name="BASE_FSLX" id="BASE_FSLX">
                                                                  <option value="">请选择</option>
                                                                  <option value="苗条型玻璃扶手" ${pd.BASE_FSLX=='苗条型玻璃扶手'?'selected':''}>苗条型玻璃扶手</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>扶手高度</td>
                                                            <td>
                                                                <select name="BASE_FSGD" id="BASE_FSGD">
                                                                  <option value="900">900</option>
                                                                </select>mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">5.中间支撑数量[水平跨距DBE&gt;15m时至少一个]</td>
                                                            <td>
                                                                <select name="BASE_ZJZCSL" id="BASE_ZJZCSL" onchange="editBase('BASE_ZJZCSL');">
                                                                  <option value="">请选择</option>
                                                                  <option value="0" ${pd.BASE_ZJZCSL=='0'?'selected':''}>0个</option>
                                                                  <option value="1" ${pd.BASE_ZJZCSL=='1'?'selected':''}>1个</option>
                                                                  <option value="2" ${pd.BASE_ZJZCSL=='2'?'selected':''}>2个</option>
                                                                  <option value="3" ${pd.BASE_ZJZCSL=='3'?'selected':''}>3个</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="BASE_ZJZCSL_TEMP" id="BASE_ZJZCSL_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">6.布置形式</td>
                                                            <td>
                                                                <select name="BASE_BZXS" id="BASE_BZXS">
                                                                  <option value="">请选择</option>
                                                                  <option value="单梯" ${pd.BASE_BZXS=='单梯'?'selected':''}>单梯</option>
                                                                  <option value="交叉" ${pd.BASE_BZXS=='交叉'?'selected':''}>交叉</option>
                                                                  <option value="连续" ${pd.BASE_BZXS=='连续'?'selected':''}>连续</option>
                                                                  <option value="平行" ${pd.BASE_BZXS=='平行'?'selected':''}>平行</option>
                                                                  <option value="根据土建图" ${pd.BASE_BZXS=='根据土建图'?'selected':''}>根据土建图</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">7.运输方式/交货形态(分段数)</td>
                                                            <td>
                                                                <select name="BASE_YSFS" id="BASE_YSFS">
                                                                  <option value="">请选择</option>
                                                                  <option value="卡车" ${pd.BASE_YSFS=='卡车'?'selected':''}>卡车</option>
                                                                  <option value="集装箱" ${pd.BASE_YSFS=='集装箱'?'selected':''}>集装箱</option>
                                                                </select>
                                                                /
                                                                <select name="BASE_JHXT" id="BASE_JHXT" onchange="editBase('BASE_JHXT');">
                                                                  <option value="整梯" ${pd.BASE_JHXT=='整梯'?'selected':''}>整梯</option>
                                                                  <option value="分2段" ${pd.BASE_JHXT=='分2段'?'selected':''}>分2段</option>
                                                                  <option value="分3段" ${pd.BASE_JHXT=='分3段'?'selected':''}>分3段</option>
                                                                  <option value="分4段" ${pd.BASE_JHXT=='分4段'?'selected':''}>分4段</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="BASE_JHXT_TEMP" id="BASE_JHXT_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">8.土建尺寸</td>
                                                            <td><p>上端加长(0~1000mm)</p>    </td>
                                                            <td>
                                                                <input type="text" name="BASE_SDJC" id="BASE_SDJC" value="${pd.BASE_SDJC}"/>mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 部件参数 -->
                                                        <table width="897" height="211" border="1" cellspacing="0" class="table table-striped table-bordered table-hover">
                                                          <tr>
                                                            <td width="355">1.减速机</td>
                                                            <td width="280">
                                                                <select name="PART_JSJ" id="PART_JSJ">
                                                                    <option value="">请选择</option>
                                                                    <option value="涡轮蜗杆" ${pd.PART_JSJ=='涡轮蜗杆'?'selected':''}>涡轮蜗杆</option>
                                                                </select>
                                                            </td>
                                                            <td width="130">&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2.踏板类型/梯级颜色</td>
                                                            <td>
                                                                <select name="PART_TJLX" id="PART_TJLX">
                                                                    <option value="">请选择</option>
                                                                    <option value="铝合金踏板" ${pd.PART_TJLX=='铝合金踏板'?'selected':''}>铝合金踏板</option>
                                                                </select>/
                                                                <select name="PART_TJYS" id="PART_TJYS">
                                                                    <option value="">请选择</option>
                                                                    <option value="银灰色" ${pd.PART_TJLX=='银灰色'?'selected':''}>银灰色</option>
                                                                    <option value="黑色" ${pd.PART_TJLX=='黑色'?'selected':''}>黑色</option>
                                                                </select>   
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5.扶手导轨材质</td>
                                                            <td>
                                                                <select name="PART_FSDGCZ" id="PART_FSDGCZ" onchange="editPart('PART_FSDGCZ');">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_FSDGCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_FSDGCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_FSDGCZ_TEMP" id="PART_FSDGCZ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>6.扶手带规格/颜色</td>
                                                            <td>
                                                                <select name="PART_FSDGG" id="PART_FSDGG"  onchange="editPart('PART_FSDGG');">
                                                                  <option value="">请选择</option>
                                                                  <option value="国内品牌" ${pd.PART_FSDGG=='国内品牌'?'selected':''}>国内品牌</option>
                                                                  <option value="外资品牌" ${pd.PART_FSDGG=='外资品牌'?'selected':''}>外资品牌</option>
                                                                  <option value="依合斯" ${pd.PART_FSDGG=='依合斯'?'selected':''}>依合斯</option>
                                                                </select>
                                                                / 
                                                                <select name="PART_FSDYS" id="PART_FSDYS">
                                                                  <option value="">请选择</option>
                                                                  <option value="黑色" ${pd.PART_FSDYS=='黑色'?'selected':''}>黑色</option>
                                                                </select> 
                                                            </td>
                                                            <td><input type="text" name="PART_FSDGG_TEMP" id="PART_FSDGG_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7.围裙版材质</td>
                                                            <td>
                                                                <select name="PART_WQBCZ" id="PART_WQBCZ" onchange="editPart('PART_WQBCZ');">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_WQBCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_WQBCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_WQBCZ_TEMP" id="PART_WQBCZ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>8.内外盖板材质</td>
                                                            <td>
                                                                <select name="PART_NWGBCZ" id="PART_NWGBCZ" onchange="editPart('PART_NWGBCZ');">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_NWGBCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_NWGBCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_NWGBCZ_TEMP" id="PART_NWGBCZ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>9.梳齿踏板及活动盖板</td>
                                                            <td>
                                                                <select name="PART_SCTBJHDGB" id="PART_SCTBJHDGB" onchange="editPart('PART_SCTBJHDGB');">
                                                                  <option value="">请选择</option>
                                                                  <option value="压纹不锈钢,方形花纹" ${pd.PART_SCTBJHDGB=='压纹不锈钢,方形花纹'?'selected':''}>压纹不锈钢,方形花纹</option>
                                                                  <option value="压纹不锈钢,矩形花纹" ${pd.PART_SCTBJHDGB=='压纹不锈钢,矩形花纹'?'selected':''}>压纹不锈钢,矩形花纹</option>
                                                                  <option value="蚀刻不锈钢,菱形花纹" ${pd.PART_SCTBJHDGB=='蚀刻不锈钢,菱形花纹'?'selected':''}>蚀刻不锈钢,菱形花纹</option>
                                                                  <option value="铝合金防滑条纹" ${pd.PART_SCTBJHDGB=='铝合金防滑条纹'?'selected':''}>铝合金防滑条纹</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_SCTBJHDGB_TEMP" id="PART_SCTBJHDGB_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>10.梳齿板</td>
                                                            <td>
                                                                <select name="PART_SCB" id="PART_SCB">
                                                                  <option value="">请选择</option>
                                                                  <option value="PVC黄色" ${pd.PART_SCB=='PVC黄色'?'selected':''}>PVC黄色</option>
                                                                  <option value="铝合金自然色" ${pd.PART_SCB=='铝合金自然色'?'selected':''}>铝合金自然色</option>
                                                                  <option value="铝合金黄色" ${pd.PART_SCB=='铝合金黄色'?'selected':''}>铝合金黄色</option>
                                                                </select>   
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11.启动方式</td>
                                                            <td>
                                                                <select name="PART_QDFS" id="PART_QDFS" onchange="editPart('PART_QDFS');">
                                                                    <option value="">请选择</option>
                                                                    <option value="Y-△,正常运行" ${pd.PART_QDFS=='Y-△,正常运行'?'selected':''}>Y-△,正常运行</option>
                                                                    <option value="Y-△,快、停节能运行" ${pd.PART_QDFS=='Y-△,快、停节能运行'?'selected':''}>Y-△,快、停节能运行</option>
                                                                    <option value="变频,快、慢节能运行" ${pd.PART_QDFS=='变频,快、慢节能运行'?'selected':''}>变频,快、慢节能运行</option>
                                                                    <option value="变频,快、慢、停节能运行" ${pd.PART_QDFS=='变频,快、慢、停节能运行'?'selected':''}>变频,快、慢、停节能运行</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_QDFS_TEMP" id="PART_QDFS_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11.变频功能功率(kw)</td>
                                                            <td>
                                                                <select name="PART_BPGNGL" id="PART_BPGNGL" onchange="editPart('PART_BPGNGL');">
                                                                    <option value="">请选择</option>
                                                                    <option value="5.5" ${pd.PART_BPGNGL=='5.5'?'selected':''}>5.5</option>
                                                                    <option value="7.5" ${pd.PART_BPGNGL=='7.5'?'selected':''}>7.5</option>
                                                                    <option value="11" ${pd.PART_BPGNGL=='11'?'selected':''}>11</option>
                                                                    <option value="15" ${pd.PART_BPGNGL=='15'?'selected':''}>15</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_BPGNGL_TEMP" id="PART_BPGNGL_TEMP"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 部件参数 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                        <table width="769" height="196" border="1" cellspacing="0" class="table table-striped table-bordered table-hover">
                                                          <tr>
                                                            <td>1.急停按钮</td>
                                                            <td>2.钥匙开关</td>
                                                            <td>3.扶手进出口保护开关</td>
                                                            <td>4.踏板链断链保护开关</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5.踏板下陷保护</td>
                                                            <td>6.缺相及错相保护</td>
                                                            <td>7.电机护罩保护</td>
                                                            <td>8.机房护板</td>
                                                          </tr>
                                                          <tr>
                                                            <td>9.电机过载保护</td>
                                                            <td>10.电机过热保护</td>
                                                            <td>11.梳齿保护开关</td>
                                                            <td>12.维修锁定装置</td>
                                                          </tr>
                                                          <tr>
                                                            <td>13.启动警铃</td>
                                                            <td>14.防逆转保护</td>
                                                            <td>15.扶手带防静电轮</td>
                                                            <td>16.工作制动器监控开关</td>
                                                          </tr>
                                                          <tr>
                                                            <td>17.踏板防静电刷</td>
                                                            <td>18.驱动链断链保护</td>
                                                            <td>19.手动检修插座</td>
                                                            <td>20.手动盘车装置</td>
                                                          </tr>
                                                          <tr>
                                                            <td>21.盖板检修开关</td>
                                                            <td>22.</td>
                                                            <td>23.扶手带速度监控</td>
                                                            <td>24.踏板遗失保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>25.踏板超速保护</td>
                                                            <td>26.制动距离超限报警</td>
                                                            <td>27.故障显示</td>
                                                            <td>28.踏板间隙照明</td>
                                                          </tr>
                                                          <tr>
                                                            <td>29.上下机房踏板</td>
                                                            <td>30.附加制动器</td>
                                                            <td>31.检修手柄</td>
                                                            <td>32.检修行灯</td>
                                                          </tr>
                                                        </table>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <!-- 选配功能 -->
                                                        <table width="729" border="1" cellspacing="0" class="table table-striped table-bordered table-hover">
                                                          <tr>
                                                            <td colspan="2">1.安全制动器[提升高度&gt;6m必选]</td>
                                                            <td width="335">
                                                                <input type="checkbox" name="OPT_AQZDQ_TEXT" id="OPT_AQZDQ_TEXT" onclick="editOpt('OPT_AQZDQ');"  ${pd.OPT_AQZDQ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_AQZDQ" id="OPT_AQZDQ">
                                                            </td>
                                                            <td width="36"><input type="text" name="OPT_AQZDQ_TEMP" id="OPT_AQZDQ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">2.5个干触点</td>
                                                            <td><input type="checkbox" name="OPT_GCD_TEXT" id="OPT_GCD_TEXT" onclick="editOpt('OPT_GCD');"  ${pd.OPT_GCD=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GCD" id="OPT_GCD">
                                                            </td>
                                                            <td><input type="text" name="OPT_GCD_TEMP" id="OPT_GCD_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">3.故障显示[在外盖板上]</td>
                                                            <td><input type="checkbox" name="OPT_GZXS_TEXT" id="OPT_GZXS_TEXT" onclick="editOpt('OPT_GZXS');"  ${pd.OPT_GZXS=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_GZXS" id="OPT_GZXS">
                                                            </td>
                                                            <td><input type="text" name="OPT_GZXS_TEMP" id="OPT_GZXS_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">4.交通流向灯[自启动时为必选]</td>
                                                            <td><input type="checkbox" name="OPT_JTLXD_TEXT" id="OPT_JTLXD_TEXT" onclick="editOpt('OPT_JTLXD');" ${pd.OPT_JTLXD=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_JTLXD" id="OPT_JTLXD">
                                                            </td>
                                                            <td><input type="text" name="OPT_JTLXD_TEMP" id="OPT_JTLXD_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">5.制动器磨损监控</td>
                                                            <td><input type="checkbox" name="OPT_ZDQMSJK_TEXT" id="OPT_ZDQMSJK_TEXT" onclick="editOpt('OPT_ZDQMSJK');" ${pd.OPT_ZDQMSJK=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_ZDQMSJK" id="OPT_ZDQMSJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDQMSJK_TEMP" id="OPT_ZDQMSJK_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">6.自动加油</td>
                                                            <td><input type="checkbox" name="OPT_ZDJY_TEXT" id="OPT_ZDJY_TEXT" onclick="editOpt('OPT_ZDJY');"  ${pd.OPT_ZDJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ZDJY" id="OPT_ZDJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDJY_TEMP" id="OPT_ZDJY_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">7.驱动链链罩</td>
                                                            <td><input type="checkbox" name="OPT_QDLLZ_TEXT" id="OPT_QDLLZ_TEXT" onclick="editOpt('OPT_QDLLZ');"  ${pd.OPT_QDLLZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_QDLLZ" id="OPT_QDLLZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_QDLLZ_TEMP" id="OPT_QDLLZ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">8.LED围裙照明</td>
                                                            <td><input type="checkbox" name="OPT_LEDWQZM_TEXT" id="OPT_LEDWQZM_TEXT" onclick="editOpt('OPT_LEDWQZM');"  ${pd.OPT_LEDWQZM=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_LEDWQZM" id="OPT_LEDWQZM">
                                                            </td>
                                                            <td><input type="text" name="OPT_LEDWQZM_TEMP" id="OPT_LEDWQZM_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">10.围裙安全装置</td>
                                                            <td><input type="checkbox" name="OPT_WQAQZZ_TEXT" id="OPT_WQAQZZ_TEXT" onclick="editOpt('OPT_WQAQZZ');"  ${pd.OPT_WQAQZZ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_WQAQZZ" id="OPT_WQAQZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_WQAQZZ_TEMP" id="OPT_WQAQZZ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">11.扶手带断带保护装置</td>
                                                            <td><input type="checkbox" name="OPT_FSDDDBHZZ_TEXT" id="OPT_FSDDDBHZZ_TEXT" onclick="editOpt('OPT_FSDDDBHZZ');"  ${pd.OPT_FSDDDBHZZ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FSDDDBHZZ" id="OPT_FSDDDBHZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FSDDDBHZZ_TEMP" id="OPT_FSDDDBHZZ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">12.中段围裙间隙开关</td>
                                                            <td><input type="checkbox" name="OPT_ZDWQJXKG_TEXT" id="OPT_ZDWQJXKG_TEXT" onclick="editOpt('OPT_ZDWQJXKG');"  ${pd.OPT_ZDWQJXKG=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_ZDWQJXKG" id="OPT_ZDWQJXKG">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDWQJXKG_TEMP" id="OPT_ZDWQJXKG_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">13.梳齿照明</td>
                                                            <td><input type="checkbox" name="OPT_SCZM_TEXT" id="OPT_SCZM_TEXT" onclick="editOpt('OPT_SCZM');"  ${pd.OPT_SCZM=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_SCZM" id="OPT_SCZM">
                                                            </td>
                                                            <td><input type="text" name="OPT_SCZM_TEMP" id="OPT_SCZM_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">15.电缆分段连接器[桁架分段时选用]</td>
                                                            <td><input type="checkbox" name="OPT_DLFDLJQ_TEXT" id="OPT_DLFDLJQ_TEXT" onclick="editOpt('OPT_DLFDLJQ');" ${pd.OPT_DLFDLJQ=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_DLFDLJQ" id="OPT_DLFDLJQ">
                                                            </td>
                                                            <td><input type="text" name="OPT_DLFDLJQ_TEMP" id="OPT_DLFDLJQ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="110" rowspan="3">19.外装饰</td>
                                                            <td width="218">外装饰位置[桁架分段时选用]</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_WZSWZ" onclick="editOpt('OPT_WZSWZ');"  ${pd.OPT_WZSWZ=='左侧'?'checked':''}/>左侧
                                                                <input type="checkbox" name="OPT_WZSWZ" onclick="editOpt('OPT_WZSWZ');"  ${pd.OPT_WZSWZ=='右侧'?'checked':''}/>右侧
                                                                <input type="checkbox" name="OPT_WZSWZ" onclick="editOpt('OPT_WZSWZ');"  ${pd.OPT_WZSWZ=='底侧'?'checked':''}/>底侧
                                                            </td>
                                                            <td><input type="text" name="OPT_WZSWZ_TEMP" id="OPT_WZSWZ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>装饰板材料</td>
                                                            <td>
                                                                <select name="OPT_ZSBCL" id="OPT_ZSBCL" onchange="editOpt('OPT_ZSBCL');">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板" ${pd.OPT_ZSBCL=='钢板'?'selected':''}>钢板</option>
                                                                    <option value="发纹不锈钢" ${pd.OPT_ZSBCL=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="发纹不锈钢SUS304" ${pd.OPT_ZSBCL=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ZSBCL_TEMP" id="OPT_ZSBCL_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>装饰板厚度</td>
                                                            <td>
                                                                <select name="OPT_ZSBHD" id="OPT_ZSBHD" onchange="editOpt('OPT_ZSBHD');">
                                                                    <option value="">请选择</option>
                                                                    <option value="0.8" ${pd.OPT_ZSBHD=='0.8'?'selected':''}>0.8</option>
                                                                    <option value="1.0" ${pd.OPT_ZSBHD=='1.0'?'selected':''}>1.0</option>
                                                                    <option value="1.2" ${pd.OPT_ZSBHD=='1.2'?'selected':''}>1.2</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ZSBHD_TEMP" id="OPT_ZSBHD_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">20.维修护栏</td>
                                                            <td>
                                                                <input type="text" name="OPT_WXHL" id="OPT_WXHL" onkeyup="editOpt('OPT_WXHL');" value="${pd.OPT_WXHL}">套
                                                            </td>
                                                            <td><input type="text" name="OPT_WXHL_TEMP" id="OPT_WXHL_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">23.吊装钢丝绳</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_DZGSS_TEXT" id="OPT_DZGSS_TEXT" onclick="editOpt('OPT_DZGSS');"  ${pd.OPT_DZGSS=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DZGSS" id="OPT_DZGSS">
                                                            </td>
                                                            <td><input type="text" name="OPT_DZGSS_TEMP" id="OPT_DZGSS_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.防爬装置</td>
                                                            <td><input type="checkbox" name="OPT_FPZZ_TEXT" id="OPT_FPZZ_TEXT" onclick="editOpt('OPT_FPZZ');"  ${pd.OPT_FPZZ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FPZZ" id="OPT_FPZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FPZZ_TEMP" id="OPT_FPZZ_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.防撞挡块</td>
                                                            <td><input type="checkbox" name="OPT_FZDK_TEXT" id="OPT_FZDK_TEXT" onclick="editOpt('OPT_FZDK');"  ${pd.OPT_FZDK=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FZDK" id="OPT_FZDK">
                                                            </td>
                                                            <td><input type="text" name="OPT_FZDK_TEMP" id="OPT_FZDK_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.中间急停</td>
                                                            <td><input type="checkbox" name="OPT_ZJJT_TEXT" id="OPT_ZJJT_TEXT" onclick="editOpt('OPT_ZJJT');"  ${pd.OPT_ZJJT=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_ZJJT" id="OPT_ZJJT">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZJJT_TEMP" id="OPT_ZJJT_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.额外急停</td>
                                                            <td><input type="checkbox" name="OPT_EWJT_TEXT" id="OPT_EWJT_TEXT" onclick="editOpt('OPT_EWJT');" ${pd.OPT_EWJT=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_EWJT" id="OPT_EWJT">
                                                            </td>
                                                            <td><input type="text" name="OPT_EWJT_TEMP" id="OPT_EWJT_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.桁架分段段数</td>
                                                            <td>
                                                            <input type="text" name="OPT_HJFDDS" id="OPT_HJFDDS" onkeyup="editOpt('OPT_HJFDDS');" value="${pd.OPT_HJFDDS}">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJFDDS_TEMP" id="OPT_HJFDDS_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.出口型人行道</td>
                                                            <td><input type="checkbox" name="OPT_CKXRXD_TEXT" id="OPT_CKXRXD_TEXT" onclick="editOpt('OPT_CKXRXD');"  ${pd.OPT_CKXRXD=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_CKXRXD" id="OPT_CKXRXD">
                                                            </td>
                                                            <td><input type="text" name="OPT_CKXRXD_TEMP" id="OPT_CKXRXD_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.双排毛刷</td>
                                                            <td><input type="checkbox" name="OPT_SPMS_TEXT" id="OPT_SPMS_TEXT" onclick="editOpt('OPT_SPMS');"  ${pd.OPT_SPMS=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_SPMS" id="OPT_SPMS">
                                                            </td>
                                                            <td><input type="text" name="OPT_SPMS_TEMP" id="OPT_SPMS_TEMP"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.运行方向指示灯</td>
                                                            <td>
                                                            <input type="text" name="OPT_YXFXZSD" id="OPT_YXFXZSD" onkeyup="editOpt('OPT_YXFXZSD');" value="${pd.OPT_YXFXZSD}">
                                                            </td>
                                                            <td><input type="text" name="OPT_YXFXZSD_TEMP" id="OPT_YXFXZSD_TEMP"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 选配功能 -->
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <!-- 环境配置 -->
                                                        <table width="931" height="431" border="1" cellspacing="0" class="table table-striped table-bordered table-hover">
                                                          <tr>
                                                            <td colspan="2">安装环境类型</td>
                                                            <td width="117">半室外配置A</td>
                                                            <td width="117">半室外配置B</td>
                                                            <td width="117">全室外配置C</td>
                                                            <td width="117">全室外配置D</td>
                                                            <td width="12">&nbsp;</td>
                                                            <td width="17">&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">自动加油</td>
                                                            <td><input type="checkbox" /></td>
                                                            <td><input name="checkbox" type="checkbox" /></td>
                                                            <td><input name="checkbox2" type="checkbox" /></td>
                                                            <td><input name="checkbox3" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">IP55电机</td>
                                                            <td><input name="checkbox7" type="checkbox" /></td>
                                                            <td><input name="checkbox6" type="checkbox" /></td>
                                                            <td><input name="checkbox5" type="checkbox" /></td>
                                                            <td><input name="checkbox4" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">IP54控制系统</td>
                                                            <td><input name="checkbox8" type="checkbox" /></td>
                                                            <td><input name="checkbox44" type="checkbox" /></td>
                                                            <td><input name="checkbox45" type="checkbox" /></td>
                                                            <td><input name="checkbox79" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">活动盖板铝基材</td>
                                                            <td><input name="checkbox9" type="checkbox" /></td>
                                                            <td><input name="checkbox43" type="checkbox" /></td>
                                                            <td><input name="checkbox46" type="checkbox" /></td>
                                                            <td><input name="checkbox78" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">室外型扶手带</td>
                                                            <td><input name="checkbox10" type="checkbox" /></td>
                                                            <td><input name="checkbox42" type="checkbox" /></td>
                                                            <td><input name="checkbox47" type="checkbox" /></td>
                                                            <td><input name="checkbox77" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">内外盖板不锈钢SUS304材质</td>
                                                            <td><input name="checkbox11" type="checkbox" /></td>
                                                            <td><input name="checkbox41" type="checkbox" /></td>
                                                            <td><input name="checkbox48" type="checkbox" /></td>
                                                            <td><input name="checkbox76" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">围裙不锈钢SUS304材质</td>
                                                            <td><input name="checkbox12" type="checkbox" /></td>
                                                            <td><input name="checkbox40" type="checkbox" /></td>
                                                            <td><input name="checkbox49" type="checkbox" /></td>
                                                            <td><input name="checkbox75" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">外装饰板不锈钢SUS304材质(若选择外装饰)</td>
                                                            <td><input name="checkbox13" type="checkbox" /></td>
                                                            <td><input name="checkbox39" type="checkbox" /></td>
                                                            <td><input name="checkbox50" type="checkbox" /></td>
                                                            <td><input name="checkbox74" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">扶手导轨不锈钢SUS304材质</td>
                                                            <td><input name="checkbox14" type="checkbox" /></td>
                                                            <td><input name="checkbox38" type="checkbox" /></td>
                                                            <td><input name="checkbox51" type="checkbox" /></td>
                                                            <td><input name="checkbox73" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="202" rowspan="2">金属骨架腐蚀保护</td>
                                                            <td width="198">金属骨架喷三遍油漆</td>
                                                            <td><input name="checkbox15" type="checkbox" /></td>
                                                            <td><input name="checkbox37" type="checkbox" /></td>
                                                            <td><input name="checkbox52" type="checkbox" /></td>
                                                            <td><input name="checkbox72" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="198">金属骨架热浸镀锌</td>
                                                            <td><input name="checkbox16" type="checkbox" /></td>
                                                            <td><input name="checkbox36" type="checkbox" /></td>
                                                            <td><input name="checkbox53" type="checkbox" /></td>
                                                            <td><input name="checkbox71" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">导轨系统和主传动轴特殊防锈处理</td>
                                                            <td><input name="checkbox17" type="checkbox" /></td>
                                                            <td><input name="checkbox35" type="checkbox" /></td>
                                                            <td><input name="checkbox54" type="checkbox" /></td>
                                                            <td><input name="checkbox70" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">主要部件螺栓螺母达克罗处理</td>
                                                            <td><input name="checkbox18" type="checkbox" /></td>
                                                            <td><input name="checkbox34" type="checkbox" /></td>
                                                            <td><input name="checkbox55" type="checkbox" /></td>
                                                            <td><input name="checkbox69" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2"><p>表面特殊处理梯级轴</p>
                                                            <p>驱动链和梯级链链板表面进行特殊防锈处理</p>
                                                            <p>主副轮双重密封</p></td>
                                                            <td><input name="checkbox19" type="checkbox" /></td>
                                                            <td><input name="checkbox32" type="checkbox" /></td>
                                                            <td><input name="checkbox33" type="checkbox" /></td>
                                                            <td><input name="checkbox68" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">油水分离器装置</td>
                                                            <td><input name="checkbox20" type="checkbox" /></td>
                                                            <td><input name="checkbox31" type="checkbox" /></td>
                                                            <td><input name="checkbox56" type="checkbox" /></td>
                                                            <td><input name="checkbox67" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">防洪保护</td>
                                                            <td><input name="checkbox21" type="checkbox" /></td>
                                                            <td><input name="checkbox30" type="checkbox" /></td>
                                                            <td><input name="checkbox57" type="checkbox" /></td>
                                                            <td><input name="checkbox66" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">梯级链防护罩</td>
                                                            <td><input name="checkbox22" type="checkbox" /></td>
                                                            <td><input name="checkbox29" type="checkbox" /></td>
                                                            <td><input name="checkbox58" type="checkbox" /></td>
                                                            <td><input name="checkbox65" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">桁架加热</td>
                                                            <td><input name="checkbox23" type="checkbox" /></td>
                                                            <td><input name="checkbox28" type="checkbox" /></td>
                                                            <td><input name="checkbox59" type="checkbox" /></td>
                                                            <td><input name="checkbox64" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">梳齿加热</td>
                                                            <td><input name="checkbox24" type="checkbox" /></td>
                                                            <td><input name="checkbox27" type="checkbox" /></td>
                                                            <td><input name="checkbox60" type="checkbox" /></td>
                                                            <td><input name="checkbox63" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">扶手加热</td>
                                                            <td><input name="checkbox25" type="checkbox" /></td>
                                                            <td><input name="checkbox26" type="checkbox" /></td>
                                                            <td><input name="checkbox61" type="checkbox" /></td>
                                                            <td><input name="checkbox62" type="checkbox" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                        </table>
                                                    <!-- 环境配置 -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        安装价格
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label>安装价格:</label>
                                            <input type="text" class="form-control" id="DNR_AZF_TEMP" name="DNR_AZF_TEMP" onkeyup="countZhj();" value="${pd.DNR_AZF}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        运输价格
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label>运输方式:</label>
                                            <select id="trans_type" class="form-control m-b" name="trans_type" onchange="hideDiv();">
                                                <option value="1">整车</option>
                                                <option value="2">零担</option>
                                            </select>
                                            <label>请选择区域:</label>
                                            <select id="province_id" name="province_id" class="form-control m-b" onchange="setCity();">
                                                <option>请选择区域</option>
                                                <c:forEach var="province" items="${provinceList}">
                                                    <option value="${province.id }">${province.name }</option>
                                                </c:forEach>
                                            </select>
                                            <label>请选择目的地:</label>
                                            <select id="destin_id" name="destin_id" class="form-control m-b">
                                                <option>请选择目的地</option>
                                            </select>
                                            <label>吨数:</label>
                                            <input type="text" id="less_num" name="less_num" class="form-control">
                                        </div>
                                        </div>
                                        <div class="form-group form-inline" id="zc">
                                            <table id="transTable">
                                                <tr>
                                                    <td>
                                                        <label>车型:</label>
                                                        <select class="form-control m-b">
                                                            <option value="">请选择车型</option>
                                                            <option value="5">5T车(6.2-7.2米)</option>
                                                            <option value="8">8T车(8.2-9.6米)</option>
                                                            <option value="10">10T车(12.5米)</option>
                                                            <option value="20">20T车(17.5米)</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <label>数量:</label>
                                                        <input type="text" class="form-control">
                                                    </td>
                                                    <td>
                                                        <input type="button" value="添加" onclick="addRow();">
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="form-group form-inline">
                                            <input type="button" value="确定" onclick="setPriceTrans();">
                                            运输价格:
                                            <input type="text" id="trans_price" name="trans_price" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>   
    </div>
    </form>

    <tr>
        <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('ElevatorParam');">关闭</a></td>
    </tr>

<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script src="static/js/iCheck/icheck.min.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        $("#tab-1").addClass("active");
        //加载标准价格,初始化关联选项
        editQxjd();
        $("#BZ_GG").val("${regelevStandardPd.GG}");
        var FLAG = $("#FLAG").val();
        if(FLAG=="CBJ"||FLAG=="ZHJ"){
            cbjPrice();
        }
        if("${pd.view}"=="edit"){
            cbjPrice();
        }
    });

    //添加行,录入运输
    function addRow(){
        var tr = $("#transTable tr").eq(0).clone();
        $(tr).find("td").eq(0).find("select").eq(0).val("");
        $(tr).find("td").eq(1).find("input").eq(0).val("");
        $(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delRow(this)'></td>");
        $("#transTable").append(tr);
    }
    //删除行
    function delRow(obj){
        $(obj).parent().parent().parent().remove();
    }

    function cbjPrice(){
        //基础项
        editBase('BASE_ZJZCSL');
        editBase('BASE_JHXT');
        //部件参数
        editPart('PART_FSDGG');
        editPart('PART_WQBCZ');
        editPart('PART_NWGBCZ');
        editPart('PART_SCTBJHDGB');
        editPart('PART_QDFS');
        editPart('PART_BPGNGL');
        //选配
        editOpt('OPT_AQZDQ');
        editOpt('OPT_JTLXD');
        editOpt('OPT_ZDJY');
        editOpt('OPT_ZDWQJXKG');
        editOpt('OPT_SCZM');
        editOpt('OPT_WXHL');
        editOpt('OPT_FPZZ');
        editOpt('OPT_HJFDDS');
        editOpt('OPT_CKXRXD');
        editOpt('OPT_SPMS');
        editOpt('OPT_YXFXZSD');
    }

    //计算基础价
    function setSbj(){
        var gg_ = $("#BZ_GG").val();  //规格
        var qxjd_ = $("#BZ_QXJD").val();     //倾斜角度
        var tbkd_ = $("#BZ_TBKD").val();  //踏板宽度
        var price = 0;
        if(qxjd_=="12"){
            if(tbkd_=="1000"){
                if(gg_=="3.0"){
                    price =  271500;
                }else if(gg_=="3.1"){
                    price =  274500;
                }else if(gg_=="3.2"){
                    price =  277500;
                }else if(gg_=="3.3"){
                    price =  280500;
                }else if(gg_=="3.4"){
                    price =  283600;
                }else if(gg_=="3.5"){
                    price =  286600;
                }else if(gg_=="3.6"){
                    price =  289600;
                }else if(gg_=="3.7"){
                    price =  292600;
                }else if(gg_=="3.8"){
                    price =  295700;
                }else if(gg_=="3.9"){
                    price =  298700;
                }else if(gg_=="4.0"){
                    price =  301700;
                }else if(gg_=="4.1"){
                    price =  304800;
                }else if(gg_=="4.2"){
                    price =  307800;
                }else if(gg_=="4.3"){
                    price =  310800;
                }else if(gg_=="4.4"){
                    price =  313800;
                }else if(gg_=="4.5"){
                    price =  316900;
                }else if(gg_=="4.6"){
                    price =  320100;
                }else if(gg_=="4.7"){
                    price =  323100;
                }else if(gg_=="4.8"){
                    price =  326100;
                }else if(gg_=="4.9"){
                    price =  329200;
                }else if(gg_=="5.0"){
                    price =  332200;
                }else if(gg_=="5.1"){
                    price =  335200;
                }else if(gg_=="5.2"){
                    price =  338300;
                }else if(gg_=="5.3"){
                    price =  341300;
                }else if(gg_=="5.4"){
                    price =  344300;
                }else if(gg_=="5.5"){
                    price =  347300;
                }else if(gg_=="5.6"){
                    price =  350400;
                }else if(gg_=="5.7"){
                    price =  355600;
                }else if(gg_=="5.8"){
                    price =  358600;
                }else if(gg_=="5.9"){
                    price =  361600;
                }else if(gg_=="6.0"){
                    price =  364600;
                }
            }else if(tbkd_=="800"){
                if(gg_=="3.0"){
                    price =  264800;
                }else if(gg_=="3.1"){
                    price =  267800;
                }else if(gg_=="3.2"){
                    price =  270800;
                }else if(gg_=="3.3"){
                    price =  273800;
                }else if(gg_=="3.4"){
                    price =  276900;
                }else if(gg_=="3.5"){
                    price =  279900;
                }else if(gg_=="3.6"){
                    price =  282900;
                }else if(gg_=="3.7"){
                    price =  285900;
                }else if(gg_=="3.8"){
                    price =  289000;
                }else if(gg_=="3.9"){
                    price =  292000;
                }else if(gg_=="4.0"){
                    price =  295000;
                }else if(gg_=="4.1"){
                    price =  298100;
                }else if(gg_=="4.2"){
                    price =  301100;
                }else if(gg_=="4.3"){
                    price =  304100;
                }else if(gg_=="4.4"){
                    price =  307100;
                }else if(gg_=="4.5"){
                    price =  310200;
                }else if(gg_=="4.6"){
                    price =  313200;
                }else if(gg_=="4.7"){
                    price =  316200;
                }else if(gg_=="4.8"){
                    price =  319300;
                }else if(gg_=="4.9"){
                    price =  322300;
                }else if(gg_=="5.0"){
                    price =  325300;
                }else if(gg_=="5.1"){
                    price =  328300;
                }else if(gg_=="5.2"){
                    price =  331400;
                }else if(gg_=="5.3"){
                    price =  334400;
                }else if(gg_=="5.4"){
                    price =  337400;
                }else if(gg_=="5.5"){
                    price =  340400;
                }else if(gg_=="5.6"){
                    price =  343700;
                }else if(gg_=="5.7"){
                    price =  346700;
                }else if(gg_=="5.8"){
                    price =  349700;
                }else if(gg_=="5.9"){
                    price =  352800;
                }else if(gg_=="6.0"){
                    price =  355800;
                }
            }
        }else if(qxjd_=="11"){
            if(tbkd_=="1000"){
                if(gg_=="3.0"){
                    price =  280400;
                }else if(gg_=="3.1"){
                    price =  283800;
                }else if(gg_=="3.2"){
                    price =  287100;
                }else if(gg_=="3.3"){
                    price =  290400;
                }else if(gg_=="3.4"){
                    price =  293700;
                }else if(gg_=="3.5"){
                    price =  297000;
                }else if(gg_=="3.6"){
                    price =  300300;
                }else if(gg_=="3.7"){
                    price =  303600;
                }else if(gg_=="3.8"){
                    price =  306900;
                }else if(gg_=="3.9"){
                    price =  310200;
                }else if(gg_=="4.0"){
                    price =  313600;
                }else if(gg_=="4.1"){
                    price =  316900;
                }else if(gg_=="4.2"){
                    price =  320200;
                }else if(gg_=="4.3"){
                    price =  323500;
                }else if(gg_=="4.4"){
                    price =  326800;
                }else if(gg_=="4.5"){
                    price =  330100;
                }else if(gg_=="4.6"){
                    price =  333600;
                }else if(gg_=="4.7"){
                    price =  336900;
                }else if(gg_=="4.8"){
                    price =  340200;
                }else if(gg_=="4.9"){
                    price =  343500;
                }else if(gg_=="5.0"){
                    price =  346900;
                }else if(gg_=="5.1"){
                    price =  350200;
                }else if(gg_=="5.2"){
                    price =  353500;
                }else if(gg_=="5.3"){
                    price =  356800;
                }else if(gg_=="5.4"){
                    price =  360100;
                }else if(gg_=="5.5"){
                    price =  363400;
                }else if(gg_=="5.6"){
                    price =  366700;
                }else if(gg_=="5.7"){
                    price =  372200;
                }else if(gg_=="5.8"){
                    price =  375500;
                }else if(gg_=="5.9"){
                    price =  378800;
                }else if(gg_=="6.0"){
                    price =  382100;
                }
            }else if(tbkd_=="800"){
                if(gg_=="3.0"){
                    price =  273700;
                }else if(gg_=="3.1"){
                    price =  277100;
                }else if(gg_=="3.2"){
                    price =  280400;
                }else if(gg_=="3.3"){
                    price =  283700;
                }else if(gg_=="3.4"){
                    price =  287000;
                }else if(gg_=="3.5"){
                    price =  290300;
                }else if(gg_=="3.6"){
                    price =  293600;
                }else if(gg_=="3.7"){
                    price =  296900;
                }else if(gg_=="3.8"){
                    price =  300200;
                }else if(gg_=="3.9"){
                    price =  303500;
                }else if(gg_=="4.0"){
                    price =  306900;
                }else if(gg_=="4.1"){
                    price =  310200;
                }else if(gg_=="4.2"){
                    price =  313500;
                }else if(gg_=="4.3"){
                    price =  316800;
                }else if(gg_=="4.4"){
                    price =  320100;
                }else if(gg_=="4.5"){
                    price =  323400;
                }else if(gg_=="4.6"){
                    price =  326700;
                }else if(gg_=="4.7"){
                    price =  330000;
                }else if(gg_=="4.8"){
                    price =  333300;
                }else if(gg_=="4.9"){
                    price =  336700;
                }else if(gg_=="5.0"){
                    price =  340000;
                }else if(gg_=="5.1"){
                    price =  343300;
                }else if(gg_=="5.2"){
                    price =  346600;
                }else if(gg_=="5.3"){
                    price =  349900;
                }else if(gg_=="5.4"){
                    price =  353200;
                }else if(gg_=="5.5"){
                    price =  356500;
                }else if(gg_=="5.6"){
                    price =  360000;
                }else if(gg_=="5.7"){
                    price =  363300;
                }else if(gg_=="5.8"){
                    price =  366600;
                }else if(gg_=="5.9"){
                    price =  370000;
                }else if(gg_=="6.0"){
                    price =  373300;
                }
            }
        }else if(qxjd_=="10"){
            if(tbkd_=="1000"){
                if(gg_=="3.0"){
                    price =  291300;
                }else if(gg_=="3.1"){
                    price =  295000;
                }else if(gg_=="3.2"){
                    price =  298600;
                }else if(gg_=="3.3"){
                    price =  302300;
                }else if(gg_=="3.4"){
                    price =  305900;
                }else if(gg_=="3.5"){
                    price =  309600;
                }else if(gg_=="3.6"){
                    price =  313200;
                }else if(gg_=="3.7"){
                    price =  316900;
                }else if(gg_=="3.8"){
                    price =  320500;
                }else if(gg_=="3.9"){
                    price =  324200;
                }else if(gg_=="4.0"){
                    price =  327800;
                }else if(gg_=="4.1"){
                    price =  331500;
                }else if(gg_=="4.2"){
                    price =  335100;
                }else if(gg_=="4.3"){
                    price =  338800;
                }else if(gg_=="4.4"){
                    price =  342400;
                }else if(gg_=="4.5"){
                    price =  346100;
                }else if(gg_=="4.6"){
                    price =  349900;
                }else if(gg_=="4.7"){
                    price =  353600;
                }else if(gg_=="4.8"){
                    price =  357200;
                }else if(gg_=="4.9"){
                    price =  360900;
                }else if(gg_=="5.0"){
                    price =  364500;
                }else if(gg_=="5.1"){
                    price =  368200;
                }else if(gg_=="5.2"){
                    price =  371800;
                }else if(gg_=="5.3"){
                    price =  375500;
                }else if(gg_=="5.4"){
                    price =  379100;
                }else if(gg_=="5.5"){
                    price =  382800;
                }else if(gg_=="5.6"){
                    price =  386400;
                }else if(gg_=="5.7"){
                    price =  392200;
                }else if(gg_=="5.8"){
                    price =  395900;
                }else if(gg_=="5.9"){
                    price =  399500;
                }else if(gg_=="6.0"){
                    price =  403200;
                }
            }else if(tbkd_=="800"){
                if(gg_=="3.0"){
                    price =  284600;
                }else if(gg_=="3.1"){
                    price =  288300;
                }else if(gg_=="3.2"){
                    price =  291900;
                }else if(gg_=="3.3"){
                    price =  295600;
                }else if(gg_=="3.4"){
                    price =  299200;
                }else if(gg_=="3.5"){
                    price =  302900;
                }else if(gg_=="3.6"){
                    price =  306500;
                }else if(gg_=="3.7"){
                    price =  310200;
                }else if(gg_=="3.8"){
                    price =  313800;
                }else if(gg_=="3.9"){
                    price =  317500;
                }else if(gg_=="4.0"){
                    price =  321100;
                }else if(gg_=="4.1"){
                    price =  324800;
                }else if(gg_=="4.2"){
                    price =  328400;
                }else if(gg_=="4.3"){
                    price =  332100;
                }else if(gg_=="4.4"){
                    price =  335700;
                }else if(gg_=="4.5"){
                    price =  339400;
                }else if(gg_=="4.6"){
                    price =  343000;
                }else if(gg_=="4.7"){
                    price =  346700;
                }else if(gg_=="4.8"){
                    price =  350300;
                }else if(gg_=="4.9"){
                    price =  354000;
                }else if(gg_=="5.0"){
                    price =  357600;
                }else if(gg_=="5.1"){
                    price =  361300;
                }else if(gg_=="5.2"){
                    price =  364900;
                }else if(gg_=="5.3"){
                    price =  368600;
                }else if(gg_=="5.4"){
                    price =  372200;
                }else if(gg_=="5.5"){
                    price =  375900;
                }else if(gg_=="5.6"){
                    price =  379700;
                }else if(gg_=="5.7"){
                    price =  383400;
                }else if(gg_=="5.8"){
                    price =  387000;
                }else if(gg_=="5.9"){
                    price =  390700;
                }else if(gg_=="6.0"){
                    price =  394300;
                }
            }
        }
        $("#SBJ_TEMP").val(price);
    }


    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#DNR_SL").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=dnr&DNR_SL="+sl_,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }

    //非标,点击添加行
    function addFbRow(){
        var tr = $("#fbTable tr").eq(1).clone();
        $(tr).find("td").eq(0).find("input").eq(0).val("");
        $(tr).find("td").eq(1).find("input").eq(0).val("");
        $(tr).find("td").eq(2).find("input").eq(0).val("");
        $(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delFbRow(this)'></td>");
        $("#fbTable").append(tr);
    }
    //非标,点击删除行
    function delFbRow(obj){
        $(obj).parent().parent().remove();
    }

    //修改角度时
    function editQxjd(){
        var appendStr = "<option value=''>请选择</option><option value='3.0'>3.0</option><option value='3.1'>3.1</option><option value='3.2'>3.2</option><option value='3.3'>3.3</option><option value='3.4'>3.4</option><option value='3.5'>3.5</option><option value='3.6'>3.6</option><option value='3.7'>3.7</option><option value='3.8'>3.8</option><option value='3.9'>3.9</option><option value='4.0'>4.0</option><option value='4.1'>4.1</option><option value='4.2'>4.2</option><option value='4.3'>4.3</option><option value='4.4'>4.4</option><option value='4.5'>4.5</option><option value='4.6'>4.6</option><option value='4.7'>4.7</option><option value='4.8'>4.8</option><option value='4.9'>4.9</option><option value='5.0'>5.0</option><option value='5.1'>5.1</option><option value='5.2'>5.2</option><option value='5.3'>5.3</option><option value='5.4'>5.4</option><option value='5.5'>5.5</option><option value='5.6'>5.6</option><option value='5.7'>5.7</option><option value='5.8'>5.8</option><option value='5.9'>5.9</option><option value='6.0'>6.0</option>";
        $("#BZ_GG").empty();
        $("#BZ_GG").append(appendStr);
    }


    function countZhj(){
        var sbj_count = 0;
        var base_zjzcsl_temp = $("#BASE_ZJZCSL_TEMP").val()==""?0:parseInt($("#BASE_ZJZCSL_TEMP").val());
        var base_jhxt_temp = $("#BASE_JHXT_TEMP").val()==""?0:parseInt($("#BASE_JHXT_TEMP").val());
        var part_fsdgg_temp = $("#PART_FSDGG_TEMP").val()==""?0:parseInt($("#PART_FSDGG_TEMP").val());
        var part_wqbcz_temp = $("#PART_WQBCZ_TEMP").val()==""?0:parseInt($("#PART_WQBCZ_TEMP").val());
        var part_nwgbcz_temp = $("#PART_NWGBCZ_TEMP").val()==""?0:parseInt($("#PART_NWGBCZ_TEMP").val());
        var part_sctbjhdgb_temp = $("#PART_SCTBJHDGB_TEMP").val()==""?0:parseInt($("#PART_SCTBJHDGB_TEMP").val());
        var part_qdfs_temp = $("#PART_QDFS_TEMP").val()==""?0:parseInt($("#PART_QDFS_TEMP").val());
        var part_bpgngl_temp = $("#PART_BPGNGL_TEMP").val()==""?0:parseInt($("#PART_BPGNGL_TEMP").val());
        var opt_aqzdq_temp = $("#OPT_AQZDQ_TEMP").val()==""?0:parseInt($("#OPT_AQZDQ_TEMP").val());
        var opt_jtlxd_temp = $("#OPT_JTLXD_TEMP").val()==""?0:parseInt($("#OPT_JTLXD_TEMP").val());
        var opt_zdjy_temp = $("#OPT_ZDJY_TEMP").val()==""?0:parseInt($("#OPT_ZDJY_TEMP").val());
        var opt_zdwqjxkg_temp = $("#OPT_ZDWQJXKG_TEMP").val()==""?0:parseInt($("#OPT_ZDWQJXKG_TEMP").val());
        var opt_sczm_temp = $("#OPT_SCZM_TEMP").val()==""?0:parseInt($("#OPT_SCZM_TEMP").val());
        var opt_wxhl_temp = $("#OPT_WXHL_TEMP").val()==""?0:parseInt($("#OPT_WXHL_TEMP").val());
        var opt_fpzz_temp = $("#OPT_FPZZ_TEMP").val()==""?0:parseInt($("#OPT_FPZZ_TEMP").val());
        var opt_hjfdds_temp = $("#OPT_HJFDDS_TEMP").val()==""?0:parseInt($("#OPT_HJFDDS_TEMP").val());
        var opt_ckxrxd_temp = $("#OPT_CKXRXD_TEMP").val()==""?0:parseInt($("#OPT_CKXRXD_TEMP").val());
        var opt_spms_temp = $("#OPT_SPMS_TEMP").val()==""?0:parseInt($("#OPT_SPMS_TEMP").val());
        var opt_yxfxzsd_temp = $("#OPT_YXFXZSD_TEMP").val()==""?0:parseInt($("#OPT_YXFXZSD_TEMP").val());

        $("#DNR_ZHJ").val(0);

        sbj_count = base_zjzcsl_temp+base_jhxt_temp+part_fsdgg_temp+part_wqbcz_temp+part_nwgbcz_temp+part_sctbjhdgb_temp+part_qdfs_temp+part_bpgngl_temp+opt_aqzdq_temp+opt_jtlxd_temp+opt_zdjy_temp+opt_zdwqjxkg_temp+opt_sczm_temp+opt_wxhl_temp+opt_fpzz_temp+opt_hjfdds_temp+opt_ckxrxd_temp+opt_spms_temp+opt_yxfxzsd_temp;
        //设备标准价格
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#DNR_SBJ").val(sbj_temp+sbj_count);


        //运输费
        var dnr_ysf = $("#DNR_YSF").val()==""?0:parseInt($("#DNR_YSF").val());
        $("#DNR_YSF").val(dnr_ysf);
        //安装费
        var dnr_azf = $("#DNR_AZF_TEMP").val()==""?0:parseInt($("#DNR_AZF_TEMP").val());
        $("#DNR_AZF").val(dnr_azf);

        var dnr_zk = parseFloat($("#DNR_ZK").val())/100;
        if(!isNaN(dnr_zk)){
            var dnr_sbj = parseInt($("#SBJ_TEMP").val());
            var dnr_sjbj = (dnr_sbj+sbj_count+dnr_azf+dnr_ysf)*dnr_zk;
            var dnr_zhsbj = dnr_sbj*dnr_zk;
            $("#DNR_SJBJ").val(dnr_sjbj);
            $("#DNR_ZHSBJ").val(dnr_zhsbj);
            $("#zk_").text($("#DNR_ZK").val()+"%");    
        }
    }


    //计算基本参数价格
    function editBase(option){

        var price = 0;
        if(option=="BASE_ZJZCSL"){
            //中间支撑数量
            var zjzcsl_ = $("#BASE_ZJZCSL").val();
            if(zjzcsl_=="0"){
                price = 0;
            }else{
                price = parseInt(zjzcsl_)*1370;
            }
            $("#BASE_ZJZCSL_TEMP").val(price);
        }else if(option=="BASE_JHXT"){
            //交货形态
            var jhxt_ = $("#BASE_JHXT").val();
            if(jhxt_=="整梯"){
                price = 0;
            }else if(jhxt_=="分2段"){
                price = 2730*2;
            }else if(jhxt_=="分3段"){
                price = 2730*3;
            }else if(jhxt_=="分4段"){
                price = 2730*4;
            }
            $("#BASE_JHXT_TEMP").val(price);
        }

        //计算价格
        countZhj();
    }

    //计算部件参数价格
    function editPart(option){

        var sl_ = parseInt($("#DNR_SL").val());

        var price = 0;
        /*if(option=="PART_FSDGCZ"){
            //扶手导轨材质
            var qxjd_ = $("#BZ_QXJD").val();
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var fsdgcz_ = $("#PART_FSDGCZ").val();
            if(fsdgcz_=="发纹不锈钢"){
                price = 0;
            }else if(fsdgcz_=="发纹不锈钢SUS304"){
                if(qxjd_=="30"){
                    price = 180*(tsgd_/100)+1000;
                }else if(qxjd_=="35"){
                    price = 160*(tsgd_/100)+1000;
                }
            }
            $("#PART_FSDGCZ_TEMP").val(price);
        }else */
        if(option=="PART_FSDGG"){
            //扶手带规格
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var fsdgg_ = $("#PART_FSDGG").val();
            var qxjd_ = $("#BZ_QXJD").val();
            if(fsdgg_=="依合斯"){
                if(qxjd_=="12"){
                    price = 3450*(tsgd_/100)+1870;
                }else if(qxjd_=="11"){
                    price = 3720*(tsgd_/100)+1870;
                }else if(qxjd_=="10"){
                    price = 4090*(tsgd_/100)+1870;
                }
            }else{
                price = 0;
            }
            $("#PART_FSDGG_TEMP").val(price);
        }else if(option=="PART_WQBCZ"){
            //围裙版材质
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var wqbcz_ = $("#PART_WQBCZ").val();
            if(wqbcz_=="发纹不锈钢"){
                price = 0;
            }else if(wqbcz_=="发纹不锈钢SUS304"){
                price = 1380*(tsgd_/100);
            }
            $("#PART_WQBCZ_TEMP").val(price);
        }else if(option=="PART_NWGBCZ"){
            //内外盖板材质
            var qxjd_ = $("#BZ_QXJD").val();
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var nwgbcz_ = $("#PART_NWGBCZ").val();
            if(nwgbcz_=="发纹不锈钢"){
                price = 0;
            }else if(nwgbcz_=="发纹不锈钢SUS304"){
                if(qxjd_=="12"){
                    price = 420*(tsgd_/100)+1870;
                }else if(qxjd_=="11"){
                    price = 450*(tsgd_/100)+1700;
                }else if(qxjd_=="10"){
                    price = 500*(tsgd_/100)+1500;
                }
            }
            $("#PART_NWGBCZ_TEMP").val(price);
        }else if(option=="PART_SCTBJHDGB"){
            //梳齿踏板及活动盖板
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var sctbjhdgb_ = $("#PART_SCTBJHDGB").val();
            if(sctbjhdgb_=="蚀刻不锈钢,菱形花纹"){
                price = 2960;
            }else{
                price = 0;
            }
            $("#PART_SCTBJHDGB_TEMP").val(price);
        }else if(option=="PART_QDFS"){
            //启动方式
            var qdfs_ = $("#PART_QDFS").val();
            if(qdfs_=="变频,快、慢节能运行"){
                price = 0;
            }else if(qdfs_=="变频,快、慢、停节能运行"){
                price = 0;
            }else if(qdfs_=="Y-△,正常运行"){
                price = 0;
            }else if(qdfs_=="Y-△,快、停节能运行"){
                price = 2660*sl_;
            }
            $("#PART_QDFS_TEMP").val(price);
        }else if(option=="PART_BPGNGL"){
            //变频功能功率
            var qdfs_ = $("#PART_QDFS").val();
            var bpgngl_ = $("#PART_BPGNGL").val();
            if(qdfs_=="变频,快、慢节能运行"){
                if(bpgngl_=="5.5"){
                    price = 6610;
                }else if(bpgngl_=="7.5"){
                    price = 6610;
                }else if(bpgngl_=="11"){
                    price = 8390;
                }else if(bpgngl_=="15"){
                    price = 10360;
                }
            }else if(qdfs_=="变频,快、慢、停节能运行"){
                if(bpgngl_=="5.5"){
                    price = 6610;
                }else if(bpgngl_=="7.5"){
                    price = 6610;
                }else if(bpgngl_=="11"){
                    price = 8390;
                }else if(bpgngl_=="15"){
                    price = 10360;
                }
            }else if(qdfs_=="Y-△,正常运行"){
                price = 0;
            }else if(qdfs_=="Y-△,快、停节能运行"){
                price = 0;
            }
            $("#PART_BPGNGL_TEMP").val(price);
        }
        //计算价格
        countZhj();
    }

    //计算选配价格
    function editOpt(option){

        var sl_ = parseInt($("#DNR_SL").val());

        if(option=="OPT_AQZDQ"){
            //安全制动器
            if($("#OPT_AQZDQ_TEXT").is(":checked")){
                var tsgd_ = parseInt($("#BZ_TSGD").val());
                var azhj_ = $("#BASE_AZHJ").val();
                if(tsgd_>=6000){
                    price = 0;
                }else{
                    price = 6310*sl_;
                }
            }else{
                price = 0;
            }
            $("#OPT_AQZDQ_TEMP").val(price);
        }else if(option=="OPT_JTLXD"){
            //交通流向灯
            if($("#OPT_JTLXD_TEXT").is(":checked")){
                var qdfs_ = $("#PART_QDFS").val();
                if(qdfs_=="变频,快、慢、停节能运行"||qdfs_=="Y-△,快、停节能运行"){
                    price = 0;
                }else{
                    price = 1640*sl_;
                }
            }else{
                price = 0;
            }
            $("#OPT_JTLXD_TEMP").val(price);
        }else if(option=="OPT_ZDJY"){
            //自动加油
            if($("#OPT_ZDJY_TEXT").is(":checked")){
                    price = 2270*sl_;
            }else{
                price = 0;
            }
            $("#OPT_ZDJY_TEMP").val(price);
        }else if(option=="OPT_ZDWQJXKG"){
            //中段围裙间隙开关
            if($("#OPT_ZDWQJXKG_TEXT").is(":checked")){
                price = 1000*sl_;
            }else{
                price = 0;
            }
            $("#OPT_ZDWQJXKG_TEMP").val(price);
        }else if(option=="OPT_SCZM"){
            //梳齿照明
            if($("#OPT_SCZM_TEXT").is(":checked")){
                price = 1750*sl_;
            }else{
                price = 0;
            }
            $("#OPT_SCZM_TEMP").val(price);
        }else if(option=="OPT_WXHL"){
            //维修护栏
            var wxhl_ = parseInt($("#OPT_WXHL").val());
            price = 1370*wxhl_;
            $("#OPT_WXHL_TEMP").val(price);
        }else if(option=="OPT_FPZZ"){
            //防爬装置
            if($("#OPT_FPZZ_TEXT").is(":checked")){
                price = 1260*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FPZZ_TEMP").val(price);
        }else if(option=="OPT_HJFDDS"){
            //桁架分段段数
            var hjfdds_ = parseInt($("#OPT_HJFDDS").val());
            price = 1480*hjfdds_;
            $("#OPT_HJFDDS_TEMP").val(price);
        }else if(option=="OPT_CKXRXD"){
            //出口型人行道
            if($("#OPT_CKXRXD_TEXT").is(":checked")){
                price = 5000;
            }else{
                price = 0;
            }
            $("#OPT_CKXRXD_TEMP").val(price);
        }else if(option=="OPT_SPMS"){
            //双排毛刷
            if($("#OPT_SPMS_TEXT").is(":checked")){
                var qxjd_ = $("#BZ_QXJD").val();
                var tsgd_ = parseInt($("#BZ_TSGD").val());
                if(qxjd_=="12"){
                    price = 1230*(tsgd_/100)+640;
                }else if(qxjd_=="11"){
                    price = 1340*(tsgd_/100)+640;
                }else if(qxjd_=="10"){
                    price = 1480*(tsgd_/100)+640;
                }
            }else{
                price = 0;
            }
            $("#OPT_SPMS_TEMP").val(price);
        }else if(option=="OPT_YXFXZSD"){
            //运行方向指示灯
            var yxfxzsd_ = parseInt($("#OPT_YXFXZSD").val());
            price = 890*yxfxzsd_;
            $("#OPT_YXFXZSD_TEMP").val(price);
        }
        //计算价格
        countZhj();
    }

    //--
    //运输价格部分
    //隐藏DIV
    function hideDiv(){
        var trans_type = $("#trans_type").val();
        if(trans_type=="1"){
            $("#ld").hide();
            $("#zc").show();
        }else{
            $("#zc").hide();
            $("#ld").show();
        }
    }

    //设置城市
    function setCity(){
        var province_id = $("#province_id").val();
        if(province_id==""){
            
        }else{
            $.post("<%=basePath%>e_offer/setCity",
                    {
                        "province_id":province_id
                    },
                    function(data){
                        $("#destin_id").empty();
                        $("#destin_id").append("<option value=''>请选择城市</option>");
                        $.each(data,function(key,value){
                            $("#destin_id").append("<option value='"+value.id+"'>"+value.name+"</option>");
                        });
                    }
                );
        }
    }

    //计算运输价格
    function setPriceTrans(){
        var transType = $("#trans_type").val();
        var province_id = $("#province_id").val();
        var destin_id = $("#destin_id").val();
        if(transType=="1"){//整车
            var zcStr = "[";
            $("#transTable tr").each(function(){
                var carType = $(this).find("td").eq("0").find("select").eq("0").val();
                var num = $(this).find("td").eq("1").find("input").eq("0").val();
                zcStr += "{\'carType\':\'"+carType+"\',\'num\':\'"+num+"\'},"
            });
            zcStr = zcStr.substring(0,zcStr.length-1)+"]";
            $.post("<%=basePath%>e_offer/setPriceTrans",
                    {
                        "zcStr": zcStr,
                        "province_id": province_id,
                        "city_id": destin_id,
                        "transType": transType
                    },
                    function(data){
                        $("#trans_price").val(data.countPrice);
                        var transPrice = parseFloat(data.countPrice);
                        $("#DNR_YSF").val(transPrice);
                        countZhj();
                    }
                );
        }else if(transType=="2"){//零担
            var less_num = $("#less_num").val();
            $.post("<%=basePath%>e_offer/setPriceTrans",
                    {
                        "province_id": province_id,
                        "city_id": destin_id,
                        "transType": transType,
                        "less_num": less_num
                    },
                    function(data){
                        $("#trans_price").val(data.countPrice);
                        var transPrice = parseFloat(data.countPrice);
                        $("#DNR_YSF").val(transPrice);
                        countZhj();
                    }
                );
        }

    }


    function save(){
        //非标json
        var fbDescription = "";
        var fbVal = "";
        var fbPrice = "";
        var fbDate = "";
        var jsonStr = "[";

        $("#fbTable tr:not(:first)").each(function(){
            fbDescription = $(this).find("td").eq(0).find("input").eq(0).val();
            fbVal = $(this).find("td").eq(1).find("input").eq(0).val();
            fbPrice = $(this).find("td").eq(2).find("input").eq(0).val();
            fbDate = $(this).find("td").eq(3).find("input").eq(0).val();
            jsonStr += "{\'fbDescription\':\'"+fbDescription+"\',\'fbVal\':\'"+fbVal+"\',\'fbPrice\':\'"+fbPrice+"\',\'fbDate\':\'"+fbDate+"\'},";
        });
        jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
        $("#UNSTD").val(jsonStr);

        $("#dnrForm").submit();
    }
</script>
</body>

</html>
