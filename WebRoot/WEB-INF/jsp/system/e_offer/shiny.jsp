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
    <div id="zhjView" class="animated fadeIn"></div>
    <form action="e_offer/${msg}.do" name="shinyForm" id="shinyForm" method="post">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="SHINY_ID" id="SHINY_ID" value="${pd.SHINY_ID}">
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
                                        <input type="button" value="装潢价格" onclick="selZhj();" class="btn-sm btn-success">
                                        <input type="button" value="调用参考报价" onclick="selCbj();" class="btn-sm btn-success">
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>梯种</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="tz_" name="tz_">
                                                <option value="曳引货梯">曳引货梯</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()">
                                                <option value="1000" ${regelevStandardPd.ZZ=='1000'?'selected':''}>1000</option>
                                                <option value="2000" ${regelevStandardPd.ZZ=='2000'?'selected':''}>2000</option>
                                                <option value="3000" ${regelevStandardPd.ZZ=='3000'?'selected':''}>3000</option>
                                                <option value="4000" ${regelevStandardPd.ZZ=='4000'?'selected':''}>4000</option>
                                                <option value="5000" ${regelevStandardPd.ZZ=='5000'?'selected':''}>5000</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">速度(m/s):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_SD" name="BZ_SD" onchange="editSd();">
                                                <option value="0.25" ${regelevStandardPd.SD=='0.25'?'selected':''}>0.25</option>
                                                <option value="0.5" ${regelevStandardPd.SD=='0.5'?'selected':''}>0.5</option>
                                                <option value="1.0" ${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_KMXS" name="BZ_KMXS">
                                                <option value="中分双折" ${regelevStandardPd.KMXS=='中分双折'?'selected':''}>中分双折</option>
                                                <option value="旁开" ${regelevStandardPd.KMXS=='旁开'?'selected':''}>旁开</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_KMKD" name="BZ_KMKD" onchange="setMPrice();">
                                                <option value="1400" ${regelevStandardPd.KMXS=='1400'?'selected':''}>1400</option>
                                                <option value="1500" ${regelevStandardPd.KMXS=='1500'?'selected':''}>1500</option>
                                                <option value="1700" ${regelevStandardPd.KMXS=='1700'?'selected':''}>1700</option>
                                                <option value="2000" ${regelevStandardPd.KMXS=='2000'?'selected':''}>2000</option>
                                                <option value="2200" ${regelevStandardPd.KMXS=='2200'?'selected':''}>2200</option>
                                            </select>
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">层站门:</label>
                                            <select class="form-control m-b" style="width:7%" name="BZ_C" id="BZ_C" onchange="editC();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="BZ_Z" id="BZ_Z" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="BZ_M" id="BZ_M" onchange="setMPrice();">
                                                <option value="">请选择</option>
                                            </select>
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:5%;margin-top: 25px;margin-bottom: 10px">数量:</label>
                                            <label style="width:20%;margin-left:57px"><input type="text" class="form-control m-b" id="SHINY_SL" name="SHINY_SL" value="${pd.SHINY_SL}" readonly="readonly"></label>

                                            <label style="width:9%;margin-top: 25px;margin-bottom: 10px;margin-left: 20px">折扣申请:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="SHINY_ZK" name="SHINY_ZK" value="${pd.SHINY_ZK}" onkeyup="countZhj();"></label>%
                                            <!-- <select  class="form-control m-b" id="SHINY_ZK" name="SHINY_ZK" onchange="countZhj();">
                                                <option value="1">请选择折扣</option>
                                                <option value="0.9" ${pd.SHINY_ZK=='0.9'?'selected':''}>90%</option>
                                                <option value="0.6" ${pd.SHINY_ZK=='0.6'?'selected':''}>60%</option>
                                                <option value="0.5" ${pd.SHINY_ZK=='0.5'?'selected':''}>50%</option>
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
                                                    <td>${pd.SHINY_SL}</td>
                                                    <td>
                                                        ${regelevStandardPd.C}
                                                        /
                                                        ${regelevStandardPd.Z}
                                                        /
                                                        ${regelevStandardPd.M}
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="SHINY_ZHJ" id="SHINY_ZHJ" value="${pd.SHINY_ZHJ}"></td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="SHINY_SBJ" id="SHINY_SBJ" value="${regelevStandardPd.PRICE}">
                                                    <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}">
                                                    </td>
                                                    <td><font color="red"><span id="zk_">${pd.SHINY_ZK}</span></font></td>
                                                    <td><font color="red"><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="SHINY_ZHSBJ" id="SHINY_ZHSBJ" value="${pd.SHINY_ZHSBJ}"></font></td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" name="SHINY_AZF" id="SHINY_AZF" value="${pd.SHINY_AZF}"  style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' onkeyup="countZhj();" />
                                                        </font>
                                                    </td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="SHINY_YSF" id="SHINY_YSF" value="${pd.SHINY_YSF}">
                                                        </font>
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="SHINY_SJBJ" id="SHINY_SJBJ" value="${pd.SHINY_SJBJ}"></td>
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="form-group form-inline">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#tab-1" class="active">基本参数</a></li> 
                                                <li class=""><a data-toggle="tab" href="#tab-2">标准功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-3">可选功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-4">单组监控室对讲系统</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-5">轿厢装潢</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-6">厅门门套</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-7">操纵盘</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-8">厅门信号装置</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-9">非标</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <!-- 基本参数 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td width="173">控制系统</td>
                                                            <td colspan="2">
                                                                <select name="BASE_KZXT" id="BASE_KZXT" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="交流变频调速微机控制" ${pd.BASE_KZXT=='交流变频调速微机控制'?'selected':''}>交流变频调速微机控制</option>
                                                                </select>
                                                            </td>
                                                            <td width="180">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>控制方式</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_KZFS" value="单台运转(G1C)" ${pd.BASE_KZFS=='单台运转(G1C)'?'checked':''}/>
                                                                单台运转(G1C)
                                                                <input type="radio" name="BASE_KZFS" value="两台联动(G2C)" ${pd.BASE_KZFS=='两台联动(G2C)'?'checked':''}/>
                                                                两台联动(G2C)
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="173">曳引主机</td>
                                                            <td colspan="2">
                                                                <select name="BASE_YYZJ" id="BASE_YYZJ" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="蜗轮蜗杆曳引机" ${pd.BASE_YYZJ=='蜗轮蜗杆曳引机'?'selected':''}>蜗轮蜗杆曳引机</option>
                                                                </select>
                                                            </td>
                                                            <td width="180"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>圈/钢梁间距</td>
                                                            <td colspan="2">
                                                                <input type="text" name="BASE_QGLJJ" id="BASE_QGLJJ" class="form-control" value="${pd.BASE_QGLJJ}"/>mm </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢规格CW*CD(mm)</td>
                                                            <td colspan="2">
                                                                <select name="BASE_JXGG" id="BASE_JXGG" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="1400×1600(1000kg)" ${pd.BASE_JXGG=='1400×1600(1000kg)'?'selected':''}>1400×1600(1000kg)</option>
                                                                    <option value="1700×2400(2000kg)" ${pd.BASE_JXGG=='1700×2400(2000kg)'?'selected':''}>1700×2400(2000kg)</option>
                                                                    <option value="2000×2800(3000kg)" ${pd.BASE_JXGG=='2000×2800(3000kg)'?'selected':''}>2000×2800(3000kg)</option>
                                                                    <option value="2000×3600(4000kg)" ${pd.BASE_JXGG=='2000×3600(4000kg)'?'selected':''}>2000×3600(4000kg)</option>
                                                                    <option value="2600×3400(5000kg)" ${pd.BASE_JXGG=='2600×3400(5000kg)'?'selected':''}>2600×3400(5000kg)</option>
                                                                </select>   
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢高度(非净高)</td>
                                                            <td>
                                                                <input type="radio" name="BASE_JXGD" value="2100" ${pd.BASE_JXGD=='2100'?'checked':''}/>2100mm
                                                                <input type="radio" name="BASE_JXGD" value="2200" ${pd.BASE_JXGD=='2200'?'checked':''}/>2200mm
                                                                <input type="radio" name="BASE_JXGD" value="2300" ${pd.BASE_JXGD=='2300'?'checked':''}/>2300mm
                                                                <input type="radio" name="BASE_JXGD" value="2400" ${pd.BASE_JXGD=='2400'?'checked':''}/>2400mm
                                                            </td>
                                                            <td rowspan="2">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>号梯代码</td>
                                                            <td>
                                                                <input type="text" name="BASE_HTDM" id="BASE_HTDM" class="form-control" value="${pd.BASE_HTDM}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>门机型号</td>
                                                            <td>
                                                                <select name="BASE_MJXH" id="BASE_MJXH">
                                                                    <option value="">请选择</option>
                                                                    <option value="变频门机" ${pd.BASE_MJXH=='变频门机'?'selected':''}>变频门机</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>门保护方式</td>
                                                            <td>
                                                                <select name="BASE_MBHFS" id="BASE_MBHFS">
                                                                    <option value="">请选择</option>
                                                                    <option value="2D光幕保护" ${pd.BASE_MBHFS=='2D光幕保护'?'selected':''}>2D光幕保护</option>
                                                                    <option value="进口光幕" ${pd.BASE_MBHFS=='进口光幕'?'selected':''}>进口光幕</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道结构</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_JDJG" value="全混凝土" ${pd.BASE_JDJG=='全混凝土'?'checked':''}/>
                                                                全混凝土
                                                                <input type="radio" name="BASE_JDJG" value="框架结构(圈梁)" ${pd.BASE_JDJG=='框架结构(圈梁)'?'checked':''}/>
                                                                框架结构(圈梁)
                                                                <input type="radio" name="BASE_JDJG" value="钢结构" ${pd.BASE_JDJG=='钢结构'?'checked':''}/>
                                                                钢结构
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道承重墙厚度</td>
                                                            <td width="317">
                                                                <input type="radio" name="BASE_JDCZQHD" value="250"  ${pd.BASE_JDCZQHD=='250'?'checked':''}/>
                                                                WT=250mm
                                                            </td>
                                                            <td width="424">
                                                                <input type="radio" name="BASE_JDCZQHD" value=""  ${pd.BASE_JDCZQHD=='250'?'':'checked'}/>
                                                                WT=
                                                                <input name="BASE_JDCZQHD_TEXT" id="BASE_JDCZQHD_TEXT" type="text" class="form-control" value="${pd.BASE_JDCZQHD=='250'?'':pd.BASE_JDCZQHD}"/>
                                                                mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道尺寸HW*HD</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDK" id="BASE_JDK" type="text" class="form-control" style="width: 10%" value="${pd.BASE_JDK}"/>
                                                                mm宽×
                                                                <input name="BASE_JDS" id="BASE_JDS" type="text" class="form-control" style="width: 10%" value="${pd.BASE_JDS}"/>
                                                                mm深
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>提升高度RISE</td>
                                                            <td>
                                                                <input name="BASE_TSGD" id="BASE_TSGD" type="text" onkeyup="setJdzg();" class="form-control"  value="${pd.BASE_TSGD}"/>mm
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>底坑S顶层K</td>
                                                            <td colspan="2">
                                                                <p>
                                                                    底坑深度:
                                                                    <input name="BASE_DKSD" id="BASE_DKSD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DKSD}"/>mm
                                                                </p>
                                                                <p>
                                                                    顶层高度:
                                                                    <input name="BASE_DCGD" id="BASE_DCGD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DCGD}"/>mm    
                                                                </p>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道总高</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDZG" id="BASE_JDZG" type="text" class="form-control" value="${pd.BASE_JDZG}"/>
                                                            </td>
                                                            <td>
                                                                <input type="text" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP" >
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>基站驻停</td>
                                                            <td colspan="2">
                                                                在
                                                                <input name="BASE_JZZT" type="text" class="form-control" value="${pd.BASE_JZZT}"/>
                                                                层
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼层标记</td>
                                                            <td colspan="2">
                                                                <input name="BASE_LCBJ" type="text" class="form-control" value="${pd.BASE_LCBJ}"/>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>导轨支架</td>
                                                            <td colspan="2">
                                                                <input name="BASE_DGZJ" id="BASE_DGZJ" type="text" class="form-control" value="${pd.BASE_DGZJ}" onkeyup="setDgzj();" />
                                                            </td>
                                                            <td>
                                                                <input type="text" name="BASE_DGZJ_TEMP" id="BASE_DGZJ_TEMP" >
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="4">标准功能及代码</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="62">1</td>
                                                            <td width="224">无呼自返基站功能(LOBBY)</td>
                                                            <td width="42">14</td>
                                                            <td width="241">设置厅、轿门时间(CHT)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>关门时间保护(DTP)</td>
                                                            <td>15</td>
                                                            <td>开、关门按钮(DOB&DCB)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>紧急消防操作(EFO)</td>
                                                            <td>16</td>
                                                            <td>轿内紧急照明(ECU)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>全集选控制(FCL)</td>
                                                            <td>17</td>
                                                            <td>厅和轿厢数字式位置指示器(HPI&CPI)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>厅和轿厢呼梯/登记(HTTL&CTTL)</td>
                                                            <td>18</td>
                                                            <td>厅及轿厢运行方向显示(HDI&CDI)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>监控室与机房、轿厢对讲（不含机房到监控室连线）(ICU-5)</td>
                                                            <td>19</td>
                                                            <td>独立服务(ISC)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>满载不停梯(LNS)</td>
                                                            <td>20</td>
                                                            <td>超载不启动(警示灯及蜂鸣器)(OLD)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>运行次数显示功能(TRIC)</td>
                                                            <td>21</td>
                                                            <td>轿顶与机房紧急电动运行</td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>轿内通风手动及照明自动控制功能</td>
                                                            <td>22</td>
                                                            <td>故障自动检测功能</td>
                                                          </tr>
                                                          <tr>
                                                            <td>10</td>
                                                            <td>警铃</td>
                                                            <td>23</td>
                                                            <td>光幕门保护装置 </td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>误登陆取消</td>
                                                            <td>24</td>
                                                            <td>驻停</td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>门保持按钮</td>
                                                            <td>25</td>
                                                            <td></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <!-- 可选功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>有</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>1</td>
                                                            <td>机房高台<=2000mm</td>
                                                            <td>
                                                                <input name="OPT_JFGT_TEXT" id="OPT_JFGT_TEXT" type="checkbox" onclick="editOpt('OPT_JFGT');" ${pd.OPT_JFGT=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JFGT" id="OPT_JFGT">
                                                            </td>
                                                            <td><input type="text" name="OPT_JFGT_TEMP" id="OPT_JFGT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>COP</td>
                                                            <td>
                                                                <select name="OPT_COP" id="OPT_COP" onchange="editOpt('OPT_COP');">
                                                                    <option value="">请选择</option>
                                                                    <option value="JFHB06H-E" ${pd.OPT_COP=='JFHB06H-E'?'selected':''}>JFHB06H-E</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_COP_TEMP" id="OPT_COP_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>外召与COP盲文按钮（只）</td>
                                                            <td>
                                                                <input name="OPT_WZYCOPMWAN" id="OPT_WZYCOPMWAN" type="text" onkeyup="editOpt('OPT_WZYCOPMWAN');"  value="${pd.OPT_WZYCOPMWAN}"/>
                                                            </td>
                                                            <td><input type="text" name="OPT_WZYCOPMWAN_TEMP" id="OPT_WZYCOPMWAN_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>挂壁式残疾人操纵箱COP</td>
                                                            <td>
                                                                <input name="OPT_GBSCJRCZXCOP_TEXT" id="OPT_GBSCJRCZXCOP_TEXT" type="checkbox" onclick="editOpt('OPT_GBSCJRCZXCOP');"  ${pd.OPT_GBSCJRCZXCOP=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GBSCJRCZXCOP" id="OPT_GBSCJRCZXCOP">
                                                            </td>
                                                            <td><input type="text" name="OPT_GBSCJRCZXCOP_TEMP" id="OPT_GBSCJRCZXCOP_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>LOP（个）</td>
                                                            <td>
                                                                <input name="OPT_LOP" id="OPT_LOP" type="text" onkeyup="editOpt('OPT_LOP');"  value="${pd.OPT_LOP}"/>
                                                            </td>
                                                            <td><input type="text" name="OPT_LOP_TEMP" id="OPT_LOP_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>防捣乱操作</td>
                                                            <td>
                                                                <input name="OPT_FDLCZ_TEXT" id="OPT_FDLCZ_TEXT" type="checkbox" onclick="editOpt('OPT_FDLCZ');"  ${pd.OPT_FDLCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_FDLCZ" id="OPT_FDLCZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FDLCZ_TEMP" id="OPT_FDLCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>停电应急救援</td>
                                                            <td>
                                                                <input name="OPT_TDJJJY_TEXT" id="OPT_TDJJJY_TEXT" type="checkbox" onclick="editOpt('OPT_TDJJJY');"  ${pd.OPT_TDJJJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TDJJJY" id="OPT_TDJJJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_TDJJJY_TEMP" id="OPT_TDJJJY_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>有司机操作</td>
                                                            <td>
                                                                <input name="OPT_YSJCZ_TEXT" id="OPT_YSJCZ_TEXT" type="checkbox" onclick="editOpt('OPT_YSJCZ');"  ${pd.OPT_YSJCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YSJCZ" id="OPT_YSJCZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YSJCZ_TEMP" id="OPT_YSJCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>CCTV电缆（轿厢到机房）(m)</td>
                                                            <td>
                                                                <input name="OPT_CCTVDL" id="OPT_CCTVDL" type="text" onkeyup="editOpt('OPT_CCTVDL');"  value="${pd.OPT_CCTVDL}"/>
                                                            </td>
                                                            <td><input type="text" name="OPT_CCTVDL_TEMP" id="OPT_CCTVDL_TEMP" class="form-control"></td>
                                                          </tr><tr>
                                                            <td>10</td>
                                                            <td>紧急备用电源操作装置</td>
                                                            <td>
                                                                <input name="OPT_JJBYDYCZZZ_TEXT" id="OPT_JJBYDYCZZZ_TEXT" type="checkbox" onclick="editOpt('OPT_JJBYDYCZZZ');"  ${pd.OPT_JJBYDYCZZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JJBYDYCZZZ" id="OPT_JJBYDYCZZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JJBYDYCZZZ_TEMP" id="OPT_JJBYDYCZZZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>轿厢到站钟</td>
                                                            <td>
                                                                <input name="OPT_JXDZZ_TEXT" id="OPT_JXDZZ_TEXT" type="checkbox" onclick="editOpt('OPT_JXDZZ');"  ${pd.OPT_JXDZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JXDZZ" id="OPT_JXDZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JXDZZ_TEMP" id="OPT_JXDZZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>再平层</td>
                                                            <td>
                                                                <input name="OPT_ZPC_TEXT" id="OPT_ZPC_TEXT" type="checkbox" onclick="editOpt('OPT_ZPC');"  ${pd.OPT_ZPC=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ZPC" id="OPT_ZPC">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZPC_TEMP" id="OPT_ZPC_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>13</td>
                                                            <td>远程监视接口准备</td>
                                                            <td>
                                                                <input name="OPT_YCJSJKZB_TEXT" id="OPT_YCJSJKZB_TEXT" type="checkbox" onclick="editOpt('OPT_YCJSJKZB');"  ${pd.OPT_YCJSJKZB=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YCJSJKZB" id="OPT_YCJSJKZB">
                                                            </td>
                                                            <td><input type="text" name="OPT_YCJSJKZB_TEMP" id="OPT_YCJSJKZB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>14</td>
                                                            <td>语音报站</td>
                                                            <td>
                                                                <input name="OPT_YYBZ_TEXT" id="OPT_YYBZ_TEXT" type="checkbox" onclick="editOpt('OPT_YYBZ');"  ${pd.OPT_YYBZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YYBZ" id="OPT_YYBZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YYBZ_TEMP" id="OPT_YYBZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>15</td>
                                                            <td>火警自动返回基站</td>
                                                            <td>
                                                                <input name="OPT_HJZDFHJZ_TEXT" id="OPT_HJZDFHJZ_TEXT" type="checkbox" onclick="editOpt('OPT_HJZDFHJZ');" ${pd.OPT_HJZDFHJZ=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_HJZDFHJZ" id="OPT_HJZDFHJZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJZDFHJZ_TEMP" id="OPT_HJZDFHJZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>16</td>
                                                            <td>BA接口</td>
                                                            <td>
                                                                <input name="OPT_BAJK_TEXT" id="OPT_BAJK_TEXT" type="checkbox" onclick="editOpt('OPT_BAJK');"  ${pd.OPT_BAJK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_BAJK" id="OPT_BAJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_BAJK_TEMP" id="OPT_BAJK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>17</td>
                                                            <td>电机过热保护</td>
                                                            <td>
                                                                <input name="OPT_DJGRBH_TEXT" id="OPT_DJGRBH_TEXT" type="checkbox" onclick="editOpt('OPT_DJGRBH');"  ${pd.OPT_DJGRBH=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DJGRBH" id="OPT_DJGRBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_DJGRBH_TEMP" id="OPT_DJGRBH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>18</td>
                                                            <td>消防联动</td>
                                                            <td>
                                                                <input name="OPT_XFLD_TEXT" id="OPT_XFLD_TEXT" type="checkbox" onclick="editOpt('OPT_XFLD');"  ${pd.OPT_XFLD=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_XFLD" id="OPT_XFLD">
                                                            </td>
                                                            <td><input type="text" name="OPT_XFLD_TEMP" id="OPT_XFLD_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>19</td>
                                                            <td>厅外消防员服务</td>
                                                            <td>
                                                                <input name="OPT_TWXFYFW_TEXT" id="OPT_TWXFYFW_TEXT" type="checkbox" onclick="editOpt('OPT_TWXFYFW');"  ${pd.OPT_TWXFYFW=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TWXFYFW" id="OPT_TWXFYFW">
                                                            </td>
                                                            <td><input type="text" name="OPT_TWXFYFW_TEMP" id="OPT_TWXFYFW_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 可选功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <!-- 单组监控室对讲系统 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td width="197">对讲通讯方式</td>
                                                            <td width="326">
                                                                <select name="DZJKSDJXT_DJTXFS" id="DZJKSDJXT_DJTXFS">
                                                                    <option value="单梯对讲" ${pd.DZJKSDJXT_DJTXFS=='单梯对讲'?'selected':''}>单梯对讲</option>
                                                                    <option value="对讲集中管理(5台以内)" ${pd.DZJKSDJXT_DJTXFS=='对讲集中管理(5台以内)'?'selected':''}>对讲集中管理(5台以内)</option>
                                                                    <option value="对讲集中管理(6~64台)" ${pd.DZJKSDJXT_DJTXFS=='对讲集中管理(6~64台)'?'selected':''}>对讲集中管理(6~64台)</option>
                                                                </select>
                                                            </td>
                                                            <td colspan="2"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>同群组的设备号</td>
                                                            <td colspan="2"><input type="text" name="DZJKSDJXT_TQZDSBH" id="DZJKSDJXT_TQZDSBH" class="form-control" value="${pd.DZJKSDJXT_TQZDSBH}"/></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 单组监控室对讲系统 -->
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <!-- 轿厢装潢 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="2">轿厢装潢</td>
                                                            <td>标准</td>
                                                            <td>可选</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="4">轿厢</td>
                                                            <td>轿门</td>
                                                            <td>
                                                                <input name="JXZH_JM" type="radio" value="发纹不锈钢" onclick="editJxzh('JXZH_JM');" ${pd.JXZH_JM=='发纹不锈钢'?'checked':''} />
                                                                发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_JM" type="radio" value="镜面不锈钢" onclick="editJxzh('JXZH_JM');"  ${pd.JXZH_JM=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_JM" type="radio" value="钢板喷涂" onclick="editJxzh('JXZH_JM');"  ${pd.JXZH_JM=='钢板喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_JMSBH" id="JXZH_JMSBH" class="form-control" onchange="editJxzh('JXZH_JMSBH');">
                                                                    <option value=''>请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_JMSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_JMSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_JMSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_JMSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_JMSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_JMSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_JMSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_JM_TEMP" id="JXZH_JM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>前围壁</td>
                                                            <td>
                                                                <input name="JXZH_QWB" type="radio" value="发纹不锈钢" onclick="editJxzh('JXZH_QWB');"  ${pd.JXZH_QWB=='发纹不锈钢'?'checked':''}/>
                                                                发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_QWB" type="radio" value="镜面不锈钢" onclick="editJxzh('JXZH_QWB');"  ${pd.JXZH_QWB=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_QWB" type="radio" value="钢板喷涂" onclick="editJxzh('JXZH_QWB');"  ${pd.JXZH_QWB=='钢板喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_QWBSBH" id="JXZH_QWBSBH" class="form-control" onchange="editJxzh('JXZH_QWBSBH');">
                                                                    <option value=''>请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_QWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_QWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_QWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_QWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_QWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_QWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_QWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_QWB_TEMP" id="JXZH_QWB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>侧围壁</td>
                                                            <td>
                                                                <input name="JXZH_CWB" type="radio" value="发纹不锈钢" onclick="editJxzh('JXZH_CWB');"  ${pd.JXZH_CWB=='发纹不锈钢'?'selected':''}/>
                                                                发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_CWB" type="radio" value="镜面不锈钢" onclick="editJxzh('JXZH_CWB');"  ${pd.JXZH_CWB=='镜面不锈钢'?'selected':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_CWB" type="radio" value="钢板喷涂" onclick="editJxzh('JXZH_CWB');"  ${pd.JXZH_CWB=='钢板喷涂'?'selected':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_CWBSBH" id="JXZH_CWBSBH" class="form-control" onchange="editJxzh('JXZH_CWBSBH');">
                                                                    <option value=''>请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_CWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_CWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_CWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_CWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_CWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_CWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_CWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_CWB_TEMP" id="JXZH_CWB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>后围壁</td>
                                                            <td>
                                                                <input name="JXZH_HWB" type="radio" value="发纹不锈钢" onclick="editJxzh('JXZH_HWB');" />
                                                                发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_HWB" type="radio" value="镜面不锈钢" onclick="editJxzh('JXZH_HWB');" />
                                                                镜面不锈钢
                                                                <input name="JXZH_HWB" type="radio" value="钢板喷涂" onclick="editJxzh('JXZH_HWB');" />
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_HWBSBH" id="JXZH_HWBSBH" class="form-control" onchange="editJxzh('JXZH_HWBSBH');">
                                                                  <option value=''>请选择</option>
                                                                  <option value="P-01" ${pd.JXZH_HWBSBH=='P-01'?'checked':''}>P-01</option>
                                                                  <option value="P-02" ${pd.JXZH_HWBSBH=='P-02'?'checked':''}>P-02</option>
                                                                  <option value="P-03" ${pd.JXZH_HWBSBH=='P-03'?'checked':''}>P-03</option>
                                                                  <option value="P-04" ${pd.JXZH_HWBSBH=='P-04'?'checked':''}>P-04</option>
                                                                  <option value="P-05" ${pd.JXZH_HWBSBH=='P-05'?'checked':''}>P-05</option>
                                                                  <option value="P-06" ${pd.JXZH_HWBSBH=='P-06'?'checked':''}>P-06</option>
                                                                  <option value="P-07" ${pd.JXZH_HWBSBH=='P-07'?'checked':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_HWB_TEMP" id="JXZH_HWB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">轿顶装潢</td>
                                                            <td>
                                                                <select name="JXZH_JDZH" onchange="editJxzh('JXZH_JDZH');" id="JXZH_JDZH" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="钢板喷涂" ${pd.JXZH_JDZH=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.JXZH_JDZH=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td><input type="text" name="JXZH_JDZH_TEMP" id="JXZH_JDZH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">轿顶安全窗</td>
                                                            <td>
                                                                <select name="JXZH_JDAQC" id="JXZH_JDAQC" onchange="editJxzh('JXZH_JDAQC');">
                                                                    <option value="">请选择</option>
                                                                    <option value="带安全窗(536mm*355mm)" ${pd.JXZH_JDAQC=='带安全窗(536mm*355mm)'?'selected':''}>带安全窗(536mm*355mm)</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板型号</td>
                                                            <td>
                                                                <select name="JXZH_DBXH" id="JXZH_DBXH" onchange="editJxzh('JXZH_DBXH');">
                                                                    <option value="">请选择</option>
                                                                    <option value="普通花纹钢板" ${pd.JXZH_DBXH=='普通花纹钢板'?'selected':''}>普通花纹钢板</option>
                                                                    <option value="不锈钢花纹钢板" ${pd.JXZH_DBXH=='普通花纹钢板'?'selected':''}>不锈钢花纹钢板</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td><input type="text" name="JXZH_DBXH_TEMP" id="JXZH_DBXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板装修厚度mm</td>
                                                            <td><input type="text" name="JXZH_DBZXHD" id="JXZH_DBZXHD" class="form-control" onkeyup="editJxzh('JXZH_DBZXHD');" value="${pd.JXZH_DBZXHD}"></td>
                                                            <td></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">防撞条型号</td>
                                                            <td>
                                                                <select name="JXZH_FZTXH" id="JXZH_FZTXH" onchange="editJxzh('JXZH_FZTXH');">
                                                                    <option value="木条" ${pd.JXZH_FZTXH=='木条'?'selected':''}>木条</option>
                                                                    <option value="橡胶条" ${pd.JXZH_FZTXH=='橡胶条'?'selected':''}>橡胶条</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                            <td><input type="text" name="JXZH_FZTXH_TEMP" id="JXZH_FZTXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">防撞条安装位置</td>
                                                            <td>
                                                                <select name="JXZH_FZTAZWZ" id="JXZH_FZTAZWZ" onchange="editJxzh('JXZH_FZTAZWZ');">
                                                                    <option value="后围壁" ${pd.JXZH_FZTAZWZ=='后围壁'?'selected':''}>后围壁</option>
                                                                    <option value="左围壁" ${pd.JXZH_FZTAZWZ=='左围壁'?'selected':''}>左围壁</option>
                                                                    <option value="右围壁" ${pd.JXZH_FZTAZWZ=='右围壁'?'selected':''}>右围壁</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">半高镜</td>
                                                            <td>
                                                                <input type="checkbox" name="JXZH_BGJ" id="JXZH_BGJ" onclick="editJxzh('JXZH_BGJ');" ${pd.JXZH_BGJ=='1'?'checked':''}>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td><input type="text" name="JXZH_BGJ_TEMP" id="JXZH_BGJ_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 轿厢装潢 -->
                                                </div>
                                                <div id="tab-6" class="tab-pane">
                                                    <!-- 厅门门套 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>首层厅门门套材质（小门框）</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_SCTMMTCZXMK' id="TMMT_SCTMMTCZXMK" onchange="editTmmt('TMMT_SCTMMTCZXMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_SCTMMTCZXMK=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_SCTMMTCZXMK=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_SCTMMTCZXMK=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_SCTMMTCZXMK_TEMP" id="TMMT_SCTMMTCZXMK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层厅门门套材质（小门框）</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_FSCTMMTCZXMK' id="TMMT_FSCTMMTCZXMK" onchange="editTmmt('TMMT_FSCTMMTCZXMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_FSCTMMTCZXMK=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_FSCTMMTCZXMK=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_FSCTMMTCZXMK=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_FSCTMMTCZXMK_TEMP" id="TMMT_FSCTMMTCZXMK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>层站数（非首层）</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_XMKCZS" id="TMMT_XMKCZS" value="${pd.TMMT_XMKCZS}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼名</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_XMKLM" id="TMMT_XMKLM" value="${pd.TMMT_XMKLM}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层厅门门套材质（大门框）</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_SCTMMTCZDMK' id="TMMT_SCTMMTCZDMK" onchange="editTmmt('TMMT_SCTMMTCZDMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_SCTMMTCZDMK=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_SCTMMTCZDMK=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_SCTMMTCZDMK=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_SCTMMTCZDMK_TEMP" id="TMMT_SCTMMTCZDMK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层厅门门套材质（大门框）</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_FSCTMMTCZDMK' id="TMMT_FSCTMMTCZDMK" onchange="editTmmt('TMMT_FSCTMMTCZDMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_FSCTMMTCZDMK=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_FSCTMMTCZDMK=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_FSCTMMTCZDMK=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_FSCTMMTCZDMK_TEMP" id="TMMT_FSCTMMTCZDMK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>层站数（非首层）</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_DMKCZS" id="TMMT_DMKCZS" value="${pd.TMMT_DMKCZS}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼名</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_DMKLM" id="TMMT_DMKLM" value="${pd.TMMT_DMKLM}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>厅门材质</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_TMCZ' id="TMMT_TMCZ" onchange="editTmmt('TMMT_TMCZ');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_TMCZ=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_TMCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_TMCZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_TMCZ_TEMP" id="TMMT_TMCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层厅门材质</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_FSCTMCZ' id="TMMT_FSCTMCZ" onchange="editTmmt('TMMT_FSCTMCZ');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_FSCTMCZ=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_FSCTMCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_FSCTMCZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_FSCTMCZ_TEMP" id="TMMT_FSCTMCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>层站数（非首层）</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_CZS" id="TMMT_CZS" value="${pd.TMMT_CZS}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼名</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_LM" id="TMMT_LM" value="${pd.TMMT_LM}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 厅门门套 -->
                                                </div>
                                                <div id="tab-7" class="tab-pane">
                                                    <!-- 操纵盘 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>操纵盘类型</td>
                                                            <td>--</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>操纵盘型号</td>
                                                            <td>
                                                                <select name="CZP_CZPXH" id="CZP_CZPXH" onchange="editCzp('CZP_CZPXH');">
                                                                    <option value="">请选择</option>
                                                                    <option value="JFCOP05P-E" ${pd.CZP_CZPXH=='JFCOP05P-E'?'selected':''}>JFCOP05P-E</option>
                                                                    <option value="JFCOP06H-E" ${pd.CZP_CZPXH=='JFCOP06H-E'?'selected':''}>JFCOP06H-E</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="CZP_CZPXH_TEMP" id="CZP_CZPXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>操纵盘位置</td>
                                                            <td>
                                                                <select name="CZP_CZPWZ" id="CZP_CZPWZ" onchange="editCzp('CZP_CZPWZ');">
                                                                    <option value="">请选择</option>
                                                                    <option value="右侧围壁(站在轿厢面向轿门)" ${pd.CZP_CZPWZ=='右侧围壁(站在轿厢面向轿门)'?'selected':''}>右侧围壁(站在轿厢面向轿门)</option>
                                                                    <option value="左侧围壁(站在轿厢面向轿门)" ${pd.CZP_CZPWZ=='左侧围壁(站在轿厢面向轿门)'?'selected':''}>左侧围壁(站在轿厢面向轿门)</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="CZP_CZPWZ_TEMP" id="CZP_CZPWZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 操纵盘 -->
                                                </div>
                                                <div id="tab-8" class="tab-pane">
                                                    <!-- 厅门信号装置 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>厅外召唤类型</td>
                                                            <td>--</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>厅外召唤型号</td>
                                                            <td>
                                                                <select name="TMXHZZ_TWZHXH" id="TMXHZZ_TWZHXH" onchange="editTmmt('TMXHZZ_TWZHXH');">
                                                                    <option value="">请选择</option>
                                                                    <option value="JFCOP05P-E" ${pd.TMXHZZ_TWZHXH=='JFCOP05P-E'?'selected':''}>JFCOP05P-E</option>
                                                                    <option value="JFCOP06H-E" ${pd.TMXHZZ_TWZHXH=='JFCOP06H-E'?'selected':''}>JFCOP06H-E</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMXHZZ_TWZHXH_TEMP" id="TMXHZZ_TWZHXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>数量</td>
                                                            <td>
                                                                <input type="text" name="TMXHZZ_SL" id="TMXHZZ_SL" onkeyup="editTmmt('TMXHZZ_SL');" value="${pd.TMXHZZ_SL}">
                                                            </td>
                                                            <td><input type="text" name="TMXHZZ_SL_TEMP" id="TMXHZZ_SL_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>在第几层</td>
                                                            <td>
                                                                <input type="text" name="TMXHZZ_ZDJC" id="TMXHZZ_ZDJC" onkeyup="editTmmt('TMXHZZ_ZDJC');" value="${pd.TMXHZZ_ZDJC}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>附加说明</td>
                                                            <td>
                                                                <input type="text" name="TMXHZZ_FJSM" id="TMXHZZ_FJSM" onkeyup="editTmmt('TMXHZZ_FJSM');" value="${pd.TMXHZZ_FJSM}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 厅门信号装置 -->
                                                </div>
                                                <div id="tab-9" class="tab-pane">
                                                    <!-- 非标 -->
                                                        <table class="table table-striped table-bordered table-hover" id="fbTable">
                                                            <thead>
                                                                <tr>
                                                                    <th style="width:10%;">非标描述</th>
                                                                    <th style="width:10%;">数值</th>
                                                                    <th style="width:10%;">价格</th>
                                                                    <th style="width:10%;">交货期</th>
                                                                    <th style="width:10%;">操作</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="轿厢宽度(mm)"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="添加" onclick="addFbRow();"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="轿厢深度(mm)"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="轿厢高度(mm)"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="开门高度(mm)"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="开门宽度(mm)"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="开门方式"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    <!-- 非标 -->
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
                                            <input type="text" class="form-control" id="SHINY_AZF_TEMP" name="SHINY_AZF_TEMP" onkeyup="countZhj();" value="${pd.SHINY_AZF}">
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
                                            请选择目的地:</label>
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
        editZz();
        editSd();
        $("#BZ_C").val("${regelevStandardPd.C}");
        $("#BZ_Z").val("${regelevStandardPd.Z}");
        $("#BZ_M").val("${regelevStandardPd.M}");
        var FLAG = $("#FLAG").val();
        if(FLAG=="CBJ"||FLAG=="ZHJ"){
            cbjPrice();
        }
        if("${pd.view}"=="edit"){
            cbjPrice();
        }
    });

    //修改层时修改站和门
    function editC(){
        var c_ = $("#BZ_C").val();
        $("#BZ_Z").val(c_);
        $("#BZ_M").val(c_);
        setSbj();
    }

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

    //调用价格时从新计算
    function cbjPrice(){
        //井道总高
        setJdzg();
        //导轨支架
        setDgzj();
        //可选项
        editOpt('OPT_JFGT');
        editOpt('OPT_COP');
        editOpt('OPT_WZYCOPMWAN');
        editOpt('OPT_GBSCJRCZXCOP');
        editOpt('OPT_LOP');
        editOpt('OPT_FDLCZ');
        editOpt('OPT_TDJJJY');
        editOpt('OPT_YSJCZ');
        editOpt('OPT_CCTVDL');
        editOpt('OPT_JJBYDYCZZZ');
        editOpt('OPT_JXDZZ');
        editOpt('OPT_ZPC');
        editOpt('OPT_YCJSJKZB');
        editOpt('OPT_YYBZ');
        editOpt('OPT_HJZDFHJZ');
        editOpt('OPT_BAJK');
        editOpt('OPT_DJGRBH');
        editOpt('OPT_XFLD');
        editOpt('OPT_TWXFYFW');
        //轿厢装潢
        editJxzh('JXZH_JM');
        editJxzh('JXZH_QWB');
        editJxzh('JXZH_CWB');
        editJxzh('JXZH_HWB');
        editJxzh('JXZH_JDZH');
        editJxzh('JXZH_DBXH');
        editJxzh('JXZH_FZTXH');
        editJxzh('JXZH_BGJ');
        //厅门门套
        editTmmt('TMMT_SCTMMTCZXMK');
        editTmmt('TMMT_FSCTMMTCZXMK');
        editTmmt('TMMT_SCTMMTCZDMK');
        editTmmt('TMMT_FSCTMMTCZDMK');
        editTmmt('TMMT_TMCZ');
        editTmmt('TMMT_FSCTMCZ');
        //操纵盘
        editCzp('CZP_CZPXH');
    }


    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#SHINY_SL").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=shiny&SHINY_SL="+sl_,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }

    //调用装潢价格
    function selZhj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前基础设备价格
        var zz_ = $("#BZ_ZZ").val();
        var sd_ = $("#BZ_SD").val();
        var kmxs_ = $("#BZ_KMXS").val();
        var kmkd_ = $("#BZ_KMKD").val();
        var c_ = $("#BZ_C").val();
        var z_ = $("#BZ_Z").val();
        var m_ = $("#BZ_M").val();
        var sl_ = $("#SHINY_SL").val();
        var zk_ = $("#SHINY_ZK").val();
        var sbj_ = $("#SHINY_SBJ").val();
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selZhj.do?models=shiny&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&SHINY_SL="+sl_+"&SHINY_ZK="+zk_+"&SHINY_SBJ="+sbj_,
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


    //设置disable--
    

    //计算基础价
    function setSbj(){
        var sd_ = $("#BZ_SD").val();  //速度
        var c_ = $("#BZ_C").val();     //层站
        var zz_ = $("#BZ_ZZ").val();  //载重
        var price = 0;
        if(sd_=="0.5"){
            if(zz_=="1000"){
                if(c_=="2"){
                    price = 120700;
                }else if(c_=="3"){
                    price = 127500;
                }else if(c_=="4"){
                    price = 136000;
                }else if(c_=="5"){
                    price = 143500;
                }else if(c_=="6"){
                    price = 150200;
                }else if(c_=="7"){
                    price = 156700;
                }else if(c_=="8"){
                    price = 165300;
                }
            }else if(zz_=="2000"){
                if(c_=="2"){
                    price = 134200;
                }else if(c_=="3"){
                    price = 141800;
                }else if(c_=="4"){
                    price = 150400;
                }else if(c_=="5"){
                    price = 158900;
                }else if(c_=="6"){
                    price = 166400;
                }else if(c_=="7"){
                    price = 175800;
                }else if(c_=="8"){
                    price = 185300;
                }
            }else if(zz_=="3000"){
                if(c_=="2"){
                    price = 179600;
                }else if(c_=="3"){
                    price = 190000;
                }else if(c_=="4"){
                    price = 201500;
                }else if(c_=="5"){
                    price = 211800;
                }else if(c_=="6"){
                    price = 222200;
                }else if(c_=="7"){
                    price = 233500;
                }else if(c_=="8"){
                    price = 244900;
                }
            }else if(zz_=="4000"){
                if(c_=="2"){
                    price = 252400;
                }else if(c_=="3"){
                    price = 266500;
                }else if(c_=="4"){
                    price = 279800;
                }else if(c_=="5"){
                    price = 294900;
                }else if(c_=="6"){
                    price = 310200;
                }else if(c_=="7"){
                    price = 324400;
                }else if(c_=="8"){
                    price = 339500;
                }
            }else if(zz_=="5000"){
                if(c_=="2"){
                    price = 269500;
                }else if(c_=="3"){
                    price = 283600;
                }else if(c_=="4"){
                    price = 298700;
                }else if(c_=="5"){
                    price = 313800;
                }else if(c_=="6"){
                    price = 328000;
                }else if(c_=="7"){
                    price = 342200;
                }else if(c_=="8"){
                    price = 356400;
                }
            }
        }else if(sd_=="0.25"){  //速度=1.75m/s
            if(zz_=="4000"){
                if(c_=="2"){
                    price = 242900;
                }else if(c_=="3"){
                    price = 257100;
                }else if(c_=="4"){
                    price = 271300;
                }
            }else if(zz_=="5000"){
                if(c_=="2"){
                    price = 260900;
                }else if(c_=="3"){
                    price = 275100;
                }else if(c_=="4"){
                    price = 289300;
                }
            }
        }else if(sd_=="1.0"){
            if(zz_=="1000"){
                if(c_=="2"){
                    price =  123700;
                }else if(c_=="3"){
                    price =  131400;
                }else if(c_=="4"){
                    price =  137900;
                }else if(c_=="5"){
                    price =  145500;
                }else if(c_=="6"){
                    price =  153000;
                }else if(c_=="7"){
                    price =  160600;
                }else if(c_=="8"){
                    price =  167200;
                }else if(c_=="9"){
                    price =  174800;
                }else if(c_=="10"){
                    price =  181400;
                }else if(c_=="11"){
                    price =  189000;
                }else if(c_=="12"){
                    price =  196600;
                }else if(c_=="13"){
                    price =  203200;
                }else if(c_=="14"){
                    price =  210800;
                }else if(c_=="15"){
                    price =  218300;
                }
            }else if(zz_=="2000"){
                if(c_=="2"){
                    price =  170200;
                }else if(c_=="3"){
                    price =  178700;
                }else if(c_=="4"){
                    price =  186200;
                }else if(c_=="5"){
                    price =  193800;
                }else if(c_=="6"){
                    price =  202400;
                }else if(c_=="7"){
                    price =  210900;
                }else if(c_=="8"){
                    price =  218400;
                }else if(c_=="9"){
                    price =  226900;
                }else if(c_=="10"){
                    price =  235500;
                }else if(c_=="11"){
                    price =  244000;
                }else if(c_=="12"){
                    price =  251500;
                }else if(c_=="13"){
                    price =  260000;
                }else if(c_=="14"){
                    price =  267600;
                }else if(c_=="15"){
                    price =  276000;
                }
            }else if(zz_=="3000"){
                if(c_=="2"){
                    price =  224000;
                }else if(c_=="3"){
                    price =  235500;
                }else if(c_=="4"){
                    price =  246700;
                }else if(c_=="5"){
                    price =  257100;
                }else if(c_=="6"){
                    price =  267600;
                }else if(c_=="7"){
                    price =  278000;
                }else if(c_=="8"){
                    price =  289300;
                }else if(c_=="9"){
                    price =  300700;
                }else if(c_=="10"){
                    price =  311100;
                }else if(c_=="11"){
                    price =  322400;
                }else if(c_=="12"){
                    price =  333800;
                }else if(c_=="13"){
                    price =  344200;
                }else if(c_=="14"){
                    price =  354500;
                }else if(c_=="15"){
                    price =  365800;
                }
            }
        }
        $("#SBJ_TEMP").val(price);
        countZhj();
    }


    //修改门数量时修改标准价格
    function setMPrice(){
        var m_ = parseInt($("#BZ_M").val());
        var c_ = parseInt($("#BZ_C").val());
        var price = parseInt($("#SHINY_SBJ").val());
        var kmkd_ = parseInt($("#BZ_KMKD").val());
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(price)){
            var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="1400"||kmkd_=="1500"){
                    price = price-4300*jm;
                }else if(kmkd_=="1700"){
                    price = price-5100*jm;
                }else if(kmkd_=="2000"){
                    price = price-5800*jm;
                }else if(kmkd_=="2200"){
                    price = price-6600*jm;
                }
            }
            $("#SHINY_SBJ").val(price);
            countZhj();
        }
    }

    //修改载重时
    function editZz(){
        var zz_ = $("#BZ_ZZ").val();
        var kmkd_ = $("#BZ_KMKD").val();

        if(zz_=="1000"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1400×1600(1000kg)'>1400×1600(1000kg)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1400'>1400</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked");
        }else if(zz_=="2000"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1700×2400(2000kg)'>1700×2400(2000kg)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1500'>1500</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked");
        }else if(zz_=="3000"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='2000×2800(3000kg)'>2000×2800(3000kg)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1700'>1700</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked");
        }else if(zz_=="4000"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='2000×3600(4000kg)'>2000×3600(4000kg)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='2000'>2000</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked");
        }else if(zz_=="5000"){
            //修改轿厢规格         
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='2600×3400(5000kg)'>2600×3400(5000kg)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='2200'>2200</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");
        }

        
    }

    //修改速度时
    function editSd(){
        var sd_ = $("#BZ_SD").val();
        if(sd_=="0.25"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="0.5"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }
    }

    //修改(层站)门
    function editM(){
        var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
        var c_ = parseInt($("#BZ_C").val());    //层
        var m_ = parseInt($("#BZ_M").val());    //门
        var price = 0;
        if(kmkd_=="800"){
            price = (c_-m_)*1680;
        }else if(kmkd_=="1500"){
            price = (c_-m_)*1920;
        }else if(kmkd_=="2000"){
            price = (c_-m_)*2200;
        }
    }

    function countZhj(){
        var zhj_count = 0;
        var sbj_count = 0;
        var base_jdzg_temp = $("#BASE_JDZG_TEMP").val()==""?0:parseInt($("#BASE_JDZG_TEMP").val());
        var base_dgzj_temp = $("#BASE_DGZJ_TEMP").val()==""?0:parseInt($("#BASE_DGZJ_TEMP").val());
        var opt_cop_temp = $("#OPT_COP_TEMP").val()==""?0:parseInt($("#OPT_COP_TEMP").val());
        var opt_wztcopmwan_temp = $("#OPT_WZYCOPMWAN_TEMP").val()==""?0:parseInt($("#OPT_WZYCOPMWAN_TEMP").val());
        var opt_gbscjrczxcop_temp = $("#OPT_GBSCJRCZXCOP_TEMP").val()==""?0:parseInt($("#OPT_GBSCJRCZXCOP_TEMP").val());
        var opt_lop_temp = $("#OPT_LOP_TEMP").val()==""?0:parseInt($("#OPT_LOP_TEMP").val());
        var opt_fdlcz_temp = $("#OPT_FDLCZ_TEMP").val()==""?0:parseInt($("#OPT_FDLCZ_TEMP").val());
        var opt_tdjjjy_temp = $("#OPT_TDJJJY_TEMP").val()==""?0:parseInt($("#OPT_TDJJJY_TEMP").val());
        var opt_ysjcz_temp = $("#OPT_YSJCZ_TEMP").val()==""?0:parseInt($("#OPT_YSJCZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt($("#OPT_CCTVDL_TEMP").val());
        var opt_jjbydyczzz_temp = $("#OPT_JJBYDYCZZZ_TEMP").val()==""?0:parseInt($("#OPT_JJBYDYCZZZ_TEMP").val());
        var opt_jxdzz_temp = $("#OPT_JXDZZ_TEMP").val()==""?0:parseInt($("#OPT_JXDZZ_TEMP").val());
        var opt_zpc_temp = $("#OPT_ZPC_TEMP").val()==""?0:parseInt($("#OPT_ZPC_TEMP").val());
        var opt_ycjsjkzb_temp = $("#OPT_YCJSJKZB_TEMP").val()==""?0:parseInt($("#OPT_YCJSJKZB_TEMP").val());
        var opt_yybz_temp = $("#OPT_YYBZ_TEMP").val()==""?0:parseInt($("#OPT_YYBZ_TEMP").val());
        var opt_hjzdfhjz_temp = $("#OPT_HJZDFHJZ_TEMP").val()==""?0:parseInt($("#OPT_HJZDFHJZ_TEMP").val());
        var opt_bajk_temp = $("#OPT_BAJK_TEMP").val()==""?0:parseInt($("#OPT_BAJK_TEMP").val());
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt($("#OPT_DJGRBH_TEMP").val());
        var opt_xfld_temp = $("#OPT_XFLD_TEMP").val()==""?0:parseInt($("#OPT_XFLD_TEMP").val());
        var opt_twfyfw_temp = $("#OPT_TWXFYFW_TEMP").val()==""?0:parseInt($("#OPT_TWXFYFW_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt($("#JXZH_JM_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt($("#JXZH_QWB_TEMP").val());
        var jxzh_cwb_temp = $("#JXZH_CWB_TEMP").val()==""?0:parseInt($("#JXZH_CWB_TEMP").val());
        var jxzh_hwb_temp = $("#JXZH_HWB_TEMP").val()==""?0:parseInt($("#JXZH_HWB_TEMP").val());
        var jxzh_jdzh_temp = $("#JXZH_JDZH_TEMP").val()==""?0:parseInt($("#JXZH_JDZH_TEMP").val());
        var jxzh_dbxh_temp = $("#JXZH_DBXH_TEMP").val()==""?0:parseInt($("#JXZH_DBXH_TEMP").val());
        var jxzh_fztxh_temp = $("#JXZH_FZTXH_TEMP").val()==""?0:parseInt($("#JXZH_FZTXH_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt($("#JXZH_BGJ_TEMP").val());
        var tmmt_sctmmtczxmk_temp = $("#TMMT_SCTMMTCZXMK_TEMP").val()==""?0:parseInt($("#TMMT_SCTMMTCZXMK_TEMP").val());
        var tmmt_fsctmmtczxmk_temp = $("#TMMT_FSCTMMTCZXMK_TEMP").val()==""?0:parseInt($("#TMMT_FSCTMMTCZXMK_TEMP").val());
        var tmmt_sctmmtczdmk_temp = $("#TMMT_SCTMMTCZDMK_TEMP").val()==""?0:parseInt($("#TMMT_SCTMMTCZDMK_TEMP").val());
        var tmmt_fsctmmtczdmk_temp = $("#TMMT_FSCTMMTCZDMK_TEMP").val()==""?0:parseInt($("#TMMT_FSCTMMTCZDMK_TEMP").val());
        var tmmt_tmcz_temp = $("#TMMT_TMCZ_TEMP").val()==""?0:parseInt($("#TMMT_TMCZ_TEMP").val());
        var tmmt_fsctmcz_temp = $("#TMMT_FSCTMCZ_TEMP").val()==""?0:parseInt($("#TMMT_FSCTMCZ_TEMP").val());
        var czp_czpxh_temp = $("#CZP_CZPXH_TEMP").val()==""?0:parseInt($("#CZP_CZPXH_TEMP").val());
        var tmxhzz_twzhxh_temp = $("#TMXHZZ_TWZHXH_TEMP").val()==""?0:parseInt($("#TMXHZZ_TWZHXH_TEMP").val());

        zhj_count = jxzh_jm_temp+jxzh_qwb_temp+jxzh_cwb_temp+jxzh_hwb_temp+jxzh_jdzh_temp+jxzh_dbxh_temp+jxzh_fztxh_temp+jxzh_bgj_temp;
        $("#SHINY_ZHJ").val(zhj_count);

        sbj_count = base_jdzg_temp+base_dgzj_temp+opt_cop_temp+opt_wztcopmwan_temp+opt_gbscjrczxcop_temp+opt_lop_temp+opt_fdlcz_temp+opt_tdjjjy_temp+opt_ysjcz_temp+opt_cctvdl_temp+opt_jjbydyczzz_temp+opt_jxdzz_temp+opt_zpc_temp+opt_ycjsjkzb_temp+opt_yybz_temp+opt_hjzdfhjz_temp+opt_bajk_temp+opt_djgrbh_temp+opt_xfld_temp+opt_twfyfw_temp+tmmt_sctmmtczxmk_temp+tmmt_fsctmmtczxmk_temp+tmmt_sctmmtczdmk_temp+tmmt_fsctmmtczdmk_temp+tmmt_tmcz_temp+tmmt_fsctmcz_temp+czp_czpxh_temp+tmxhzz_twzhxh_temp;
        //设备标准价格
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#SHINY_SBJ").val(sbj_temp+sbj_count);

        //运输费
        var shiny_ysf = $("#SHINY_YSF").val()==""?0:parseInt($("#SHINY_YSF").val());
        $("#SHINY_YSF").val(shiny_ysf);
        //安装费
        var shiny_azf = $("#SHINY_AZF_TEMP").val()==""?0:parseInt($("#SHINY_AZF_TEMP").val());
        $("#SHINY_AZF").val(shiny_azf);

        var shiny_zk = parseFloat($("#SHINY_ZK").val())/100;
        if(!isNaN(shiny_zk)){
            var shiny_sbj = parseInt($("#SBJ_TEMP").val());
            var shiny_sjbj = (shiny_sbj+zhj_count+sbj_count+shiny_azf+shiny_ysf)*shiny_zk;
            var shiny_zhsbj = shiny_sbj*shiny_zk;
            $("#SHINY_SJBJ").val(shiny_sjbj);
            $("#SHINY_ZHSBJ").val(shiny_zhsbj);
            $("#zk_").text($("#SHINY_ZK").val()+"%");
        }
    }

    //计算井道总高-加价
    function setJdzg(){
        var tsgd_ = parseInt($("#BASE_TSGD").val());    //提升高度
        var dksd_ = parseInt($("#BASE_DKSD").val());     //底坑深度
        var dcgd_ = parseInt($("#BASE_DCGD").val());    //顶层高度
        //加价
        var price = 0;
        if(!isNaN(tsgd_)&&!isNaN(dksd_)&&!isNaN(dcgd_)){
            var jdzg_ = tsgd_+dksd_+dcgd_;  //井道总高
            $("#BASE_JDZG").val(jdzg_);
            var zz_ = $("#BZ_ZZ").val();  //载重
            var sd_ = $("#BZ_SD").val();    //速度
            var jxgd_ = $("#BASE_JXGD").val();  //轿厢高度
            var c_ = parseInt($("#BZ_C").val())   //层数
            var K = 0;
            var S = 0;
            if(zz_=="1000"||zz_=="2000"||zz_=="3000"){
                K = 4300;
                S = 1400;
            }else if(zz_=="4000"||zz_=="5000"){
                K = 4500;
                S = 1500;
            }
            var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            if(sd_=="0.25"){
                if(zz_=="4000"){
                    price = 1510*((jdzg_-jdzg_std)/100);
                }else if(zz_=="5000"){
                    price = 1610*((jdzg_-jdzg_std)/100);
                }
            }else if(sd_=="0.5"){
                if(zz_=="1000"){
                    price = 720*((jdzg_-jdzg_std)/100);
                }else if(zz_=="2000"){
                    price = 770*((jdzg_-jdzg_std)/100);
                }else if(zz_=="3000"){
                    price = 890*((jdzg_-jdzg_std)/100);
                }else if(zz_=="4000"){
                    price = 1510*((jdzg_-jdzg_std)/100);
                }else if(zz_=="5000"){
                    price = 1610*((jdzg_-jdzg_std)/100);
                }
            }else if(sd_=="1.0"){
                if(zz_=="1000"){
                    price = 720*((jdzg_-jdzg_std)/100);
                }else if(zz_=="2000"){
                    price = 770*((jdzg_-jdzg_std)/100);
                }else if(zz_=="3000"){
                    price = 890*((jdzg_-jdzg_std)/100);
                }
            }

            //计算导轨支架标准档数
            var dgzj_std = Maht.ceil((jdzg_std/2000)+1);
            $("#BASE_DGZJ").val(dgzj_std);
        }
        $("#BASE_JDZG_TEMP").val(price);
        //放入价格
        countZhj();
    }

    //计算导轨支架-加价
    function setDgzj(){
        var dgzj_ = parseInt($("#BASE_DGZJ").val());  //导轨支架
        if(!isNaN(dgzj_)){
            var zz_ = $("#BZ_ZZ").val();  //载重
            var sd_ = $("#BZ_SD").val();    //速度
            var jxgd_ = $("#BASE_JXGD").val();  //轿厢高度
            var c_ = parseInt($("#BZ_C").val())   //层数
            var jdzg_std = 0;   //井道总高(标准)
            var dgzj_std = 0;   //导轨支架档数(标准)
            var K = 0;
            var S = 0;
            var price = 0;
            if(zz_=="1000"||zz_=="2000"||zz_=="3000"){
                K = 4300;
                S = 1400;
            }else if(zz_=="4000"||zz_=="5000"){
                K = 4500;
                S = 1500;
            }
            jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            dgzj_std = (jdzg_std/2000)+1;
            price = (dgzj_-dgzj_std)*450;
            $("#BASE_DGZJ_TEMP").val(price);
            //放入价格
            countZhj();
        }
    }

    //可选功能部分加价
    function editOpt(option){
        //数量
        var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
        //价格
        var price = 0;
        if(option=="OPT_JFGT"){
            //机房高台
            if($("#OPT_JFGT_TEXT").is(":checked")){
                price = 380*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JFGT_TEXT").val(price);
        }else if(option=="OPT_COP"){
            //COP
            var cop_ = $("#OPT_COP").val();
            if(cop_=="JFHB06H-E"){
                150*sl_
            }else{
                price = 0;
            }
            $("#OPT_COP_TEMP").val(price);
        }else if(option=="OPT_WZYCOPMWAN"){
            //外召与COP盲文按钮（只）
            var wzycopmwan_ = parseInt($("#OPT_WZYCOPMWAN").val());
            price = 15*wzycopmwan_;
            $("#OPT_WZYCOPMWAN_TEMP").val(price);
        }else if(option=="OPT_GBSCJRCZXCOP"){
            //挂壁式残疾人操纵箱COP
            if($("#OPT_GBSCJRCZXCOP_TEXT").is(":checked")){
                var c_ = parseInt($("#BZ_C").val());
                if(c_<=16){
                    price = 2800;
                }else if(c_<=30){
                    price = 3800;   
                }
            }else{
                price = 0;
            }
            $("#OPT_GBSCJRCZXCOP_TEMP").val(price);
        }else if(option=="OPT_LOP"){
            //LOP（个）JFHB06H-E
            var lop_ = parseInt($("#OPT_LOP").val());
            price = lop_*31;
            $("#OPT_LOP_TEMP").val(price);
        }else if(option=="OPT_FDLCZ"){
            //防捣乱操作
            if($("#OPT_FDLCZ_TEXT").is(":checked")){
                price = 120*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FDLCZ_TEMP").val(price);
        }else if(option=="OPT_TDJJJY"){
            //停电应急救援
            $("#OPT_TDJJJY_TEMP").val(price);
        }else if(option=="OPT_YSJCZ"){
            //有司机操作
            if($("#OPT_YSJCZ_TEXT").is(":checked")){
                price = 46*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YSJCZ_TEMP").val(price);
        }else if(option=="OPT_CCTVDL"){
            //CCTV电缆（轿厢到机房）(m)
            var cctvdl_ = $("#OPT_CCTVDL").val();
            var tsgd_ = parseInt($("#BASE_TSGD").val());
            price = 16*(tsgd_/100)+15;
            $("#OPT_CCTVDL_TEMP").val(price);
        }else if(option=="OPT_JJBYDYCZZZ"){
            //紧急备用电源操作装置
            if($("#OPT_JJBYDYCZZZ_TEXT").is(":checked")){
                price = 3100;
            }else{
                price = 0;
            }
            $("#OPT_JJBYDYCZZZ_TEMP").val(price);
        }else if(option=="OPT_JXDZZ"){
            //轿厢到站钟
            if($("#OPT_JXDZZ_TEXT").is(":checked")){
                price = 180*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JXDZZ_TEMP").val(price);
        }else if(option=="OPT_ZPC"){
            //再平层
            if($("#OPT_ZPC_TEXT").is(":checked")){
                price = 1500*sl_;
            }else{
                price = 0;
            }
            $("#OPT_ZPC_TEMP").val(price);
        }else if(option=="OPT_YCJSJKZB"){
            //远程监视接口准备
            if($("#OPT_YCJSJKZB_TEXT").is(":checked")){
                price = 3700*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YCJSJKZB_TEMP").val(price);
        }else if(option=="OPT_YYBZ"){
            //语音报站
            if($("#OPT_YYBZ_TEXT").is(":checked")){
                price = 1200*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YYBZ_TEMP").val(price);
        }else if(option=="OPT_HJZDFHJZ"){
            //火警自动返回基站
            if($("#OPT_HJZDFHJZ_TEXT").is(":checked")){
                price = 150*sl_;
            }else{
                price = 0;
            }
            $("#OPT_HJZDFHJZ_TEMP").val(price);
        }else if(option=="OPT_BAJK"){
            //BA接口
            if($("#OPT_BAJK_TEXT").is(":checked")){
                price = 620*sl_;
            }else{
                price = 0;
            }
            $("#OPT_BAJK_TEMP").val(price);
        }else if(option=="OPT_DJGRBH"){
            //电机过热保护
            if($("#OPT_DJGRBH_TEXT").is(":checked")){
                price = 620*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DJGRBH_TEMP").val(price);
        }else if(option=="OPT_XFLD"){
            //消防联动
            if($("#OPT_XFLD_TEXT").is(":checked")){
                price = 150*sl_;
            }else{
                price = 0;
            }
            $("#OPT_XFLD_TEMP").val(price);
        }else if(option=="OPT_TWXFYFW"){
            //厅外消防员服务
            if($("#OPT_TWXFYFW_TEXT").is(":checked")){
                price = 230*sl_;
            }else{
                price = 0;
            }
            $("#OPT_TWXFYFW_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //轿厢装潢部分-加价
    function editJxzh(option){
        //数量
        var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
        //价格
        var price = 0;
        if(option=="JXZH_JM"){
            //轿门
            var jm_ = $("input[name='JXZH_JM']:checked").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            if(jm_=="钢板喷涂"){
                price = 0;
            }else if(jm_=="镜面不锈钢"){
                price = 0;
            }else if(jm_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 1500*sl_;
                }else if(kmkd_=="1500"){
                    price = 1700*sl_;
                }else if(kmkd_=="1700"){
                    price = 1800*sl_;
                }else if(kmkd_=="2000"){
                    price = 2200*sl_;
                }else if(kmkd_=="2200"){
                    price = 2300*sl_;
                }
            }
            $("#JXZH_JM_TEMP").val(price);
        }else if(option=="JXZH_QWB"){
            //前围壁
            var qwb_ = $("input[name='JXZH_QWB']:checked").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var zz_ = $("#BZ_ZZ").val();//载重
            if(qwb_=="钢板喷涂"){
                price = 0;
            }else if(qwb_=="镜面不锈钢"){
                price = 0;
            }else if(qwb_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 5000*sl_;
                }else if(kmkd_=="1500"){
                    price = 8000*sl_;
                }else if(kmkd_=="1700"){
                    price = 10000*sl_;
                }else if(kmkd_=="2000"){
                    price = 12000*sl_;
                }else if(kmkd_=="2200"){
                    price = 15000*sl_;
                }
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_CWB"){
            //侧围壁
            var cwb_ = $("input[name='JXZH_CWB']:checked").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var zz_ = $("#BZ_ZZ").val();//载重
            if(cwb_=="钢板喷涂"){
                price = 0;
            }else if(cwb_=="镜面不锈钢"){
                price = 0;
            }else if(cwb_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 5000*sl_;
                }else if(kmkd_=="1500"){
                    price = 8000*sl_;
                }else if(kmkd_=="1700"){
                    price = 10000*sl_;
                }else if(kmkd_=="2000"){
                    price = 12000*sl_;
                }else if(kmkd_=="2200"){
                    price = 15000*sl_;
                }
            }
            $("#JXZH_CWB_TEMP").val(price);
        }else if(option=="JXZH_HWB"){
            //后围壁
            var hwb_ = $("input[name='JXZH_HWB']:checked").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var zz_ = $("#BZ_ZZ").val();//载重
            if(hwb_=="钢板喷涂"){
                price = 0;
            }else if(hwb_=="镜面不锈钢"){
                price = 0;
            }else if(hwb_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 5000*sl_;
                }else if(kmkd_=="1500"){
                    price = 8000*sl_;
                }else if(kmkd_=="1700"){
                    price = 10000*sl_;
                }else if(kmkd_=="2000"){
                    price = 12000*sl_;
                }else if(kmkd_=="2200"){
                    price = 15000*sl_;
                }
            }
            $("#JXZH_HWB_TEMP").val(price);
        }else if(option=="JXZH_JDZH"){
            //轿顶装潢
            var jdzh_ = $("#JXZH_JDZH").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(jdzh_=="发纹不锈钢"){
                if(zz_=="1000"){
                    price = 1200*sl_;
                }else if(zz_=="2000"){
                    price = 2300*sl_;
                }else if(zz_=="3000"){
                    price = 3500*sl_;
                }else if(zz_=="4000"){
                    price = 4600*sl_;
                }else if(zz_=="5000"){
                    price = 5800*sl_;
                }
            }else{
                price = 0;
            }
            $("#JXZH_JDZH_TEMP").val(price);
        }else if(option=="JXZH_DBXH"){
            //地板型号
            var dbxh_ = $("#JXZH_DBXH").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(dbxh_=="不锈钢花纹钢板"){
                if(zz_=="1000"){
                    price = 3100*sl_;
                }else if(zz_=="2000"){
                    price = 5400*sl_;
                }else if(zz_=="3000"){
                    price = 7700*sl_;
                }else if(zz_=="4000"){
                    price = 10000*sl_;
                }else if(zz_=="5000"){
                    price = 12000*sl_;
                }
            }else{
                price = 0;
            }
            $("#JXZH_DBXH_TEMP").val(price);
        }else if(option=="JXZH_FZTXH"){
            //防撞条型号
            var fztxh_ = $("#JXZH_FZTXH").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(fztxh_=="木条"){
                if(zz_=="1000"||zz_=="2000"||zz_=="3000"){
                    price = 1500*sl_;
                }else if(zz_=="4000"||zz_=="5000"){
                    price = 1800*sl_;
                }
            }else if(fztxh_=="橡胶条"){
                if(zz_=="1000"||zz_=="2000"||zz_=="3000"){
                    price = 2200*sl_;
                }else if(zz_=="4000"||zz_=="5000"){
                    price = 2600*sl_;
                }
            }
            $("#JXZH_FZTXH_TEMP").val(price);
        }else if(option=="JXZH_BGJ"){
            //半高镜
            if($("#JXZH_BGJ_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();
                if(zz_=="1000"){
                    price = 1200*sl_;
                }else if(zz_=="2000"){
                    price = 1500*sl_;
                }else if(zz_=="3000"){
                    price = 1800*sl_;
                }else if(zz_=="4000"){
                    price = 2200*sl_;
                }else if(zz_=="5000"){
                    price = 2500*sl_;
                }
            }else{
                price = 0;
            }
            $("#JXZH_BGJ_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //厅门门套部分-加价
    function editTmmt(option){
        //数量
        var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
        var sctmmtczxmk_ = $("#TMMT_SCTMMTCZXMK").val();//首层厅门门套材质小门框
        var fsctmmtczxmk_ = $("#TMMT_FSCTMMTCZXMK").val();//非首层厅门门套材质小门框
        var sctmmtczdmk_ = $("#TMMT_SCTMMTCZDMK").val();//首层厅门门套材质大门框
        var fsctmmtczdmk_ = $("#TMMT_FSCTMMTCZDMK").val();//非首层厅门门套材质大门框
        var tmcz_ = $("#TMMT_TMCZ").val();//厅门材质
        var fsctmcz_ = $("#TMMT_FSCTMCZ").val();//非首层厅门材质

        var kmkd_ = $("#BZ_KMKD").val();//开门宽度
        var c_ = parseInt($("#BZ_C").val());//层
        //价格
        var price = 0;
        if(option=="TMMT_SCTMMTCZXMK"){
            //首层厅门门套材质小门框
            if(sctmmtczxmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 460*sl_;
                }else if(kmkd_=="1500"){
                    price = 540*sl_;
                }else if(kmkd_=="1700"){
                    price = 620*sl_;
                }else if(kmkd_=="2000"){
                    price = 690*sl_;
                }else if(kmkd_=="2200"){
                    price = 770*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_SCTMMTCZXMK_TEMP").val(price);
        }else if(option=="TMMT_FSCTMMTCZXMK"){
            //非首层厅门门套材质小门框
            var sctmmtczxmk_temp = parseInt($("#TMMT_SCTMMTCZXMK_TEMP").val());
            if(fsctmmtczxmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = ((460*c_)+sctmmtczxmk_temp)*sl_;
                }else if(kmkd_=="1500"){
                    price = ((540*c_)+sctmmtczxmk_temp)*sl_;
                }else if(kmkd_=="1700"){
                    price = ((620*c_)+sctmmtczxmk_temp)*sl_;
                }else if(kmkd_=="2000"){
                    price = ((690*c_)+sctmmtczxmk_temp)*sl_;
                }else if(kmkd_=="2200"){
                    price = ((770*c_)+sctmmtczxmk_temp)*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_FSCTMMTCZXMK_TEMP").val(price);
        }else if(option=="TMMT_SCTMMTCZDMK"){
            //首层厅门门套材质大门框
            if(sctmmtczdmk_=="钢板喷涂"){
                if(kmkd_=="1400"){
                    price = 2200*sl_;
                }else if(kmkd_=="1500"){
                    price = 2300*sl_;
                }else if(kmkd_=="1700"){
                    price = 2600*sl_;
                }else if(kmkd_=="2000"){
                    price = 3100*sl_;
                }else if(kmkd_=="2200"){
                    price = 3400*sl_;
                }
            }else if(sctmmtczdmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 3200*sl_;
                }else if(kmkd_=="1500"){
                    price = 3400*sl_;
                }else if(kmkd_=="1700"){
                    price = 3800*sl_;
                }else if(kmkd_=="2000"){
                    price = 4500*sl_;
                }else if(kmkd_=="2200"){
                    price = 4800*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_SCTMMTCZDMK_TEMP").val(price);
        }else if(option=="TMMT_FSCTMMTCZDMK"){
            //非首层厅门门套材质大门框
            var sctmmtczdmk_ = parseInt($("#TMMT_SCTMMTCZDMK_TEMP").val());
            if(fsctmmtczdmk_=="钢板喷涂"){
                if(kmkd_=="1400"){
                    price = ((2200*c_)+sctmmtczdmk_)*sl_;
                }else if(kmkd_=="1500"){
                    price = ((2300*c_)+sctmmtczdmk_)*sl_;
                }else if(kmkd_=="1700"){
                    price = ((2600*c_)+sctmmtczdmk_)*sl_;
                }else if(kmkd_=="2000"){
                    price = ((3100*c_)+sctmmtczdmk_)*sl_;
                }else if(kmkd_=="2200"){
                    price = ((3400*c_)+sctmmtczdmk_)*sl_;
                }
            }else if(fsctmmtczdmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = ((3200*c_)+sctmmtczdmk_)*sl_;
                }else if(kmkd_=="1500"){
                    price = ((3400*c_)+sctmmtczdmk_)*sl_;
                }else if(kmkd_=="1700"){
                    price = ((3800*c_)+sctmmtczdmk_)*sl_;
                }else if(kmkd_=="2000"){
                    price = ((4500*c_)+sctmmtczdmk_)*sl_;
                }else if(kmkd_=="2200"){
                    price = ((4800*c_)+sctmmtczdmk_)*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_FSCTMMTCZDMK_TEMP").val(price);
        }else if(option=="TMMT_TMCZ"){
            //厅门材质
            if(sctmmtczxmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 1500*sl_;
                }else if(kmkd_=="1500"){
                    price = 1700*sl_;
                }else if(kmkd_=="1700"){
                    price = 1800*sl_;
                }else if(kmkd_=="2000"){
                    price = 2200*sl_;
                }else if(kmkd_=="2200"){
                    price = 2300*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_TMCZ_TEMP").val(price);
        }else if(option=="TMMT_FSCTMCZ"){
            //非首层厅门材质
            var tmcz_temp = parseInt($("#TMMT_TMCZ_TEMP").val());
            if(fsctmcz_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = ((1500*c_)+tmcz_temp)*sl_;
                }else if(kmkd_=="1500"){
                    price = ((1700*c_)+tmcz_temp)*sl_;
                }else if(kmkd_=="1700"){
                    price = ((1800*c_)+tmcz_temp)*sl_;
                }else if(kmkd_=="2000"){
                    price = ((2200*c_)+tmcz_temp)*sl_;
                }else if(kmkd_=="2200"){
                    price = ((2300*c_)+tmcz_temp)*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_FSCTMCZ_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }
    

    //操纵盘-加价
    function editCzp(option){
        var sl_ = parseInt($("#SHINY_SL").val());
        var price = 0;
        if(option=="CZP_CZPXH"){
            var czpxh_ = $("#CZP_CZPXH").val();
            if(czpxh_=="JFCOP05P-E"){
                price = 0;
            }else if(czpxh_=="JFCOP06H-E"){
                price = 150*sl_;
            }
            $("#CZP_CZPXH_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //厅门信号装置-加价
    function editTmxhzz(option){
        var sl_ = parseInt($("#SHINY_SL").val());
        var price = 0;
        if(option=="TMXHZZ_SL"){
            var tmxhzzsl_ = parseInt($("#TMXHZZ_SL").val());
            var twzhxh_ = $("#TMXHZZ_TWZHXH").val();
            if(twzhxh_=="JFHB05P-E"){
                price = 0;
            }else if(twzhxh_=="JFHB06H-E"){
                price = 31*tmxhzzsl_;
            }
            $("#TMXHZZ_TWZHXH_TEMP").val(price);
        }
        //放入价格
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
                        $("#SHINY_YSF").val(transPrice);
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
                        $("#SHINY_YSF").val(transPrice);
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

        //设置checkbox选项值
        //可选功能部分
        if($("#OPT_JFGT_TEXT").is(":checked")){
            $("#OPT_JFGT").val("1");
        }else{
            $("#OPT_JFGT").val("0");
        }
        if($("#OPT_GBSCJRCZXCOP_TEXT").is(":checked")){
            $("#OPT_GBSCJRCZXCOP").val("1");
        }else{
            $("#OPT_GBSCJRCZXCOP").val("0");
        }
        if($("#OPT_FDLCZ_TEXT").is(":checked")){
            $("#OPT_FDLCZ").val("1");
        }else{
            $("#OPT_FDLCZ").val("0");
        }
        if($("#OPT_TDJJJY_TEXT").is(":checked")){
            $("#OPT_TDJJJY").val("1");
        }else{
            $("#OPT_TDJJJY").val("0");
        }
        if($("#OPT_YSJCZ_TEXT").is(":checked")){
            $("#OPT_YSJCZ").val("1");
        }else{
            $("#OPT_YSJCZ").val("0");
        }
        if($("#OPT_JJBYDYCZZZ_TEXT").is(":checked")){
            $("#OPT_JJBYDYCZZZ").val("1");
        }else{
            $("#OPT_JJBYDYCZZZ").val("0");
        }
        if($("#OPT_JXDZZ_TEXT").is(":checked")){
            $("#OPT_JXDZZ").val("1");
        }else{
            $("#OPT_JXDZZ").val("0");
        }
        if($("#OPT_ZPC_TEXT").is(":checked")){
            $("#OPT_ZPC").val("1");
        }else{
            $("#OPT_ZPC").val("0");
        }
        if($("#OPT_YCJSJKZB_TEXT").is(":checked")){
            $("#OPT_YCJSJKZB").val("1");
        }else{
            $("#OPT_YCJSJKZB").val("0");
        }
        if($("#OPT_YYBZ_TEXT").is(":checked")){
            $("#OPT_YYBZ").val("1");
        }else{
            $("#OPT_YYBZ").val("0");
        }
        if($("#OPT_HJZDFHJZ_TEXT").is(":checked")){
            $("#OPT_HJZDFHJZ").val("1");
        }else{
            $("#OPT_HJZDFHJZ").val("0");
        }
        if($("#OPT_BAJK_TEXT").is(":checked")){
            $("#OPT_BAJK").val("1");
        }else{
            $("#OPT_BAJK").val("0");
        }
        if($("#OPT_DJGRBH_TEXT").is(":checked")){
            $("#OPT_DJGRBH").val("1");
        }else{
            $("#OPT_DJGRBH").val("0");
        }
        if($("#OPT_XFLD_TEXT").is(":checked")){
            $("#OPT_XFLD").val("1");
        }else{
            $("#OPT_XFLD").val("0");
        }
        if($("#OPT_TWXFYFW_TEXT").is(":checked")){
            $("#OPT_TWXFYFW").val("1");
        }else{
            $("#OPT_TWXFYFW").val("0");
        }

        $("#shinyForm").submit();
    }
</script>
</body>

</html>
