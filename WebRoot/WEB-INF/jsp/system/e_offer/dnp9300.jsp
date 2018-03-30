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
    <form action="e_offer/${msg}.do" name="dnp9300Form" id="dnp9300Form" method="post">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="DNP9300_ID" id="DNP9300_ID" value="${pd.DNP9300_ID}">
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
                                                <option value="DNP9300">DNP9300</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>倾斜角度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_QXJD" name="BZ_QXJD">
                                                <option value="">请选择</option>
                                                <option value="35" ${regelevStandardPd.QXJD=='35'?'selected':''}>35°</option>
                                                <option value="30" ${regelevStandardPd.QXJD=='30'?'selected':''}>30°</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">梯级宽度(mm):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_TJKD" name="BZ_TJKD" onchange="setSbj();">
                                                <option value="">请选择</option>
                                                <option value="600" ${regelevStandardPd.TJKD=='600'?'selected':''}>600</option>
                                                <option value="800" ${regelevStandardPd.TJKD=='800'?'selected':''}>800</option>
                                                <option value="1000" ${regelevStandardPd.TJKD=='1000'?'selected':''}>1000</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>水平梯级数</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_SPTJ" name="BZ_SPTJ" onchange="setSbj()">
                                                <option value="">请选择</option>
                                                <option value="2" ${regelevStandardPd.SPTJ=='2'?'selected':''}>2</option>
                                                <option value="3" ${regelevStandardPd.SPTJ=='3'?'selected':''}>3</option>
                                            </select>

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
                                            <label style="width:20%;margin-left:57px"><input type="text" class="form-control m-b" id="DNP9300_SL" name="DNP9300_SL" value="${pd.DNP9300_SL}" readonly="readonly"></label>
                                            <label style="width:9%;margin-top: 25px;margin-bottom: 10px;margin-left: 20px">折扣申请:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="DNP9300_ZK" name="DNP9300_ZK" value="${pd.DNP9300_ZK}" onkeyup="countZhj();"></label>%
                                            <!-- <select  class="form-control m-b" id="DNP9300_ZK" name="DNP9300_ZK" onchange="countZhj();">
                                                <option value="1">请选择折扣</option>
                                                <option value="0.9" ${pd.DNP9300_ZK=='0.9'?'selected':''}>90%</option>
                                                <option value="0.6" ${pd.DNP9300_ZK=='0.6'?'selected':''}>60%</option>
                                                <option value="0.5" ${pd.DNP9300_ZK=='0.5'?'selected':''}>50%</option>
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
                                                    <td>${pd.DNP9300_SL}</td>
                                                    <td>
                                                        --
                                                        /
                                                        --
                                                        /
                                                        --
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNP9300_ZHJ" id="DNP9300_ZHJ" value="${pd.DNP9300_ZHJ}"></td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNP9300_SBJ" id="DNP9300_SBJ" value="${regelevStandardPd.PRICE}">
                                                    <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}">
                                                    </td>
                                                    <td><font color="red"><span id="zk_">${pd.DNP9300_ZK}</span></font></td>
                                                    <td><font color="red"><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNP9300_ZHSBJ" id="DNP9300_ZHSBJ" value="${pd.DNP9300_ZHSBJ}"></font></td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" name="DNP9300_AZF" id="DNP9300_AZF" value="${pd.DNP9300_AZF}"  style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' onkeyup="countZhj();" />
                                                        </font>
                                                    </td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNP9300_YSF" id="DNP9300_YSF" value="${pd.DNP9300_YSF}">
                                                        </font>
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="DNP9300_SJBJ" id="DNP9300_SJBJ" value="${pd.DNP9300_SJBJ}"></td>
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
                                                        <table class="table table-striped table-bordered table-hover" border="1">
                                                          
                                                          <tr>
                                                            <td colspan="2">1.水平跨距(DBE)</td>
                                                            <td>
                                                                <select name="BASE_SPKJ" id="BASE_SPKJ" class="form-control">
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
                                                                <select name="BASE_AZHJ" id="BASE_AZHJ" onchange="editBase('BASE_AZHJ');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="室内" ${pd.BASE_AZHJ=='室内'?'selected':''}>室内</option>
                                                                  <option value="半室外配置A" ${pd.BASE_AZHJ=='半室外配置A'?'selected':''}>半室外配置A</option>
                                                                  <option value="半室外配置B" ${pd.BASE_AZHJ=='半室外配置B'?'selected':''}>半室外配置B</option>
                                                                  <option value="半室外配置C" ${pd.BASE_AZHJ=='半室外配置C'?'selected':''}>全室外配置C</option>
                                                                  <option value="半室外配置D" ${pd.BASE_AZHJ=='半室外配置D'?'selected':''}>全室外配置D</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="BASE_AZHJ_TEMP" id="BASE_AZHJ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="117" rowspan="2">8.扶手装置</td>
                                                            <td width="197">扶手类型</td>
                                                            <td>
                                                                <select name="BASE_FSLX" id="BASE_FSLX" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="苗条型玻璃扶手" ${pd.BASE_FSLX=='苗条型玻璃扶手'?'selected':''}>苗条型玻璃扶手</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>扶手高度</td>
                                                            <td>
                                                                <select name="BASE_FSGD" id="BASE_FSGD" onchange="editBase('BASE_FSGD');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="900" ${pd.BASE_FSGD=='900'?'selected':''}>900</option>
                                                                  <option value="1000" ${pd.BASE_FSGD=='1000'?'selected':''}>1000</option>
                                                                </select>mm
                                                            </td>
                                                            <td><input type="text" name="BASE_FSGD_TEMP" id="BASE_FSGD_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">4.中间支撑数量[水平跨距DBE&gt;15m时至少一个]</td>
                                                            <td>
                                                                <select name="BASE_ZJZCSL" id="BASE_ZJZCSL" onchange="editBase('BASE_ZJZCSL');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="0" ${pd.BASE_ZJZCSL=='0'?'selected':''}>0个</option>
                                                                  <option value="1" ${pd.BASE_ZJZCSL=='1'?'selected':''}>1个</option>
                                                                  <option value="2" ${pd.BASE_ZJZCSL=='2'?'selected':''}>2个</option>
                                                                  <option value="3" ${pd.BASE_ZJZCSL=='3'?'selected':''}>3个</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="BASE_ZJZCSL_TEMP" id="BASE_ZJZCSL_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">5.布置形式</td>
                                                            <td>
                                                                <select name="BASE_BZXS" id="BASE_BZXS" class="form-control">
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
                                                            <td colspan="2">6.运输方式/交货形态(分段数)</td>
                                                            <td>
                                                                <select name="BASE_YSFS" id="BASE_YSFS" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="卡车" ${pd.BASE_YSFS=='卡车'?'selected':''}>卡车</option>
                                                                </select>
                                                                /
                                                                <select name="BASE_JHXT" id="BASE_JHXT" onchange="editBase('BASE_JHXT');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="整梯" ${pd.BASE_JHXT=='整梯'?'selected':''}>整梯</option>
                                                                  <option value="分2段" ${pd.BASE_JHXT=='分2段'?'selected':''}>分2段</option>
                                                                  <option value="分3段" ${pd.BASE_JHXT=='分3段'?'selected':''}>分3段</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="BASE_JHXT_TEMP" id="BASE_JHXT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">7.土建尺寸</td>
                                                            <td><p>上端加长(0~1000mm)[A-600时必须加长417]</p>    </td>
                                                            <td>
                                                                <input type="text" name="BASE_SDJC" id="BASE_SDJC" onkeyup="editBase('BASE_SDJC');" class="form-control" value="${pd.BASE_SDJC}"/>mm
                                                            </td>
                                                            <td><input type="text" name="BASE_SDJC_TEMP" id="BASE_SDJC_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>下端加长(0~1000mm)</td>
                                                            <td>
                                                                <input type="text" name="BASE_XDJC" id="BASE_XDJC" onkeyup="editBase('BASE_XDJC');" class="form-control" value="${pd.BASE_XDJC}"/>mm
                                                            </td>
                                                            <td><input type="text" name="BASE_XDJC_TEMP" id="BASE_XDJC_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 部件参数 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td width="355">1.减速机</td>
                                                            <td width="280">
                                                                <select name="PART_JSJ" id="PART_JSJ" class="form-control"> 
                                                                    <option value="">请选择</option>
                                                                    <option value="涡轮蜗杆" ${pd.PART_JSJ=='涡轮蜗杆'?'selected':''}>涡轮蜗杆</option>
                                                                </select>
                                                            </td>
                                                            <td width="130">&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2.梯级-梯级类型/颜色[自然色仅用于铝梯级]</td>
                                                            <td>
                                                                <select name="PART_TJLX" id="PART_TJLX" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="不锈钢梯级" ${pd.PART_TJLX=='不锈钢梯级'?'selected':''}>不锈钢梯级</option>
                                                                    <option value="铝合金梯级" ${pd.PART_TJLX=='铝合金梯级'?'selected':''}>铝合金梯级</option>
                                                                </select>/
                                                                <select name="PART_TJYS" id="PART_TJYS" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="自然色" ${pd.PART_TJYS=='自然色'?'selected':''}>自然色</option>
                                                                    <option value="银灰色" ${pd.PART_TJYS=='银灰色'?'selected':''}>银灰色</option>
                                                                    <option value="黑色" ${pd.PART_TJYS=='黑色'?'selected':''}>黑色</option>
                                                                </select>   
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3.梯级-梯级中分线[仅用于铝合金梯级]</td>
                                                            <td>
                                                                <input type="checkbox" name="PART_TJZFX" id="PART_TJZFX"/>   </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4.梯级-梯级边框材质</td>
                                                            <td>
                                                                <select name="PART_TJBKCZ" id="PART_TJBKCZ" class="form-control">
                                                                    <option value="三边黄色喷漆警戒线-铝合金梯级">三边黄色喷漆警戒线-铝合金梯级</option>
                                                                    <option value="三边黄色塑料边框-不锈钢梯级">三边黄色塑料边框-不锈钢梯级</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5.扶手导轨材质</td>
                                                            <td>
                                                                <select name="PART_FSDGCZ" id="PART_FSDGCZ" onchange="editPart('PART_FSDGCZ');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_FSDGCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_FSDGCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_FSDGCZ_TEMP" id="PART_FSDGCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>6.扶手带规格/颜色</td>
                                                            <td>
                                                                <select name="PART_FSDGG" id="PART_FSDGG" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="国内品牌" ${pd.PART_FSDGG=='国内品牌'?'selected':''}>国内品牌</option>
                                                                  <option value="外资品牌" ${pd.PART_FSDGG=='外资品牌'?'selected':''}>外资品牌</option>
                                                                </select>
                                                                / 
                                                                <select name="PART_FSDYS" id="PART_FSDYS" onchange="editPart('PART_FSDYS');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="黑色" ${pd.PART_FSDYS=='黑色'?'selected':''}>黑色</option>
                                                                  <option value="红色" ${pd.PART_FSDYS=='红色'?'selected':''}>红色</option>
                                                                  <option value="蓝色" ${pd.PART_FSDYS=='蓝色'?'selected':''}>蓝色</option>
                                                                </select> 
                                                            </td>
                                                            <td><input type="text" name="PART_FSDYS_TEMP" id="PART_FSDYS_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7.围裙版材质</td>
                                                            <td>
                                                                <select name="PART_WQBCZ" id="PART_WQBCZ" onchange="editPart('PART_WQBCZ');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_WQBCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_WQBCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_WQBCZ_TEMP" id="PART_WQBCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>8.内外盖板材质</td>
                                                            <td>
                                                                <select name="PART_NWGBCZ" id="PART_NWGBCZ" onchange="editPart('PART_NWGBCZ');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_NWGBCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_NWGBCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_NWGBCZ_TEMP" id="PART_NWGBCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>9.梳齿踏板及活动盖板</td>
                                                            <td>
                                                                <select name="PART_SCTBJHDGB" id="PART_SCTBJHDGB" onchange="editPart('PART_SCTBJHDGB');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="压纹不锈钢,方形花纹" ${pd.PART_SCTBJHDGB=='压纹不锈钢,方形花纹'?'selected':''}>压纹不锈钢,方形花纹</option>
                                                                  <option value="压纹不锈钢,矩形花纹" ${pd.PART_SCTBJHDGB=='压纹不锈钢,矩形花纹'?'selected':''}>压纹不锈钢,矩形花纹</option>
                                                                  <option value="铝合金防滑条纹" ${pd.PART_SCTBJHDGB=='铝合金防滑条纹'?'selected':''}>铝合金防滑条纹</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_SCTBJHDGB_TEMP" id="PART_SCTBJHDGB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>10.梳齿板</td>
                                                            <td>
                                                                <select name="PART_SCB" id="PART_SCB" onchange="editPart('PART_SCB');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="PVC黄色" ${pd.PART_SCB=='PVC黄色'?'selected':''}>PVC黄色</option>
                                                                  <option value="铝合金自然色" ${pd.PART_SCB=='铝合金自然色'?'selected':''}>铝合金自然色</option>
                                                                  <option value="铝合金黄色" ${pd.PART_SCB=='铝合金黄色'?'selected':''}>铝合金黄色</option>
                                                                </select>   
                                                            </td>
                                                            <td><input type="text" name="PART_SCB_TEMP" id="PART_SCB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11.启动方式</td>
                                                            <td>
                                                                <select name="PART_QDFS" id="PART_QDFS" onchange="editPart('PART_QDFS');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="Y-△,正常运行" ${pd.PART_QDFS=='Y-△,正常运行'?'selected':''}>Y-△,正常运行</option>
                                                                    <option value="变频,快、慢节能运行" ${pd.PART_QDFS=='变频,快、慢节能运行'?'selected':''}>变频,快、慢节能运行</option>
                                                                    <option value="变频,快、慢、停节能运行" ${pd.PART_QDFS=='变频,快、慢、停节能运行'?'selected':''}>变频,快、慢、停节能运行</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_QDFS_TEMP" id="PART_QDFS_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 部件参数 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>1.急停按钮</td>
                                                            <td>2.钥匙开关</td>
                                                            <td>3.扶手进出口保护开关</td>
                                                            <td>4.梯级链断链保护开关</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5.梯级下陷保护</td>
                                                            <td>6.缺相及错相保护</td>
                                                            <td>7.点击护罩保护</td>
                                                            <td>8.机房护板</td>
                                                          </tr>
                                                          <tr>
                                                            <td>9.点击过载保护</td>
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
                                                            <td>17.梯级防静电刷</td>
                                                            <td>18.驱动链断链保护</td>
                                                            <td>19.手动检修插座</td>
                                                            <td>20.手动盘车装置</td>
                                                          </tr>
                                                          <tr>
                                                            <td>21.盖板检修开关</td>
                                                            <td>22.围裙毛刷</td>
                                                            <td>23.扶手带速度监控</td>
                                                            <td>24.梯级遗失保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>25.梯级超速保护</td>
                                                            <td>26.制动距离超限报警</td>
                                                            <td>27.故障显示[控制柜上]</td>
                                                            <td>28.梯级间隙照明</td>
                                                          </tr>
                                                          <tr>
                                                            <td>29.上下机房踏板</td>
                                                            <td>30.附加制动器[仅H&gt;6m时为标配]</td>
                                                            <td>31.检修手柄[每个项目配一件]</td>
                                                            <td>32.检修行灯[每个项目配1件]</td>
                                                          </tr>
                                                        </table>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <!-- 选配功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="2">1.安全制动器[提升高度&gt;6m必选]</td>
                                                            <td width="335">
                                                                <input type="checkbox" name="OPT_AQZDQ_TEXT" id="OPT_AQZDQ_TEXT" onclick="editOpt('OPT_AQZDQ');"  ${pd.OPT_AQZDQ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_AQZDQ" id="OPT_AQZDQ">
                                                            </td>
                                                            <td width="36"><input type="text" name="OPT_AQZDQ_TEMP" id="OPT_AQZDQ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">2.5个干触点</td>
                                                            <td><input type="checkbox" name="OPT_GCD_TEXT" id="OPT_GCD_TEXT" onclick="editOpt('OPT_GCD');"  ${pd.OPT_GCD=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GCD" id="OPT_GCD">
                                                            </td>
                                                            <td><input type="text" name="OPT_GCD_TEMP" id="OPT_GCD_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">3.故障显示[在外盖板上]</td>
                                                            <td><input type="checkbox" name="OPT_GZXS_TEXT" id="OPT_GZXS_TEXT" onclick="editOpt('OPT_GZXS');"  ${pd.OPT_GZXS=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_GZXS" id="OPT_GZXS">
                                                            </td>
                                                            <td><input type="text" name="OPT_GZXS_TEMP" id="OPT_GZXS_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">4.交通流向灯[自启动时为必选]</td>
                                                            <td><input type="checkbox" name="OPT_JTLXD_TEXT" id="OPT_JTLXD_TEXT" onclick="editOpt('OPT_JTLXD');" ${pd.OPT_JTLXD=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_JTLXD" id="OPT_JTLXD">
                                                            </td>
                                                            <td><input type="text" name="OPT_JTLXD_TEMP" id="OPT_JTLXD_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">5.制动器磨损监控</td>
                                                            <td><input type="checkbox" name="OPT_ZDQMSJK_TEXT" id="OPT_ZDQMSJK_TEXT" onclick="editOpt('OPT_ZDQMSJK');" ${pd.OPT_ZDQMSJK=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_ZDQMSJK" id="OPT_ZDQMSJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDQMSJK_TEMP" id="OPT_ZDQMSJK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">6.自动加油</td>
                                                            <td><input type="checkbox" name="OPT_ZDJY_TEXT" id="OPT_ZDJY_TEXT" onclick="editOpt('OPT_ZDJY');"  ${pd.OPT_ZDJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ZDJY" id="OPT_ZDJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDJY_TEMP" id="OPT_ZDJY_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">7.驱动链链罩</td>
                                                            <td><input type="checkbox" name="OPT_QDLLZ_TEXT" id="OPT_QDLLZ_TEXT" onclick="editOpt('OPT_QDLLZ');"  ${pd.OPT_QDLLZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_QDLLZ" id="OPT_QDLLZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_QDLLZ_TEMP" id="OPT_QDLLZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">8.LED围裙照明</td>
                                                            <td><input type="checkbox" name="OPT_LEDWQZM_TEXT" id="OPT_LEDWQZM_TEXT" onclick="editOpt('OPT_LEDWQZM');" ${pd.OPT_LEDWQZM=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_LEDWQZM" id="OPT_LEDWQZM">
                                                            </td>
                                                            <td><input type="text" name="OPT_LEDWQZM_TEMP" id="OPT_LEDWQZM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">9.梯级防跳保护</td>
                                                            <td><input type="checkbox" name="OPT_TJFTBH_TEXT" id="OPT_TJFTBH_TEXT" onclick="editOpt('OPT_TJFTBH');"  ${pd.OPT_TJFTBH=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_TJFTBH" id="OPT_TJFTBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_TJFTBH_TEMP" id="OPT_TJFTBH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">10.围裙安全装置</td>
                                                            <td><input type="checkbox" name="OPT_WQAQZZ_TEXT" id="OPT_WQAQZZ_TEXT" onclick="editOpt('OPT_WQAQZZ');"  ${pd.OPT_WQAQZZ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_WQAQZZ" id="OPT_WQAQZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_WQAQZZ_TEMP" id="OPT_WQAQZZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">11.扶手带断带保护装置</td>
                                                            <td><input type="checkbox" name="OPT_FSDDDBHZZ_TEXT" id="OPT_FSDDDBHZZ_TEXT" onclick="editOpt('OPT_FSDDDBHZZ');" ${pd.OPT_FSDDDBHZZ=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_FSDDDBHZZ" id="OPT_FSDDDBHZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FSDDDBHZZ_TEMP" id="OPT_FSDDDBHZZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">12.中段围裙间隙开关</td>
                                                            <td><input type="checkbox" name="OPT_ZDWQJXKG_TEXT" id="OPT_ZDWQJXKG_TEXT" onclick="editOpt('OPT_ZDWQJXKG');"  ${pd.OPT_ZDWQJXKG=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_ZDWQJXKG" id="OPT_ZDWQJXKG">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDWQJXKG_TEMP" id="OPT_ZDWQJXKG_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">13.梳齿照明</td>
                                                            <td><input type="checkbox" name="OPT_SCZM_TEXT" id="OPT_SCZM_TEXT" onclick="editOpt('OPT_SCZM');" ${pd.OPT_SCZM=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_SCZM" id="OPT_SCZM">
                                                            </td>
                                                            <td><input type="text" name="OPT_SCZM_TEMP" id="OPT_SCZM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">14.扶手照明</td>
                                                            <td><input type="checkbox" name="OPT_FSZM_TEXT" id="OPT_FSZM_TEXT" onclick="editOpt('OPT_FSZM');" ${pd.OPT_FSZM=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_FSZM" id="OPT_FSZM">
                                                            </td>
                                                            <td><input type="text" name="OPT_FSZM_TEMP" id="OPT_FSZM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">15.电缆分段连接器[桁架分段时选用]</td>
                                                            <td><input type="checkbox" name="OPT_DLFDLJQ_TEXT" id="OPT_DLFDLJQ_TEXT" onclick="editOpt('OPT_DLFDLJQ');"  ${pd.OPT_DLFDLJQ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_DLFDLJQ" id="OPT_DLFDLJQ">
                                                            </td>
                                                            <td><input type="text" name="OPT_DLFDLJQ_TEMP" id="OPT_DLFDLJQ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">16.油水分离器[户外是必选]</td>
                                                            <td><input type="checkbox" name="OPT_YSFLQ_TEXT" id="OPT_YSFLQ_TEXT" onclick="editOpt('OPT_YSFLQ');"  ${pd.OPT_YSFLQ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_YSFLQ" id="OPT_YSFLQ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YSFLQ_TEMP" id="OPT_YSFLQ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">17.防洪保护[户外是必选]</td>
                                                            <td><input type="checkbox" name="OPT_FHBH_TEXT" id="OPT_FHBH_TEXT" onclick="editOpt('OPT_FHBH');"  ${pd.OPT_FHBH=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FHBH" id="OPT_FHBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_FHBH_TEMP" id="OPT_FHBH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">18.梯级链防护罩[户外是必选]</td>
                                                            <td><input type="checkbox" name="OPT_TJLFHZ_TEXT" id="OPT_TJLFHZ_TEXT" onclick="editOpt('OPT_TJLFHZ');"  ${pd.OPT_TJLFHZ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_TJLFHZ" id="OPT_TJLFHZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_TJLFHZ_TEMP" id="OPT_TJLFHZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="110" rowspan="3">19.外装饰</td>
                                                            <td width="218">外装饰位置[桁架分段时选用]</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_WZSWZ" onclick="editOpt('OPT_WZSWZ');"  ${pd.OPT_WZSWZ=='左侧'?'checked':''}/>左侧
                                                                <input type="checkbox" name="OPT_WZSWZ" onclick="editOpt('OPT_WZSWZ');"  ${pd.OPT_WZSWZ=='右侧'?'checked':''}/>右侧
                                                                <input type="checkbox" name="OPT_WZSWZ" onclick="editOpt('OPT_WZSWZ');"  ${pd.OPT_WZSWZ=='底侧'?'checked':''}/>底侧
                                                            </td>
                                                            <td><input type="text" name="OPT_WZSWZ_TEMP" id="OPT_WZSWZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>装饰板材料</td>
                                                            <td>
                                                                <select name="OPT_ZSBCL" id="OPT_ZSBCL" onchange="editOpt('OPT_ZSBCL');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板" ${pd.OPT_ZSBCL=='钢板'?'selected':''}>钢板</option>
                                                                    <option value="发纹不锈钢" ${pd.OPT_ZSBCL=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="发纹不锈钢SUS304" ${pd.OPT_ZSBCL=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ZSBCL_TEMP" id="OPT_ZSBCL_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>装饰板厚度</td>
                                                            <td>
                                                                <select name="OPT_ZSBHD" id="OPT_ZSBHD" onchange="editOpt('OPT_ZSBHD');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="0.8" ${pd.OPT_ZSBHD=='0.8'?'selected':''}>0.8</option>
                                                                    <option value="1.0" ${pd.OPT_ZSBHD=='1.0'?'selected':''}>1.0</option>
                                                                    <option value="1.2" ${pd.OPT_ZSBHD=='1.2'?'selected':''}>1.2</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ZSBHD_TEMP" id="OPT_ZSBHD_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">20.维修护栏</td>
                                                            <td>
                                                                <input type="text" name="OPT_WXHL" id="OPT_WXHL" onkeyup="editOpt('OPT_WXHL');" class="form-control" value="${pd.OPT_WXHL}">套
                                                            </td>
                                                            <td><input type="text" name="OPT_WXHL_TEMP" id="OPT_WXHL_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">23.吊装钢丝绳</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_DZGSS_TEXT" id="OPT_DZGSS_TEXT" onclick="editOpt('OPT_DZGSS');"  ${pd.OPT_DZGSS=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DZGSS" id="OPT_DZGSS">
                                                            </td>
                                                            <td><input type="text" name="OPT_DZGSS_TEMP" id="OPT_DZGSS_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.防爬装置</td>
                                                            <td><input type="checkbox" name="OPT_FPZZ_TEXT" id="OPT_FPZZ_TEXT" onclick="editOpt('OPT_FPZZ');"  ${pd.OPT_FPZZ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FPZZ" id="OPT_FPZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FPZZ_TEMP" id="OPT_FPZZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.桁架分段段数</td>
                                                            <td>
                                                            <input type="text" name="OPT_HJFDDS" id="OPT_HJFDDS" onkeyup="editOpt('OPT_HJFDDS');" class="form-control" value="${pd.OPT_HJFDDS}">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJFDDS_TEMP" id="OPT_HJFDDS_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">25.桁架加热</td>
                                                            <td><input type="checkbox" name="OPT_HJJR_TEXT" id="OPT_HJJR_TEXT" onclick="editOpt('OPT_HJJR');"  ${pd.OPT_HJJR=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_HJJR" id="OPT_HJJR">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJJR_TEMP" id="OPT_HJJR_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">26.梳齿加热</td>
                                                            <td><input type="checkbox" name="OPT_SCJR_TEXT" id="OPT_SCJR_TEXT" ${pd.OPT_SCJR_TEXT=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_SCJR" id="OPT_SCJR">
                                                            </td>
                                                            <td><input type="text" name="OPT_SCJR_TEMP" id="OPT_SCJR_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">27.扶手加热</td>
                                                            <td><input type="checkbox" name="OPT_FSJR_TEXT" id="OPT_FSJR_TEXT" onclick="editOpt('OPT_FSJR');"  ${pd.OPT_FSJR=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FSJR" id="OPT_FSJR">
                                                            </td>
                                                            <td><input type="text" name="OPT_FSJR_TEMP" id="OPT_FSJR_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 选配功能 -->
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <!-- 环境配置 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
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
                                            <input type="text" class="form-control" id="DNP9300_AZF_TEMP" name="DNP9300_AZF_TEMP" onkeyup="countZhj();" value="${pd.DNP9300_AZF}">
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

    //计算基础价
    function setSbj(){
        var gg_ = $("#BZ_GG").val();  //规格
        var qxjd_ = $("#BZ_QXJD").val();     //倾斜角度
        var tjkd_ = $("#BZ_TJKD").val();  //梯级宽度
        var price = 0;
        if(qxjd_=="35"){
            if(tjkd_=="1000"){
                if(gg_=="3.0"){
                    price =  165900;
                }else if(gg_=="3.1"){
                    price =  167300;
                }else if(gg_=="3.2"){
                    price =  168700;
                }else if(gg_=="3.3"){
                    price =  170200;
                }else if(gg_=="3.4"){
                    price =  171600;
                }else if(gg_=="3.5"){
                    price =  173000;
                }else if(gg_=="3.6"){
                    price =  174400;
                }else if(gg_=="3.7"){
                    price =  175800;
                }else if(gg_=="3.8"){
                    price =  177200;
                }else if(gg_=="3.9"){
                    price =  178600;
                }else if(gg_=="4.0"){
                    price =  180000;
                }else if(gg_=="4.1"){
                    price =  182400;
                }else if(gg_=="4.2"){
                    price =  183800;
                }else if(gg_=="4.3"){
                    price =  185200;
                }else if(gg_=="4.4"){
                    price =  186600;
                }else if(gg_=="4.5"){
                    price =  188000;
                }else if(gg_=="4.6"){
                    price =  189500;
                }else if(gg_=="4.7"){
                    price =  190900;
                }else if(gg_=="4.8"){
                    price =  192300;
                }else if(gg_=="4.9"){
                    price =  193700;
                }else if(gg_=="5.0"){
                    price =  195300;
                }else if(gg_=="5.1"){
                    price =  197100;
                }else if(gg_=="5.2"){
                    price =  198500;
                }else if(gg_=="5.3"){
                    price =  199900;
                }else if(gg_=="5.4"){
                    price =  201300;
                }else if(gg_=="5.5"){
                    price =  202700;
                }else if(gg_=="5.6"){
                    price =  204100;
                }else if(gg_=="5.7"){
                    price =  205500;
                }else if(gg_=="5.8"){
                    price =  206900;
                }else if(gg_=="5.9"){
                    price =  208300;
                }else if(gg_=="6.0"){
                    price =  209800;
                }
            }else if(tjkd_=="800"){
                if(gg_=="3.0"){
                    price =  164700;
                }else if(gg_=="3.1"){
                    price =  166000;
                }else if(gg_=="3.2"){
                    price =  167400;
                }else if(gg_=="3.3"){
                    price =  168800;
                }else if(gg_=="3.4"){
                    price =  170200;
                }else if(gg_=="3.5"){
                    price =  171600;
                }else if(gg_=="3.6"){
                    price =  173000;
                }else if(gg_=="3.7"){
                    price =  174400;
                }else if(gg_=="3.8"){
                    price =  175800;
                }else if(gg_=="3.9"){
                    price =  177200;
                }else if(gg_=="4.0"){
                    price =  178500;
                }else if(gg_=="4.1"){
                    price =  179900;
                }else if(gg_=="4.2"){
                    price =  181300;
                }else if(gg_=="4.3"){
                    price =  182700;
                }else if(gg_=="4.4"){
                    price =  184100;
                }else if(gg_=="4.5"){
                    price =  185500;
                }else if(gg_=="4.6"){
                    price =  186900;
                }else if(gg_=="4.7"){
                    price =  188300;
                }else if(gg_=="4.8"){
                    price =  189600;
                }else if(gg_=="4.9"){
                    price =  191000;
                }else if(gg_=="5.0"){
                    price =  192600;
                }else if(gg_=="5.1"){
                    price =  195400;
                }else if(gg_=="5.2"){
                    price =  196800;
                }else if(gg_=="5.3"){
                    price =  198200;
                }else if(gg_=="5.4"){
                    price =  199500;
                }else if(gg_=="5.5"){
                    price =  200900;
                }else if(gg_=="5.6"){
                    price =  202300;
                }else if(gg_=="5.7"){
                    price =  203700;
                }else if(gg_=="5.8"){
                    price =  205100;
                }else if(gg_=="5.9"){
                    price =  206500;
                }else if(gg_=="6.0"){
                    price =  207900;
                }
            }else if(tjkd_=="600"){
                if(gg_=="3.0"){
                    price =  163800;
                }else if(gg_=="3.1"){
                    price =  165200;
                }else if(gg_=="3.2"){
                    price =  166600;
                }else if(gg_=="3.3"){
                    price =  167900;
                }else if(gg_=="3.4"){
                    price =  169300;
                }else if(gg_=="3.5"){
                    price =  170700;
                }else if(gg_=="3.6"){
                    price =  172100;
                }else if(gg_=="3.7"){
                    price =  173500;
                }else if(gg_=="3.8"){
                    price =  174800;
                }else if(gg_=="3.9"){
                    price =  176200;
                }else if(gg_=="4.0"){
                    price =  177600;
                }else if(gg_=="4.1"){
                    price =  178900;
                }else if(gg_=="4.2"){
                    price =  180300;
                }else if(gg_=="4.3"){
                    price =  181700;
                }else if(gg_=="4.4"){
                    price =  183100;
                }else if(gg_=="4.5"){
                    price =  184500;
                }else if(gg_=="4.6"){
                    price =  185800;
                }else if(gg_=="4.7"){
                    price =  187200;
                }else if(gg_=="4.8"){
                    price =  188600;
                }else if(gg_=="4.9"){
                    price =  190000;
                }else if(gg_=="5.0"){
                    price =  191500;
                }else if(gg_=="5.1"){
                    price =  193300;
                }else if(gg_=="5.2"){
                    price =  194700;
                }else if(gg_=="5.3"){
                    price =  196100;
                }else if(gg_=="5.4"){
                    price =  197400;
                }else if(gg_=="5.5"){
                    price =  198800;
                }else if(gg_=="5.6"){
                    price =  200200;
                }else if(gg_=="5.7"){
                    price =  201500;
                }else if(gg_=="5.8"){
                    price =  202900;
                }else if(gg_=="5.9"){
                    price =  204300;
                }else if(gg_=="6.0"){
                    price =  205700;
                }
            }
        }else if(qxjd_=="30"){
            if(tjkd_=="1000"){
                if(gg_=="3.0"){
                    price =   171700;
                }else if(gg_=="3.1"){
                    price =   173300;
                }else if(gg_=="3.2"){
                    price =   174900;
                }else if(gg_=="3.3"){
                    price =   176500;
                }else if(gg_=="3.4"){
                    price =   178100;
                }else if(gg_=="3.5"){
                    price =   179700;
                }else if(gg_=="3.6"){
                    price =   182300;
                }else if(gg_=="3.7"){
                    price =   184000;
                }else if(gg_=="3.8"){
                    price =   185600;
                }else if(gg_=="3.9"){
                    price =   187200;
                }else if(gg_=="4.0"){
                    price =   188800;
                }else if(gg_=="4.1"){
                    price =   190400;
                }else if(gg_=="4.2"){
                    price =   192000;
                }else if(gg_=="4.3"){
                    price =   193600;
                }else if(gg_=="4.4"){
                    price =   195200;
                }else if(gg_=="4.5"){
                    price =   196800;
                }else if(gg_=="4.6"){
                    price =   198400;
                }else if(gg_=="4.7"){
                    price =   200100;
                }else if(gg_=="4.8"){
                    price =   201700;
                }else if(gg_=="4.9"){
                    price =   203700;
                }else if(gg_=="5.0"){
                    price =   205300;
                }else if(gg_=="5.1"){
                    price =   206900;
                }else if(gg_=="5.2"){
                    price =   208500;
                }else if(gg_=="5.3"){
                    price =   210100;
                }else if(gg_=="5.4"){
                    price =   211700;
                }else if(gg_=="5.5"){
                    price =   213300;
                }else if(gg_=="5.6"){
                    price =   214900;
                }else if(gg_=="5.7"){
                    price =   216500;
                }else if(gg_=="5.8"){
                    price =   218200;
                }else if(gg_=="5.9"){
                    price =   219800;
                }else if(gg_=="6.0"){
                    price =   221400;
                }else if(gg_=="6.1"){
                    price =   243000;
                }else if(gg_=="6.2"){
                    price =   244600;
                }else if(gg_=="6.3"){
                    price =   246200;
                }else if(gg_=="6.4"){
                    price =   247800;
                }else if(gg_=="6.5"){
                    price =   249400;
                }else if(gg_=="6.6"){
                    price =   254400;
                }else if(gg_=="6.7"){
                    price =   256000;
                }else if(gg_=="6.8"){
                    price =   257600;
                }else if(gg_=="6.9"){
                    price =   259200;
                }else if(gg_=="7.0"){
                    price =   260800;
                }else if(gg_=="7.1"){
                    price =   262400;
                }else if(gg_=="7.2"){
                    price =   264000;
                }else if(gg_=="7.3"){
                    price =   265700;
                }else if(gg_=="7.4"){
                    price =   267300;
                }else if(gg_=="7.5"){
                    price =   268900;
                }
            }else if(tjkd_=="800"){
                if(gg_=="3.0"){
                    price =    170400;
                }else if(gg_=="3.1"){
                    price =    171900;
                }else if(gg_=="3.2"){
                    price =    173500;
                }else if(gg_=="3.3"){
                    price =    175100;
                }else if(gg_=="3.4"){
                    price =    176700;
                }else if(gg_=="3.5"){
                    price =    178300;
                }else if(gg_=="3.6"){
                    price =    179900;
                }else if(gg_=="3.7"){
                    price =    181500;
                }else if(gg_=="3.8"){
                    price =    183000;
                }else if(gg_=="3.9"){
                    price =    184600;
                }else if(gg_=="4.0"){
                    price =    186200;
                }else if(gg_=="4.1"){
                    price =    188800;
                }else if(gg_=="4.2"){
                    price =    190400;
                }else if(gg_=="4.3"){
                    price =    192000;
                }else if(gg_=="4.4"){
                    price =    193500;
                }else if(gg_=="4.5"){
                    price =    195100;
                }else if(gg_=="4.6"){
                    price =    196700;
                }else if(gg_=="4.7"){
                    price =    198300;
                }else if(gg_=="4.8"){
                    price =    199900;
                }else if(gg_=="4.9"){
                    price =    201900;
                }else if(gg_=="5.0"){
                    price =    203500;
                }else if(gg_=="5.1"){
                    price =    205000;
                }else if(gg_=="5.2"){
                    price =    206600;
                }else if(gg_=="5.3"){
                    price =    208200;
                }else if(gg_=="5.4"){
                    price =    209800;
                }else if(gg_=="5.5"){
                    price =    211400;
                }else if(gg_=="5.6"){
                    price =    213000;
                }else if(gg_=="5.7"){
                    price =    214600;
                }else if(gg_=="5.8"){
                    price =    216200;
                }else if(gg_=="5.9"){
                    price =    217700;
                }else if(gg_=="6.0"){
                    price =    219300;
                }else if(gg_=="6.1"){
                    price =    241300;
                }else if(gg_=="6.2"){
                    price =    242900;
                }else if(gg_=="6.3"){
                    price =    244500;
                }else if(gg_=="6.4"){
                    price =    246200;
                }else if(gg_=="6.5"){
                    price =    247800;
                }else if(gg_=="6.6"){
                    price =    249400;
                }else if(gg_=="6.7"){
                    price =    251000;
                }else if(gg_=="6.8"){
                    price =    252600;
                }else if(gg_=="6.9"){
                    price =    254200;
                }else if(gg_=="7.0"){
                    price =    255800;
                }else if(gg_=="7.1"){
                    price =    257400;
                }else if(gg_=="7.2"){
                    price =    259000;
                }else if(gg_=="7.3"){
                    price =    260600;
                }else if(gg_=="7.4"){
                    price =    262300;
                }else if(gg_=="7.5"){
                    price =    263900;
                }
            }else if(tjkd_=="600"){
                if(gg_=="3.0"){
                    price =    169500;
                }else if(gg_=="3.1"){
                    price =    171000;
                }else if(gg_=="3.2"){
                    price =    172600;
                }else if(gg_=="3.3"){
                    price =    174200;
                }else if(gg_=="3.4"){
                    price =    175800;
                }else if(gg_=="3.5"){
                    price =    177300;
                }else if(gg_=="3.6"){
                    price =    178900;
                }else if(gg_=="3.7"){
                    price =    180500;
                }else if(gg_=="3.8"){
                    price =    182100;
                }else if(gg_=="3.9"){
                    price =    183600;
                }else if(gg_=="4.0"){
                    price =    185200;
                }else if(gg_=="4.1"){
                    price =    186800;
                }else if(gg_=="4.2"){
                    price =    188300;
                }else if(gg_=="4.3"){
                    price =    189900;
                }else if(gg_=="4.4"){
                    price =    191500;
                }else if(gg_=="4.5"){
                    price =    193100;
                }else if(gg_=="4.6"){
                    price =    194600;
                }else if(gg_=="4.7"){
                    price =    196200;
                }else if(gg_=="4.8"){
                    price =    197800;
                }else if(gg_=="4.9"){
                    price =    199700;
                }else if(gg_=="5.0"){
                    price =    201300;
                }else if(gg_=="5.1"){
                    price =    202900;
                }else if(gg_=="5.2"){
                    price =    204500;
                }else if(gg_=="5.3"){
                    price =    206000;
                }else if(gg_=="5.4"){
                    price =    207600;
                }else if(gg_=="5.5"){
                    price =    209200;
                }else if(gg_=="5.6"){
                    price =    210800;
                }else if(gg_=="5.7"){
                    price =    212300;
                }else if(gg_=="5.8"){
                    price =    213900;
                }else if(gg_=="5.9"){
                    price =    215500;
                }else if(gg_=="6.0"){
                    price =    217000;
                }else if(gg_=="6.1"){
                    price =    239600;
                }else if(gg_=="6.2"){
                    price =    241200;
                }else if(gg_=="6.3"){
                    price =    242900;
                }else if(gg_=="6.4"){
                    price =    244500;
                }else if(gg_=="6.5"){
                    price =    246100;
                }else if(gg_=="6.6"){
                    price =    247700;
                }else if(gg_=="6.7"){
                    price =    249300;
                }else if(gg_=="6.8"){
                    price =    250900;
                }else if(gg_=="6.9"){
                    price =    252500;
                }else if(gg_=="7.0"){
                    price =    254100;
                }else if(gg_=="7.1"){
                    price =    255700;
                }else if(gg_=="7.2"){
                    price =    257300;
                }else if(gg_=="7.3"){
                    price =    259000;
                }else if(gg_=="7.4"){
                    price =    260600;
                }else if(gg_=="7.5"){
                    price =    262200;
                }
            }
        }
        $("#PRICE_TEMP").val(price);
        $("#PRICE").val(price);
    }

    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#DNP9300_SL").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=dnp9300&DNP9300_SL="+sl_,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }


    //调用参考价时重新计算
    function cbjPrice(){
        //基础项
        editBase('BASE_AZHJ');
        editBase('BASE_FSGD');
        editBase('BASE_ZJZCSL');
        editBase('BASE_SDJC');
        editBase('BASE_XDJC');
        editBase('BASE_JHXT');
        //部件参数
        editPart('PART_FSDGCZ');
        editPart('PART_FSDYS');
        editPart('PART_WQBCZ');
        editPart('PART_NWGBCZ');
        editPart('PART_SCTBJHDGB');
        editPart('PART_SCB');
        editPart('PART_QDFS');
        //选配项
        editOpt('OPT_AQZDQ');
        editOpt('OPT_JTLXD');
        editOpt('OPT_ZDJY');
        editOpt('OPT_LEDWQZM');
        editOpt('OPT_TJFTBH');
        editOpt('OPT_ZDWQJXKG');
        editOpt('OPT_SCZM');
        editOpt('OPT_WXHL');
        editOpt('OPT_FPZZ');
        editOpt('OPT_HJFDDS');
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
        var qxjd_ = $("#BZ_QXJD").val();
        if(qxjd_=="35"){
            var appendStr = "<option value=''>请选择</option><option value='3.0'>3.0</option><option value='3.1'>3.1</option><option value='3.2'>3.2</option><option value='3.3'>3.3</option><option value='3.4'>3.4</option><option value='3.5'>3.5</option><option value='3.6'>3.6</option><option value='3.7'>3.7</option><option value='3.8'>3.8</option><option value='3.9'>3.9</option><option value='4.0'>4.0</option><option value='4.1'>4.1</option><option value='4.2'>4.2</option><option value='4.3'>4.3</option><option value='4.4'>4.4</option><option value='4.5'>4.5</option><option value='4.6'>4.6</option><option value='4.7'>4.7</option><option value='4.8'>4.8</option><option value='4.9'>4.9</option><option value='5.0'>5.0</option><option value='5.1'>5.1</option><option value='5.2'>5.2</option><option value='5.3'>5.3</option><option value='5.4'>5.4</option><option value='5.5'>5.5</option><option value='5.6'>5.6</option><option value='5.7'>5.7</option><option value='5.8'>5.8</option><option value='5.9'>5.9</option><option value='6.0'>6.0</option>";
            $("#BZ_GG").empty();
            $("#BZ_GG").append(appendStr);
        }else if(qxjd_=="30"){
            var appendStr = "<option value=''>请选择</option><option value='3.0'>3.0</option><option value='3.1'>3.1</option><option value='3.2'>3.2</option><option value='3.3'>3.3</option><option value='3.4'>3.4</option><option value='3.5'>3.5</option><option value='3.6'>3.6</option><option value='3.7'>3.7</option><option value='3.8'>3.8</option><option value='3.9'>3.9</option><option value='4.0'>4.0</option><option value='4.1'>4.1</option><option value='4.2'>4.2</option><option value='4.3'>4.3</option><option value='4.4'>4.4</option><option value='4.5'>4.5</option><option value='4.6'>4.6</option><option value='4.7'>4.7</option><option value='4.8'>4.8</option><option value='4.9'>4.9</option><option value='5.0'>5.0</option><option value='5.1'>5.1</option><option value='5.2'>5.2</option><option value='5.3'>5.3</option><option value='5.4'>5.4</option><option value='5.5'>5.5</option><option value='5.6'>5.6</option><option value='5.7'>5.7</option><option value='5.8'>5.8</option><option value='5.9'>5.9</option><option value='6.0'>6.0</option><option value='6.1'>6.1</option><option value='6.2'>6.2</option><option value='6.3'>6.3</option><option value='6.4'>6.4</option><option value='6.5'>6.5</option><option value='6.6'>6.6</option><option value='6.7'>6.7</option><option value='6.8'>6.8</option><option value='6.9'>6.9</option><option value='7.0'>7.0</option><option value='7.1'>7.1</option><option value='7.2'>7.2</option><option value='7.3'>7.3</option><option value='7.4'>7.4</option><option value='7.5'>7.5</option>";
            $("#BZ_GG").empty();
            $("#BZ_GG").append(appendStr);
        }
    }


    function countZhj(){
        var sbj_count = 0;

        var base_azhj_temp = $("#BASE_AZHJ_TEMP").val()==""?0:parseInt($("#BASE_AZHJ_TEMP").val());
        var base_fsgd_temp = $("#BASE_FSGD_TEMP").val()==""?0:parseInt($("#BASE_FSGD_TEMP").val());
        var base_zjzcsl_temp = $("#BASE_ZJZCSL_TEMP").val()==""?0:parseInt($("#BASE_ZJZCSL_TEMP").val());
        var base_sdjc_temp = $("#BASE_SDJC_TEMP").val()==""?0:parseInt($("#BASE_SDJC_TEMP").val());
        var base_xdjc_temp = $("#BASE_XDJC_TEMP").val()==""?0:parseInt($("#BASE_XDJC_TEMP").val());

        var part_fsdgcz_temp = $("#PART_FSDGCZ_TEMP").val()==""?0:parseInt($("#PART_FSDGCZ_TEMP").val());
        var part_fsdys_temp = $("#PART_FSDYS_TEMP").val()==""?0:parseInt($("#PART_FSDYS_TEMP").val());
        var part_wqbcz_temp = $("#PART_WQBCZ_TEMP").val()==""?0:parseInt($("#PART_WQBCZ_TEMP").val());
        var part_nwgbcz_temp = $("#PART_NWGBCZ_TEMP").val()==""?0:parseInt($("#PART_NWGBCZ_TEMP").val());
        var part_scb_temp = $("#PART_SCB_TEMP").val()==""?0:parseInt($("#PART_SCB_TEMP").val());
        var part_qdfs_temp = $("#PART_QDFS_TEMP").val()==""?0:parseInt($("#PART_QDFS_TEMP").val());

        var opt_aqzdq_temp = $("#OPT_AQZDQ_TEMP").val()==""?0:parseInt($("#OPT_AQZDQ_TEMP").val());
        var opt_jtlxd_temp = $("#OPT_JTLXD_TEMP").val()==""?0:parseInt($("#OPT_JTLXD_TEMP").val());
        var opt_zdjy_temp = $("#OPT_ZDJY_TEMP").val()==""?0:parseInt($("#OPT_ZDJY_TEMP").val());
        var opt_ledwqzm_temp = $("#OPT_LEDWQZM_TEMP").val()==""?0:parseInt($("#OPT_LEDWQZM_TEMP").val());
        var opt_tjftbh_temp = $("#OPT_TJFTBH_TEMP").val()==""?0:parseInt($("#OPT_TJFTBH_TEMP").val());
        var opt_zdwqjxkg_temp = $("#OPT_ZDWQJXKG_TEMP").val()==""?0:parseInt($("#OPT_ZDWQJXKG_TEMP").val());
        var opt_sczm_temp = $("#OPT_SCZM_TEMP").val()==""?0:parseInt($("#OPT_SCZM_TEMP").val());
        var opt_wxhl_temp = $("#OPT_WXHL_TEMP").val()==""?0:parseInt($("#OPT_WXHL_TEMP").val());
        var opt_fpzz_temp = $("#OPT_FPZZ_TEMP").val()==""?0:parseInt($("#OPT_FPZZ_TEMP").val());
        var opt_hjfdds_temp = $("#OPT_HJFDDS_TEMP").val()==""?0:parseInt($("#OPT_HJFDDS_TEMP").val());

        $("#DNP9300_ZHJ").val("0");

        sbj_count = base_azhj_temp+base_fsgd_temp+base_zjzcsl_temp+base_sdjc_temp+base_xdjc_temp+part_fsdgcz_temp+part_fsdys_temp+part_wqbcz_temp+part_nwgbcz_temp+part_scb_temp+part_qdfs_temp+opt_aqzdq_temp+opt_jtlxd_temp+opt_zdjy_temp+opt_ledwqzm_temp+opt_tjftbh_temp+opt_zdwqjxkg_temp+opt_sczm_temp+opt_wxhl_temp+opt_fpzz_temp+opt_hjfdds_temp;
        
        //设备标准价格
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#DNP9300_SBJ").val(sbj_temp+sbj_count);

        //运输费
        var dnp9300_ysf = $("#DNP9300_YSF").val()==""?0:parseInt($("#DNP9300_YSF").val());
        $("#DNP9300_YSF").val(dnp9300_ysf);
        //安装费
        var dnp9300_azf = $("#DNP9300_AZF_TEMP").val()==""?0:parseInt($("#DNP9300_AZF_TEMP").val());
        $("#DNP9300_AZF").val(dnp9300_azf);

        var dnp9300_zk = parseFloat($("#DNP9300_ZK").val())/100;
        if(!isNaN(dnp9300_zk)){
            var dnp9300_sbj = parseInt($("#SBJ_TEMP").val());
            var dnp9300_sjbj = (dnp9300_sbj+sbj_count+dnp9300_azf+dnp9300_ysf)*dnp9300_zk;
            var dnp9300_zhsbj = dnp9300_sbj*dnp9300_zk;
            $("#DNP9300_SJBJ").val(dnp9300_sjbj);
            $("#DNP9300_ZHSBJ").val(dnp9300_zhsbj);
            $("#zk_").text($("#DNP9300_ZK").val()+"%");
        }
    }


    //计算基本参数价格
    function editBase(option){

        var price = 0;
        if(option=="BASE_AZHJ"){
            //安装环境
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var azhj_ = $("#BASE_AZHJ").val();//安装环境
            if(azhj_=="室内"){
                price = 0;
            }else if(azhj_=="半室外配置A"||azhj_=="半室外配置B"){
                price = 2500*(tsgd_/100)+39000;
            }else if(azhj_=="半室外配置C"||azhj_=="半室外配置D"){
                price = 3500*(tsgd_/100)+39000;
            }
            $("#BASE_AZHJ_TEMP").val(price);
        }else if(option=="BASE_FSGD"){
            //扶手高度
            var fsgd_ = $("#BASE_FSGD").val();
            if(fsgd_=="900"){
                price = 0;
            }else if(fsgd_=="1000"){
                var tsgd_ = parseInt($("#BZ_TSGD").val());
                price = 65*(tsgd_/100)+850;
            }
            $("#BASE_FSGD_TEMP").val(price);
        }else if(option=="BASE_ZJZCSL"){
            //中间支撑数量
            var zjzcsl_ = $("#BASE_ZJZCSL").val();
            if(zjzcsl_=="0"){
                price = 0;
            }else{
                price = parseInt(zjzcsl_)*1370;
            }
            $("#BASE_ZJZCSL_TEMP").val(price);
        }else if(option=="BASE_SDJC"){
            //上端加长
            var azhj_ = $("#BASE_AZHJ").val();
            if(azhj_=="室内"){
                price = 370;
            }else{
                price = 450;
            }
            $("#BASE_SDJC_TEMP").val(price);
        }else if(option=="BASE_XDJC"){
            //下端加长
            var azhj_ = $("#BASE_AZHJ").val();
            if(azhj_=="室内"){
                price = 370;
            }else{
                price = 450;
            }
            $("#BASE_XDJC_TEMP").val(price);
        }else if(option=="BASE_JHXT"){
            //交货形态
            var jhxt_ = $("#BASE_JHXT").val();
            if(jhxt_=="整梯"){
                price = 0;
            }else if(jhxt_=="分2段"){
                price = 2730;
            }else if(jhxt_=="分3段"){
                price = 5460;
            }
            $("#BASE_JHXT_TEMP").val(price);
        }

        //计算价格
        countZhj();
    }

    //计算部件参数价格
    function editPart(option){

        var sl_ = parseInt($("#DNP9300_SL").val());

        var price = 0;
        if(option=="PART_FSDGCZ"){
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
        }else if(option=="PART_FSDYS"){
            //扶手带颜色
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var fsdys_ = $("#PART_FSDYS").val();
            if(fsdys_=="黑色"){
                price = 0;
            }else if(fsdys_=="红色"||fsdys_=="蓝色"){
                price = 250*(tsgd_/100)+630;
            }
            $("#PART_FSDYS_TEMP").val(price);
        }else if(option=="PART_WQBCZ"){
            //围裙版材质
            var qxjd_ = $("#BZ_QXJD").val();
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var wqbcz_ = $("#PART_WQBCZ").val();
            var azhj_ = $("#BASE_AZHJ").val();
            if(azhj_=="室内"){
                if(wqbcz_=="发纹不锈钢"){
                    price = 0;
                }else if(wqbcz_=="发纹不锈钢SUS304"){
                    if(qxjd_=="30"){
                        price = 480*(tsgd_/100)+1000;
                    }else if(qxjd_=="35"){
                        price = 660*(tsgd_/100)+1000;
                    }
                }
            }else{
                price = 0;
            }
            $("#PART_WQBCZ_TEMP").val(price);
        }else if(option=="PART_NWGBCZ"){
            //内外盖板材质
            var qxjd_ = $("#BZ_QXJD").val();
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var nwgbcz_ = $("#PART_NWGBCZ").val();
            var azhj_ = $("#BASE_AZHJ").val();
            if(azhj_=="室内"){
                if(nwgbcz_=="发纹不锈钢"){
                    price = 0;
                }else if(nwgbcz_=="发纹不锈钢SUS304"){
                    if(qxjd_=="30"){
                        price = 360*(tsgd_/100)+1000;
                    }else if(qxjd_=="35"){
                        price = 300*(tsgd_/100)+1000;
                    }
                }
            }else{
                price = 0;
            }
            $("#PART_NWGBCZ_TEMP").val(price);
        }else if(option=="PART_SCTBJHDGB"){
            //梳齿踏板及活动盖板
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var sctbjhdgb_ = $("#PART_SCTBJHDGB").val();
            var azhj_ = $("#BASE_AZHJ").val();
            if(azhj_=="室内"){
                if(sctbjhdgb_=="铝合金防滑条纹"){
                    price = 8000;
                }else{
                    price = 0;
                }
            }else{
                price = 0;
            }
            $("#PART_SCTBJHDGB_TEMP").val(price);
        }else if(option=="PART_SCB"){
            //梳齿板
            var scb_ = $("#PART_SCB").val();
            if(scb_=="PVC黄色"){
                price = 0;
            }else{
                price = 250;
            }
            $("#PART_SCB_TEMP").val(price);
        }else if(option=="PART_QDFS"){
            //启动方式
            var qdfs_ = $("#PART_QDFS").val();
            if(qdfs_=="变频,快、慢节能运行"){
                price = 0;
            }else if(qdfs_=="变频,快、慢、停节能运行"){
                price = 4000*sl_;
            }else if(qdfs_=="Y-△,正常运行"){
                price = -2000*sl_;
            }
            $("#PART_QDFS_TEMP").val(price);
        }
        //计算价格
        countZhj();
    }

    //计算选配价格
    function editOpt(option){

        var sl_ = parseInt($("#DNP9300_SL").val());

        if(option=="OPT_AQZDQ"){
            //安全制动器
            if($("#OPT_AQZDQ_TEXT").is(":checked")){
                var tsgd_ = parseInt($("#BZ_TSGD").val());
                var azhj_ = $("#BASE_AZHJ").val();
                if(tsgd_>=6000){
                    price = 0;
                }else{
                    if(azhj_=="室内"){
                        price = 7090*sl_;
                    }else{
                        price = 7630*sl_;
                    }
                }
            }else{
                price = 0;
            }
            $("#OPT_AQZDQ_TEMP").val(price);
        }else if(option=="OPT_JTLXD"){
            //交通流向灯
            if($("#OPT_JTLXD_TEXT").is(":checked")){
                var qdfs_ = $("#PART_QDFS").val();
                if(qdfs_=="变频,快、慢、停节能运行"){
                    price = 1640*sl_;
                }else{
                    price = 0;
                }
            }else{
                price = 0;
            }
            $("#OPT_JTLXD_TEMP").val(price);
        }else if(option=="OPT_ZDJY"){
            //自动加油
            if($("#OPT_ZDJY_TEXT").is(":checked")){
                var azhj_ = $("#BASE_AZHJ").val();
                if(azhj_=="室内"){
                    price = 2270*sl_;
                }else{
                    price = 0;
                }
            }else{
                price = 0;
            }
            $("#OPT_ZDJY_TEMP").val(price);
        }else if(option=="OPT_LEDWQZM"){
            //LED围裙照明
            if($("#OPT_LEDWQZM_TEXT").is(":checked")){
                var tsgd_ = parseInt($("#BZ_TSGD").val());
                price = 1090*(tsgd_/100)+1150;
            }else{
                price = 0;
            }
            $("#OPT_LEDWQZM_TEMP").val(price);
        }else if(option=="OPT_TJFTBH"){
            //梯级防跳保护
            if($("#OPT_TJFTBH_TEXT").is(":checked")){
                price = 500*sl_;
            }else{
                price = 0;
            }
            $("#OPT_TJFTBH_TEMP").val(price);
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
            price = 2730*hjfdds_;
            $("#OPT_HJFDDS_TEMP").val(price);
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
                        $("#DNP9300_YSF").val(transPrice);
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
                        $("#DNP9300_YSF").val(transPrice);
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

        //设置checkbox选中
        if($("#OPT_AQZDQ_TEXT").is(":checked")){
            $("#OPT_AQZDQ").val("1");
        }else{
            $("#OPT_AQZDQ").val("0");
        }
        if($("#OPT_GCD_TEXT").is(":checked")){
            $("#OPT_GCD").val("1");
        }else{
            $("#OPT_GCD").val("0");
        }
        if($("#OPT_GZXS_TEXT").is(":checked")){
            $("#OPT_GZXS").val("1");
        }else{
            $("#OPT_GZXS").val("0");
        }
        if($("#OPT_JTLXD_TEXT").is(":checked")){
            $("#OPT_JTLXD").val("1");
        }else{
            $("#OPT_JTLXD").val("0");
        }
        if($("#OPT_ZDQMSJK_TEXT").is(":checked")){
            $("#OPT_ZDQMSJK").val("1");
        }else{
            $("#OPT_ZDQMSJK").val("0");
        }
        if($("#OPT_ZDJY_TEXT").is(":checked")){
            $("#OPT_ZDJY").val("1");
        }else{
            $("#OPT_ZDJY").val("0");
        }
        if($("#OPT_QDLLZ_TEXT").is(":checked")){
            $("#OPT_QDLLZ").val("1");
        }else{
            $("#OPT_QDLLZ").val("0");
        }
        if($("#OPT_LEDWQZM_TEXT").is(":checked")){
            $("#OPT_LEDWQZM").val("1");
        }else{
            $("#OPT_LEDWQZM").val("0");
        }
        if($("#OPT_TJFTBH_TEXT").is(":checked")){
            $("#OPT_TJFTBH").val("1");
        }else{
            $("#OPT_TJFTBH").val("0");
        }
        if($("#OPT_WQAQZZ_TEXT").is(":checked")){
            $("#OPT_WQAQZZ").val("1");
        }else{
            $("#OPT_WQAQZZ").val("0");
        }
        if($("#OPT_FSDDDBHZZ_TEXT").is(":checked")){
            $("#OPT_FSDDDBHZZ").val("1");
        }else{
            $("#OPT_FSDDDBHZZ").val("0");
        }
        if($("#OPT_ZDWQJXKG_TEXT").is(":checked")){
            $("#OPT_ZDWQJXKG").val("1");
        }else{
            $("#OPT_ZDWQJXKG").val("0");
        }
        if($("#OPT_SCZM_TEXT").is(":checked")){
            $("#OPT_SCZM").val("1");
        }else{
            $("#OPT_SCZM").val("0");
        }
        if($("#OPT_FSZM_TEXT").is(":checked")){
            $("#OPT_FSZM").val("1");
        }else{
            $("#OPT_FSZM").val("0");
        }
        if($("#OPT_DLFDLJQ_TEXT").is(":checked")){
            $("#OPT_DLFDLJQ").val("1");
        }else{
            $("#OPT_DLFDLJQ").val("0");
        }
        if($("#OPT_YSFLQ_TEXT").is(":checked")){
            $("#OPT_YSFLQ").val("1");
        }else{
            $("#OPT_YSFLQ").val("0");
        }
        if($("#OPT_FHBH_TEXT").is(":checked")){
            $("#OPT_FHBH").val("1");
        }else{
            $("#OPT_FHBH").val("0");
        }
        if($("#OPT_TJLFHZ_TEXT").is(":checked")){
            $("#OPT_TJLFHZ").val("1");
        }else{
            $("#OPT_TJLFHZ").val("0");
        }
        if($("#OPT_DZGSS_TEXT").is(":checked")){
            $("#OPT_DZGSS").val("1");
        }else{
            $("#OPT_DZGSS").val("0");
        }
        if($("#OPT_FPZZ_TEXT").is(":checked")){
            $("#OPT_FPZZ").val("1");
        }else{
            $("#OPT_FPZZ").val("0");
        }
        if($("#OPT_HJJR_TEXT").is(":checked")){
            $("#OPT_HJJR").val("1");
        }else{
            $("#OPT_HJJR").val("0");
        }
        if($("#OPT_SCJR_TEXT").is(":checked")){
            $("#OPT_SCJR").val("1");
        }else{
            $("#OPT_SCJR").val("0");
        }
        if($("#OPT_FSJR_TEXT").is(":checked")){
            $("#OPT_FSJR").val("1");
        }else{
            $("#OPT_FSJR").val("0");
        }

        $("#dnp9300Form").submit();
    }
</script>
</body>

</html>
