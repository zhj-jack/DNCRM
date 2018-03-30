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
    <form action="e_offer/${msg}.do" name="feishangForm" id="feishangForm" method="post">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="FEISHANG_ID" id="FEISHANG_ID" value="${pd.FEISHANG_ID}">
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
                                                <option value="飞尚">飞尚</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()">
                                                <option value="1000" ${regelevStandardPd.ZZ=='1000'?'selected':''}>1000</option>
                                                <option value="2000" ${regelevStandardPd.ZZ=='2000'?'selected':''}>2000</option>
                                                <option value="3000" ${regelevStandardPd.ZZ=='3000'?'selected':''}>3000</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">速度(m/s):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_SD" name="BZ_SD" onchange="editSd();">
                                                <option value="0.5" ${regelevStandardPd.SD=='0.5'?'selected':''}>0.5</option>
                                                <option value="1.0" ${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_KMXS" name="BZ_KMXS">
                                                <option value="中分" ${regelevStandardPd.KMXS=='中分'?'selected':''}>中分</option>
                                                <option value="左旁开" ${regelevStandardPd.KMXS=='左旁开'?'selected':''}>左旁开</option>
                                                <option value="右旁开" ${regelevStandardPd.KMXS=='右旁开'?'selected':''}>右旁开</option>
                                                <option value="中分双折" ${regelevStandardPd.KMXS=='中分双折'?'selected':''}>中分双折</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_KMKD" name="BZ_KMKD" onchange="setMPrice();">
                                                <option value="900" ${regelevStandardPd.KMKD=='900'?'selected':''}>900</option>
                                                <option value="1500" ${regelevStandardPd.KMKD=='1500'?'selected':''}>1500</option>
                                                <option value="2000" ${regelevStandardPd.KMKD=='2000'?'selected':''}>2000</option>
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
                                            <label style="width:20%;margin-left:57px"><input type="text" class="form-control m-b" id="FEISHANG_SL" name="FEISHANG_SL" value="${pd.FEISHANG_SL}" readonly="readonly"></label>

                                            <label style="width:9%;margin-top: 25px;margin-bottom: 10px;margin-left: 20px">折扣申请:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="FEISHANG_ZK" name="FEISHANG_ZK" value="${pd.FEISHANG_ZK}" onkeyup="countZhj();"></label>%
                                            <!-- <select  class="form-control m-b" id="FEISHANG_ZK" name="FEISHANG_ZK" onchange="countZhj();">
                                                <option value="1" ${pd.FEISHANG_ZK=='1'?'selected':''}>请选择折扣</option>
                                                <option value="0.9" ${pd.FEISHANG_ZK=='0.9'?'selected':''}>90%</option>
                                                <option value="0.6" ${pd.FEISHANG_ZK=='0.6'?'selected':''}>60%</option>
                                                <option value="0.5" ${pd.FEISHANG_ZK=='0.5'?'selected':''}>50%</option>
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
                                                    <td>${pd.FEISHANG_SL}</td>
                                                    <td>
                                                        ${regelevStandardPd.C}
                                                        /
                                                        ${regelevStandardPd.Z}
                                                        /
                                                        ${regelevStandardPd.M}
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEISHANG_ZHJ" id="FEISHANG_ZHJ" value="${pd.FEISHANG_ZHJ}"></td>
                                                    <td>
                                                        <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEISHANG_SBJ" id="FEISHANG_SBJ" value="${regelevStandardPd.PRICE}">
                                                        <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}">
                                                    </td>
                                                    <td><font color="red"><span id="zk_">${pd.FEISHANG_ZK}</span></font></td>
                                                    <td><font color="red"><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEISHANG_ZHSBJ" id="FEISHANG_ZHSBJ" value="${pd.FEISHANG_ZHSBJ}"></font></td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" name="FEISHANG_AZF" id="FEISHANG_AZF" value="${pd.FEISHANG_AZF}"  style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' onkeyup="countZhj();" />
                                                        </font>
                                                    </td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEISHANG_YSF" id="FEISHANG_YSF" value="${pd.FEISHANG_YSF}">
                                                        </font>
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEISHANG_SJBJ" id="FEISHANG_SJBJ" value="${pd.FEISHANG_SJBJ}"></td>
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="form-group form-inline">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#tab-1" class="active">基本参数</a></li>
                                                <li><a data-toggle="tab" href="#tab-2">标准功能</a></li>
                                                <li><a data-toggle="tab" href="#tab-3">可选功能</a></li>
                                                <li><a data-toggle="tab" href="#tab-4">单组监控室对讲系统</a></li>
                                                <li><a data-toggle="tab" href="#tab-5">轿厢装潢</a></li>
                                                <li><a data-toggle="tab" href="#tab-6">厅门门套</a></li>
                                                <li><a data-toggle="tab" href="#tab-7">操纵盘</a></li>
                                                <li><a data-toggle="tab" href="#tab-8">厅门信号装置</a></li>
                                                <li><a data-toggle="tab" href="#tab-9">非标</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <!-- 基本参数 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="6">基本价格</td>
                                                            <td width="50">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="110">控制系统</td>
                                                            <td colspan="5">
                                                                <input type="hidden" name="BASE_KZXT" id="BASE_KZXT" value="VVVF系统">
                                                                VVVF系统
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="3">控制方式</td>
                                                            <td colspan="2" rowspan="2">
                                                                <input type="radio" name="BASE_KZFS"  value="单台(G1C)" ${pd.BASE_KZFS=='单台(G1C)'?'checked':''}/>单台(G1C)
                                                            </td>
                                                            <td colspan="3">
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="121">
                                                                <input type="radio" name="BASE_KZFS" value="两台并联(G2C)" ${pd.BASE_KZFS=='两台并联(G2C)'?'checked':''}/>两台并联(G2C)
                                                            </td>
                                                            <td width="183">
                                                                <input type="radio" name="BASE_KZFS" value="三台群控(G3C)" ${pd.BASE_KZFS=='三台群控(G3C)'?'checked':''}/>三台群控(G3C)
                                                            </td>
                                                            <td width="121">
                                                                <input type="radio" name="BASE_KZFS" value="四台群控(G4C)" ${pd.BASE_KZFS=='四台群控(G4C)'?'checked':''}/>四台群控(G4C)
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">
                                                                A梯:<input type="text" style="width:20px"/>
                                                            </td>
                                                            <td>
                                                                A梯:<input name="text" type="text" style="width:20px" />
                                                                B梯:<input name="text2" type="text"  style="width:20px"/></td>
                                                            <td>
                                                                A梯:<input name="text3" type="text" style="width:20px" />
                                                                B梯:<input name="text4" type="text"  style="width:20px"/>
                                                                C梯:<input name="text5" type="text" style="width:20px" /></td>
                                                            <td>
                                                                A梯:<input name="text32" type="text"  style="width:20px"/>
                                                                B梯:<input name="text42" type="text"  style="width:20px"/>
                                                                C梯:<input name="text52" type="text"  style="width:20px"/>
                                                                D梯:<input name="text322" type="text"  style="width:20px"/></td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>曳引主机</td>
                                                            <td colspan="5">
                                                                <select name="BASE_YYZJ" id="BASE_YYZJ" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="永磁同步无齿轮曳引机" ${pd.BASE_YYZJ=='永磁同步无齿轮曳引机'?'selected':''}>永磁同步无齿轮曳引机</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道结构</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDJG" type="radio" value="全混凝土" ${pd.BASE_JDJG=='全混凝土'?'checked':''}/>全混凝土
                                                            </td>
                                                            <td>
                                                                <input name="BASE_JDJG" type="radio" value="框架结构(圈梁)" ${pd.BASE_JDJG=='框架结构(圈梁)'?'checked':''}/>框架结构(圈梁)</td>
                                                            <td>
                                                                <input name="BASE_JDJG" type="radio" value="钢结构" ${pd.BASE_JDJG=='钢结构'?'checked':''}/>钢结构
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>圈/钢梁间距</td>
                                                            <td colspan="2">&nbsp;</td>
                                                            <td>
                                                                <input name="BASE_QGLJJ" type="text" value="${pd.BASE_QGLJJ}" style="width:20px"/>mm
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢规格CW*CD(mm)</td>
                                                            <td colspan="2">
                                                                <select name="BASE_JXGG" id="BASE_JXGG" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="1000D-1400*1600" ${pd.BASE_JXGG=='1000D-1400*1600'?'selected':''}>1000D-1400*1600</option>
                                                                    <option value="2000D-1700*2400" ${pd.BASE_JXGG=='2000D-1700*2400'?'selected':''}>2000D-1700*2400</option>
                                                                    <option value="3000D-2000*2800" ${pd.BASE_JXGG=='3000D-2000*2800'?'selected':''}>3000D-2000*2800</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢高度(非净高)</td>
                                                            <td colspan="2">
                                                                <p>
                                                                    1000kg:<input name="BASE_JXGD" ${pd.BASE_JXGD=='2300mm'?'selected':''} type="radio" value="2300mm" />2300mm
                                                                </p>
                                                                <p>
                                                                    2000~3000kg:<input name="BASE_JXGD" ${pd.BASE_JXGD=='2200mm'?'selected':''} type="radio" value="2200mm" />2200mm
                                                                </p>
                                                            </td>
                                                            <td colspan="3">
                                                                可选:
                                                                <input name="BASE_JXGD" type="radio" ${pd.BASE_JXGD=='2400mm'?'selected':''} value="2400mm"/>2400mm
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>开门尺寸OP*OPH</td>
                                                            <td colspan="5">
                                                                <select name="BASE_KMCC" id="BASE_KMCC" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="900mm*2100mm(1000kg)" ${pd.BASE_KMCC=='900mm*2100mm(1000kg)'?'selected':''}>900mm*2100mm(1000kg)</option>
                                                                  <option value="1500mm*2100mm(2000kg)" ${pd.BASE_KMCC=='1500mm*2100mm(2000kg)'?'selected':''}>>1500mm*2100mm(2000kg)</option>
                                                                  <option value="2000mm*2100mm(3000kg)" ${pd.BASE_KMCC=='2000mm*2100mm(3000kg)'?'selected':''}>>2000mm*2100mm(3000kg)</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢出入口数量</td>
                                                            <td colspan="5">
                                                                <select name="BASE_JXRKSL" id="BASE_JXRKSL" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="1" ${pd.BASE_JXRKSL=='1'?'selected':''}>1</option>
                                                                  <option value="2" ${pd.BASE_JXRKSL=='2'?'selected':''}>2</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>门类型/门保护</td>
                                                            <td colspan="5">
                                                                <select id="BASE_MLXMBH" name="BASE_MLXMBH" class="form-control">
                                                                    <option value="PM/2D光幕" ${pd.BASE_MLXMBH=='PM/2D光幕'?'selected':''}>PM/2D光幕</option>
                                                                    <option value="VVVF门机/2D光幕" ${pd.BASE_MLXMBH=='VVVF门机/2D光幕'?'selected':''}>VVVF门机/2D光幕</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道承重墙厚度</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDCZQHD" type="radio" value="250" ${pd.BASE_JDCZQHD=='250'?'checked':''} onclick="setJdczqhdDisable('1');"/>WT=250mm
                                                            </td>
                                                            <td colspan="3">
                                                                <input name="BASE_JDCZQHD" type="radio" value="" onclick="setJdczqhdDisable('0');" ${pd.BASE_JDCZQHD=='250'?'':'checked'}/>
                                                                WT=<input name="BASE_JDCZQHD_TEXT" id="BASE_JDCZQHD_TEXT" type="text"  style="width:20px" value="${pd.BASE_JDCZQHD=='250'?'':pd.BASE_JDCZQHD}"/>mm
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>提升高度RISE</td>
                                                            <td width="83">
                                                                <input name="BASE_TSGD" id="BASE_TSGD" type="text"  style="width:20px" onkeyup="setJdzg();" value="${pd.BASE_TSGD}" />m</td>
                                                            <td width="100"></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道尺寸HW*HD</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDK" id="BASE_JDK" type="text" class="form-control" style="width:30% " value="${pd.BASE_JDK}" />mm宽×
                                                                <input name="BASE_JDS" id="BASE_JDS" type="text" class="form-control" style="width:30% " value="${pd.BASE_JDS}"/>mm深
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>底坑顶层</td>
                                                            <td colspan="2">
                                                                <p>
                                                                    底坑深度:<input name="BASE_DKSD" id="BASE_DKSD" type="text" class="form-control" style="width: 50%" onkeyup="setJdzg();" value="${pd.BASE_DKSD}" />mm
                                                                </p>
                                                                <p>
                                                                    顶层高度:<input name="BASE_DCGD" id="BASE_DCGD" type="text" class="form-control" style="width: 50%" onkeyup="setJdzg();" value="${pd.BASE_DCGD}" />mm
                                                                </p>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道总高</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDZG" id="BASE_JDZG" type="text" class="form-control" value="${pd.BASE_JDZG}" />mm
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td><input type="text" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP" style="width:100% " class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>基站驻停</td>
                                                            <td colspan="2"><input type="text" name="BASE_JZZT" id="BASE_JZZT" style="width:100% " class="form-control" value="${pd.BASE_JZZT}"></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼层标记</td>
                                                            <td colspan="2">
                                                                <input class="form-control" name="BASE_LCBJ" id="BASE_LCBJ" type="text" value="${pd.BASE_LCBJ}" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>导轨支架</td>
                                                            <td colspan="2">
                                                                <input class="form-control" name="BASE_DGZJ" id="BASE_DGZJ" type="text" onkeyup="setDgzj();" value="${pd.BASE_DGZJ}" />
                                                                
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td><input class="form-control" type="text" name="BASE_DGZJ_TEMP" id="BASE_DGZJ_TEMP" style="width:100%"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>备注</td>
                                                            <td colspan="6">
                                                                楼层标记中作为盲层的楼层在标记外加圆圈注明，如1、2、③、4其中3层为盲层；标准配置下基站、驻停、紧急消防操作都设在同一层；轿厢高度指轿厢结构高度（含吊顶高度，非净高）；圈/钢梁结构间距指导轨架安装间距，需与土建（图纸）一致。
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                          </tr>
                                                          <tr>
                                                            <td>1</td>
                                                            <td>无呼自返基站</td>
                                                            <td>LOBBY</td>
                                                            <td>2</td>
                                                            <td>再平层</td>
                                                            <td>RLEV</td>
                                                            <td>3</td>
                                                            <td>监控室与机房、轿厢对讲(不含机房到监控室连线)</td>
                                                            <td>ICU-5</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>关门时间保护</td>
                                                            <td>DTP</td>
                                                            <td>5</td>
                                                            <td>端站换速及楼层号矫正</td>
                                                            <td>&nbsp;</td>
                                                            <td>6</td>
                                                            <td>接触器反馈检测功能</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>全集选控制</td>
                                                            <td>FCL</td>
                                                            <td>8</td>
                                                            <td>轿厢防意外移动</td>
                                                            <td>UCMP</td>
                                                            <td>9</td>
                                                            <td>电网电压波动检测功能</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>10</td>
                                                            <td>厅外和轿厢数字式位置指示器</td>
                                                            <td>HPI CPI </td>
                                                            <td>11</td>
                                                            <td>继电器检查保护</td>
                                                            <td>&nbsp;</td>
                                                            <td>12</td>
                                                            <td>故障自动检测</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>13</td>
                                                            <td>厅外和轿厢呼梯/等级</td>
                                                            <td>DTTL</td>
                                                            <td>14</td>
                                                            <td>速度反馈检测功能</td>
                                                            <td>&nbsp;</td>
                                                            <td>15</td>
                                                            <td>超载不启动(警示灯及蜂鸣器)</td>
                                                            <td>OLD</td>
                                                          </tr>
                                                          <tr>
                                                            <td>16</td>
                                                            <td>厅外及轿厢运行方向显示</td>
                                                            <td>HDI&amp;CDI</td>
                                                            <td>17</td>
                                                            <td>逆向运行保护</td>
                                                            <td>&nbsp;</td>
                                                            <td>18</td>
                                                            <td>自动开关门</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>19</td>
                                                            <td>运行次数显示</td>
                                                            <td>TRIC</td>
                                                            <td>20</td>
                                                            <td>防打滑保护</td>
                                                            <td>&nbsp;</td>
                                                            <td>21</td>
                                                            <td>直接停靠</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>22</td>
                                                            <td>楼层显示字符的任意设定</td>
                                                            <td>&nbsp;</td>
                                                            <td>23</td>
                                                            <td>防溜车保护</td>
                                                            <td>&nbsp;</td>
                                                            <td>24</td>
                                                            <td>门区外不能开门</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>25</td>
                                                            <td><strong>轿内通风手动及照明自动控制</strong></td>
                                                            <td>FLP</td>
                                                            <td>26</td>
                                                            <td>限位保护</td>
                                                            <td>&nbsp;</td>
                                                            <td>27</td>
                                                            <td>预转矩输出</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>28</td>
                                                            <td><strong>本层外召开门</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>29</td>
                                                            <td><strong>上下极限保护装置</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>30</td>
                                                            <td><strong>门连锁保护</strong></td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>31</td>
                                                            <td><strong>重复关门</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>32</td>
                                                            <td><strong>机房选层</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>33</td>
                                                            <td><strong>运行接触器保护</strong></td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>34</td>
                                                            <td><strong>井道自学习</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>35</td>
                                                            <td><strong>开、关门按钮</strong></td>
                                                            <td><strong><span lang="EN-US" xml:lang="EN-US">DOB DCB</span></strong></td>
                                                            <td>36</td>
                                                            <td><strong>抱闸检测保护</strong></td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>37</td>
                                                            <td><strong>待梯层设定</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>38</td>
                                                            <td><strong>紧急消防操作（消防功能）</strong></td>
                                                            <td>EFO</td>
                                                            <td>39</td>
                                                            <td><strong>光幕门保护装置</strong></td>
                                                            <td>LRD</td>
                                                          </tr>
                                                          <tr>
                                                            <td>40</td>
                                                            <td><strong>不停层设置</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>41</td>
                                                            <td><strong>轿内应急照明</strong></td>
                                                            <td>ECU</td>
                                                            <td>42</td>
                                                            <td><strong>撞底缓冲装置</strong></td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>43</td>
                                                            <td><strong>外召按钮嵌入自诊断</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>44</td>
                                                            <td><strong>故障低速自救功能</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>45</td>
                                                            <td><strong>错误指令删除</strong></td>
                                                            <td>DCC</td>
                                                          </tr>
                                                          <tr>
                                                            <td>46</td>
                                                            <td><strong>反向指令自动消除</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>47</td>
                                                            <td><strong>检修运行（轿顶与机房）</strong></td>
                                                            <td><strong><span lang="EN-US" xml:lang="EN-US">TCI ERO</span></strong></td>
                                                            <td>48</td>
                                                            <td><strong>安全回路保护</strong></td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>49</td>
                                                            <td><strong>门保持按钮</strong></td>
                                                            <td>DHB</td>
                                                            <td>50</td>
                                                            <td><strong>紧急电动运行</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>51</td>
                                                            <td><strong>独立运行</strong></td>
                                                            <td>ISC</td>
                                                          </tr>
                                                          <tr>
                                                            <td>52</td>
                                                            <td><strong>驻停</strong></td>
                                                            <td>PKS</td>
                                                            <td>53</td>
                                                            <td><strong>警铃</strong></td>
                                                            <td>ALM</td>
                                                            <td>54</td>
                                                            <td><strong>设置厅、轿门时间</strong></td>
                                                            <td>CHT</td>
                                                          </tr>
                                                          <tr>
                                                            <td>55</td>
                                                            <td><strong>手动紧急救援</strong></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                        </table>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <!-- 可选功能 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="5">可选功能</td>
                                                          </tr>
                                                          <tr>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                            <td>有</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>1</td>
                                                            <td>消防联动（火警自动返回基站）</td>
                                                            <td>FL</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_XFLD_TEXT" id="OPT_XFLD_TEXT" onclick="editOpt('OPT_XFLD')" ${pd.OPT_XFLD=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_XFLD" id="OPT_XFLD">
                                                            </td>
                                                            <td><input type="text" name="OPT_XFLD_TEMP" id="OPT_XFLD_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>司机操作</td>
                                                            <td>ATT</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_SJCZ_TEXT" id="OPT_SJCZ_TEXT" onclick="editOpt('OPT_SJCZ')" ${pd.OPT_SJCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_SJCZ" id="OPT_SJCZ">
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>消防员运行（轿厢内）</td>
                                                            <td>EFS</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_XFYYX_TEXT" id="OPT_XFYYX_TEXT" onclick="editOpt('OPT_XFYYX')" ${pd.OPT_XFYYX=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_XFYYX" id="OPT_XFYYX">
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>提前开门</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_SZTJMSJ_TEXT" id="OPT_SZTJMSJ_TEXT" onclick="editOpt('OPT_SZTJMSJ')" ${pd.OPT_SZTJMSJ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_SZTJMSJ" id="OPT_SZTJMSJ">
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>轿厢到站钟</td>
                                                            <td>GNC</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_JXDZZ_TEXT" id="OPT_JXDZZ_TEXT" onclick="editOpt('OPT_JXDZZ')" ${pd.OPT_JXDZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JXDZZ" id="OPT_JXDZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JXDZZ_TEMP" id="OPT_JXDZZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>BA接口</td>
                                                            <td>BA</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_BAJK_TEXT" id="OPT_BAJK_TEXT" onclick="editOpt('OPT_BAJK')" ${pd.OPT_BAJK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_BAJK" id="OPT_BAJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_BAJK_TEMP" id="OPT_BAJK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>CCTV电缆（轿厢到机房）</td>
                                                            <td>CCTVC</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_CCTVDL_TEXT" id="OPT_CCTVDL_TEXT" onclick="editOpt('OPT_CCTVDL')" ${pd.OPT_CCTVDL=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_CCTVDL" id="OPT_CCTVDL">
                                                            </td>
                                                            <td>
                                                                <input type="text" name="OPT_CCTVDL_TEMP" id="OPT_CCTVDL_TEMP" class="form-control">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>语音报站</td>
                                                            <td>SR</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_YYBZ_TEXT" id="OPT_YYBZ_TEXT" onclick="editOpt('OPT_YYBZ')" ${pd.OPT_YYBZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YYBZ" id="OPT_YYBZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YYBZ_TEMP" id="OPT_YYBZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>停电应急救援</td>
                                                            <td>ARD</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_TDYJJY_TEXT" id="OPT_TDYJJY_TEXT" onclick="editOpt('OPT_TDYJJY')" ${pd.OPT_TDYJJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TDYJJY" id="OPT_TDYJJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_TDYJJY_TEMP" id="OPT_TDYJJY_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>10</td>
                                                            <td>防捣乱操作</td>
                                                            <td>ANS</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_FDLCZ_TEXT" id="OPT_FDLCZ_TEXT" onclick="editOpt('OPT_FDLCZ')" ${pd.OPT_FDLCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_FDLCZ" id="OPT_FDLCZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FDLCZ_TEMP" id="OPT_FDLCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>电机过热保护</td>
                                                            <td>THB</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_DJGRBH_TEXT" id="OPT_DJGRBH_TEXT" onclick="editOpt('OPT_DJGRBH')" ${pd.OPT_DJGRBH=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DJGRBH" id="OPT_DJGRBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_DJGRBH_TEMP" id="OPT_DJGRBH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>下集选</td>
                                                            <td>DCL</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_XJX_TEXT" id="OPT_XJX_TEXT" onclick="editOpt('OPT_XJX')" ${pd.OPT_XJX=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_XJX" id="OPT_XJX">
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>13</td>
                                                            <td>物联网（远程监控）</td>
                                                            <td>DTNS</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_WLW_TEXT" id="OPT_WLW_TEXT" onclick="editOpt('OPT_WLW')" ${pd.OPT_WLW=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_WLW" id="OPT_WLW">
                                                            </td>
                                                            <td><input type="text" name="OPT_WLW_TEMP" id="OPT_WLW_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>14</td>
                                                            <td>紧急备用电源操作装置</td>
                                                            <td>EPO</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_JJBYDYCZZZ_TEXT" id="OPT_JJBYDYCZZZ_TEXT" onclick="editOpt('OPT_JJBYDYCZZZ')" ${pd.OPT_JJBYDYCZZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JJBYDYCZZZ" id="OPT_JJBYDYCZZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JJBYDYCZZZ_TEMP" id="OPT_JJBYDYCZZZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>15</td>
                                                            <td>厅外消防员服务</td>
                                                            <td>EPO</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_TWXFYFW_TEXT" id="OPT_TWXFYFW_TEXT" onclick="editOpt('OPT_TWXFYFW')" ${pd.OPT_TWXFYFW=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TWXFYFW" id="OPT_TWXFYFW">
                                                            </td>
                                                            <td><input type="text" name="OPT_TWXFYFW_TEMP" id="OPT_TWXFYFW_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>16</td>
                                                            <td>LOP按钮</td>
                                                            <td>EPO</td>
                                                            <td>
                                                                <select name="OPT_LOPAN" id="OPT_LOPAN" onchange="editOpt('OPT_LOPAN')" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="单梯" ${pd.OPT_LOPAN=='单梯'?'selected':''}>单梯</option>
                                                                    <option value="并联" ${pd.OPT_LOPAN=='并联'?'selected':''}>并联</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>17</td>
                                                            <td>LOP按钮个数</td>
                                                            <td>EPO</td>
                                                            <td>
                                                                <input type="text" name="OPT_LOPANGS" id="OPT_LOPANGS" onkeyup="editOpt('OPT_LOPANGS')" class="form-control" value="${pd.OPT_LOPANGS}" />
                                                            </td>
                                                            <td><input type="text" name="OPT_LOPANGS_TEMP" id="OPT_LOPANGS_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>18</td>
                                                            <td>贯通轿厢</td>
                                                            <td>EPO</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_GTJX_TEXT" id="OPT_GTJX_TEXT" onclick="editOpt('OPT_GTJX')" ${pd.OPT_GTJX=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GTJX" id="OPT_GTJX">
                                                            </td>
                                                            <td><input type="text" name="OPT_GTJX_TEMP" id="OPT_GTJX_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>19</td>
                                                            <td>贯通层数</td>
                                                            <td>EPO</td>
                                                            <td>
                                                                <input type="text" name="OPT_GTCS" id="OPT_GTCS" onkeyup="editOpt('OPT_GTCS')" class="form-control" value="${pd.OPT_GTCS}" />
                                                            </td>
                                                            <td><input type="text" name="OPT_GTCS_TEMP" id="OPT_GTCS_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 可选功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <!-- 单组监控室对讲系统 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="4">单组监控室对讲系统</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>对讲通讯方式</td>
                                                            <td>
                                                                <input name="DZJKSDJXT_DJTXFS" type="radio" value="分线制" ${pd.DZJKSDJXT_DJTXFS=='分线制'?'checked':''}/>分线制
                                                                <input name="DZJKSDJXT_DJTXFS" type="radio" value="总线制"${pd.DZJKSDJXT_DJTXFS=='总线制'?'checked':''}/>总线制
                                                            </td>
                                                            <td>对讲的电梯台数</td>
                                                            <td>
                                                                <input name="DZJKSDJXT_DJDDTTS" id="DZJKSDJXT_DJDDTTS" type="text" style="width:20px" value="${pd.DZJKSDJXT_DJDDTTS}" />台
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <!-- <tr>
                                                            <td>关联电梯合同号</td>
                                                            <td colspan="4"><input name="text2" type="text" class="form-control" /></td>
                                                          </tr> -->
                                                          <tr>
                                                            <td>备注</td>
                                                            <td colspan="4">
                                                                <strong>
                                                                    标配五方对讲：轿厢、轿顶、底坑，控制柜，监控室；选择一对多时，10台以下项目标配为分线制多局对讲；台以上项目标配为总线制多局对讲，多局对讲系统单个监控室主机的最大控制台数为64台
                                                                </strong>
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 单组监控室对讲系统 -->
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <!-- 轿厢装潢 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
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
                                                                <input name="JXZH_JM" type="radio" value="喷涂" onclick="editJxzh('JXZH_JM')" ${pd.JXZH_JM=='喷涂'?'checked':''} />喷涂 
                                                                色标号:
                                                                <select name="JXZH_JMSBH" id="JXZH_JMSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="不锈钢花纹钢板" ${pd.JXZH_JMSBH=='不锈钢花纹钢板'?'selected':''}>不锈钢花纹钢板</option>
                                                                    <option value="碳钢花纹钢板" ${pd.JXZH_JMSBH=='碳钢花纹钢板'?'selected':''}>碳钢花纹钢板</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_JM" type="radio" value="SUS 443发纹不锈钢" onclick="editJxzh('JXZH_JM')" ${pd.JXZH_JM=='SUS 443发纹不锈钢'?'checked':''}/>SUS 443发纹不锈钢 
                                                            </td>
                                                            <td><input type="text" name="JXZH_JM_TEMP" id="JXZH_JM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>前围壁</td>
                                                            <td>
                                                                <input name="JXZH_QWB" type="radio" value="喷涂" onclick="editJxzh('JXZH_QWB')" ${pd.JXZH_QWB=='喷涂'?'checked':''}/>喷涂 
                                                                色标号:
                                                                <select name="JXZH_QWBSBH" id="JXZH_QWBSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_QWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_QWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_QWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_QWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_QWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_QWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_QWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select></td>
                                                            <td>
                                                                <input name="JXZH_QWB" type="radio" value="SUS 443发纹不锈钢" onclick="editJxzh('JXZH_QWB')" ${pd.JXZH_QWB=='SUS 443发纹不锈钢'?'checked':''}/>SUS 443发纹不锈钢 
                                                            </td>
                                                            <td><input type="text" name="JXZH_QWB_TEMP" id="JXZH_QWB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>侧围壁</td>
                                                            <td>
                                                                <input name="JXZH_CWB" type="radio" value="喷涂" onclick="editJxzh('JXZH_CWB')" ${pd.JXZH_CWB=='喷涂'?'checked':''}/>喷涂 
                                                                色标号:
                                                                <select name="JXZH_CWBSBH" id="JXZH_CWBSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_CWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_CWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_CWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_CWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_CWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_CWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_CWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_CWB" type="radio" value="SUS 443发纹不锈钢" onclick="editJxzh('JXZH_CWB')" ${pd.JXZH_CWB=='SUS 443发纹不锈钢'?'checked':''}/>SUS 443发纹不锈钢 
                                                            </td>
                                                            <td><input type="text" name="JXZH_CWB_TEMP" id="JXZH_CWB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>后围壁</td>
                                                            <td>
                                                                <input name="JXZH_HWB" type="radio" value="喷涂" onclick="editJxzh('JXZH_HWB')" ${pd.JXZH_HWB=='喷涂'?'checked':''}/>喷涂 
                                                                色标号:
                                                                  <select name="JXZH_HWBSBH" id="JXZH_HWBSBH" class="form-control">
                                                                    <option value="">----</option>
                                                                    <option value="P-01" ${pd.JXZH_HWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_HWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_HWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_HWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_HWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_HWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_HWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                  </select>
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_HWB" type="radio" value="SUS 443发纹不锈钢" onclick="editJxzh('JXZH_HWB')" ${pd.JXZH_HWB=='SUS 443发纹不锈钢'?'checked':''}/>SUS 443发纹不锈钢 
                                                            </td>
                                                            <td><input type="text" name="JXZH_HWB_TEMP" id="JXZH_HWB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td height="63" colspan="2">轿顶装潢</td>
                                                            <td colspan="2">
                                                                <p>
                                                                    <input name="JXZH_JDZH" type="radio" value="悬吊式:(1000kg标准)" ${pd.JXZH_JDZH=='悬吊式:(1000kg标准)'?'checked':''}/>悬吊式:(1000kg标准)
                                                                </p>
                                                                <p>
                                                                    JF-CL22
                                                                </p>
                                                                <p>
                                                                    <input name="JXZH_JDZH" type="radio" value="单顶式:(2000~3000kg标准)" ${pd.JXZH_JDZH=='单顶式:(2000~3000kg标准)'?'checked':''}/>单顶式:(2000~3000kg标准)
                                                                </p>
                                                                <p>
                                                                    均分块式碳钢板喷漆结构顶
                                                                </p></td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td height="63" colspan="2">不锈钢吊顶</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="JXZH_BXGDD_TEXT" id="JXZH_BXGDD_TEXT" onclick="editJxzh('JXZH_BXGDD')" ${pd.JXZH_BXGDD=='1'?'checked':''}>
                                                                <input type="hidden" name="JXZH_BXGDD" id="JXZH_BXGDD">
                                                            </td>
                                                            <td><input type="text" name="JXZH_BXGDD_TEMP" id="JXZH_BXGDD_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td height="63" colspan="2">不锈钢地板</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="JXZH_BXGDB_TEXT" id="JXZH_BXGDB_TEXT" onclick="editJxzh('JXZH_BXGDB')"${pd.JXZH_BXGDB=='1'?'checked':''}>
                                                                <input type="hidden" name="JXZH_BXGDB" id="JXZH_BXGDB">
                                                            </td>
                                                            <td><input type="text" name="JXZH_BXGDB_TEMP" id="JXZH_BXGDB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td height="63" colspan="2">半高镜</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="JXZH_BGJ_TEXT" id="JXZH_BGJ_TEXT" onclick="editJxzh('JXZH_BGJ')" ${pd.JXZH_BGJ=='1'?'checked':''}>
                                                                <input type="hidden" name="JXZH_BGJ" id="JXZH_BGJ">
                                                            </td>
                                                            <td><input type="text" name="JXZH_BGJ_TEMP" id="JXZH_BGJ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板型号</td>
                                                            <td>
                                                                <p>
                                                                    1000kg:<input name="JXZH_DBXH" type="radio" value="PVC地板革" onclick="setDbxhDisable('1');" ${pd.JXZH_DBXH=='PVC地板革'?'checked':''}/>PVC地板革
                                                                </p>
                                                                <p>
                                                                    其他载重:<input name="JXZH_DBXH" type="radio" value="碳钢花纹钢板" ${pd.JXZH_DBXH=='碳钢花纹钢板'?'checked':''} onclick="setDbxhDisable('1');" />碳钢花纹钢板
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_DBXH" type="radio" value="" onclick="setDbxhDisable('0');" ${pd.JXZH_DBXH==''?'checked':''}/>
                                                                <select name="JXZH_DBXH_SELECT" id="JXZH_DBXH_SELECT" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_DBXH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_DBXH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_DBXH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_DBXH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_DBXH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_DBXH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_DBXH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板装修厚度(mm)</td>
                                                            <td colspan="2">
                                                                <input type="text" value="${pd.JXZH_DBZXHD}" name="JXZH_DBZXHD" id="JXZH_DBZXHD" class="form-control">
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">防撞条型号</td>
                                                            <td>
                                                                <input name="JXZH_FZTXH" type="radio" value="无" onchange="editJxzh('JXZH_FZTXH')" ${pd.JXZH_FZTXH=='无'?'checked':''}/>无
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_FZTXH" type="radio" value="" onchange="editJxzh('JXZH_FZTXH')" ${pd.JXZH_FZTXH=='无'?'':'checked'}/>
                                                                  <select name="JXZH_FZTXH_SELECT" id="JXZH_FZTXH_SELECT" onchange="editJxzh('JXZH_FZTXH')" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="木条" ${pd.JXZH_FZTXH=='木条'?'selected':''}>木条</option>
                                                                    <option value="橡胶条" ${pd.JXZH_FZTXH=='橡胶条'?'selected':''}>橡胶条</option>
                                                                  </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_FZTXH_TEMP" id="JXZH_FZTXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">防撞条安装位置</td>
                                                            <td colspan="2">
                                                                <input name="JXZH_FZTAZWZ" type="radio" value="后围壁" ${pd.JXZH_FZTAZWZ=='后围壁'?'checked':''}/>后围壁 
                                                                轿厢外向内看:
                                                                <input name="JXZH_FZTAZWZ" type="radio" value="左围壁" ${pd.JXZH_FZTAZWZ=='左围壁'?'checked':''}/>左围壁
                                                                <input name="JXZH_FZTAZWZ" type="radio" value="右围壁" ${pd.JXZH_FZTAZWZ=='右围壁'?'checked':''}/>右围壁
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                        </table>
                                                    <!-- 轿厢装潢 -->
                                                </div>
                                                <div id="tab-6" class="tab-pane">
                                                    <!-- 厅门门套 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="7">厅门门套</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="91">发纹不锈钢厅门</td>
                                                            <td width="573" colspan="6">
                                                                <input type="checkbox" name="TMMT_FWBXGTM_TEXT" id="TMMT_FWBXGTM_TEXT" onclick="editTmmt('TMMT_FWBXGTM');" ${pd.TMMT_FWBXGTM=='1'?'checked':''}> 
                                                                <input type="hidden" name="TMMT_FWBXGTM" id="TMMT_FWBXGTM">
                                                            </td>
                                                            <td><input type="text" name="TMMT_FWBXGTM_TEMP" id="TMMT_FWBXGTM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="91">发纹不锈钢小门套</td>
                                                            <td width="573" colspan="6">
                                                                <input type="checkbox" name="TMMT_FWBXGXMT_TEXT" id="TMMT_FWBXGXMT_TEXT" onclick="editTmmt('TMMT_FWBXGXMT');" ${pd.TMMT_FWBXGXMT=='1'?'checked':''}> 
                                                                <input type="hidden" name="TMMT_FWBXGXMT" id="TMMT_FWBXGXMT">
                                                            </td>
                                                            <td><input type="text" name="TMMT_FWBXGXMT_TEMP" id="TMMT_FWBXGXMT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="91">大门套(墙厚+装饰层)≤350mm</td>
                                                            <td width="573" colspan="6">
                                                                <input type="radio" name="TMMT_DMT" value="喷涂" onclick="editTmmt('TMMT_DMT');" ${pd.TMMT_DMT=='喷涂'?'checked':''}>喷涂
                                                                <input type="radio" name="TMMT_DMT" value="发纹不锈钢" onclick="editTmmt('TMMT_DMT');" ${pd.TMMT_DMT=='发纹不锈钢'?'checked':''}>发纹不锈钢
                                                            </td>
                                                            <td><input type="text" name="TMMT_DMT_TEMP" id="TMMT_DMT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="91" rowspan="2">首层厅门门套</td>
                                                            <td width="127">厅门材质</td>
                                                            <td width="45">合同号</td>
                                                            <td width="45">数量</td>
                                                            <td width="164">厅门材质</td>
                                                            <td width="45">合同号</td>
                                                            <td width="45">数量</td>
                                                            <td width="68">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td height="62">
                                                                <p>
                                                                    标准:
                                                                    <input name="TMMT_SCTMMT" type="radio" value="喷涂" onclick="setScsbhDisable('0');" ${pd.TMMT_SCTMMT=='喷涂'?'checked':''}/>喷涂
                                                                </p>
                                                                <p>
                                                                    色标号:
                                                                    <select name="TMMT_SCSBH" id="TMMT_SCSBH" class="form-control">
                                                                        <option value="">----</option>
                                                                        <option value="P-01" ${pd.TMMT_SCSBH=='P-01'?'selected':''}>P-01</option>
                                                                        <option value="P-02" ${pd.TMMT_SCSBH=='P-02'?'selected':''}>P-02</option>
                                                                        <option value="P-03" ${pd.TMMT_SCSBH=='P-03'?'selected':''}>P-03</option>
                                                                        <option value="P-04" ${pd.TMMT_SCSBH=='P-04'?'selected':''}>P-04</option>
                                                                        <option value="P-05" ${pd.TMMT_SCSBH=='P-05'?'selected':''}>P-05</option>
                                                                        <option value="P-06" ${pd.TMMT_SCSBH=='P-06'?'selected':''}>P-06</option>
                                                                        <option value="P-07" ${pd.TMMT_SCSBH=='P-07'?'selected':''}>P-07</option>
                                                                    </select>
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <input name="TMMT_SCSL" type="text" style="width:20px" />
                                                            </td>
                                                            <td>
                                                                <input name="TMMT_SCSL" id="TMMT_SCSL_1" type="text" style="width:20px" value="${pd.TMMT_SCSL}" />套
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    可选:
                                                                </p>
                                                                <p>
                                                                    <input name="TMMT_SCTMMT" type="radio" value="SUS443 发纹不锈钢" onclick="setScsbhDisable('1');" ${pd.TMMT_SCTMMT=='SUS443 发纹不锈钢'?'checked':''}/>SUS443 发纹不锈钢
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <input name="text3" type="text" style="width:20px" />
                                                            </td>
                                                            <td>
                                                                <input name="TMMT_SCSL" id="TMMT_SCSL_2" type="text" style="width:20px"  value="${pd.TMMT_SCSL}" />套
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td height="62">非首层厅门门套</td>
                                                            <td>
                                                                <p>
                                                                    标准:
                                                                    <input name="TMMT_FSCTMMT" type="radio" value="喷涂" onclick="setFscsbhDisable('0');" ${pd.TMMT_FSCTMMT=='喷涂'?'checked':''}/>喷涂
                                                                </p>
                                                                <p>
                                                                    色标号:
                                                                    <select name="TMMT_FSCSBH" id="TMMT_FSCSBH" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="P-01" ${pd.TMMT_FSCSBH=='P-01'?'selected':''}>P-01</option>
                                                                        <option value="P-02" ${pd.TMMT_FSCSBH=='P-02'?'selected':''}>P-02</option>
                                                                        <option value="P-03" ${pd.TMMT_FSCSBH=='P-03'?'selected':''}>P-03</option>
                                                                        <option value="P-04" ${pd.TMMT_FSCSBH=='P-04'?'selected':''}>P-04</option>
                                                                        <option value="P-05" ${pd.TMMT_FSCSBH=='P-05'?'selected':''}>P-05</option>
                                                                        <option value="P-06" ${pd.TMMT_FSCSBH=='P-06'?'selected':''}>P-06</option>
                                                                        <option value="P-07" ${pd.TMMT_FSCSBH=='P-07'?'selected':''}>P-07</option>
                                                                    </select>
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <input name="text5" type="text" style="width:20px" />
                                                            </td>
                                                            <td>
                                                                <input name="TMMT_FSCSL" id="TMMT_FSCSL_1" type="text" style="width:20px"  value="${pd.TMMT_FSCSL}" />套
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    可选: 
                                                                </p>
                                                                <p>
                                                                    <input name="TMMT_FSCTMMT" type="radio" value="SUS443 发纹不锈钢" onclick="setFscsbhDisable('1');" ${pd.TMMT_FSCTMMT=='SUS443 发纹不锈钢'?'checked':''}/>SUS443 发纹不锈钢
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <input name="text32" type="text" style="width:20px" />
                                                            </td>
                                                            <td>
                                                                <input name="TMMT_FSCSL" id="TMMT_FSCSL_2" type="text" style="width:20px"  value="${pd.TMMT_FSCSL}" />套
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>备注</td>
                                                            <td colspan="7">
                                                                厅门和门套的数量，不管单台还是并联或多台群控，必须按单台计算，并注明合同好，多台可连写。
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 厅门门套 -->
                                                </div>
                                                <div id="tab-7" class="tab-pane">
                                                    <!-- 操纵盘 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="4">操纵盘</td>
                                                          </tr>
                                                          <tr>
                                                            <td>操纵盘型号</td>
                                                            <td>标准：嵌入式</td>
                                                            <td>可选：嵌入式<input type="hidden" name="CZP_CZPLX" id="CZP_CZPLX" value="嵌入式"></td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td height="138">操纵盘型号</td>
                                                            <td>
                                                                <p>
                                                                    <input name="CZP_CZPXH" type="radio" value="JFCOP19H-E" onclick="setCzpxhDisable('1');" ${pd.CZP_CZPXH=='JFCOP19H-E'?'checked':''}/>JFCOP19H-E（标配只勾选本行，下列不必选）
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="CZP_XS" id="CZP_XS_1" class="form-control">
                                                                      <option value="">请选择</option>
                                                                      <option value="LED(标配)" ${pd.CZP_XS=='LED(标配)'?'selected':''}>LED(标配)</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="CZP_AN" id="CZP_AN_1" class="form-control">
                                                                      <option value="">请选择</option>
                                                                      <option value="圆形(标配)" ${pd.CZP_AN=='圆形(标配)'?'selected':''}>圆形(标配)</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="CZP_CZ" id="CZP_CZ_1" class="form-control">
                                                                      <option value="">请选择</option>
                                                                      <option value="发纹不锈钢(标准)" ${pd.CZP_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
                                                                    </select>
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    <input name="CZP_CZPXH" type="radio" value="JFCOP19H-C" onclick="setCzpxhDisable('2');" ${pd.CZP_CZPXH=='JFCOP19H-C'?'selected':''}/>JFCOP19H-C（标配只勾选本行，下列不必选）
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="CZP_XS" id="CZP_XS_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.CZP_XS=='LED(标配)'?'selected':''}>LCD(标配)</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="CZP_AN" id="CZP_AN_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="圆形(标配)" ${pd.CZP_AN=='圆形(标配)'?'selected':''}>圆形(标配)</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="CZP_CZ" id="CZP_CZ_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="发纹不锈钢(标准)" ${pd.CZP_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
                                                                    </select>
                                                                </p>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="3">操纵盘位置</td>
                                                            <td>标准:</td>
                                                            <td>可选:</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                <!-- <img src="操纵盘_image003.jpg" alt="cop_fr"/> -->1000kg:左前
                                                                <input type="radio" name="CZP_CZPWZ" value="1000kg:左前" ${pd.CZP_CZPWZ=='1000kg:左前'?'checked':''}>
                                                                <input type="hidden" name="CZP_CZPWZ" value="">
                                                            </td>
                                                            <td>
                                                                <!-- <img src="操纵盘_image004.jpg" alt="cop_r"/> -->左侧(窄/深轿厢可选)
                                                                <input type="radio" name="CZP_CZPWZ" value="左侧(窄/深轿厢可选)" ${pd.CZP_CZPWZ=='左侧(窄/深轿厢可选)'?'checked':''}>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                <!-- <img src="操纵盘_image004_0000.jpg" alt="cop_r"/> -->其他载重:左侧
                                                                <input type="radio" name="CZP_CZPWZ" value="其他载重:左侧" ${pd.CZP_CZPWZ=='其他载重:左侧'?'checked':''}>
                                                            </td>
                                                            <td>
                                                                <!-- <img src="操纵盘_image005.jpg" alt="cop_fr"/> -->其他载重:左前
                                                                <input type="radio" name="CZP_CZPWZ" value="其他载重:左前"${pd.CZP_CZPWZ=='其他载重:左前'?'checked':''}>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                        </table>
                                                    <!-- 操纵盘 -->
                                                </div>
                                                <div id="tab-8" class="tab-pane">
                                                    <!-- 厅门信号装置 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="4">厅门信号装置</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="86">厅外召唤类型</td>
                                                            <td width="180">标准：无底盒<input type="hidden" name="TMXHZZ_TWZHLX" id="TMXHZZ_TWZHLX" value="无底盒"></td>
                                                            <td width="244">可选：无底盒</td>
                                                            <td width="56">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>厅外召唤型号</td>
                                                            <td>
                                                                <p>
                                                                    <input name="TMXHZZ_TWZHXH" type="radio" onclick="setTwzhxhDisable('1');" value="JFCOP19H-E1" ${pd.TMXHZZ_TWZHXX=='JFCOP19H-E1'?'checked':''}/>JFCOP19H-E1（标配只勾选本行，下列不必选）
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="TMXHZZ_XS" id="TMXHZZ_XS_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LED(标配)" ${pd.TMXHZZ_XS=='LED(标配)'?'selected':''}>LED(标配)</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="TMXHZZ_AN" id="TMXHZZ_AN_1" class="form-control">
                                                                      <option value="">请选择</option>
                                                                      <option value="按钮(圆形)" ${pd.TMXHZZ_AN=='按钮(圆形)'?'selected':''}>按钮(圆形)</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="TMXHZZ_CZ" id="TMXHZZ_CZ_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="发纹不锈钢(标准)" ${pd.TMXHZZ_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
                                                                    </select>
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    <input name="TMXHZZ_TWZHXH" type="radio" value="JFCOP19H-C1" onclick="setTwzhxhDisable('2');" ${pd.TMXHZZ_TWZHXH=='JFCOP19H-C1'?'checked':''}/>JFCOP19H-C1（标配只勾选本行，下列不必选）
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="TMXHZZ_XS" id="TMXHZZ_XS_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.TMXHZZ_XS=='LCD(标配)'?'selected':''}>LCD(标配)</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="TMXHZZ_AN" id="TMXHZZ_AN_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="圆形(标准)" ${pd.TMXHZZ_AN=='圆形(标准)'?'selected':''}>圆形(标准)</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="TMXHZZ_CZ" id="TMXHZZ_CZ_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="发纹不锈钢(标准)" ${pd.TMXHZZ_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
                                                                    </select>
                                                                </p>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="3">厅外召唤形式</td>
                                                            <td>标准:</td>
                                                            <td>可选:</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                <!-- <img src="../../../../../AppData/Roaming/Macromedia/Dreamweaver 8/OfficeImageTemp/image006.png"/> -->
                                                                <input type="radio" name="TMXHZZ_TWZHXS" value="标准" ${pd.TMXHZZ_TWZHXS=='标准'?'checked':''}>
                                                            </td>
                                                            <td>
                                                                <!-- <img src="../../../../../AppData/Roaming/Macromedia/Dreamweaver 8/OfficeImageTemp/image007.png"/> -->
                                                                <input type="radio" name="TMXHZZ_TWZHXS" value="双控" ${pd.TMXHZZ_TWZHXS=='双控'?'checked':''}>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                <p>
                                                                    在
                                                                    <input name="TMXHZZ_ZDJC" id="TMXHZZ_ZDJC_1" type="text" style="width:20px" value="${pd.TMXHZZ_ZDJC}" />
                                                                    层、
                                                                    每层
                                                                    <input name="TMXHZZ_MCGS" id="TMXHZZ_MCGS_1" type="text" style="width:20px" value="${pd.TMXHZZ_MCGS}" />
                                                                    个
                                                                </p>
                                                                <p>
                                                                    附加说明：
                                                                    <input name="TMXHZZ_FJSM" id="TMXHZZ_FJSM_1" type="text" class="form-control" value="${pd.TMXHZZ_FJSM}" />
                                                                </p>    
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    在
                                                                    <input name="TMXHZZ_ZDJC" id="TMXHZZ_ZDJC_2" type="text" style="width:20px" />
                                                                    层、
                                                                    每层
                                                                    <input name="TMXHZZ_MCGS" id="TMXHZZ_MCGS_2" type="text" style="width:20px" />
                                                                    个
                                                                </p>
                                                                <p>
                                                                    附加说明：
                                                                    <input name="TMXHZZ_FJSM" id="TMXHZZ_FJSM_2" type="text" class="form-control"/>
                                                                </p>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>备注</td>
                                                            <td colspan="3">
                                                                <strong>
                                                                    1、填写厅外召唤所在层时，请用实际楼层标记填写。2、厅外召唤形式图例仅作示意，当楼层标记为一位数时，数字显示为一位数字，在顶层只有一个向下按钮，在底层只有一个向上按钮。3、驻停楼层的厅外召唤带钥匙开关。4、厅外召唤样式(HBtype)有单个(Single)和两台合用一个(Duplex)两种。
                                                                </strong>
                                                            </td>
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
                                                                    <th style="width:10%;">价格</th>
                                                                    <th style="width:10%;">交货期</th>
                                                                    <th style="width:10%;">操作</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="轿厢宽度×轿厢深度  CW*CD       mm×      mm"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="添加" onclick="addFbRow();"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="轿厢高度 CH       mm"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="开门高度 OPH       mm"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="开门宽度 OP       mm"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="开门方式"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="贯通门"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="进口光幕"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="进口主机"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="总线制对讲（不含机房到监控室连线,10台以上为标准配置）"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="无线对讲（无电话卡式，机房至监控室不用布线）"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="大门套（350mm及其以下）：墙体厚度     mm  装饰层厚度     mm  材质：  "></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="副操纵盘 DCOP"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="IC卡  刷卡后手动选择到达楼层      台式读/写卡器   台   磁卡   张"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="text" class="form-control"></td>
                                                                    <td><input type="button" value="删除" onclick="delFbRow(this);"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="text" class="form-control" value="IC卡  刷卡后自动到达指定楼层      台式读/写卡器   台   磁卡   张"></td>
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
                                            <input type="text" class="form-control" id="FEISHANG_AZF_TEMP" name="FEISHANG_AZF_TEMP" onkeyup="countZhj();" value="${pd.FEISHANG_AZF}">
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


    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#FEISHANG_SL").val();
        
        var elevIds_ = $("#ELEV_IDS").val();
        var itemId_ = $("#ITEM_ID").val();
        var bjcId = $("#BJC_ID").val();
        var feishangId = $("#FEISHANG_ID").val();
        var rowIndex = $("#rowIndex").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=feishang&FEISHANG_SL="+sl_+"&FEISHANG_ID="+feishangId+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex,
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
        var sl_ = $("#FEISHANG_SL").val();
        var zk_ = $("#FEISHANG_ZK").val();
        var sbj_ = $("#FEISHANG_SBJ").val();

        var elevIds_ = $("#ELEV_IDS").val();
        var itemId_ = $("#ITEM_ID").val();
        var bjcId = $("#BJC_ID").val();
        var feishangId = $("#FEISHANG_ID").val();
        var rowIndex = $("#rowIndex").val();
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selZhj.do?models=feishang&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEISHANG_SL="+sl_+"&FEISHANG_ZK="+zk_+"&FEISHANG_SBJ="+sbj_+"&FEISHANG_ID="+feishangId+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex,
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
    //井道承重墙厚度
    function setJdczqhdDisable(flag){
        if(flag=='1'){
            $("#BASE_JDCZQHD_TEXT").val("");
            $("#BASE_JDCZQHD_TEXT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#BASE_JDCZQHD_TEXT').removeAttr("disabled"); 
        }
    }
    //轿门色标号
    function setJmsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_JMSBH").val("");
            $("#JXZH_JMSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_JMSBH').removeAttr("disabled"); 
        }
    }
    //前围壁色标号
    function setQwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_QWBSBH").val("");
            $("#JXZH_QWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_QWBSBH').removeAttr("disabled"); 
        }
    }
    //侧围壁色标号
    function setCwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_CWBSBH").val("");
            $("#JXZH_CWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_CWBSBH').removeAttr("disabled"); 
        }
    }
    //后围壁色标号
    function setHwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_HWBSBH").val("");
            $("#JXZH_HWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_HWBSBH').removeAttr("disabled"); 
        }
    }
    //地板型号
    function setDbxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_DBXH_SELECT").val("");
            $("#JXZH_DBXH_SELECT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_DBXH_SELECT').removeAttr("disabled"); 
        }
    }
    //防撞条型号
    function setFztxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_FZTXH_SELECT").val("");
            $("#JXZH_FZTXH_SELECT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_FZTXH_SELECT').removeAttr("disabled"); 
        }
    }
    //首层色标号
    function setScsbhDisable(flag){
        if(flag=='1'){
            $("#TMMT_SCSBH").val("");
            $("#TMMT_SCSBH").attr("disabled","disabled");
            $("#TMMT_SCSL_1").val("");
            $("#TMMT_SCSL_1").attr("disabled","disabled");
            $('#TMMT_SCSL_2').removeAttr("disabled"); 
            /*$("#TMMT_SCSL").val("");
            $("#TMMT_SCSL").attr("disabled","disabled");*/
        }else if(flag=='0'){
            $("#TMMT_SCSL_2").val("");
            $("#TMMT_SCSL_2").attr("disabled","disabled");
            $('#TMMT_SCSBH').removeAttr("disabled"); 
            $('#TMMT_SCSL_1').removeAttr("disabled"); 
            /*$('#TMMT_SCSL').removeAttr("disabled"); */
        }
    }
    //非首层色标号
    function setFscsbhDisable(flag){
        if(flag=='1'){
            $("#TMMT_FSCSBH").val("");
            $("#TMMT_FSCSBH").attr("disabled","disabled");
            $("#TMMT_FSCSL_1").val("");
            $("#TMMT_FSCSL_1").attr("disabled","disabled");
            $('#TMMT_FSCSL_2').removeAttr("disabled"); 
            /*$("#TMMT_FSCSL").val("");
            $("#TMMT_FSCSL").attr("disabled","disabled");*/
        }else if(flag=='0'){
            $("#TMMT_FSCSL_2").val("");
            $("#TMMT_FSCSL_2").attr("disabled","disabled");
            $('#TMMT_FSCSBH').removeAttr("disabled"); 
            $('#TMMT_FSCSBH').removeAttr("disabled"); 
            $('#TMMT_FSCSL_1').removeAttr("disabled"); 
            /*$('#TMMT_FSCSL').removeAttr("disabled"); */
        }
    }
    //操纵盘型号
    function setCzpxhDisable(flag){
        if(flag=='1'){
            $("#CZP_XS_2").val("");
            $("#CZP_XS_2").attr("disabled","disabled");
            $("#CZP_AN_2").val("");
            $("#CZP_AN_2").attr("disabled","disabled");
            $("#CZP_CZ_2").val("");
            $("#CZP_CZ_2").attr("disabled","disabled");
            $('#CZP_XS_1').removeAttr("disabled"); 
            $('#CZP_AN_1').removeAttr("disabled"); 
            $('#CZP_CZ_1').removeAttr("disabled"); 
        }else if(flag=='2'){
            $("#CZP_XS_1").val("");
            $("#CZP_XS_1").attr("disabled","disabled");
            $("#CZP_AN_1").val("");
            $("#CZP_AN_1").attr("disabled","disabled");
            $("#CZP_CZ_1").val("");
            $("#CZP_CZ_1").attr("disabled","disabled");
            $('#CZP_XS_2').removeAttr("disabled"); 
            $('#CZP_AN_2').removeAttr("disabled"); 
            $('#CZP_CZ_2').removeAttr("disabled"); 
        }
    }

    //厅外召唤型号
    function setTwzhxhDisable(flag){
        if(flag=='1'){
            $("#TMXHZZ_XS_2").val("");
            $("#TMXHZZ_XS_2").attr("disabled","disabled");
            $("#TMXHZZ_AN_2").val("");
            $("#TMXHZZ_AN_2").attr("disabled","disabled");
            $("#TMXHZZ_CZ_2").val("");
            $("#TMXHZZ_CZ_2").attr("disabled","disabled");
            $("#TMXHZZ_ZDJC_2").val("");
            $("#TMXHZZ_ZDJC_2").attr("disabled","disabled");
            $("#TMXHZZ_MCGS_2").val("");
            $("#TMXHZZ_MCGS_2").attr("disabled","disabled");
            $("#TMXHZZ_FJSM_2").val("");
            $("#TMXHZZ_FJSM_2").attr("disabled","disabled");
            $('#TMXHZZ_XS_1').removeAttr("disabled"); 
            $('#TMXHZZ_AN_1').removeAttr("disabled"); 
            $('#TMXHZZ_CZ_1').removeAttr("disabled"); 
            $('#TMXHZZ_ZDJC_1').removeAttr("disabled"); 
            $('#TMXHZZ_MCGS_1').removeAttr("disabled"); 
            $('#TMXHZZ_FJSM_1').removeAttr("disabled"); 
        }else if(flag=='2'){
            $("#TMXHZZ_XS_1").val("");
            $("#TMXHZZ_XS_1").attr("disabled","disabled");
            $("#TMXHZZ_AN_1").val("");
            $("#TMXHZZ_AN_1").attr("disabled","disabled");
            $("#TMXHZZ_CZ_1").val("");
            $("#TMXHZZ_CZ_1").attr("disabled","disabled");
            $("#TMXHZZ_ZDJC_1").val("");
            $("#TMXHZZ_ZDJC_1").attr("disabled","disabled");
            $("#TMXHZZ_MCGS_1").val("");
            $("#TMXHZZ_MCGS_1").attr("disabled","disabled");
            $("#TMXHZZ_FJSM_1").val("");
            $("#TMXHZZ_FJSM_1").attr("disabled","disabled");
            $('#TMXHZZ_XS_2').removeAttr("disabled"); 
            $('#TMXHZZ_AN_2').removeAttr("disabled"); 
            $('#TMXHZZ_CZ_2').removeAttr("disabled"); 
            $('#TMXHZZ_ZDJC_2').removeAttr("disabled"); 
            $('#TMXHZZ_MCGS_2').removeAttr("disabled"); 
            $('#TMXHZZ_FJSM_2').removeAttr("disabled"); 
        }
    }



    //计算基础价
    function setSbj(){
        var sd_ = $("#BZ_SD").val();  //速度
        var c_ = $("#BZ_C").val();     //层站
        var zz_ = $("#BZ_ZZ").val();  //载重
        var price = 0;
        if(sd_=="0.5"){
            if(zz_=="1000"){
                if(c_=="2"){
                    price = 95550;
                }else if(c_=="3"){
                    price = 99340;
                }else if(c_=="4"){
                    price = 103130;
                }else if(c_=="5"){
                    price = 106920
                }else if(c_=="6"){
                    price = 110710;
                }else if(c_=="7"){
                    price = 114500;
                }else if(c_=="8"){
                    price = 118300;
                }
            }else if(zz_=="2000"){
                if(c_=="2"){
                    price = 129140;
                }else if(c_=="3"){
                    price = 138330;
                }else if(c_=="4"){
                    price = 147530;
                }else if(c_=="5"){
                    price = 156730;
                }else if(c_=="6"){
                    price = 165920;
                }else if(c_=="7"){
                    price = 175120;
                }else if(c_=="8"){
                    price = 184310;
                }
            }else if(zz_=="3000"){
                if(c_=="2"){
                    price = 176370;
                }else if(c_=="3"){
                    price = 187530;
                }else if(c_=="4"){
                    price = 198700;
                }else if(c_=="5"){
                    price = 209870;
                }else if(c_=="6"){
                    price = 221040;
                }else if(c_=="7"){
                    price = 232210;
                }else if(c_=="8"){
                    price = 243380;
                }
            }
        }else if(sd_=="1.0"){
            if(zz_=="1000"){
                if(c_=="2"){
                    price = 96070;
                }else if(c_=="3"){
                    price = 99860;
                }else if(c_=="4"){
                    price = 103650;
                }else if(c_=="5"){
                    price = 107440
                }else if(c_=="6"){
                    price = 111240;
                }else if(c_=="7"){
                    price = 115030;
                }else if(c_=="8"){
                    price = 118820;
                }else if(c_=="9"){
                    price = 122610;
                }else if(c_=="10"){
                    price = 126400;
                }else if(c_=="11"){
                    price = 131090;
                }else if(c_=="12"){
                    price = 135080;
                }else if(c_=="13"){
                    price = 139080;
                }else if(c_=="14"){
                    price = 143080;
                }else if(c_=="15"){
                    price = 147070;
                }
            }else if(zz_=="2000"){
                if(c_=="2"){
                    price = 140720;
                }else if(c_=="3"){
                    price = 149860;
                }else if(c_=="4"){
                    price = 159010;
                }else if(c_=="5"){
                    price = 168150;
                }else if(c_=="6"){
                    price = 177300;
                }else if(c_=="7"){
                    price = 186440;
                }else if(c_=="8"){
                    price = 195590;
                }else if(c_=="9"){
                    price = 204730;
                }else if(c_=="10"){
                    price = 213880;
                }else if(c_=="11"){
                    price = 223020;
                }else if(c_=="12"){
                    price = 232160;
                }else if(c_=="13"){
                    price = 241310;
                }else if(c_=="14"){
                    price = 250450;
                }else if(c_=="15"){
                    price = 259600;
                }
            }else if(zz_=="3000"){
                if(c_=="2"){
                    price = 193160;
                }else if(c_=="3"){
                    price = 204300;
                }else if(c_=="4"){
                    price = 215430;
                }else if(c_=="5"){
                    price = 226570;
                }else if(c_=="6"){
                    price = 237710;
                }else if(c_=="7"){
                    price = 248850;
                }else if(c_=="8"){
                    price = 259980;
                }else if(c_=="9"){
                    price = 271120;
                }else if(c_=="10"){
                    price = 282260;
                }else if(c_=="11"){
                    price = 293400;
                }else if(c_=="12"){
                    price = 304540;
                }else if(c_=="13"){
                    price = 315670;
                }else if(c_=="14"){
                    price = 326810;
                }else if(c_=="15"){
                    price = 337950;
                }
            }
        }
        $("#SBJ_TEMP").val(price);
        countZhj();
    }

    //修改载重时
    function editZz(){
        var zz_ = $("#BZ_ZZ").val();
        if(zz_=="1000"){    //载重1000时
            //修改轿厢规格
            $("#BASE_JXGG").val("1000D-1400*1600");
            //修改轿厢高度
            $("input[name='BASE_JXGD'][value='2200mm']").attr("checked",true);
            //修改开门尺寸
            $("#BASE_KMCC").val("900mm*2100mm(1000kg)");
            //修改开门形式下拉框内容
            $("#BZ_KMXS").empty();
            $("#BZ_KMXS").append("<option value='中分'>中分</option>");

        }else if(zz_=="2000"){  //载重2000时
            //修改轿厢规格
            $("#BASE_JXGG").val("2000D-1700*2400");
            //修改轿厢高度
            $("input[name='BASE_JXGD'][value='2300mm']").attr("checked",true);
            //修改开门尺寸
            $("#BASE_KMCC").val("1500mm*2100mm(2000kg)");
            //修改开门形式下拉框内容
            $("#BZ_KMXS").empty();
            $("#BZ_KMXS").append("<option value='左旁开'>左旁开</option><option value='右旁开'>右旁开</option>");

        }else if(zz_=="3000"){  //载重3000时
            //修改轿厢规格
            $("#BASE_JXGG").val("3000D-2000*2800");
            //修改轿厢高度
            $("input[name='BASE_JXGD'][value='2400mm']").attr("checked",true);
            //修改开门尺寸
            $("#BASE_KMCC").val("2000mm*2100mm(3000kg)");
            //修改开门形式下拉框内容
            $("#BZ_KMXS").empty();
            $("#BZ_KMXS").append("<option value='中分双折'>中分双折</option>");
        }
    }

    //修改速度时
    function editSd(){
        var sd_ = $("#BZ_SD").val();
        if(sd_=="0.5"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='2' ${regelevStandardPd.C=='2'?'selected':''}>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }
    }

    //修改门数量时修改标准价格
    function setMPrice(){
        var m_ = parseInt($("#BZ_M").val());
        var c_ = parseInt($("#BZ_C").val());
        var price = parseInt($("#FEISHANG_SBJ").val());
        var kmkd_ = parseInt($("#BZ_KMKD").val());
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(price)){
            var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="900"){
                    price = price-2400*jm;
                }else if(kmkd_=="1500"){
                    price = price-4300*jm;
                }else if(kmkd_=="2000"){
                    price = price-5800*jm;
                }
            }
            $("#SBJ_TEMP").val(price);
            countZhj();
        }
    }

    function countZhj(){
        var zhj_count = 0;
        var sbj_count = 0;
        var base_jdzg_temp = $("#BASE_JDZG_TEMP").val()==""?0:parseInt($("#BASE_JDZG_TEMP").val());
        var base_dgzj_temp = $("#BASE_DGZJ_TEMP").val()==""?0:parseInt($("#BASE_DGZJ_TEMP").val());
        var opt_xfld_temp = $("#OPT_XFLD_TEMP").val()==""?0:parseInt($("#OPT_XFLD_TEMP").val());
        var opt_twxftfw_temp = $("#OPT_TWXFYFW_TEMP").val()==""?0:parseInt($("#OPT_TWXFYFW_TEMP").val());
        var opt_jxdzz_temp = $("#OPT_JXDZZ_TEMP").val()==""?0:parseInt($("#OPT_JXDZZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt($("#OPT_CCTVDL_TEMP").val());
        var opt_tdyjjy_temp = $("#OPT_TDYJJY_TEMP").val()==""?0:parseInt($("#OPT_TDYJJY_TEMP").val());
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt($("#OPT_DJGRBH_TEMP").val());
        var opt_wlw_temp = $("#OPT_WLW_TEMP").val()==""?0:parseInt($("#OPT_WLW_TEMP").val());
        var opt_bajk_temp = $("#OPT_BAJK_TEMP").val()==""?0:parseInt($("#OPT_BAJK_TEMP").val());
        var opt_yybz_temp = $("#OPT_YYBZ_TEMP").val()==""?0:parseInt($("#OPT_YYBZ_TEMP").val());
        var opt_fdlcz_temp = $("#OPT_FDLCZ_TEMP").val()==""?0:parseInt($("#OPT_FDLCZ_TEMP").val());
        var opt_jjbydyczzz_temp = $("#OPT_JJBYDYCZZZ_TEMP").val()==""?0:parseInt($("#OPT_JJBYDYCZZZ_TEMP").val());
        var opt_lopangs_temp = $("#OPT_LOPANGS_TEMP").val()==""?0:parseInt($("#OPT_LOPANGS_TEMP").val());
        var opt_gtjx_temp = $("#OPT_GTJX_TEMP").val()==""?0:parseInt($("#OPT_GTJX_TEMP").val());
        var opt_gtcs_temp = $("#OPT_GTCS_TEMP").val()==""?0:parseInt($("#OPT_GTCS_TEMP").val());
        var jxzh_fztxh_temp = $("#JXZH_FZTXH_TEMP").val()==""?0:parseInt($("#JXZH_FZTXH_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt($("#JXZH_BGJ_TEMP").val());
        var jxzh_bxgdb_temp = $("#JXZH_BXGDB_TEMP").val()==""?0:parseInt($("#JXZH_BXGDB_TEMP").val());
        var jxzh_bxgdd_temp = $("#JXZH_BXGDD_TEMP").val()==""?0:parseInt($("#JXZH_BXGDD_TEMP").val());
        var jxzh_hwb_temp = $("#JXZH_HWB_TEMP").val()==""?0:parseInt($("#JXZH_HWB_TEMP").val());
        var jxzh_cwb_temp = $("#JXZH_CWB_TEMP").val()==""?0:parseInt($("#JXZH_CWB_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt($("#JXZH_QWB_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt($("#JXZH_JM_TEMP").val());
        var tmmt_dmt_temp = $("#TMMT_DMT_TEMP").val()==""?0:parseInt($("#TMMT_DMT_TEMP").val());
        var tmmt_fwbxgxmt_temp = $("#TMMT_FWBXGXMT_TEMP").val()==""?0:parseInt($("#TMMT_FWBXGXMT_TEMP").val());
        var tmmt_fwbxgtm_temp = $("#TMMT_FWBXGTM_TEMP").val()==""?0:parseInt($("#TMMT_FWBXGTM_TEMP").val());
        zhj_count = jxzh_fztxh_temp+jxzh_bgj_temp+jxzh_bxgdb_temp+jxzh_bxgdd_temp+jxzh_hwb_temp+jxzh_cwb_temp+jxzh_qwb_temp+jxzh_jm_temp;
        $("#FEISHANG_ZHJ").val(zhj_count);

        sbj_count = base_jdzg_temp+base_dgzj_temp+opt_xfld_temp+opt_twxftfw_temp+opt_jxdzz_temp+opt_cctvdl_temp+opt_tdyjjy_temp+opt_djgrbh_temp+opt_wlw_temp+opt_bajk_temp+opt_yybz_temp+opt_fdlcz_temp+opt_jjbydyczzz_temp+opt_lopangs_temp+opt_gtjx_temp+opt_gtcs_temp+tmmt_dmt_temp+tmmt_fwbxgxmt_temp+tmmt_fwbxgtm_temp;

        //设备标准价格
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#FEISHANG_SBJ").val(sbj_temp+sbj_count);

        //运输费
        var feishang_ysf = $("#FEISHANG_YSF").val()==""?0:parseInt($("#FEISHANG_YSF").val());
        $("#FEISHANG_YSF").val(feishang_ysf);
        //安装费
        var feishang_azf = $("#FEISHANG_AZF_TEMP").val()==""?0:parseInt($("#FEISHANG_AZF_TEMP").val());
        $("#FEISHANG_AZF").val(feishang_azf);

        var feishang_zk = parseFloat($("#FEISHANG_ZK").val())/100;
        if(!isNaN(feishang_zk)){
            var feishang_sbj = parseInt($("#SBJ_TEMP").val());
            var feishang_sjbj = (feishang_sbj+zhj_count+sbj_count+feishang_ysf+feishang_azf)*feishang_zk;
            var feishang_zhsbj = feishang_sbj*feishang_zk;
            $("#FEISHANG_SJBJ").val(feishang_sjbj);
            $("#FEISHANG_ZHSBJ").val(feishang_zhsbj);
            $("#zk_").text($("#FEISHANG_ZK").val()+"%");
        }
        
    }

    //调用参考报价之后计算价格
    function cbjPrice(){
        //井道总高
        setJdzg();
        //导轨支架
        setDgzj();
        //可选功能
        editOpt('OPT_XFLD');
        editOpt('OPT_TWXFYFW');
        editOpt('OPT_JXDZZ');
        editOpt('OPT_CCTVDL');
        editOpt('OPT_TDYJJY');
        editOpt('OPT_DJGRBH');
        editOpt('OPT_WLW');
        editOpt('OPT_BAJK');
        editOpt('OPT_YYBZ');
        editOpt('OPT_FDLCZ');
        editOpt('OPT_JJBYDYCZZZ');
        editOpt('OPT_LOPANGS');
        editOpt('OPT_GTJX');
        editOpt('OPT_GTCS');
        //轿厢装潢
        editJxzh('JXZH_JM');
        editJxzh('JXZH_QWB');
        editJxzh('JXZH_CWB');
        editJxzh('JXZH_HWB');
        editJxzh('JXZH_BXGDD');
        editJxzh('JXZH_BXGDB');
        editJxzh('JXZH_BGJ');
        editJxzh('JXZH_FZTXH');
        //厅门门套
        editTmmt('TMMT_FWBXGTM');
        editTmmt('TMMT_FWBXGXMT');
        editTmmt('TMMT_DMT');
    }

    //计算井道总高-加价
    function setJdzg(){
        var tsgd_ = parseInt($("#BASE_TSGD").val());    //提升高度
        var dksd_ = parseInt($("#BASE_DKSD").val());     //底坑深度
        var dcgd_ = parseInt($("#BASE_DCGD").val());    //顶层高度
        if(!isNaN(tsgd_)&&!isNaN(dksd_)&&!isNaN(dcgd_)){
            var jdzg_ = tsgd_+dksd_+dcgd_;  //井道总高
            $("#BASE_JDZG").val(jdzg_);
            //加价
            var price = 0;
            var zz_ = $("#BZ_ZZ").val();  //载重
            var c_ = parseInt($("#BZ_C").val())   //层数
            if(zz_=="1000"){
                var K = 3850;
                var S = 1250;
                var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
                price = 720*((jdzg_-jdzg_std)/100);
                var dgzj_std = Math.ceil((jdzg_std/2500)+1);//导轨支架标准档数
                $("#BASE_DGZJ").val(dgzj_std);
            }else if(zz_=="2000"){
                var K = 4300;
                var S = 1500;
                var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
                price = 770*((jdzg_-jdzg_std)/100);
                var dgzj_std = Math.ceil((jdzg_std/2000)+1);//导轨支架标准档数
                $("#BASE_DGZJ").val(dgzj_std);
            }else if(zz_=="3000"){
                var K = 4300;
                var S = 1500;
                var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
                price = 890*((jdzg_-jdzg_std)/100);
                var dgzj_std = Math.ceil((jdzg_std/2000)+1);//导轨支架标准档数
                $("#BASE_DGZJ").val(dgzj_std);
            }
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
            var c_ = parseInt($("#BZ_C").val())   //层数
            var jdzg_std = 0;   //井道总高(标准)
            var dgzj_std = 0;   //导轨支架档数(标准)
            if(zz_=="1000"){
                var K = 3850;
                var S = 1250;
                jdzg_std = 3000*(c_-1)+K+S;
            }else if(zz_=="2000"){
                var K = 4300;
                var S = 1500;
                jdzg_std = 3000*(c_-1)+K+S;
            }else if(zz_=="3000"){
                var K = 4300;
                var S = 1500;
                jdzg_std = 3000*(c_-1)+K+S;
            }
            if(zz_=="1000"){
                dgzj_std = (jdzg_std/2500)+1;
            }else if(zz_=="2000"||zz_=="3000"){
                dgzj_std = (jdzg_std/2000)+1;
            }
            var price = (dgzj_-dgzj_std)*450;
            $("#BASE_DGZJ").val(dgzj_std);
            $("#BASE_DGZJ_TEMP").val(price);
            //放入价格
            countZhj();
        }
    }

    //可选功能部分加价
    function editOpt(option){
        //数量
        var sl_ = $("#FEISHANG_SL").val()==""?0:parseInt($("#FEISHANG_SL").val());
        //价格
        var price = 0;
        if(option=="OPT_XFLD"){
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
        }else if(option=="OPT_JXDZZ"){
            //轿厢到站钟
            if($("#OPT_JXDZZ_TEXT").is(":checked")){
                price = 180*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JXDZZ_TEMP").val(price);
        }else if(option=="OPT_CCTVDL"){
            //CCTV电缆
            if($("#OPT_CCTVDL_TEXT").is(":checked")){
                var test = $("#BASE_TSGD").val();
                if(!isNaN(parseInt($("#BASE_TSGD").val()))){
                    var tsgd_ = parseInt($("#BASE_TSGD").val());  //提升高度
                    price = 16*(tsgd_+15)*sl_;
                }
            }else{
                price = 0;
            }
            $("#OPT_CCTVDL_TEMP").val(price);
        }else if(option=="OPT_TDYJJY"){
            //停电应急救援
            if($("#OPT_TDYJJY_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                var sd_ = $("#BZ_SD").val();  //速度
                if(zz_=="3000"&&sd_=="1.0"){
                    price = 9000*sl_;
                }else{
                    price = 7300*sl_;
                }
            }else{
                price = 0;
            }
            $("#OPT_TDYJJY_TEMP").val(price);
        }else if(option=="OPT_DJGRBH"){
            //电机过热保护
            if($("#OPT_DJGRBH_TEXT").is(":checked")){
                price = 620*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DJGRBH_TEMP").val(price);
        }else if(option=="OPT_WLW"){
            //物联网
            if($("#OPT_WLW_TEXT").is(":checked")){
                price = 3700*sl_;
            }else{
                price = 0;
            }
            $("#OPT_WLW_TEMP").val(price);
        }else if(option=="OPT_BAJK"){
            //BA接口
            if($("#OPT_BAJK_TEXT").is(":checked")){
                price = 620*sl_;
            }else{
                price = 0;
            }
            $("#OPT_BAJK_TEMP").val(price);
        }else if(option=="OPT_YYBZ"){
            //语音报站
            if($("#OPT_YYBZ_TEXT").is(":checked")){
                price = 1200*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YYBZ_TEMP").val(price);
        }else if(option=="OPT_FDLCZ"){
            //防捣乱操作
            if($("#OPT_FDLCZ_TEXT").is(":checked")){
                price = 120*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FDLCZ_TEMP").val(price);
        }else if(option=="OPT_JJBYDYCZZZ"){
            //紧急备用电源操作装置
            if($("#OPT_JJBYDYCZZZ_TEXT").is(":checked")){
                price = 3100*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JJBYDYCZZZ_TEMP").val(price);
        }else if(option=="OPT_LOPANGS"){
            //LOP按钮个数
            console.log($("#OPT_LOPANGS").val());
            if(!isNaN(parseInt($("#OPT_LOPANGS").val()))){
                var lopangs_ = parseInt($("#OPT_LOPANGS").val());
                price = 30*lopangs_;   
            }
            $("#OPT_LOPANGS_TEMP").val(price);
        }else if(option=="OPT_GTJX"){
            //贯通轿厢
            if($("#OPT_GTJX_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 10000;
                }else if(zz_=="2000"){
                    price = 12000;
                }else if(zz_=="3000"){
                    price = 13100;
                } 
            }else{
                price = 0;
            }
            $("#OPT_GTJX_TEMP").val(price);
        }else if(option=="OPT_GTCS"){
            //贯通层数
            if(!isNaN(parseInt($("#OPT_GTCS").val()))){
                var gtcs_ = parseInt($("#OPT_GTCS").val());
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 2400*gtcs_;
                }else if(zz_=="2000"){
                    price = 4300*gtcs_;
                }else if(zz_=="3000"){
                    price = 5100*gtcs_;
                }
            }else{
                price = 0;
            }
            $("#OPT_GTCS_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //轿厢装潢部分-加价
    function editJxzh(option){
        //数量
        var sl_ = $("#FEISHANG_SL").val()==""?0:parseInt($("#FEISHANG_SL").val());
        //价格
        var price = 0;
        if(option=="JXZH_JM"){
            //轿门
            var jm_ = $("input[name='JXZH_JM']:checked").val();
            if(jm_=="SUS 443发纹不锈钢"){
                setJmsbhDisable("1");
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                if(kmkd_=="900"){
                    price = 1000;
                }else if(kmkd_=="1500"){
                    price = 1700;
                }else if(kmkd_=="2000"){
                    price = 2200;
                }
            }else{
                setJmsbhDisable("0");
                price = 0;
            }
            $("#JXZH_JM_TEMP").val(price);
        }else if(option=="JXZH_QWB"){
            //前围壁
            var qwb_ = $("input[name='JXZH_QWB']:checked").val();
            if(qwb_=="SUS 443发纹不锈钢"){
                setQwbsbhDisable("1");
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                if(kmkd_=="900"){
                    price = 4000;
                }else if(kmkd_=="1500"){
                    price = 8000;
                }else if(kmkd_=="2000"){
                    price = 10000;
                }
            }else{
                setQwbsbhDisable("0");
                price = 0;
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_CWB"){
            //侧围壁
            var cwb_ = $("input[name='JXZH_CWB']:checked").val();
            if(cwb_=="SUS 443发纹不锈钢"){
                setCwbsbhDisable("1");
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                if(kmkd_=="900"){
                    price = 4000;
                }else if(kmkd_=="1500"){
                    price = 8000;
                }else if(kmkd_=="2000"){
                    price = 10000;
                }
            }else{
                setCwbsbhDisable("0");
                price = 0;
            }
            $("#JXZH_CWB_TEMP").val(price);
        }else if(option=="JXZH_HWB"){
            //后围壁
            var hwb_ = $("input[name='JXZH_HWB']:checked").val();
            if(hwb_=="SUS 443发纹不锈钢"){
                setHwbsbhDisable("1");
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                if(kmkd_=="900"){
                    price = 4000;
                }else if(kmkd_=="1500"){
                    price = 8000;
                }else if(kmkd_=="2000"){
                    price = 10000;
                }
            }else{
                setHwbsbhDisable("0");
                price = 0;
            }
            $("#JXZH_HWB_TEMP").val(price);
        }else if(option=="JXZH_BXGDD"){
            //不锈钢吊顶
            if($("#JXZH_BXGDD_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 1200;
                }else if(zz_=="2000"){
                    price = 2300;
                }else if(zz_=="3000"){
                    price = 3500;
                }
            }else{
                price = 0;
            }
            $("#JXZH_BXGDD_TEMP").val(price);
        }else if(option=="JXZH_BXGDB"){
            //不锈钢地板
            if($("#JXZH_BXGDB_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 3100;
                }else if(zz_=="2000"){
                    price = 5400;
                }else if(zz_=="3000"){
                    price = 7700;
                }
            }else{
                price = 0;
            }
            $("#JXZH_BXGDB_TEMP").val(price);
        }else if(option=="JXZH_BGJ"){
            //半高镜
            if($("#JXZH_BGJ_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 800;
                }else if(zz_=="2000"){
                    price = 1500;
                }else if(zz_=="3000"){
                    price = 1800;
                }
            }else{
                price = 0;
            }
            $("#JXZH_BGJ_TEMP").val(price);
        }else if(option=="JXZH_FZTXH"){
            //防撞条型号
            if($("input[name='JXZH_FZTXH']:checked").val()!="无"){
                setFztxhDisable('0');
                var fztxh_ = $("#JXZH_FZTXH_SELECT").val();
                if(fztxh_=="木条"){
                    price = 1500;
                }else if(fztxh_=="橡胶条"){
                    price = 2200;
                }
            }else{
                setFztxhDisable('1');
                price = 0;
            }
            $("#JXZH_FZTXH_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //厅门门套部分-加价
    function editTmmt(option){
        //数量
        var sl_ = $("#FEISHANG_SL").val()==""?0:parseInt($("#FEISHANG_SL").val());
        //价格
        var price = 0;
        if(option=="TMMT_FWBXGTM"){
            //发纹不锈钢厅门
            if($("#TMMT_FWBXGTM_TEXT").is(":checked")){
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                var c_ = parseInt($("#BZ_C").val());    //层数
                if(kmkd_=="900"){
                    price = 980*c_*sl_;
                }else if(kmkd_=="1500"){
                    price = 1700*c_*sl_;
                }else if(kmkd_=="2000"){
                    price = 2200*c_*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_FWBXGTM_TEMP").val(price);
        }else if(option=="TMMT_FWBXGXMT"){
            //发纹不锈钢小门套
            if($("#TMMT_FWBXGXMT_TEXT").is(":checked")){
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                var c_ = parseInt($("#BZ_C").val());    //层数
                if(kmkd_=="900"){
                    price = 310*c_*sl_;
                }else if(kmkd_=="1500"){
                    price = 540*c_*sl_;
                }else if(kmkd_=="2000"){
                    price = 690*c_*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_FWBXGXMT_TEMP").val(price);
        }else if(option=="TMMT_DMT"){
            //大门套
            var dmt_ = $("input[name='TMMT_DMT']:checked").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var c_ = parseInt($("#BZ_C").val());    //层数
            if(dmt_=="喷涂"){
                if(kmkd_=="900"){
                    price = 1500*c_*sl_;
                }else if(kmkd_=="1500"){
                    price = 2300*c_*sl_;
                }else if(kmkd_=="2000"){
                    price = 3100*c_*sl_;
                }
            }else if(dmt_=="发纹不锈钢"){
                if(kmkd_=="900"){
                    price = 2100*c_*sl_;
                }else if(kmkd_=="1500"){
                    price = 3400*c_*sl_;
                }else if(kmkd_=="2000"){
                    price = 4500*c_*sl_;
                }
            }
            $("#TMMT_DMT_TEMP").val(price);
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
                        $("#FEISHANG_YSF").val(transPrice);
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
                        $("#FEISHANG_YSF").val(transPrice);
                        countZhj();
                    }
                );
        }

    }

    function save(){
        //非标json
        var fbDescription = "";
        var fbPrice = "";
        var fbDate = "";
        var jsonStr = "[";

        $("#fbTable tr:not(:first)").each(function(){
            fbDescription = $(this).find("td").eq(0).find("input").eq(0).val();
            fbPrice = $(this).find("td").eq(1).find("input").eq(0).val();
            fbDate = $(this).find("td").eq(2).find("input").eq(0).val();
            jsonStr += "{\'fbDescription\':\'"+fbDescription+"\',\'fbPrice\':\'"+fbPrice+"\',\'fbDate\':\'"+fbDate+"\'},";
        });
        jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
        $("#UNSTD").val(jsonStr);

        //井道承重墙厚度
        if($("input[name='BASE_JDCZQHD']:checked").val()!="250"){
            $("input[name='BASE_JDCZQHD']:checked").val($("#BASE_JDCZQHD_TEXT").val());
        }
        //轿厢装潢地板型号
        if($("input[name='JXZH_DBXH']:checked").val()!="PVC地板革"&&$("input[name='JXZH_DBXH']:checked").val()!="碳钢花纹钢板"){
            $("input[name='JXZH_DBXH']:checked").val($("#JXZH_DBXH_SELECT").val());
        }
        //防撞条型号
        if($("input[name='JXZH_FZTXH']:checked").val()!="无"){
            $("input[name='JXZH_FZTXH']:checked").val($("#JXZH_FZTXH_SELECT").val());
        }
        //轿厢装潢
        if($("#JXZH_BXGDD_TEXT").is(":checked")){
            $("#JXZH_BXGDD").val("1");
        }else{
            $("#JXZH_BXGDD").val("0");
        }
        if($("#JXZH_BXGDB_TEXT").is(":checked")){
            $("#JXZH_BXGDB").val("1");
        }else{
            $("#JXZH_BXGDB").val("0");
        }
        if($("#JXZH_BGJ_TEXT").is(":checked")){
            $("#JXZH_BGJ").val("1");
        }else{
            $("#JXZH_BGJ").val("0");
        }
        //厅门门套
        if($("#TMMT_FWBXGTM_TEXT").is(":checked")){
            $("#TMMT_FWBXGTM").val("1");
        }else{
            $("#TMMT_FWBXGTM").val("0");
        }
        if($("#TMMT_FWBXGXMT_TEXT").is(":checked")){
            $("#TMMT_FWBXGXMT").val("1");
        }else{
            $("#TMMT_FWBXGXMT").val("0");
        }
        //可选功能
        if($("#OPT_XFLD_TEXT").is(":checked")){
            $("#OPT_XFLD").val("1");
        }else{
            $("#OPT_XFLD").val("0");
        }
        if($("#OPT_SJCZ_TEXT").is(":checked")){
            $("#OPT_SJCZ").val("1");
        }else{
            $("#OPT_SJCZ").val("0");
        }
        if($("#OPT_XFYYX_TEXT").is(":checked")){
            $("#OPT_XFYYX").val("1");
        }else{
            $("#OPT_XFYYX").val("0");
        }
        if($("#OPT_SZTJMSJ_TEXT").is(":checked")){
            $("#OPT_SZTJMSJ").val("1");
        }else{
            $("#OPT_SZTJMSJ").val("0");
        }
        if($("#OPT_JXDZZ_TEXT").is(":checked")){
            $("#OPT_JXDZZ").val("1");
        }else{
            $("#OPT_JXDZZ").val("0");
        }
        if($("#OPT_BAJK_TEXT").is(":checked")){
            $("#OPT_BAJK").val("1");
        }else{
            $("#OPT_BAJK").val("0");
        }
        if($("#OPT_CCTVDL_TEXT").is(":checked")){
            $("#OPT_CCTVDL").val("1");
        }else{
            $("#OPT_CCTVDL").val("0");
        }
        if($("#OPT_YYBZ_TEXT").is(":checked")){
            $("#OPT_YYBZ").val("1");
        }else{
            $("#OPT_YYBZ").val("0");
        }
        if($("#OPT_TDYJJY_TEXT").is(":checked")){
            $("#OPT_TDYJJY").val("1");
        }else{
            $("#OPT_TDYJJY").val("0");
        }
        if($("#OPT_FDLCZ_TEXT").is(":checked")){
            $("#OPT_FDLCZ").val("1");
        }else{
            $("#OPT_FDLCZ").val("0");
        }
        if($("#OPT_DJGRBH_TEXT").is(":checked")){
            $("#OPT_DJGRBH").val("1");
        }else{
            $("#OPT_DJGRBH").val("0");
        }
        if($("#OPT_XJX_TEXT").is(":checked")){
            $("#OPT_XJX").val("1");
        }else{
            $("#OPT_XJX").val("0");
        }
        if($("#OPT_WLW_TEXT").is(":checked")){
            $("#OPT_WLW").val("1");
        }else{
            $("#OPT_WLW").val("0");
        }
        if($("#OPT_JJBYDYCZZZ_TEXT").is(":checked")){
            $("#OPT_JJBYDYCZZZ").val("1");
        }else{
            $("#OPT_JJBYDYCZZZ").val("0");
        }
        if($("#OPT_TWXFYFW_TEXT").is(":checked")){
            $("#OPT_TWXFYFW").val("1");
        }else{
            $("#OPT_TWXFYFW").val("0");
        }
        if($("#OPT_GTJX_TEXT").is(":checked")){
            $("#OPT_GTJX").val("1");
        }else{
            $("#OPT_GTJX").val("0");
        }
        $("#feishangForm").submit();
    }

</script>
</body>

</html>
