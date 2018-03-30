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
    <form action="e_offer/${msg}.do" name="feiyueForm" id="feiyueForm" method="post">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="FEIYUE_ID" id="FEIYUE_ID" value="${pd.FEIYUE_ID}">
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
                                                <option value="新飞越">新飞越</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()">
                                                <option value="630" ${regelevStandardPd.ZZ=='630'?'selected':''}>630</option>
                                                <option value="800" ${regelevStandardPd.ZZ=='800'?'selected':''}>800</option>
                                                <option value="1000" ${regelevStandardPd.ZZ=='1000'?'selected':''}>1000</option>
                                                <option value="1150" ${regelevStandardPd.ZZ=='1150'?'selected':''}>1150</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">速度(m/s):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_SD" name="BZ_SD" onchange="editSd();">
                                                <option value="1.0" ${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>
                                                <option value="1.75" ${regelevStandardPd.SD=='1.75'?'selected':''}>1.75</option>
                                                <option value="2.0" ${regelevStandardPd.SD=='2.0'?'selected':''}>2.0</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_KMXS" name="BZ_KMXS">
                                                <option value="中分" ${regelevStandardPd.KMXS=='中分'?'selected':''}>中分</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_KMKD" name="BZ_KMKD" onchange="setMPrice();">
                                                <option value="800" ${regelevStandardPd.KMXS=='800'?'selected':''}>800</option>
                                                <option value="900" ${regelevStandardPd.KMXS=='900'?'selected':''}>900</option>
                                                <option value="1100" ${regelevStandardPd.KMXS=='1100'?'selected':''}>1100</option>
                                                <option value="1200" ${regelevStandardPd.KMXS=='1200'?'selected':''}>1200</option>
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
                                            <label style="width:20%;margin-left:57px"><input type="text" class="form-control m-b" id="FEIYUE_SL" name="FEIYUE_SL" value="${pd.FEIYUE_SL}" readonly="readonly"></label>

                                            <label style="width:9%;margin-top: 25px;margin-bottom: 10px;margin-left: 20px">折扣申请:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="FEIYUE_ZK" name="FEIYUE_ZK" value="${pd.FEIYUE_ZK}" onkeyup="countZhj();"></label>%
                                            <!-- <select  class="form-control m-b" id="FEIYUE_ZK" name="FEIYUE_ZK" onchange="countZhj();">
                                                <option value="1">请选择折扣</option>
                                                <option value="0.9" ${pd.FEIYUE_ZK=='0.9'?'selected':''}>90%</option>
                                                <option value="0.6" ${pd.FEIYUE_ZK=='0.6'?'selected':''}>60%</option>
                                                <option value="0.5" ${pd.FEIYUE_ZK=='0.5'?'selected':''}>50%</option>
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
                                                    <td>${pd.FEIYUE_SL}</td>
                                                    <td>
                                                        ${regelevStandardPd.C}
                                                        /
                                                        ${regelevStandardPd.Z}
                                                        /
                                                        ${regelevStandardPd.M}
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYUE_ZHJ" id="FEIYUE_ZHJ" value="${pd.FEIYUE_ZHJ}"></td>
                                                    <td>
                                                        <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYUE_SBJ" id="FEIYUE_SBJ" value="${regelevStandardPd.PRICE}">
                                                        <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}">
                                                    </td>
                                                    <td><font color="red"><span id="zk_">${pd.FEIYUE_ZK}</span></font></td>
                                                    <td><font color="red"><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYUE_ZHSBJ" id="FEIYUE_ZHSBJ" value="${pd.FEIYUE_ZHSBJ}"></font></td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" name="FEIYUE_AZF" id="FEIYUE_AZF" value="${pd.FEIYUE_AZF}"  style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' onkeyup="countZhj();" />
                                                        </font>
                                                    </td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYUE_YSF" id="FEIYUE_YSF" value="${pd.FEIYUE_YSF}">
                                                        </font>
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYUE_SJBJ" id="FEIYUE_SJBJ" value="${pd.FEIYUE_SJBJ}"></td>
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
                                                                    <option value="STEP">STEP</option>
                                                                    <option value="Monarch">Monarch</option>
                                                                </select>
                                                            </td>
                                                            <td width="180">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>控制方式</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_KZFS" value="单台(G1C)" ${pd.BASE_KZFS=='单台(G1C)'?'checked':''}/>
                                                                单台(G1C)
                                                                <input type="radio" name="BASE_KZFS" value="两台并联(G2C)" ${pd.BASE_KZFS=='两台并联(G2C)'?'checked':''}/>
                                                                两台并联(G2C)
                                                                <input type="radio" name="BASE_KZFS" value="三台群控(G3C)" ${pd.BASE_KZFS=='三台群控(G3C)'?'checked':''}/>
                                                                三台群控(G3C)
                                                                <input type="radio" name="BASE_KZFS" value="四台群控(G4C)" ${pd.BASE_KZFS=='四台群控(G4C)'?'checked':''}/>
                                                                四台群控(G4C)   
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>号梯代码</td>
                                                            <td colspan="2">
                                                                <input type="text" name="BASE_HTDM" id="BASE_HTDM" class="form-control" value="${pd.BASE_HTDM}">
                                                            </td>
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
                                                                    <option value="1400×1100(630kg)" ${pd.BASE_JXGG=='1400×1100(630kg)'?'selected':''}>1400×1100(630kg)</option>
                                                                    <option value="1100×1400(630kg)" ${pd.BASE_JXGG=='1100×1400(630kg)'?'selected':''}>1100×1400(630kg)</option>
                                                                    <option value="1400×1350(800kg)" ${pd.BASE_JXGG=='1400×1350(800kg)'?'selected':''}>1400×1350(800kg)</option>
                                                                    <option value="1350×1400(800kg)" ${pd.BASE_JXGG=='1350×1400(800kg)'?'selected':''}>1350×1400(800kg)</option>
                                                                    <option value="1600×1400(1000kg)" ${pd.BASE_JXGG=='1600×1400(1000kg)'?'selected':''}>1600×1400(1000kg)</option>
                                                                    <option value="1100×2100(1000kg担架梯)" ${pd.BASE_JXGG=='1100×2100(1000kg担架梯)'?'selected':''}>1100×2100(1000kg担架梯)</option>
                                                                    <option value="1800×1500(1150kg)" ${pd.BASE_JXGG=='1800×1500(1150kg)'?'selected':''}>1800×1500(1150kg)</option>
                                                                </select>   
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">轿厢高度(非净高)</td>
                                                            <td>
                                                                <input type="radio" name="BASE_JXGD" value="2300" ${pd.BASE_JXGD=='2300'?'checked':''}/>2300mm
                                                                <input type="radio" name="BASE_JXGD" value="2500" ${pd.BASE_JXGD=='2500'?'checked':''}/>2500mm
                                                                <!-- <select name="BASE_JXGD_SELECT">
                                                                    <option value="2400(V=1.0m/s时,K≥4000)">2400(V=1.0m/s时,K≥4000)</option>
                                                                    <option value="2400(V=1.5m/s时,K≥4150)">2400(V=1.5m/s时,K≥4150)</option>
                                                                    <option value="2400(V=1.75m/s时,K≥4250)">2400(V=1.75m/s时,K≥4250)</option>
                                                                    <option value="2400(V=1.0m/s时,K≥4100)">2400(V=1.0m/s时,K≥4100)</option>
                                                                    <option value="2400(V=1.5m/s时,K≥4250)">2400(V=1.5m/s时,K≥4250)</option>
                                                                    <option value="2400(V=1.75m/s时,K≥4350)">2400(V=1.75m/s时,K≥4350)</option>
                                                                </select>
                                                                mm(450-1000kg) -->
                                                            </td>
                                                            <td rowspan="2">可选:
                                                                <input type="radio" name="BASE_JXGD" value="2400" ${pd.BASE_JXGD=='2400'?'checked':''}/>
                                                                2400mm 
                                                                <input type="radio" name="BASE_JXGD" value="2600" ${pd.BASE_JXGD=='2600'?'checked':''}/>
                                                                2600mm 
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td><!-- <input type="radio" name="BASE_JXGD" value="2500"/>2500mm -->
                                                                <!-- <select name="select" name="BASE_JXGD_SELECT">
                                                                    <option value="2500(V=1.0m/s时,K≥4100)">2500(V=1.0m/s时,K≥4100)</option>
                                                                    <option value="2500(V=1.5m/s时,K≥4200)">2500(V=1.5m/s时,K≥4200)</option>
                                                                    <option value="2500(V=1.75m/s时,K≥4300)">2500(V=1.75m/s时,K≥4300)</option>
                                                                </select>
                                                                mm(1350-1600kg) -->
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>门类型/门保护</td>
                                                            <td>
                                                                <input type="radio" name="BASE_MLXMBH" value="PM门机/2D光幕" onclick="setMlxmbhDisable('1');" ${pd.BASE_MLXMBH=='PM门机/2D光幕'?'checked':''}/>
                                                                PM门机/2D光幕
                                                            </td>
                                                            <td>
                                                                可选:
                                                                <input type="radio" name="BASE_MLXMBH" value="" onclick="setMlxmbhDisable('0');" ${pd.BASE_MLXMBH=='PM门机/2D光幕'?'':'checked'}/>
                                                                <select name="BASE_MLXMBH_TEXT" id="BASE_MLXMBH_TEXT" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="VVVF门机/2D光幕" ${pd.BASE_MLXMBH=='VVVF门机/2D光幕'?'selected':''}>VVVF门机</option>
                                                                </select>
                                                                /2D光幕
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道承重墙厚度</td>
                                                            <td width="317">
                                                                <input type="radio" name="BASE_JDCZQHD" value="250" onclick="setJdczqhdDisable('1');" ${pd.BASE_JDCZQHD=='250'?'checked':''} />
                                                                WT=250mm
                                                            </td>
                                                            <td width="424">
                                                                <input type="radio" name="BASE_JDCZQHD" value="" onclick="setJdczqhdDisable('0')" ${pd.BASE_JDCZQHD=='250'?'':'checked'}/>
                                                                WT=
                                                                <input name="BASE_JDCZQHD_TEXT" id="BASE_JDCZQHD_TEXT" type="text" class="form-control" value="${pd.BASE_JDCZQHD}"/>
                                                                mm
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
                                                          </tr><tr>
                                                            <td>井道总高</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDZG" id="BASE_JDZG" type="text" class="form-control" value="${pd.BASE_JDZG}"/>
                                                            </td>
                                                            <td>
                                                                <input type="text" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP" ></td>
                                                          </tr><tr>
                                                            <td>导轨支架</td>
                                                            <td colspan="2">
                                                                <input name="BASE_DGZJ" id="BASE_DGZJ" type="text" class="form-control" value="${pd.BASE_DGZJ}"/>
                                                            </td>
                                                            <td>
                                                                <input type="text" name="BASE_DGZJ_TEMP" id="BASE_DGZJ_TEMP" ></td>
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
                                                            <td width="224">全集选控制</td>
                                                            <td width="42">14</td>
                                                            <td width="241">故障自动检测</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>轿顶与机房紧急电动运行</td>
                                                            <td>15</td>
                                                            <td>关门时间保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>轿内应急照明</td>
                                                            <td>16</td>
                                                            <td>超载不启动（警示灯及蜂鸣器）</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>设置厅、轿门时间</td>
                                                            <td>17</td>
                                                            <td>运行次数显示</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>满载不停梯</td>
                                                            <td>18</td>
                                                            <td>警铃</td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>无呼自动返基站</td>
                                                            <td>19</td>
                                                            <td>厅和轿厢数字式位置指示器</td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>驻停</td>
                                                            <td>20</td>
                                                            <td>厅外和轿厢呼梯/登记</td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>外呼按钮嵌入自诊断</td>
                                                            <td>21</td>
                                                            <td>厅及轿厢运行方向显示</td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>防捣乱操作</td>
                                                            <td>22</td>
                                                            <td>轿厢防意外移动功能（UCMP)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>10</td>
                                                            <td>轿内通风手动及照明自动控制</td>
                                                            <td>23</td>
                                                            <td>2D光幕门保护装置</td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>盲文按钮</td>
                                                            <td>24</td>
                                                            <td>错误指令删除</td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>轿门防扒门</td>
                                                            <td>25</td>
                                                            <td>开、关门按钮</td>
                                                          </tr>
                                                          <tr>
                                                            <td>13</td>
                                                            <td>监控室与机房、轿厢对讲（不含机房到监控室线）</td>
                                                            <td>26</td>
                                                            <td>开门再平层</td>
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
                                                            <td>两台并联</td>
                                                            <td>
                                                                <input name="OPT_LTBL_TEXT" id="OPT_LTBL_TEXT" type="checkbox" onclick="editOpt('OPT_LTBL');" ${pd.OPT_LTBL=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_LTBL" id="OPT_LTBL">
                                                            </td>
                                                            <td><input type="text" name="OPT_LTBL_TEMP" id="OPT_LTBL_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>停电紧急救援</td>
                                                            <td>
                                                                <input name="OPT_TDJJJY_TEXT" id="OPT_TDJJJY_TEXT" type="checkbox" onclick="editOpt('OPT_TDJJJY');"  ${pd.OPT_TDJJJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TDJJJY" id="OPT_TDJJJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_TDJJJY_TEMP" id="OPT_TDJJJY_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>轿厢到站钟</td>
                                                            <td>
                                                                <input name="OPT_JXDZZ_TEXT" id="OPT_JXDZZ_TEXT" type="checkbox" onclick="editOpt('OPT_JXDZZ');"  ${pd.OPT_JXDZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JXDZZ" id="OPT_JXDZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JXDZZ_TEMP" id="OPT_JXDZZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>有司机操作</td>
                                                            <td>
                                                                <input name="OPT_SJCZ_TEXT" id="OPT_SJCZ_TEXT" type="checkbox" onclick="editOpt('OPT_SJCZ');"  ${pd.OPT_SJCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_SJCZ" id="OPT_SJCZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_SJCZ_TEMP" id="OPT_SJCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>CCTV电缆(轿厢到机房)</td>
                                                            <td>
                                                                <input name="OPT_CCTVDL_TEXT" id="OPT_CCTVDL_TEXT" type="checkbox" onclick="editOpt('OPT_CCTVDL');"  ${pd.OPT_CCTVDL=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_CCTVDL" id="OPT_CCTVDL">
                                                            </td>
                                                            <td><input type="text" name="OPT_CCTVDL_TEMP" id="OPT_CCTVDL_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>电机过热保护</td>
                                                            <td>
                                                                <input name="OPT_DJGRBH_TEXT" id="OPT_DJGRBH_TEXT" type="checkbox" onclick="editOpt('OPT_DJGRBH');"  ${pd.OPT_DJGRBH=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DJGRBH" id="OPT_DJGRBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_DJGRBH_TEMP" id="OPT_DJGRBH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>BA接口</td>
                                                            <td>
                                                                <input name="OPT_BAJK_TEXT" id="OPT_BAJK_TEXT" type="checkbox" onclick="editOpt('OPT_BAJK');" ${pd.OPT_BAJK=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_BAJK" id="OPT_BAJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_BAJK_TEMP" id="OPT_BAJK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>门保持按钮</td>
                                                            <td>
                                                                <input name="OPT_KMBC_TEXT" id="OPT_MBCAN_TEXT" type="checkbox" onclick="editOpt('OPT_MBCAN');" ${pd.OPT_MBCAN=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_MBCAN" id="OPT_MBCAN">
                                                            </td>
                                                            <td><input type="text" name="OPT_MBCAN_TEMP" id="OPT_MBCAN_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>开门再平层(1.0-1.75m/s)</td>
                                                            <td>
                                                                <input name="OPT_KMZPC_TEXT" id="OPT_KMZPC_TEXT" type="checkbox" onclick="editOpt('OPT_KMZPC');" ${pd.OPT_KMZPC=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_KMZPC" id="OPT_KMZPC">
                                                            </td>
                                                            <td><input type="text" name="OPT_KMZPC_TEMP" id="OPT_KMZPC_TEMP" class="form-control"></td>
                                                          </tr><tr>
                                                            <td>10</td>
                                                            <td>强迫关门</td>
                                                            <td>
                                                                <input name="OPT_QPGM_TEXT" id="OPT_QPGM_TEXT" type="checkbox" onclick="editOpt('OPT_QPGM');"  ${pd.OPT_QPGM=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_QPGM" id="OPT_QPGM">
                                                            </td>
                                                            <td><input type="text" name="OPT_QPGM_TEMP" id="OPT_QPGM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>远程监控(物联网系统)</td>
                                                            <td>
                                                                <input name="OPT_YCJK_TEXT" id="OPT_YCJK_TEXT" type="checkbox" onclick="editOpt('OPT_YCJK');"  ${pd.OPT_YCJK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YCJK" id="OPT_YCJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_YCJK_TEMP" id="OPT_YCJK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>500mm ＜机房高台＜=2000mm</td>
                                                            <td>
                                                                <input name="OPT_JFGT_TEXT" id="OPT_JFGT_TEXT" type="checkbox" onclick="editOpt('OPT_JFGT');"  ${pd.OPT_JFGT=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JFGT" id="OPT_JFGT">
                                                            </td>
                                                            <td><input type="text" name="OPT_JFGT_TEMP" id="OPT_JFGT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>13</td>
                                                            <td>IC卡(轿内控制)</td>
                                                            <td>
                                                                <select name="OPT_ICK" id="OPT_ICK" onchange="editOpt('OPT_ICK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="刷卡后手动选择到达楼层" ${pd.OPT_ICK=='刷卡后手动选择到达楼层'?'selected':''}>刷卡后手动选择到达楼层</option>
                                                                    <option value="刷卡后自动选择到达楼层" ${pd.OPT_ICK=='刷卡后自动选择到达楼层'?'selected':''}>刷卡后自动选择到达楼层</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ICK_TEMP" id="OPT_ICK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>14</td>
                                                            <td>IC卡制卡设备</td>
                                                            <td>
                                                                <input name="OPT_ICKZKSB_TEXT" id="OPT_ICKZKSB_TEXT" type="checkbox" onclick="editOpt('OPT_ICKZKSB');" ${pd.OPT_ICKZKSB=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_ICKZKSB" id="OPT_ICKZKSB">
                                                            </td>
                                                            <td><input type="text" name="OPT_ICKZKSB_TEMP" id="OPT_ICKZKSB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>15</td>
                                                            <td>IC卡卡片(张)</td>
                                                            <td>
                                                                <input name="OPT_ICKKP" id="OPT_ICKKP" type="text" onkeyup="editOpt('OPT_ICKKP');" class="form-control" value="${pd.OPT_ICKKP}"/>
                                                            </td>
                                                            <td><input type="text" name="OPT_ICKKP_TEMP" id="OPT_ICKKP_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>16</td>
                                                            <td>贯通门(轿厢、轿门部分)</td>
                                                            <td>
                                                                <input name="OPT_GTMJXJMBF_TEXT" id="OPT_GTMJXJMBF_TEXT" type="checkbox" onclick="editOpt('OPT_GTMJXJMBF');"  ${pd.OPT_GTMJXJMBF=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GTMJXJMBF" id="OPT_GTMJXJMBF">
                                                            </td>
                                                            <td>
                                                                <input type="text" name="OPT_GTMJXJMBF_TEMP" id="OPT_GTMJXJMBF_TEMP" class="form-control">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>17</td>
                                                            <td>贯通门(厅门部分)</td>
                                                            <td>
                                                                <select name="OPT_GTMTMBF" id="OPT_GTMTMBF" onchange="editOpt('OPT_GTMTMBF');" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value='发纹不锈钢' ${pd.OPT_GTMTMBF=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value='喷涂' ${pd.OPT_GTMTMBF=='喷涂'?'selected':''}>喷涂</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_GTMTMBF_TEMP" id="OPT_GTMTMBF_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                              <td>18</td>
                                                            <td>贯通门数</td>
                                                            <td>
                                                                <input type="text" name="OPT_GTMS" id="OPT_GTMS" class="form-control" value="${pd.OPT_GTMS}">
                                                            </td>
                                                            <td>
                                                                <input type="text" name="OPT_GTMTMBF_TEMP" id="OPT_GTMTMBF_TEMP" class="form-control">
                                                            </td>
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
                                                                <input name="DZJKSDJXT_DJTXFS" type="radio" value="分线制" ${pd.DZJKSDJXT_DJTXFS=='分线制'?'checked':''}/>
                                                                分线制
                                                                <input name="DZJKSDJXT_DJTXFS" type="radio" value="总线制" ${pd.DZJKSDJXT_DJTXFS=='总线制'?'checked':''}/>
                                                                总线制
                                                            </td>
                                                            <td width="326">对讲的电梯台数:    
                                                            <input name="DZJKSDJXT_DJTS" id="DZJKSDJXT_DJTS" type="text" onkeyup="editDzjksdjxt();" class="form-control" value="${pd.DZJKSDJXT_DJTS}"/>
                                                            台</td>
                                                          </tr>
                                                          <!-- <tr>
                                                            <td>关联电梯合同号</td>
                                                            <td colspan="2"><input type="text" class="form-control"/></td>
                                                          </tr> -->
                                                          <tr>
                                                            <td>备注</td>
                                                            <td colspan="2">标配五方对讲:轿厢、轿顶、底坑,控制柜,监控室;选择一对多时,10台一下项目标配为分线制多局对讲;10台以上项目标配为总线制对局对讲,对局对讲系统单个监控室主机的最大控制台数为64台</td>
                                                          </tr>
                                                          <tr>
                                                            <td>加价</td>
                                                            <td colspan="2"><input type="text" name="DZJKSDJXT_DJTS_TEMP" id="DZJKSDJXT_DJTS_TEMP" class="form-control"/></td>
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
                                                                <input name="JXZH_JM" type="radio" value="SUS304发纹不锈钢" onclick="setJmsbhDisable('1');" ${pd.JXZH_JM=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_JM" type="radio" value="镜面不锈钢" onclick="setJmsbhDisable('1');" ${pd.JXZH_JM=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_JM" type="radio" value="喷涂" onclick="setJmsbhDisable('0');" ${pd.JXZH_JM=='喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_JMSBH" id="JXZH_JMSBH" class="form-control">
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
                                                                <input name="JXZH_QWB" type="radio" value="SUS304发纹不锈钢" onclick="setQwbsbhDisable('1');" ${pd.JXZH_QWB=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_QWB" type="radio" value="镜面不锈钢" onclick="setQwbsbhDisable('1');" ${pd.JXZH_QWB=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_QWB" type="radio" value="喷涂" onclick="setQwbsbhDisable('0');" ${pd.JXZH_QWB=='喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_QWBSBH" id="JXZH_QWBSBH" class="form-control">
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
                                                                <input name="JXZH_CWB" type="radio" value="SUS304发纹不锈钢" onclick="setCwbsbhDisable('1');"/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_CWB" type="radio" value="镜面不锈钢" onclick="setCwbsbhDisable('1');"/>
                                                                镜面不锈钢
                                                                <input name="JXZH_CWB" type="radio" value="喷涂" onclick="setCwbsbhDisable('0');"/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_CWBSBH" id="JXZH_CWBSBH" class="form-control">
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
                                                                <input name="JXZH_HWB" type="radio" value="SUS304发纹不锈钢" onclick="setHwbsbhDisable('1');" ${pd.JXZH_HWB=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_HWB" type="radio" value="镜面不锈钢" onclick="setHwbsbhDisable('1');" ${pd.JXZH_HWB=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_HWB" type="radio" value="喷涂" onclick="setHwbsbhDisable('0');" ${pd.JXZH_HWB=='喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_HWBSBH" id="JXZH_HWBSBH" class="form-control">
                                                                  <option value=''>请选择</option>
                                                                  <option value="P-01" ${pd.JXZH_HWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                  <option value="P-02" ${pd.JXZH_HWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                  <option value="P-03" ${pd.JXZH_HWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                  <option value="P-04" ${pd.JXZH_HWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                  <option value="P-05" ${pd.JXZH_HWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                  <option value="P-06" ${pd.JXZH_HWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                  <option value="P-07" ${pd.JXZH_HWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_HWB_TEMP" id="JXZH_HWB_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">轿门装潢</td>
                                                            <td colspan="2">
                                                                <select name="JXZH_JMZH" id="JXZH_JMZH" onclick="editJxzh('JXZH_JMZH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JF-K-C01" ${pd.JXZH_JMZH=='JF-K-C01'?'selected':''}>JF-K-C01</option>
                                                                    <option value="JF-K-C02" ${pd.JXZH_JMZH=='JF-K-C02'?'selected':''}>JF-K-C02</option>
                                                                    <option value="JF-K-C03" ${pd.JXZH_JMZH=='JF-K-C03'?'selected':''}>JF-K-C03</option>
                                                                    <option value="JF-K-C04" ${pd.JXZH_JMZH=='JF-K-C04'?'selected':''}>JF-K-C04</option>
                                                                    <option value="JF-K-C05" ${pd.JXZH_JMZH=='JF-K-C05'?'selected':''}>JF-K-C05</option>
                                                                    <option value="JF-K-C06" ${pd.JXZH_JMZH=='JF-K-C06'?'selected':''}>JF-K-C06</option>
                                                                    <option value="JF-K-C07" ${pd.JXZH_JMZH=='JF-K-C07'?'selected':''}>JF-K-C07</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_JMZH_TEMP" id="JXZH_JMZH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">轿厢装潢</td>
                                                            <td colspan="2">
                                                                <select name="JXZH_JXZH" id="JXZH_JXZH" onclick="editJxzh('JXZH_JXZH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JF-K-JX-01" ${pd.JXZH_JXZH=='JF-K-JX-01'?'selected':''}>JF-K-JX-01</option>
                                                                    <option value="JF-K-JX-02" ${pd.JXZH_JXZH=='JF-K-JX-02'?'selected':''}>JF-K-JX-02</option>
                                                                    <option value="JF-K-JX-03" ${pd.JXZH_JXZH=='JF-K-JX-03'?'selected':''}>JF-K-JX-03</option>
                                                                    <option value="JF-K-JX-04" ${pd.JXZH_JXZH=='JF-K-JX-04'?'selected':''}>JF-K-JX-04</option>
                                                                    <option value="JF-K-JX-05" ${pd.JXZH_JXZH=='JF-K-JX-05'?'selected':''}>JF-K-JX-05</option>
                                                                    <option value="JF-K-JX-06" ${pd.JXZH_JXZH=='JF-K-JX-06'?'selected':''}>JF-K-JX-06</option>
                                                                    <option value="JF-K-JX-07" ${pd.JXZH_JXZH=='JF-K-JX-07'?'selected':''}>JF-K-JX-07</option>
                                                                    <option value="JF-K-JX-08" ${pd.JXZH_JXZH=='JF-K-JX-08'?'selected':''}>JF-K-JX-08</option>
                                                                    <option value="JF-K-JX-09" ${pd.JXZH_JXZH=='JF-K-JX-09'?'selected':''}>JF-K-JX-09</option>
                                                                    <option value="JF-K-JX-10" ${pd.JXZH_JXZH=='JF-K-JX-10'?'selected':''}>JF-K-JX-10</option>
                                                                    <option value="JF-K-JX-11" ${pd.JXZH_JXZH=='JF-K-JX-11'?'selected':''}>JF-K-JX-11</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_JXZH_TEMP" id="JXZH_JXZH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">轿顶装潢</td>
                                                            <td>
                                                                <input name="JXZH_JDZH" type="radio" value="悬吊式:JF-CL20(450-2000kg标准)" onclick="setJdzhDisable('0');"  ${pd.JXZH_JDZH=='悬吊式:JF-CL20(450-2000kg标准)'?'checked':''}/>
                                                                悬吊式:JF-CL20(450-2000kg标准)
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_JDZH" type="radio" value="集成式" onclick="setJdzhDisable('1');"  ${pd.JXZH_JDZH=='集成式'?'checked':''}/>
                                                                集成式:
                                                                <select name="JXZH_ZSDD" onchange="editJxzh('JXZH_ZSDD');" id="ZSDD_1" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="JF-CL-01" ${pd.JXZH_ZSDD=='JF-CL-01'?'selected':''}>JF-CL-01</option>
                                                                    <option value="JF-CL-02" ${pd.JXZH_ZSDD=='JF-CL-02'?'selected':''}>JF-CL-02</option>
                                                                    <option value="JF-CL-03" ${pd.JXZH_ZSDD=='JF-CL-03'?'selected':''}>JF-CL-03</option>
                                                                    <option value="JF-CL-04" ${pd.JXZH_ZSDD=='JF-CL-04'?'selected':''}>JF-CL-04</option>
                                                                 </select>
                                                                <input name="JXZH_JDZH" type="radio" value="悬吊式" onclick="setJdzhDisable('2');"  ${pd.JXZH_JDZH=='悬吊式'?'checked':''}/>
                                                                悬吊式:
                                                                <select name="JXZH_ZSDD" onchange="editJxzh('JXZH_ZSDD');" id="ZSDD_2" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="JF-CL-21" ${pd.JXZH_ZSDD=='JF-CL-21'?'selected':''}>JF-CL-21</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_ZSDD_TEMP" id="JXZH_ZSDD_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">安全窗</td>
                                                            <td>
                                                                <input name="JXZH_AQC" type="radio" value="无" onclick="editJxzh('JXZH_AQC');"  ${pd.JXZH_AQC=='无'?'checked':''}/>
                                                                无
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_AQC" type="radio" value="有" onclick="editJxzh('JXZH_AQC');" ${pd.JXZH_AQC=='有'?'checked':''}/>
                                                                有
                                                            </td>
                                                            <td><input type="text" name="JXZH_AQC_TEMP" id="JXZH_AQC_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">半高镜</td>
                                                            <td>
                                                                <input name="JXZH_BGJ" type="radio" value="无" onclick="editJxzh('JXZH_BGJ');" ${pd.JXZH_BGJ=='无'?'checked':''}/>
                                                                无
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_BGJ" type="radio" value="有" onclick="editJxzh('JXZH_BGJ');" ${pd.JXZH_BGJ=='有'?'checked':''}/>
                                                                有
                                                            </td>
                                                            <td><input type="text" name="JXZH_BGJ_TEMP" id="JXZH_BGJ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板型号</td>
                                                            <td>
                                                                <input type="radio" name="JXZH_DBXH" value="JD-08" onclick="setDbxhDisable('1');" ${pd.JXZH_DBXH=='JD-08'?'checked':''}>
                                                                JD-08
                                                            </td>
                                                            <td>
                                                                可选:
                                                                <input name="JXZH_DBXH" type="radio" value="" onclick="setDbxhDisable('0');" ${pd.JXZH_DBXH=='JD-08'?'':'checked'}/>
                                                                <select name="JXZH_DBXH_SELECT" id="JXZH_DBXH_SELECT" onchange="setDbzxhd();" class="form-control">
                                                                  <option value="无">请选择</option>
                                                                  <option value="JD-01" ${pd.JXZH_DBXH=='JD-01'?'selected':''}>JD-01</option>
                                                                  <option value="JD-02" ${pd.JXZH_DBXH=='JD-02'?'selected':''}>JD-02</option>
                                                                  <option value="JD-03" ${pd.JXZH_DBXH=='JD-03'?'selected':''}>JD-03</option>
                                                                  <option value="JD-04" ${pd.JXZH_DBXH=='JD-04'?'selected':''}>JD-04</option>
                                                                  <option value="JD-05" ${pd.JXZH_DBXH=='JD-05'?'selected':''}>JD-05</option>
                                                                </select>
                                                                <input name="JXZH_DBXH" type="radio" value="大理石预留" onclick="setDbxhDisable('1');" ${pd.JXZH_DBXH=='大理石预留'?'checked':''}/>
                                                                大理石预留
                                                            </td>
                                                            <td><input type="text" name="JXZH_DBXH_TEMP" id="JXZH_DBXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板装修厚度mm</td>
                                                            <td><input type="text" name="JXZH_DBZXHD" id="JXZH_DBZXHD" class="form-control" value="${pd.JXZH_DBZXHD}"></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2" rowspan="2">预留装潢重量kg</td>
                                                            <td colspan="2">
                                                                <input name="JXZH_YLZHZL" id="JXZH_YLZHZL" type="text" onkeyup="editJxzh('JXZH_YLZHZL');" class="form-control" value="${pd.JXZH_YLZHZL}"/>
                                                            </td>
                                                            <td><input type="text" name="JXZH_YLZHZL_TEMP" id="JXZH_YLZHZL_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">
                                                                备注:当客户自主装修或选择大理石预留时必须填写预留装潢重量,当载重为450-1000/1150-1600/2000kg时,最大允许装潢重量分别为200/300/400kg,如装潢重量超出最大允许装潢重量时,需非标处理.
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">扶手型号</td>
                                                            <td>
                                                                <input name="JXZH_FSXH" type="radio" value="无" onclick="setFsxhDisable('1');" ${pd.JXZH_FSXH=='无'?'checked':''}/>
                                                                无
                                                            </td>
                                                            <td><input name="JXZH_FSXH" type="radio" value="" onclick="setFsxhDisable('0');" ${pd.JXZH_FSXH=='无'?'':'checked'}/>
                                                              <select name="JXZH_FSXH_SELECT" id="JXZH_FSXH_SELECT" onchange="editJxzh('JXZH_FSXH');" class="form-control">
                                                                <option value="无">请选择</option>
                                                                <option value="JF-FS-01" ${pd.JXZH_FSXH=='JF-FS-01'?'selected':''}>JF-FS-01</option>
                                                                <option value="JF-FS-02" ${pd.JXZH_FSXH=='JF-FS-02'?'selected':''}>JF-FS-02</option>
                                                                <option value="JF-FS-03" ${pd.JXZH_FSXH=='JF-FS-03'?'selected':''}>JF-FS-03</option>
                                                                <option value="JF-FS-04" ${pd.JXZH_FSXH=='JF-FS-04'?'selected':''}>JF-FS-04</option>
                                                              </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_FSXH_TEMP" id="JXZH_FSXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">扶手安装位置</td>
                                                            <td colspan="2">
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="后围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ=='后围壁'?'checked':''}/>
                                                                后围壁
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="左围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ=='左围壁'?'checked':''}/>
                                                                左围壁
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="右围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ=='右围壁'?'checked':''}/>
                                                                右围壁
                                                            </td>
                                                            <td><input type="text" name="JXZH_FSAZWZ_TEMP" id="JXZH_FSAZWZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 轿厢装潢 -->
                                                </div>
                                                <div id="tab-6" class="tab-pane">
                                                    <!-- 厅门门套 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>首层门框</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_SCMK' id="TMMT_SCMK" onchange="editTmmt('TMMT_SCMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="小门框" ${pd.TMMT_SCMK=='小门框'?'selected':''}>小门框</option>
                                                                    <option value="大门框" ${pd.TMMT_SCMK=='大门框'?'selected':''}>大门框</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_SCMK_TEMP" id="TMMT_SCMK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层门框材质</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_SCMKCZ" name="TMMT_SCMKCZ" onchange="editTmmt('TMMT_SCMKCZ');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_SCMKCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_SCMKCZ=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_SCMKCZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            <td>
                                                                <input type="text" name="TMMT_SCMKCZ_TEMP" id="TMMT_SCMKCZ_TEMP" class="form-control">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层门框钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_SCMKGBSBH" name="TMMT_SCMKGBSBH" onchange="editTmmt('TMMT_SCMKGBSBH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_SCMKGBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_SCMKGBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_SCMKGBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_SCMKGBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_SCMKGBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_SCMKGBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_SCMKGBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_SCMKGBSBH_TEMP" id="TMMT_SCMKGBSBH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>其余层门框</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_QYCMK' id="TMMT_QYCMK" onchange="editTmmt('TMMT_QYCMK');" class="form-control">
                                                                    <option value="小门框" ${pd.TMMT_QYCMK=='小门框'?'selected':''}>小门框</option>
                                                                    <option value="大门框" ${pd.TMMT_QYCMK=='大门框'?'selected':''}>大门框</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_QYCMK_TEMP" id="TMMT_QYCMK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>其余层门框材质</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_QYCMKCZ" name="TMMT_QYCMKCZ" onchange="editTmmt('TMMT_QYCMKCZ');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_QYCMKCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_QYCMKCZ=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_QYCMKCZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_QYCMKCZ_TEMP" id="TMMT_QYCMKCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>其余层门框钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_QYCMKGBSBH" name="TMMT_QYCMKGBSBH" onchange="editTmmt('TMMT_QYCMKGBSBH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_QYCMKGBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_QYCMKGBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_QYCMKGBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_QYCMKGBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_QYCMKGBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_QYCMKGBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_QYCMKGBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_QYCMKGBSBH_TEMP" id="TMMT_QYCMKGBSBH_TEMP" class="form-control"></td>
                                                          </tr>

                                                          <tr>
                                                            <td>首层厅门材质</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_SCTMCZ" name="TMMT_SCTMCZ" onchange="editTmmt('TMMT_SCTMCZ');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_SCTMCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_SCTMCZ=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_SCTMCZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_SCTMCZ_TEMP" id="TMMT_SCTMCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层厅门钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_SCTMGBSBH" name="TMMT_SCTMGBSBH" onchange="editTmmt('TMMT_SCTMGBSBH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_SCTMGBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_SCTMGBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_SCTMGBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_SCTMGBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_SCTMGBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_SCTMGBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_SCTMGBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_SCTMGBSBH_TEMP" id="TMMT_SCTMGBSBH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>其余层厅门材质</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_QYCTMCZ" name="TMMT_QYCTMCZ" onchange="editTmmt('TMMT_QYCTMCZ');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_QYCTMCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_QYCTMCZ=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_QYCTMCZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_QYCTMCZ_TEMP" id="TMMT_QYCTMCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>其余层厅门钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_QYCTMGBSBH" name="TMMT_QYCTMGBSBH" onchange="editTmmt('TMMT_QYCTMGBSBH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_QYCTMGBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_QYCTMGBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_QYCTMGBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_QYCTMGBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_QYCTMGBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_QYCTMGBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_QYCTMGBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_QYCTMGBSBH_TEMP" id="TMMT_QYCTMGBSBH_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 厅门门套 -->
                                                </div>
                                                <div id="tab-7" class="tab-pane">
                                                    <!-- 操纵盘 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>操纵盘类型</td>
                                                            <td>标准:一体式</td>
                                                            <td>可选:嵌入式</td>
                                                            <td>
                                                                加价
                                                                <input type="hidden" name="CZP_XS_TEMP" id="CZP_XS_TEMP">
                                                                <input type="hidden" name="CZP_AN_TEMP" id="CZP_AN_TEMP">
                                                                <input type="hidden" name="CZP_CZ_TEMP" id="CZP_CZ_TEMP">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>操纵盘型号</td>
                                                            <td>
                                                                <p>
                                                                    <input type="radio" name="CZP_CZPXH" value="JFCOP09H-D1" onclick="setCzpxhDisable('2');" ${pd.CZP_CZPXH=='JFCOP09H-D1'?'checked':''}/>
                                                                    JFCOP09H-D1(标配只勾选本行,下列不必选)
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="CZP_XS" id="CZP_XS_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.CZP_XS=='LCD(标配)'?'selected':''}>LCD(标配)</option>
                                                                        <option value="LED(无偿选配)" ${pd.CZP_XS=='LED(无偿选配)'?'selected':''}>LED(无偿选配)</option>
                                                                        <option value="TFT(彩色液晶)" ${pd.CZP_XS=='TFT(彩色液晶)'?'selected':''}>TFT(彩色液晶)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                    <select name="CZP_XS_SUB" id="CZP_XS_SUB" onchange="editCzp('CZP_CZPXH');" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="真彩液晶图片显示7寸" ${pd.CZP_XS_SUB=='真彩液晶图片显示7寸'?'selected':''}>真彩液晶图片显示7寸</option>
                                                                        <option value="真彩液晶图片显示10寸" ${pd.CZP_XS_SUB=='真彩液晶图片显示10寸'?'selected':''}>真彩液晶图片显示10寸</option>
                                                                        <option value="真彩液晶多媒体显示10.4寸" ${pd.CZP_XS_SUB=='真彩液晶多媒体显示10.4寸'?'selected':''}>真彩液晶多媒体显示10.4寸</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="CZP_AN" onchange="editCzp('CZP_CZPXH');" id="CZP_AN_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="金属红光带字牌按钮" ${pd.CZP_AN=='金属红光带字牌按钮'?'selected':''}>金属红光带字牌按钮</option>
                                                                        <option value="金属红光方按钮" ${pd.CZP_AN=='金属红光方按钮'?'selected':''}>金属红光方按钮</option>
                                                                        <option value="亚克力红光白字圆按钮" ${pd.CZP_AN=='亚克力红光白字圆按钮'?'selected':''}>亚克力红光白字圆按钮</option>
                                                                        <option value="亚克力红光白字方按钮" ${pd.CZP_AN=='亚克力红光白字方按钮'?'selected':''}>亚克力红光白字方按钮</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="CZP_CZ" onchange="editCzp('CZP_CZPXH');" id="CZP_CZ_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value='发纹不锈钢(标准)' ${pd.CZP_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
                                                                        <option value="镜面不锈钢" ${pd.CZP_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    <input name="CZP_CZPXH" type="radio" value="JFCOP09H-D" onclick="setCzpxhDisable('1');" ${pd.CZP_CZPXH=='JFCOP09H-D'?'checked':''}/>
                                                                    JFCOP09H-D
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="CZP_XS" id="CZP_XS_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.CZP_XS==''?'selected':''}>LCD(标配)</option>
                                                                        <option value="LED(无偿选配)" ${pd.CZP_XS==''?'selected':''}>LED(无偿选配)</option>
                                                                        <option value="TFT(有偿选配)" ${pd.CZP_XS==''?'selected':''}>TFT(有偿选配)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="CZP_AN" id="CZP_AN_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="BAS241(标配)" ${pd.CZP_AN=='BAS241(标配)'?'selected':''}>BAS241(标配)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="CZP_CZ" id="CZP_CZ_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="发纹不锈钢" ${pd.CZP_CZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                        <option value="镜面不锈钢" ${pd.CZP_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                            </td>
                                                            <td><input type="text" name="CZP_CZPXH_TEMP" id="CZP_CZPXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="3">操纵盘位置</td>
                                                            <td>标准:</td>
                                                            <td>可选:</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">
                                                                <input name="CZP_CZPWZ" type="radio" value="左前" ${pd.CZP_CZPWZ=='左前'?'checked':''}/>
                                                                左前
                                                            </td>
                                                            <td>
                                                                <input name="CZP_CZPWZ" type="radio" value="左侧" ${pd.CZP_CZPWZ=='左侧'?'checked':''}/>
                                                                左侧(窄/深轿厢可选,担架梯标配)
                                                            </td>
                                                            <td rowspan="2"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                <input name="CZP_CZPWZ" type="radio" value="右前" ${pd.CZP_CZPWZ=='右前'?'checked':''}/>
                                                                右前
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 操纵盘 -->
                                                </div>
                                                <div id="tab-8" class="tab-pane">
                                                    <!-- 厅门信号装置 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>厅外召唤类型</td>
                                                            <td>标准:无底盒</td>
                                                            <td>可选:有底盒</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>厅外召唤型号</td>
                                                            <td>
                                                                <p>
                                                                    <input name="TMXHZZ_TWZHXH" type="radio" value="JFHB09H-D1" onclick="setTwzhxhDisable('2');" ${pd.TMXHZZ_TWZHXH=='JFHB09H-D1'?'checked':''} />
                                                                    JFHB09H-D1(标配只勾选本行,下列不必选)
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="TMXHZZ_XS" id="TMXHZZ_XS_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.TMXHZZ_XS=='LCD(标配)'?'selected':''}>LCD(标配)</option>
                                                                        <option value="LED(无偿选配)" ${pd.TMXHZZ_XS=='LED(无偿选配)'?'selected':''}>LED(无偿选配)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="TMXHZZ_AN" id="TMXHZZ_AN_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="BAS241(标准)" ${pd.TMXHZZ_AN=='BAS241(标准)'?'selected':''}>BAS241(标准)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="TMXHZZ_CZ" onchange="editTmxhzz('TMXHZZ_CZ');" id="TMXHZZ_CZ_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="镜面不锈钢" ${pd.TMXHZZ_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                        <option value="钛金不锈钢" ${pd.TMXHZZ_CZ=='钛金不锈钢'?'selected':''}>钛金不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    <input name="TMXHZZ_TWZHXH" type="radio" value="JFHB09H-D" onclick="setTwzhxhDisable('1');" ${pd.TMXHZZ_TWZHXH=='JFHB09H-D'?'checked':''}/>
                                                                    JFHB09H-D
                                                                </p>
                                                                <p>
                                                                    显示 
                                                                    <select name="TMXHZZ_XS" id="TMXHZZ_XS_2" class="form-control">
                                                                      <option value="">请选择</option>
                                                                      <option value="LCD" ${pd.TMXHZZ_XS=='LCD'?'selected':''}>LCD</option>
                                                                      <option value="LED" ${pd.TMXHZZ_XS=='LED'?'selected':''}>LED</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="TMXHZZ_AN" id="TMXHZZ_AN_2" class="form-control">
                                                                      <option value="">请选择</option>
                                                                      <option value="BAS241" ${pd.TMXHZZ_AN=='BAS241'?'selected':''}>BAS241</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="TMXHZZ_CZ" onchange="editTmxhzz('TMXHZZ_CZ');" id="TMXHZZ_CZ_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="镜面不锈钢" ${pd.TMXHZZ_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                        <option value="钛金不锈钢" ${pd.TMXHZZ_CZ=='钛金不锈钢'?'selected':''}>钛金不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                            </td>
                                                            <td><input type="text" name="TMXHZZ_CZ_TEMP" id="TMXHZZ_CZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">厅外召唤形式</td>
                                                            <td>标准:</td>
                                                            <td>可选:</td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                <p>
                                                                    在
                                                                    <input name="TMXHZZ_ZDJC" type="text"  id="TMXHZZ_ZDJC_1" class="form-control" style="width: 10%" value="${pd.TMXHZZ_ZDJC}"/>
                                                                    层、每层
                                                                    <input name="TMXHZZ_MCGS" type="text" id="TMXHZZ_MCGS_1" class="form-control" style="width: 10%" value="${pd.TMXHZZ_MCGS}"/>
                                                                    个
                                                                </p>
                                                                <p>
                                                                    附加说明:
                                                                    <input name="TMXHZZ_FJSM" type="text" id="TMXHZZ_FJSM_1" class="form-control" value="${pd.TMXHZZ_FJSM}"/>
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    在
                                                                    <input name="TMXHZZ_ZDJC" type="text" id="TMXHZZ_ZDJC_2" class="form-control" style="width: 10%" value="${pd.TMXHZZ_ZDJC}"/>
                                                                    层、每层
                                                                    <input name="TMXHZZ_MCGS" type="text" id="TMXHZZ_MCGS_2" class="form-control" style="width: 10%" value="${pd.TMXHZZ_MCGS}"/>
                                                                    个
                                                                </p>
                                                                <p>
                                                                    附加说明:
                                                                    <input name="TMXHZZ_FJSM" type="text" id="TMXHZZ_FJSM_2" class="form-control" value="${pd.TMXHZZ_FJSM}"/>
                                                                </p>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>挂壁式残疾人操纵箱:</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="TMXHZZ_GBSCJRCZX_TEXT" id="TMXHZZ_GBSCJRCZX_TEXT" onclick="editTmxhzz('TMXHZZ_GBSCJRCZX');" ${pd.TMXHZZ_GBSCJRCZX=='1'?'checked':''}>
                                                                <input type="hidden" name="TMXHZZ_GBSCJRCZX" id="TMXHZZ_GBSCJRCZX">
                                                            </td>
                                                            <td><input type="text" name="TMXHZZ_GBSCJRCZX_TEMP" id="TMXHZZ_GBSCJRCZX_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>备注:</td>
                                                            <td colspan="3">
                                                                1.填写厅外召唤所在层时,请用实际楼层标记填写;2.厅外召唤形式图例仅作示意,当楼层标记为一位数时,数字显示为一位数,在顶层只有一个向下按钮,在底层只有一个向上按钮;3.驻停楼层的厅外召唤带钥匙开关;4.厅外召唤样式(HBtype)有单个(Single)和两台合用一个(Duplex)两种
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
                                            <input type="text" class="form-control" id="FEIYUE_AZF_TEMP" name="FEIYUE_AZF_TEMP" onkeyup="countZhj();" value="${pd.FEIYUE_AZF}">
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

    //调用时计算价格
    function cbjPrice(){
        //井道总高
        setJdzg();
        //导轨支架
        setDgzj();
        //可选项
        editOpt('OPT_LTBL');
        editOpt('OPT_TDJJJY');
        editOpt('OPT_JXDZZ');
        editOpt('OPT_SJCZ');
        editOpt('OPT_CCTVDL');
        editOpt('OPT_DJGRBH');
        editOpt('OPT_BAJK');
        editOpt('OPT_MBCAN');
        editOpt('OPT_KMZPC');
        editOpt('OPT_QPGM');
        editOpt('OPT_YCJK');
        editOpt('OPT_JFGT');
        editOpt('OPT_ICK');
        editOpt('OPT_ICKZKSB');
        editOpt('OPT_ICKKP');
        editOpt('OPT_GTMJXJMBF');
        editOpt('OPT_GTMTMBF');
        //单组监控室对讲
        editDzjksdjxt();
        //轿厢装潢
        editJxzh('JXZH_JM');
        editJxzh('JXZH_JMZH');
        editJxzh('JXZH_JXZH');
        editJxzh('JXZH_QWB');
        editJxzh('JXZH_CWB');
        editJxzh('JXZH_HWB');
        editJxzh('JXZH_ZSDD');
        editJxzh('JXZH_AQC');
        editJxzh('JXZH_BGJ');
        editJxzh('JXZH_YLZHZL');
        editJxzh('JXZH_FSXH');
        editJxzh('JXZH_FSAZWZ');
        //厅门门套
        editTmmt('TMMT_SCMKCZ');
        editTmmt('TMMT_QYCMKCZ');
        editTmmt('TMMT_SCTMCZ');
        editTmmt('TMMT_QYCTMCZ');
        //操纵盘
        editCzp('CZP_CZPXH');
        //厅门信号装置
        editTmxhzz('TMXHZZ_CZ');
        editTmxhzz('TMXHZZ_GBSCJRCZX');

    }



    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#FEIYUE_SL").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=feiyue&FEIYUE_SL="+sl_,
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
        var sl_ = $("#FEIYUE_SL").val();
        var zk_ = $("#FEIYUE_ZK").val();
        var sbj_ = $("#FEIYUE_SBJ").val();
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selZhj.do?models=feiyue&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYUE_SL="+sl_+"&FEIYUE_ZK="+zk_+"&FEIYUE_SBJ="+sbj_,
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
    //设置地板装修厚度
    function setDbzxhd(){
        var dbxh_ = $("#JXZH_DBXH").val();
        if(dbxh_=="JD-08"){
            $("#JXZH_DBZXHD").val("3");
        }else{
            $("#JXZH_DBZXHD").val("");
        }
    }
    //井道承重墙厚度
    function setJdczqhdDisable(flag){
        if(flag=='1'){
            $("#BASE_JDCZQHD_TEXT").val("");
            $("#BASE_JDCZQHD_TEXT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#BASE_JDCZQHD_TEXT').removeAttr("disabled"); 
        }
    }
    //门类型门保护
    function setMlxmbhDisable(flag){
        if(flag=='1'){
            $("#BASE_MLXMBH_TEXT").val("");
            $("#BASE_MLXMBH_TEXT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#BASE_MLXMBH_TEXT').removeAttr("disabled"); 
        }
    }
    //轿厢装潢-轿门色标号
    function setJmsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_JMSBH").val("");
            $("#JXZH_JMSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_JMSBH').removeAttr("disabled"); 
        }
        editJxzh('JXZH_JM');
    }
    //轿厢装潢-前围壁色标号
    function setQwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_QWBSBH").val("");
            $("#JXZH_QWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_QWBSBH').removeAttr("disabled"); 
        }
        editJxzh('JXZH_QWB');
    }
    //轿厢装潢-侧围壁色标号
    function setCwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_CWBSBH").val("");
            $("#JXZH_CWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_CWBSBH').removeAttr("disabled"); 
        }
        editJxzh('JXZH_CWB');
    }
    //轿厢装潢-后围壁色标号
    function setHwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_HWBSBH").val("");
            $("#JXZH_HWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_HWBSBH').removeAttr("disabled"); 
        }
        editJxzh('JXZH_HWB');
    }
    //轿厢装潢-轿顶装潢
    function setJdzhDisable(flag){
        if(flag=="1"){
            $("#ZSDD_2").val("");
            $("#ZSDD_2").attr("disabled","disabled");
            $('#ZSDD_1').removeAttr("disabled"); 
        }else if(flag=="2"){
            $("#ZSDD_1").val("");
            $("#ZSDD_1").attr("disabled","disabled");
            $('#ZSDD_2').removeAttr("disabled"); 
        }else{
            $("#ZSDD_2").val("");
            $("#ZSDD_2").attr("disabled","disabled");
            $("#ZSDD_1").val("");
            $("#ZSDD_1").attr("disabled","disabled");
        }
    }
    //轿厢装潢-地板型号
    function setDbxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_DBXH_SELECT").val("");
            $("#JXZH_DBXH_SELECT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_DBXH_SELECT').removeAttr("disabled"); 
        }
    }
    //轿厢装潢-扶手型号
    function setFsxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_FSXH_SELECT").val("");
            $("#JXZH_FSXH_SELECT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_FSXH_SELECT').removeAttr("disabled"); 
        }
    }
    //厅门门套-首层色标号
    function setScsbhDisable(flag){
        if(flag=='1'){
            $("#TMMT_SCSBH").val("");
            $("#TMMT_SCSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#TMMT_SCSBH').removeAttr("disabled"); 
        }
        editTmmt('TMMT_SCTMMT');
    }
    //厅门门套-非首层色标号
    function setFscsbhDisable(flag){
        if(flag=='1'){
            $("#TMMT_FSCSBH").val("");
            $("#TMMT_FSCSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#TMMT_FSCSBH').removeAttr("disabled"); 
        }
        editTmmt('TMMT_FSCTMMT');
    }
    //操纵盘-操纵盘型号
    function setCzpxhDisable(flag){
        if(flag=='1'){
            $("#CZP_XS_1").val("");
            $("#CZP_XS_1").attr("disabled","disabled");
            $("#CZP_AN_1").val("");
            $("#CZP_AN_1").attr("disabled","disabled");
            $("#CZP_CZ_1").val("");
            $("#CZP_CZ_1").attr("disabled","disabled");
            $("#CZP_XS_SUB").val("");
            $("#CZP_XS_SUB").attr("disabled","disabled");
            $('#CZP_XS_2').removeAttr("disabled"); 
            $('#CZP_AN_2').removeAttr("disabled"); 
            $('#CZP_CZ_2').removeAttr("disabled"); 
        }else if(flag=='2'){
            $("#CZP_XS_2").val("");
            $("#CZP_XS_2").attr("disabled","disabled");
            $("#CZP_AN_2").val("");
            $("#CZP_AN_2").attr("disabled","disabled");
            $("#CZP_CZ_2").val("");
            $("#CZP_CZ_2").attr("disabled","disabled");
            $('#CZP_XS_1').removeAttr("disabled"); 
            $('#CZP_AN_1').removeAttr("disabled"); 
            $('#CZP_CZ_1').removeAttr("disabled"); 
            $('#CZP_XS_SUB').removeAttr("disabled"); 
        }
        editCzp('CZP_CZPXH');
    }
    //厅门信号装置-厅外召唤型号
    function setTwzhxhDisable(flag){
        if(flag=="1"){
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
        }else if(flag=="2"){
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
        var kmkd_ = $("#BZ_KMKD").val();

        if(zz_=="630"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1400×1100(630kg)'>1400×1100(630kg)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='800'>800</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");

        }else if(zz_=="800"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1400×1350(800kg)'>1400×1350(800kg)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='800'>800</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");

        }else if(zz_=="1000"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1600×1400(1000kg)'>1600×1400(1000kg)</option><option value='1100×2100(1000kg担架梯)'>1100×2100(1000kg担架梯)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='900'>900</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");
        }else if(zz_=="1150"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1800×1500(1150kg)'>1800×1500(1150kg)</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1000'>1000</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");
        }

        
    }

    //修改速度时
    function editSd(){
        var sd_ = $("#BZ_SD").val();
        if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="1.75"){
            var appendStr = "<option value=''>请选择</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="2.0"){
            var appendStr = "<option value=''>请选择</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option><option value='32'>32</option><option value='33'>33</option><option value='34'>34</option><option value='35'>35</option><option value='36'>36</option>";
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
        var price = parseInt($("#FEIYUE_SBJ").val());
        var kmkd_ = parseInt($("#BZ_KMKD").val());
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(price)){
            var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="800"){
                    price = price-1680*jm;
                }else if(kmkd_=="900"){
                    price = price-1920*jm;
                }else if(kmkd_=="1100"){
                    price = price-2200*jm;
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
        var opt_ltbl_temp = $("#OPT_LTBL_TEMP").val()==""?0:parseInt($("#OPT_LTBL_TEMP").val());
        var opt_tdjjjy_temp = $("#OPT_TDJJJY_TEMP").val()==""?0:parseInt($("#OPT_TDJJJY_TEMP").val());
        var opt_jxdzz_temp = $("#OPT_JXDZZ_TEMP").val()==""?0:parseInt($("#OPT_JXDZZ_TEMP").val());
        var opt_sjcz_temp = $("#OPT_SJCZ_TEMP").val()==""?0:parseInt($("#OPT_SJCZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt($("#OPT_CCTVDL_TEMP").val());
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt($("#OPT_DJGRBH_TEMP").val());
        var opt_bajk_temp = $("#OPT_BAJK_TEMP").val()==""?0:parseInt($("#OPT_BAJK_TEMP").val());
        var opt_mbcan_temp = $("#OPT_MBCAN_TEMP").val()==""?0:parseInt($("#OPT_MBCAN_TEMP").val());
        var opt_kmzpc_temp = $("#OPT_KMZPC_TEMP").val()==""?0:parseInt($("#OPT_KMZPC_TEMP").val());
        var opt_qpgm_temp = $("#OPT_QPGM_TEMP").val()==""?0:parseInt($("#OPT_QPGM_TEMP").val());
        var opt_ycjk_temp = $("#OPT_YCJK_TEMP").val()==""?0:parseInt($("#OPT_YCJK_TEMP").val());
        var opt_jfgt_temp = $("#OPT_JFGT_TEMP").val()==""?0:parseInt($("#OPT_JFGT_TEMP").val());
        var opt_ick_temp = $("#OPT_ICK_TEMP").val()==""?0:parseInt($("#OPT_ICK_TEMP").val());
        var opt_ickzksb_temp = $("#OPT_ICKZKSB_TEMP").val()==""?0:parseInt($("#OPT_ICKZKSB_TEMP").val());
        var opt_ickkp_temp = $("#OPT_ICKKP_TEMP").val()==""?0:parseInt($("#OPT_ICKKP_TEMP").val());
        var opt_gtmjxjmbf_temp = $("#OPT_GTMJXJMBF_TEMP").val()==""?0:parseInt($("#OPT_GTMJXJMBF_TEMP").val());
        var opt_gtmtmbf_temp = $("#OPT_GTMTMBF_TEMP").val()==""?0:parseInt($("#OPT_GTMTMBF_TEMP").val());
        var dzjksdjxt_djts_temp = $("#DZJKSDJXT_DJTS_TEMP").val()==""?0:parseInt($("#DZJKSDJXT_DJTS_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt($("#JXZH_JM_TEMP").val());
        var jxzh_jmzh_temp = $("#JXZH_JMZH_TEMP").val()==""?0:parseInt($("#JXZH_JMZH_TEMP").val());
        var jxzh_jxzh_temp = $("#JXZH_JXZH_TEMP").val()==""?0:parseInt($("#JXZH_JXZH_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt($("#JXZH_QWB_TEMP").val());
        var jxzh_cwb_temp = $("#JXZH_CWB_TEMP").val()==""?0:parseInt($("#JXZH_CWB_TEMP").val());
        var jxzh_hwb_temp = $("#JXZH_HWB_TEMP").val()==""?0:parseInt($("#JXZH_HWB_TEMP").val());
        var jxzh_zsdd_temp = $("#JXZH_ZSDD_TEMP").val()==""?0:parseInt($("#JXZH_JM_TEMP").val());
        var jxzh_aqc_temp = $("#JXZH_AQC_TEMP").val()==""?0:parseInt($("#JXZH_AQC_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt($("#JXZH_BGJ_TEMP").val());
        var jxzh_ylzhzl_temp = $("#JXZH_YLZHZL_TEMP").val()==""?0:parseInt($("#JXZH_YLZHZL_TEMP").val());
        var jxzh_fsxh_temp = $("#JXZH_FSXH_TEMP").val()==""?0:parseInt($("#JXZH_FSXH_TEMP").val());
        var jxzh_fsazwz_temp = $("#JXZH_FSAZWZ_TEMP").val()==""?0:parseInt($("#JXZH_FSAZWZ_TEMP").val());
        var tmmt_scmkcz_temp = $("#TMMT_SCMKCZ_TEMP").val()==""?0:parseInt($("#TMMT_SCMKCZ_TEMP").val());
        var tmmt_qycmkcz_temp = $("#TMMT_QYCMKCZ_TEMP").val()==""?0:parseInt($("#TMMT_QYCMKCZ_TEMP").val());
        var tmmt_sctmcz_temp = $("#TMMT_SCTMCZ_TEMP").val()==""?0:parseInt($("#TMMT_SCTMCZ_TEMP").val());
        var tmmt_qyctmcz_temp = $("#TMMT_QYCTMCZ_TEMP").val()==""?0:parseInt($("#TMMT_QYCTMCZ_TEMP").val());
        var czp_czpxh_temp = $("#CZP_CZPXH_TEMP").val()==""?0:parseInt($("#CZP_CZPXH_TEMP").val());
        var tmxhzz_cz_temp = $("#TMXHZZ_CZ_TEMP").val()==""?0:parseInt($("#TMXHZZ_CZ_TEMP").val());
        var tmxhzz_gbscjrczx_temp = $("#TMXHZZ_GBSCJRCZX_TEMP").val()==""?0:parseInt($("#TMXHZZ_GBSCJRCZX_TEMP").val());

        zhj_count = jxzh_jm_temp+jxzh_jmzh_temp+jxzh_jxzh_temp+jxzh_qwb_temp+jxzh_cwb_temp+jxzh_hwb_temp+jxzh_zsdd_temp+jxzh_aqc_temp+jxzh_bgj_temp+jxzh_ylzhzl_temp+jxzh_fsxh_temp+jxzh_fsazwz_temp;
        $("#FEIYUE_ZHJ").val(zhj_count);

        sbj_count = base_jdzg_temp+base_dgzj_temp+opt_ltbl_temp+opt_tdjjjy_temp+opt_jxdzz_temp+opt_sjcz_temp+opt_cctvdl_temp+opt_djgrbh_temp+opt_bajk_temp+opt_mbcan_temp+opt_kmzpc_temp+opt_qpgm_temp+opt_ycjk_temp+opt_jfgt_temp+opt_ick_temp+opt_ickzksb_temp+opt_ickkp_temp+opt_gtmjxjmbf_temp+opt_gtmtmbf_temp+dzjksdjxt_djts_temp+tmmt_scmkcz_temp+tmmt_qycmkcz_temp+tmmt_sctmcz_temp+tmmt_qyctmcz_temp+czp_czpxh_temp+tmxhzz_cz_temp+tmxhzz_gbscjrczx_temp;
        //设备标准价格
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#FEIYUE_SBJ").val(sbj_temp+sbj_count);

        //运输费
        var feiyue_ysf = $("#FEIYUE_YSF").val()==""?0:parseInt($("#FEIYUE_YSF").val());
        $("#FEIYUE_YSF").val(feiyue_ysf);
        //安装费
        var feiyue_azf = $("#FEIYUE_AZF_TEMP").val()==""?0:parseInt($("#FEIYUE_AZF_TEMP").val());
        $("#FEIYUE_AZF").val(feiyue_azf);

        var feiyue_zk = parseFloat($("#FEIYUE_ZK").val())/100;
        if(!isNaN(feiyue_zk)){
            var feiyue_sbj = parseInt($("#SBJ_TEMP").val());
            var feiyue_sjbj = (feiyue_sbj+zhj_count+sbj_count+feiyue_azf+feiyue_ysf)*feiyue_zk;
            var feiyue_zhsbj = feiyue_sbj*feiyue_zk;
            $("#FEIYUE_SJBJ").val(feiyue_sjbj);
            $("#FEIYUE_ZHSBJ").val(feiyue_zhsbj);
            $("#zk_").text($("#FEIYUE_ZK").val()+"%");
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
            if(zz_=="630"){
                if(sd_=="1"){
                    K = 3950;
                    S = 1250;
                }
            }else if(zz_=="800"||zz_=="1000"||zz_=="1150"){
                if(sd_=="1"){
                    K = 3950;
                    S = 1250;
                }else if(sd_=="1.75"){
                    K = 4200;
                    S = 1400;
                }else if(sd_=="2.0"){
                    K = 4600;
                    S = 1600;
                }
            }
            var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            if(sd_=="1.0"||sd_=="1.75"){
                if(zz_=="630"||zz_=="800"){
                    price = 1000*((jdzg_-jdzg_std)/100);
                }else if(zz_=="1000"){
                    price = 1100*((jdzg_-jdzg_std)/100);
                }else if(zz_=="11150"){
                    price = 1300*((jdzg_-jdzg_std)/100);
                }
            }else if(sd_=="2.0"){
                if(zz_=="800"||zz_=="1000"){
                    price = 1300*((jdzg_-jdzg_std)/100);
                }else if(zz_=="1150"){
                    price = 1500*((jdzg_-jdzg_std)/100);
                }
            }

            //计算导轨支架标准档数
            var dgzj_std = 0;
            if(zz_=="450"||zz_=="630"||zz_=="800"||zz_=="1000"){
                dgzj_std = Math.ceil((jdzg_std/2500)+1);
            }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"||zz_=="2000"){
                dgzj_std = Math.ceil((jdzg_std/2000)+1);
            }
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
            if(zz_=="630"){
                if(sd_=="1"){
                    K = 3950;
                    S = 1250;
                }
            }else if(zz_=="800"||zz_=="1000"||zz_=="1150"){
                if(sd_=="1"){
                    K = 3950;
                    S = 1250;
                }else if(sd_=="1.75"){
                    K = 4200;
                    S = 1400;
                }else if(sd_=="2.0"){
                    K = 4600;
                    S = 1600;
                }
            }
            jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            if(zz_=="450"||zz_=="630"||zz_=="800"||zz_=="1000"){
                dgzj_std = (jdzg_std/2500)+1;
                price = (dgzj_-dgzj_std)*310;
            }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"||zz_=="2000"){
                dgzj_std = (jdzg_std/2000)+1;
                price = (dgzj_-dgzj_std)*310;
            }
            $("#BASE_DGZJ_TEMP").val(price);
            //放入价格
            countZhj();
        }
    }

    //可选功能部分加价
    function editOpt(option){
        //数量
        var sl_ = $("#FEIYUE_SL").val()==""?0:parseInt($("#FEIYUE_SL").val());
        //价格
        var price = 0;
        if(option=="OPT_LTBL"){
            //两台并联
            if($("#OPT_LTBL_TEXT").is(":checked")){
                price = 240*sl_;
            }else{
                price = 0;
            }
            $("#OPT_LTBL_TEMP").val(price);
        }else if(option=="OPT_TDJJJY"){
            //停电紧急救援
            if($("#OPT_TDJJJY_TEXT").is(":checked")){
                price = 7300*sl_;
            }else{
                price = 0;
            }
            $("#OPT_TDJJJY_TEMP").val(price);
        }else if(option=="OPT_JXDZZ"){
            //轿厢到站钟
            if($("#OPT_JXDZZ_TEXT").is(":checked")){
                price = 200*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JXDZZ_TEMP").val(price);
        }else if(option=="OPT_SJCZ"){
            //司机操作
            if($("#OPT_SJCZ_TEXT").is(":checked")){
                price = 0;
            }else{
                price = 0;
            }
            $("#OPT_SJCZ_TEMP").val(price);
        }else if(option=="OPT_CCTVDL"){
            //CCTV电缆(轿厢到机房)
            if($("#OPT_CCTVDL_TEXT").is(":checked")){
                var tsgd_ = parseInt($("#BASE_TSGD").val());
                price = 17*(tsgd_+15)*sl_;
            }else{
                price = 0;
            }
            $("#OPT_CCTVDL_TEMP").val(price);
        }else if(option=="OPT_DJGRBH"){
            //电机过热保护
            if($("#OPT_DJGRBH_TEXT").is(":checked")){
                price = 650*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DJGRBH_TEMP").val(price);
        }else if(option=="OPT_BAJK"){
            //BA接口
            if($("#OPT_BAJK_TEXT").is(":checked")){
                price = 650*sl_;
            }else{
                price = 0;
            }
            $("#OPT_BAJK_TEMP").val(price);
        }else if(option=="OPT_MBCAN"){
            //门保持按钮
            if($("#OPT_MBCAN_TEXT").is(":checked")){
                price = 650*sl_;
            }else{
                price = 0;
            }
            $("#OPT_MBCAN_TEMP").val(price);
        }else if(option=="OPT_KMZPC"){
            //开门再平层
            if($("#OPT_KMZPC_TEXT").is(":checked")){
                price = 0;
            }else{
                price = 0;
            }
            $("#OPT_KMZPC_TEMP").val(price);
        }else if(option=="OPT_QPGM"){
            //强迫关门
            if($("#OPT_QPGM_TEXT").is(":checked")){
                price = 0;
            }else{
                price = 0;
            }
            $("#OPT_QPGM_TEMP").val(price);
        }else if(option=="OPT_YCJK"){
            //远程监控(物联网系统)
            if($("#OPT_YCJK_TEXT").is(":checked")){
                price = 2880*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YCJK_TEMP").val(price);
        }else if(option=="OPT_JFGT"){
            //机房高台
            if($("#OPT_JFGT_TEXT").is(":checked")){
                price = 410*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JFGT_TEMP").val(price);
        }else if(option=="OPT_ICK"){
            //IC卡(轿内控制)
            if($("#OPT_ICK").val()=="刷卡后手动选择到达楼层"){
                price = 1920;
            }else if($("#OPT_ICK").val()=="刷卡后自动选择到达楼层"){
                price = 4040;
            }else{
                price = 0;
            }
            $("#OPT_ICK_TEMP").val(price);
        }else if(option=="OPT_ICKZKSB"){
            //IC卡制卡设备
            if($("#OPT_ICKZKSB_TEXT").is(":checked")){
                price = 1400*sl_;
            }else{
                price = 0;
            }
            $("#OPT_ICKZKSB_TEMP").val(price);
        }else if(option=="OPT_ICKKP"){
            //IC卡卡片
            if(!isNaN(parseInt($("#OPT_ICKKP").val()))){
                price = parseInt($("#OPT_ICKKP").val())*12;
            }else{
                price = 0;
            }
            $("#OPT_ICKKP_TEMP").val(price);
        }else if(option=="OPT_GTMJXJMBF"){
            //贯通门(轿厢轿门部分)
            if($("#OPT_GTMJXJMBF_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();
                if(zz_=="630"||zz_=="800"){
                    price = 13000*sl_;
                }else if(zz_=="1000"){
                    price = 13900*sl_;
                }else if(zz_=="1150"){
                    price = 14500*sl_
                }else{
                    price = 0;
                }
            }else{
                price = 0;
            }
            $("#OPT_GTMJXJMBF_TEMP").val(price);
        }else if(option=="OPT_GTMTMBF"){
            //贯通门(厅门部分)
            var zz_ = $("#BZ_ZZ").val();
            if($("#OPT_GTMTMBF").val()=="发纹不锈钢"){
                if(zz_=="630"||zz_=="800"){
                    price = 2700*sl_;
                }else if(zz_=="1000"){
                    price = 3230*sl_;
                }else if(zz_=="1150"){
                    price = 3500*sl_
                }else{
                    price = 0;
                }    
            }else if($("#OPT_GTMTMBF").val()=="喷涂"){
                if(zz_=="630"||zz_=="800"){
                    price = 1785*sl_;
                }else if(zz_=="1000"){
                    price = 2040*sl_;
                }else if(zz_=="1150"){
                    price = 2380*sl_;
                }else{
                    price = 0;
                }    
            }else{
                price = 0;
            }
            $("#OPT_GTMTMBF_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }


    //单组监控室对讲系统-加价
    function editDzjksdjxt(){
        var sl_ = parseInt($("#FEIYUE_SL").val());
        var price = 0;
        if(sl_<10){
            var djts_ = parseInt($("#DZJKSDJXT_DJTS").val());
            if($("input[name='DZJKSDJXT_DJTXFS']:checked").val()=="分线制"){
                price = 2330*djts_+3570;
            }else if($("input[name='DZJKSDJXT_DJTXFS']:checked").val()=="总线制"){
                price = 720*djts_+4080;
            }
        }
        $("#DZJKSDJXT_DJTS_TEMP").val(price);
        //放入价格
        countZhj();
    }


    //轿厢装潢部分-加价
    function editJxzh(option){
        //数量
        var sl_ = $("#FEIYUE_SL").val()==""?0:parseInt($("#FEIYUE_SL").val());
        //价格
        var price = 0;
        if(option=="JXZH_JM"){
            //轿门
            var jm_ = $("input[name='JXZH_JM']:checked").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            if(jm_=="喷涂"){
                if(kmkd_=="800"){
                    price = -820*sl_;
                }else if(kmkd_=="900"){
                    price = -980*sl_;
                }else if(kmkd_=="1100"){
                    price = -1300*sl_;
                }else if(kmkd_=="1200"){
                    price = -1500*sl_;
                }
            }else if(jm_=="SUS304发纹不锈钢"){
                price = 0;
            }else if(jm_=="镜面不锈钢"){
                if(kmkd_=="800"){
                    price = 1580*sl_;
                }else if(kmkd_=="900"){
                    price = 1620*sl_;
                }else if(kmkd_=="1100"){
                    price = 2400*sl_;
                }else if(kmkd_=="1200"){
                    price = 2600*sl_;
                }
            }
            $("#JXZH_JM_TEMP").val(price);
        }else if(option=="JXZH_JMZH"){
            //轿门装潢
            var jmzh_ = $("#JXZH_JMZH").val();
            if(jmzh_=="JF-K-C01"){
                price = 0;
            }else if(jmzh_=="JF-K-C02"||jmzh_=="JF-K-C03"){
                price = 2950;
            }else if(jmzh_=="JF-K-C04"||jmzh_=="JF-K-C05"||jmzh_=="JF-K-C06"||jmzh_=="JF-K-C07"){
                price = 3420;
            }
            $("#JXZH_JMZH_TEMP").val(price);
        }else if(option=="JXZH_JXZH"){
            //轿厢装潢
            var jxzh_ = $("#JXZH_JXZH").val();
            if(jxzh_=="JF-K-JX-01"){
                price = 0;
            }else if(jxzh_=="JF-K-JX-02"){
                price = 19100;
            }else if(jxzh_=="JF-K-JX-03"){
                price = 27500;
            }else if(jxzh_=="JF-K-JX-04"){
                price = 33200;
            }else if(jxzh_=="JF-K-JX-05"){
                price = 16000;
            }else if(jxzh_=="JF-K-JX-06"){
                price = 25100;
            }else if(jxzh_=="JF-K-JX-07"){
                price = 22700;
            }else if(jxzh_=="JF-K-JX-08"){
                price = 32700;
            }else if(jxzh_=="JF-K-JX-09"){
                price = 13200;
            }else if(jxzh_=="JF-K-JX-10"){
                price = 19600;
            }else if(jxzh_=="JF-K-JX-11"){
                price = 19600;
            }
            $("#JXZH_JXZH_TEMP").val(price);
        }else if(option=="JXZH_QWB"){
            //前围壁
            var qwb_ = $("input[name='JXZH_QWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(qwb_=="喷涂"){
                if(zz_=="450"){
                    price = -4700*sl_;
                }else if(zz_=="630"){
                    price = -4900*sl_;
                }else if(zz_=="800"){
                    price = -5400*sl_;
                }else if(zz_=="1000"){
                    price = -5700*sl_;
                }else if(zz_=="1150"){
                    price = -6500*sl_;
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
                }else if(zz_=="2000"){
                    price = -7900*sl_;
                }
            }else if(qwb_=="SUS304发纹不锈钢"){
                price = 0;
            }else if(qwb_=="镜面不锈钢"){
                if(zz_=="450"){
                    price = 5500*sl_;
                }else if(zz_=="630"){
                    price = 5700*sl_;
                }else if(zz_=="800"){
                    price = 5700*sl_;
                }else if(zz_=="1000"){
                    price = 5700*sl_;
                }else if(zz_=="1150"){
                    price = 8200*sl_;
                }else if(zz_=="1350"){
                    price = 8200*sl_;
                }else if(zz_=="1600"){
                    price = 8200*sl_;
                }else if(zz_=="2000"){
                    price = 8200*sl_;
                }
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_CWB"){
            //侧围壁
            var cwb_ = $("input[name='JXZH_CWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(cwb_=="喷涂"){
                if(zz_=="450"){
                    price = -4700*sl_;
                }else if(zz_=="630"){
                    price = -4900*sl_;
                }else if(zz_=="800"){
                    price = -5400*sl_;
                }else if(zz_=="1000"){
                    price = -5700*sl_;
                }else if(zz_=="1150"){
                    price = -6500*sl_;
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
                }else if(zz_=="2000"){
                    price = -7900*sl_;
                }
            }else if(cwb_=="SUS304发纹不锈钢"){
                price = 0;
            }else if(cwb_=="镜面不锈钢"){
                if(zz_=="450"){
                    price = 5500*sl_;
                }else if(zz_=="630"){
                    price = 5700*sl_;
                }else if(zz_=="800"){
                    price = 5700*sl_;
                }else if(zz_=="1000"){
                    price = 5700*sl_;
                }else if(zz_=="1150"){
                    price = 8200*sl_;
                }else if(zz_=="1350"){
                    price = 8200*sl_;
                }else if(zz_=="1600"){
                    price = 8200*sl_;
                }else if(zz_=="2000"){
                    price = 8200*sl_;
                }
            }
            $("#JXZH_CWB_TEMP").val(price);
        }else if(option=="JXZH_HWB"){
            //后围壁
            var hwb_ = $("input[name='JXZH_HWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(hwb_=="喷涂"){
                if(zz_=="450"){
                    price = -4700*sl_;
                }else if(zz_=="630"){
                    price = -4900*sl_;
                }else if(zz_=="800"){
                    price = -5400*sl_;
                }else if(zz_=="1000"){
                    price = -5700*sl_;
                }else if(zz_=="1150"){
                    price = -6500*sl_;
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
                }else if(zz_=="2000"){
                    price = -7900*sl_;
                }
            }else if(hwb_=="SUS304发纹不锈钢"){
                price = 0;
            }else if(hwb_=="镜面不锈钢"){
                if(zz_=="450"){
                    price = 5500*sl_;
                }else if(zz_=="630"){
                    price = 5700*sl_;
                }else if(zz_=="800"){
                    price = 5700*sl_;
                }else if(zz_=="1000"){
                    price = 5700*sl_;
                }else if(zz_=="1150"){
                    price = 8200*sl_;
                }else if(zz_=="1350"){
                    price = 8200*sl_;
                }else if(zz_=="1600"){
                    price = 8200*sl_;
                }else if(zz_=="2000"){
                    price = 8200*sl_;
                }
            }
            $("#JXZH_HWB_TEMP").val(price);
        }else if(option=="JXZH_ZSDD"){
            //轿顶装潢-装饰吊顶
            var zsdd_ = $("select[name='JXZH_ZSDD']").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(zsdd_=="JF-CL-01"){
                if(zz_=="450"){
                    price = -380*sl_;
                }else if(zz_=="630"){
                    price = -540*sl_;
                }else if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-02"){
                if(zz_=="450"){
                    price = -380*sl_;
                }else if(zz_=="630"){
                    price = -540*sl_;
                }else if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-03"){
                if(zz_=="450"){
                    price = -380*sl_;
                }else if(zz_=="630"){
                    price = -540*sl_;
                }else if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-04"){
                if(zz_=="450"){
                    price = 330*sl_;
                }else if(zz_=="630"){
                    price = -540*sl_;
                }else if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-21"){
                if(zz_=="450"){
                    price = 240*sl_;
                }else if(zz_=="630"){
                    price = 240*sl_;
                }else if(zz_=="800"){
                    price = 240*sl_;
                }else if(zz_=="1000"){
                    price = 240*sl_;
                }else if(zz_=="1350"){
                    price = 280*sl_;
                }else if(zz_=="1600"){
                    price = 390*sl_;
                }else if(zz_=="2000"){
                    price = 510*sl_;
                }
            }
            $("#JXZH_ZSDD_TEMP").val(price);
        }else if(option=="JXZH_AQC"){
            //安全窗
            var aqc_ = $("input[name='JXZH_AQC']:checked").val();
            if(aqc_=="有"){
                price = 1300*sl_;
            }else if(aqc_=="无"){
                price = 0;
            }
            $("#JXZH_AQC_TEMP").val(price);
        }else if(option=="JXZH_BGJ"){
            //半高镜
            var bgj_ = $("input[name='JXZH_BGJ']:checked").val();
            if(bgj_=="有"){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="450"){
                    price = 950*sl_;
                }else if(zz_=="630"){
                    price = 980*sl_;
                }else if(zz_=="800"){
                    price = 1300*sl_;
                }else if(zz_=="1000"){
                    price = 1600*sl_;
                }else if(zz_=="1150"){
                    price = 1600*sl_;
                }else if(zz_=="1350"){
                    price = 1600*sl_;
                }else if(zz_=="1600"){
                    price = 1600*sl_;
                }else if(zz_=="2000"){
                    price = 1600*sl_;
                }
            }else if(bgj_=="无"){
                price = 0;
            }
            $("#JXZH_BGJ_TEMP").val(price);
        }else if(option=="JXZH_YLZHZL"){
            //预留装潢重量
            var ylzhzl_ = parseInt($("#JXZH_YLZHZL").val());
            var zz_ = $("#BZ_ZZ").val();  //载重
            if(ylzhzl_<=200){
                if(zz_=="450"){
                    price = 650*sl_;
                }else if(zz_=="630"){
                    price = 730*sl_;
                }else if(zz_=="800"){
                    price = 900*sl_;
                }else if(zz_=="1000"){
                    price = 1100*sl_;
                }
            }else if(ylzhzl_<=250){
                if(zz_=="1150"){
                    price = 1500*sl_;
                }
            }
            $("#JXZH_YLZHZL_TEMP").val(price);
        }else if(option=="JXZH_FSXH"){
            //扶手型号
            var fsxh_ = $("#JXZH_FSXH_SELECT").val();
            if(fsxh_=="JF-FS-01"){
                price = 650*sl_;
            }else if(fsxh_=="JF-FS-02"){
                price = 490*sl_;
            }else if(fsxh_=="JF-FS-03"){
                price = 490*sl_;
            }else if(fsxh_=="JF-FS-04"){
                price = 520*sl_;
            }
            $("#JXZH_FSXH_TEMP").val(price);
        }else if(option=="JXZH_FSAZWZ"){
            //扶手安装位置
            var fsazwz_sl = $("input:checkbox[name='JXZH_FSAZWZ']:checked").length;
            //单价
            var dj_ = parseInt($("#JXZH_FSXH_TEMP").val());
            price = parseInt(fsazwz_sl)*dj_;
            $("#JXZH_FSAZWZ_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //厅门门套部分-加价
    function editTmmt(option){
        //数量
        var sl_ = $("#FEIYUE_SL").val()==""?0:parseInt($("#FEIYUE_SL").val());
        var scmk_ = $("#TMMT_SCMK").val();//首层门框
        var qycmk_ = $("#TMMT_QYCMK").val();//其余层门框
        var kmkd_ = $("#BZ_KMKD").val();//开门宽度
        var c_ = parseInt($("#BZ_C").val());//层
        //价格
        var price = 0;
        if(option=="TMMT_SCMKCZ"){
            //首层门框材质
            var scmkcz_ = $("#TMMT_SCMKCZ").val();
            if(scmk_=="小门框"){
                if(scmkcz_=="发纹不锈钢"){
                    if(kmkd_=="800"){
                        price = 200*sl_;
                    }else if(kmkd_=="900"){
                        price = 260*sl_;
                    }else if(kmkd_=="1000"){
                        price = 320*sl_;
                    }
                }else if(scmkcz_=="镜面不锈钢"||scmkcz_=="钢板喷涂"){
                    price = 0;
                }
            }else if(scmk_=="大门框"){
                if(scmkcz_=="发纹不锈钢"){
                    if(kmkd_=="800"){
                        price = 1700*sl_;
                    }else if(kmkd_=="900"){
                        price = 1790*sl_;
                    }else if(kmkd_=="1000"){
                        price = 1860*sl_;
                    }
                }else if(scmkcz_=="镜面不锈钢"){
                    if(kmkd_=="800"){
                        price = 2760*sl_;
                    }else if(kmkd_=="900"){
                        price = 2990*sl_;
                    }else if(kmkd_=="1000"){
                        price = 3200*sl_;
                    }
                }else if(scmkcz_=="钢板喷涂"){
                    if(kmkd_=="800"){
                        price = 1000*sl_;
                    }else if(kmkd_=="900"){
                        price = 1090*sl_;
                    }else if(kmkd_=="1000"){
                        price = 1180*sl_;
                    }
                }
            }
            $("#TMMT_SCMKCZ_TEMP").val(price);
        }else if(option=="TMMT_QYCMKCZ"){
            //其余层门框
            var qycmkcz_ = $("#TMMT_QYCMKCZ").val();
            if(qycmk_=="小门框"){
                if(qycmkcz_=="发纹不锈钢"){
                    if(kmkd_=="800"){
                        price = 200*sl_*(c_-1);
                    }else if(kmkd_=="900"){
                        price = 260*sl_*(c_-1);
                    }else if(kmkd_=="1000"){
                        price = 320*sl_*(c_-1);
                    }
                }else if(qycmkcz_=="镜面不锈钢"||qycmkcz_=="钢板喷涂"){
                    price = 0;
                }
            }else if(qycmk_=="大门框"){
                if(qycmkcz_=="发纹不锈钢"){
                    if(kmkd_=="800"){
                        price = 1700*sl_*(c_-1);
                    }else if(kmkd_=="900"){
                        price = 1790*sl_*(c_-1);
                    }else if(kmkd_=="1000"){
                        price = 1860*sl_*(c_-1);
                    }
                }else if(qycmkcz_=="镜面不锈钢"){
                    if(kmkd_=="800"){
                        price = 2760*sl_*(c_-1);
                    }else if(kmkd_=="900"){
                        price = 2990*sl_*(c_-1);
                    }else if(kmkd_=="1000"){
                        price = 3200*sl_*(c_-1);
                    }
                }else if(qycmkcz_=="钢板喷涂"){
                    if(kmkd_=="800"){
                        price = 1000*sl_*(c_-1);
                    }else if(kmkd_=="900"){
                        price = 1090*sl_*(c_-1);
                    }else if(kmkd_=="1000"){
                        price = 1180*sl_*(c_-1);
                    }
                }
            }
            $("#TMMT_QYCMKCZ_TEMP").val(price);
        }else if(option=="TMMT_SCTMCZ"){
            //首层厅门材质
            if(kmkd_=="800"){
                price = 690*sl_;
            }else if(kmkd_=="900"){
                price = 830*sl_;
            }else if(kmkd_=="1000"){
                price = 960*sl_;
            }
            $("#TMMT_SCTMCZ_TEMP").val(price);
        }else if(option=="TMMT_QYCTMCZ"){
            //其余层厅门材质
            if(kmkd_=="800"){
                price = 690*sl_*(c_-1);
            }else if(kmkd_=="900"){
                price = 830*sl_*(c_-1);
            }else if(kmkd_=="1000"){
                price = 960*sl_*(c_-1);
            }
            $("#TMMT_QYCTMCZ_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }
    

    //操纵盘-加价
    function editCzp(option){
        var sl_ = parseInt($("#FEIYUE_SL").val());
        var price = 0;
        if(option=="CZP_CZPXH"){
            var xh_ = $("input[name='CZP_CZPXH']:checked").val();
            if(xh_=="JFCOP09H-D1"){
                //操纵盘显示
                var price_xs = 0;
                var xs_ = $("select[name='CZP_XS_SUB']").val();
                if(xs_=="真彩液晶图片显示7寸"){
                    price_xs = 1300*sl_;
                }else if(xs_=="真彩液晶图片显示10寸"){
                    price_xs = 2000*sl_;
                }else if(xs_=="真彩液晶多媒体显示10.4寸"){
                    price_xs = 6580*sl_;
                }else{
                    price_xs = 0;
                }
                $("#CZP_XS_TEMP").val(price_xs);
                //操纵盘按钮
                var price_an = 0;
                var an_ =  $("select[name='CZP_AN']").val();
                if(an_=="金属红光带字牌按钮"){
                    price_an = 31*sl_;
                }else{
                    price_an = 0;
                }
                $("#CZP_AN_TEMP").val(price_an);
                //材质
                var price_cz = 0;
                var cz_ = $("select[name='CZP_CZ']").val();
                if(cz_=="镜面不锈钢"){
                    price_cz = 500*sl_;
                }else if(cz_=="钛金不锈钢"){
                    price_cz = 700*sl_;
                }
                price = price_xs+price_an+price_cz;
                $("#CZP_CZPXH_TEMP").val(price);
            }else if(xh_=="JFCOP09H-D"){
                price = -500*sl_;
                $("#CZP_CZPXH_TEMP").val(price);
            }
        }
        //放入价格
        countZhj();
    }

    //厅门信号装置-加价
    function editTmxhzz(option){
        var sl_ = $("#FEIYUE_SL").val();
        var price = 0;
        if(option=="TMXHZZ_CZ"){
            //材质
            cz_ = $("select[name='TMXHZZ_CZ']").val();
            if(cz_=="镜面不锈钢"){
                price = 25*sl_;
            }else if(cz_=="钛金不锈钢"){
                price = 50*sl_;
            }
            $("#TMXHZZ_CZ_TEMP").val(price);
        }else if(option=="TMXHZZ_GBSCJRCZX"){
            //挂壁式残疾人操纵箱
            if($("#TMXHZZ_GBSCJRCZX_TEXT").is(":checked")){
                var c_ = parseInt($("#BZ_C").val());
                if(c_<=16){
                    price = 2900*sl_;
                }else if(c_<=30){
                    price = 4100*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMXHZZ_GBSCJRCZX_TEMP").val(price);
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
                        $("#FEIYUE_YSF").val(transPrice);
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
                        $("#FEIYUE_YSF").val(transPrice);
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

        if($("#OPT_LTBL_TEXT").is(":checked")){
            $("#OPT_LTBL").val("1");
        }else{
            $("#OPT_LTBL").val("0");
        }
        if($("#OPT_TDJJJY_TEXT").is(":checked")){
            $("#OPT_TDJJJY").val("1");
        }else{
            $("#OPT_TDJJJY").val("0");
        }
        if($("#OPT_JXDZZ_TEXT").is(":checked")){
            $("#OPT_JXDZZ").val("1");
        }else{
            $("#OPT_JXDZZ").val("0");
        }
        if($("#OPT_SJCZ_TEXT").is(":checked")){
            $("#OPT_SJCZ").val("1");
        }else{
            $("#OPT_SJCZ").val("0");
        }
        if($("#OPT_CCTVDL_TEXT").is(":checked")){
            $("#OPT_CCTVDL").val("1");
        }else{
            $("#OPT_CCTVDL").val("0");
        }
        if($("#OPT_DJGRBH_TEXT").is(":checked")){
            $("#OPT_DJGRBH").val("1");
        }else{
            $("#OPT_DJGRBH").val("0");
        }
        if($("#OPT_BAJK_TEXT").is(":checked")){
            $("#OPT_BAJK").val("1");
        }else{
            $("#OPT_BAJK").val("0");
        }
        if($("#OPT_MBCAN_TEXT").is(":checked")){
            $("#OPT_MBCAN").val("1");
        }else{
            $("#OPT_MBCAN").val("0");
        }
        if($("#OPT_KMZPC_TEXT").is(":checked")){
            $("#OPT_KMZPC").val("1");
        }else{
            $("#OPT_KMZPC").val("0");
        }
        if($("#OPT_QPGM_TEXT").is(":checked")){
            $("#OPT_QPGM").val("1");
        }else{
            $("#OPT_QPGM").val("0");
        }
        if($("#OPT_YCJK_TEXT").is(":checked")){
            $("#OPT_YCJK").val("1");
        }else{
            $("#OPT_YCJK").val("0");
        }
        if($("#OPT_JFGT_TEXT").is(":checked")){
            $("#OPT_JFGT").val("1");
        }else{
            $("#OPT_JFGT").val("0");
        }
        if($("#OPT_ICKZKSB_TEXT").is(":checked")){
            $("#OPT_ICKZKSB").val("1");
        }else{
            $("#OPT_ICKZKSB").val("0");
        }
        if($("#OPT_GTMJXJMBF_TEXT").is(":checked")){
            $("#OPT_GTMJXJMBF").val("1");
        }else{
            $("#OPT_GTMJXJMBF").val("0");
        }
            //厅门信号装置部分
        if($("#TMXHZZ_GBSCJRCZX_TEXT").is(":checked")){
            $("#TMXHZZ_GBSCJRCZX").val("1");
        }else{
            $("#TMXHZZ_GBSCJRCZX").val("0");
        }



        $("#feiyueForm").submit();
    }
</script>
</body>

</html>
