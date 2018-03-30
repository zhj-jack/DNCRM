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
    <form action="e_offer/${msg}.do" name="feiyangxfForm" id="feiyangxfForm" method="post">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="FEIYANGXF_ID" id="FEIYANGXF_ID" value="${pd.FEIYANGXF_ID}">
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
                                                <option value="飞扬消防梯">飞扬消防梯</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()">
                                                <option value="800" ${regelevStandardPd.ZZ=='800'?'selected':''}>800</option>
                                                <option value="1000" ${regelevStandardPd.ZZ=='1000'?'selected':''}>1000</option>
                                                <option value="1150" ${regelevStandardPd.ZZ=='1150'?'selected':''}>1150</option>
                                                <option value="1350" ${regelevStandardPd.ZZ=='1350'?'selected':''}>1350</option>
                                                <option value="1600" ${regelevStandardPd.ZZ=='1600'?'selected':''}>1600</option>
                                                <option value="2000" ${regelevStandardPd.ZZ=='2000'?'selected':''}>2000</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">速度(m/s):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_SD" name="BZ_SD" onchange="editSd();">
                                                <option value="1.0" ${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>
                                                <option value="1.5" ${regelevStandardPd.SD=='1.5'?'selected':''}>1.5</option>
                                                <option value="1.75" ${regelevStandardPd.SD=='1.75'?'selected':''}>1.75</option>
                                                <option value="2.0" ${regelevStandardPd.SD=='2.0'?'selected':''}>2.0</option>
                                                <option value="2.5" ${regelevStandardPd.SD=='2.5'?'selected':''}>2.5</option>
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
                                            <label style="width:20%;margin-left:57px"><input type="text" class="form-control m-b" id="FEIYANGXF_SL" name="FEIYANGXF_SL" value="${pd.FEIYANGXF_SL}" readonly="readonly"></label>

                                            <label style="width:9%;margin-top: 25px;margin-bottom: 10px;margin-left: 20px">折扣申请:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="FEIYANGXF_ZK" name="FEIYANGXF_ZK" value="${pd.FEIYANGXF_ZK}" onkeyup="countZhj();"></label>%
                                            <!-- <select  class="form-control m-b" id="FEIYANGXF_ZK" name="FEIYANGXF_ZK" onchange="countZhj();">
                                                <option value="1">请选择折扣</option>
                                                <option value="0.9" ${pd.FEIYANGXF_ZK=='0.9'?'selected':''}>90%</option>
                                                <option value="0.6" ${pd.FEIYANGXF_ZK=='0.6'?'selected':''}>60%</option>
                                                <option value="0.5" ${pd.FEIYANGXF_ZK=='0.5'?'selected':''}>50%</option>
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
                                                    <td>${pd.FEIYANGXF_SL}</td>
                                                    <td>
                                                        ${regelevStandardPd.C}
                                                        /
                                                        ${regelevStandardPd.Z}
                                                        /
                                                        ${regelevStandardPd.M}
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGXF_ZHJ" id="FEIYANGXF_ZHJ" value="${pd.FEIYANGXF_ZHJ}"></td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGXF_SBJ" id="FEIYANGXF_SBJ" value="${regelevStandardPd.PRICE}">
                                                    <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}"></td>
                                                    <td><font color="red"><span id="zk_">${pd.FEIYANGXF_ZK}</span></font></td>
                                                    <td><font color="red"><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGXF_ZHSBJ" id="FEIYANGXF_ZHSBJ" value="${pd.FEIYANGXF_ZHSBJ}"></font></td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" name="FEIYANGXF_AZF" id="FEIYANGXF_AZF" value="${pd.FEIYANGXF_AZF}"  style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' onkeyup="countZhj();" />
                                                        </font>
                                                    </td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGXF_YSF" id="FEIYANGXF_YSF" value="${pd.FEIYANGXF_YSF}">
                                                        </font>
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGXF_SJBJ" id="FEIYANGXF_SJBJ" value="${pd.FEIYANGXF_SJBJ}"></td>
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
                                                                <select name="BASE_KZXT" id="BASE_KZXT" class="form-control" >
                                                                    <option value="STEP">STEP</option>
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
                                                            <td>曳引主机</td>
                                                            <td colspan="2">
                                                                <select name="BASE_YYZJ" id="BASE_YYZJ" class="form-control" >
                                                                    <option value="">请选择</option>
                                                                    <option value="西子富沃德(800-1600标准)" ${pd.BASE_YYZJ=='西子富沃德(800-1600标准)'?'selected':''}>西子富沃德(800-1600标准)</option>
                                                                </select>
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
                                                                <input type="text" name="BASE_QGLJJ" id="BASE_QGLJJ" class="form-control"  value="${pd.BASE_QGLJJ}"/>mm </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢规格CW*CD(mm)</td>
                                                            <td colspan="2">
                                                                <select name="BASE_JXGG" id="BASE_JXGG" class="form-control" >
                                                                    <option value=''>请选择</option>
                                                                    <option value="800W-1350×1400" ${pd.BASE_JXGG=='800W-1350×1400'?'selected':''}>800W-1350×1400</option>
                                                                    <option value="1000W-1600×1400" ${pd.BASE_JXGG=='1000W-1600×1400'?'selected':''}>1000W-1600×1400</option>
                                                                    <option value="1000D-1100×2100担架梯" ${pd.BASE_JXGG=='1000D-1100×2100担架梯'?'selected':''}>1000D-1100×2100担架梯</option>
                                                                    <option value="1150W-2000×1350" ${pd.BASE_JXGG=='1150W-2000×1350'?'selected':''}>1150W-2000×1350</option>
                                                                    <option value="1350W-2000×1500" ${pd.BASE_JXGG=='1350W-2000×1500'?'selected':''}>1350W-2000×1500</option>
                                                                    <option value="1600W-2000×1700" ${pd.BASE_JXGG=='1600W-2000×1700'?'selected':''}>1600W-2000×1700</option>
                                                                </select>   
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">轿厢高度(非净高)</td>
                                                            <td>
                                                                <input type="radio" name="BASE_JXGD" value="2400" ${pd.BASE_JXGD=='2400'?'checked':''}/>2400mm(800-1000 标准)
                                                                <input type="radio" name="BASE_JXGD" value="2500" ${pd.BASE_JXGD=='2500'?'checked':''}/>2500mm(1150-1600 标准)
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
                                                                <input type="radio" name="BASE_JXGD" value="2300" ${pd.BASE_JXGD=='2300'?'checked':''}/>
                                                                2300mm
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
                                                            <td>开门尺寸OP*OPH </td>
                                                            <td colspan="2">
                                                                <select name="BASE_KMCC" id="BASE_KMCC" class="form-control" >
                                                                  <option value=''>请选择</option>
                                                                  <option value="800mm×2100mm(800kg)" ${pd.BASE_KMCC=='800mm×2100mm(800kg)'?'selected':''}>800mm×2100mm(800kg)</option>
                                                                  <option value="900mm×2100mm(1000kg)" ${pd.BASE_KMCC=='900mm×2100mm(1000kg)'?'selected':''}>900mm×2100mm(1000kg)</option>
                                                                  <option value="1100mm×2100mm(1150kg-1600kg)" ${pd.BASE_KMCC=='1100mm×2100mm(1150kg-1600kg)'?'selected':''}>1100mm×2100mm(1150kg-1600kg)</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
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
                                                                <select name="BASE_MLXMBH_TEXT" id="BASE_MLXMBH_TEXT" class="form-control" >
                                                                    <option value=''>请选择</option>
                                                                    <option value="VVVF申菱门机/2D光幕" ${pd.BASE_MLXMBH=='VVVF申菱门机/2D光幕'?'selected':''}>VVVF申菱门机</option>
                                                                </select>
                                                                /2D光幕
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道承重墙厚度</td>
                                                            <td width="317">
                                                                <input type="radio" name="BASE_JDCZQHD" value="250" onclick="setJdczqhdDisable('1');"  ${pd.BASE_JDCZQHD=='250'?'checked':''}/>
                                                                WT=250mm
                                                            </td>
                                                            <td width="424">
                                                                <input type="radio" name="BASE_JDCZQHD" value="" onclick="setJdczqhdDisable('0')" ${pd.BASE_JDCZQHD=='250'?'':'checked'}/>
                                                                WT=
                                                                <input name="BASE_JDCZQHD_TEXT" id="BASE_JDCZQHD_TEXT" type="text" class="form-control"  value="${pd.BASE_JDCZQHD}"/>
                                                                mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>提升高度RISE</td>
                                                            <td>
                                                                <input name="BASE_TSGD" id="BASE_TSGD" type="text" onkeyup="setJdzg();" class="form-control" value="${pd.BASE_TSGD}" />mm
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
                                                                <input type="text" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP"></td>
                                                          </tr><tr>
                                                            <td>导轨支架</td>
                                                            <td colspan="2">
                                                                <input name="BASE_DGZJ" id="BASE_DGZJ" type="text" class="form-control"  value="${pd.BASE_DGZJ}" onkeyup="setDgzj();" />
                                                            </td>
                                                            <td>
                                                                <input type="text" name="BASE_DGZJ_TEMP" id="BASE_DGZJ_TEMP"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
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
                                                            <td>全集选控制</td>
                                                            <td>FCL</td>
                                                            <td>9</td>
                                                            <td>轿内通风手动及照明自动控制</td>
                                                            <td>FLP</td>
                                                            <td>17</td>
                                                            <td>厅及轿厢运行方向显示</td>
                                                            <td>HDI&amp;CDI</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>轿顶与机房紧急电动运行</td>
                                                            <td>TCI ERO </td>
                                                            <td>10</td>
                                                            <td>故障自动检测</td>
                                                            <td>FAN</td>
                                                            <td>18</td>
                                                            <td>2D光幕门保护装置</td>
                                                            <td>LRD</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>轿内应急照明</td>
                                                            <td>ECU</td>
                                                            <td>11</td>
                                                            <td>关门时间保护</td>
                                                            <td>DTP</td>
                                                            <td>19</td>
                                                            <td>紧急消防操作</td>
                                                            <td>EFO</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>设置厅、轿门时间</td>
                                                            <td>CHT</td>
                                                            <td>12</td>
                                                            <td>超载不启动(警示灯及蜂鸣器)</td>
                                                            <td>OLD</td>
                                                            <td rowspan="2">20</td>
                                                            <td rowspan="2">监控室与机房、轿厢对讲(不含机房到监控室连线)</td>
                                                            <td rowspan="2">ICU</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>满载不停梯</td>
                                                            <td>LNS</td>
                                                            <td>13</td>
                                                            <td>运行次数显示</td>
                                                            <td>TRIC</td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>无呼自动返基站</td>
                                                            <td>ARTL</td>
                                                            <td>14</td>
                                                            <td>警铃</td>
                                                            <td>ALM</td>
                                                            <td>21</td>
                                                            <td>开、关门按钮</td>
                                                            <td>DOB DCB </td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>驻停</td>
                                                            <td>PKS</td>
                                                            <td>15</td>
                                                            <td>厅和轿厢数字位置指示器</td>
                                                            <td>HPI</td>
                                                            <td>22</td>
                                                            <td>错误指令删除</td>
                                                            <td>DCC</td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>司机操作</td>
                                                            <td>ATT</td>
                                                            <td>16</td>
                                                            <td>厅外和轿厢呼梯/登记</td>
                                                            <td>DTTL</td>
                                                            <td>23</td>
                                                            <td>消防员运行</td>
                                                            <td>EFS</td>
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
                                                            <td>简称</td>
                                                            <td>有</td>
                                                            <td>加价</td>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                            <td>有</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>1</td>
                                                            <td>盲文按钮(无偿选配)</td>
                                                            <td>BRAILLEB</td>
                                                            <td>
                                                                <input name="OPT_MWAN_TEXT" id="OPT_MWAN_TEXT" type="checkbox" onlcick="editOpt('OPT_MWAN');" ${pd.OPT_MWAN=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_MWAN" id="OPT_MWAN">
                                                            </td>
                                                            <td><input type="text" name="OPT_MWAN_TEMP" id="OPT_MWAN_TEMP" class="form-control"></td>
                                                            <td>16</td>
                                                            <td>防捣乱操作</td>
                                                            <td>ANS</td>
                                                            <td>
                                                                <input name="OPT_FDLCZ_TEXT" id="OPT_FDLCZ_TEXT" type="checkbox" onclick="editOpt('OPT_FDLCZ');"  ${pd.OPT_FDLCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_FDLCZ" id="OPT_FDLCZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FDLCZ_TEMP" id="OPT_FDLCZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>火警自动返回基站</td>
                                                            <td>FL</td>
                                                            <td>
                                                                <input name="OPT_HJZDFHJZ_TEXT" id="OPT_HJZDFHJZ_TEXT" type="checkbox" onclick="editOpt('OPT_HJZDFHJZ');"  ${pd.OPT_HJZDFHJZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_HJZDFHJZ" id="OPT_HJZDFHJZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJZDFHJZ_TEMP" id="OPT_HJZDFHJZ_TEMP" class="form-control"></td>
                                                            <td>17</td>
                                                            <td>再平层</td>
                                                            <td>RLEV</td>
                                                            <td>
                                                                <input name="OPT_ZPC_TEXT" id="OPT_ZPC_TEXT" type="checkbox" onclick="editOpt('OPT_ZPC')"  ${pd.OPT_ZPC=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ZPC" id="OPT_ZPC">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZPC_TEMP" id="OPT_ZPC_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>消防员运行</td>
                                                            <td>EFS</td>
                                                            <td>
                                                                <input name="OPT_XFYYX_TEXT" id="OPT_XFYYX_TEXT" type="checkbox" onclick="editOpt('OPT_XFYYX');"  ${pd.OPT_XFYYX=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_XFYYX" id="OPT_XFYYX">
                                                            </td>
                                                            <td><input type="text" name="OPT_XFYYX_TEMP" id="OPT_XFYYX_TEMP" class="form-control"></td>
                                                            <td>18</td>
                                                            <td>BA接口</td>
                                                            <td>BA</td>
                                                            <td>
                                                                <input name="OPT_BAJK_TEXT" id="OPT_BAJK_TEXT" type="checkbox" onclick="editOpt('OPT_BAJK');"  ${pd.OPT_BAJK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_BAJK" id="OPT_BAJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_BAJK_TEMP" id="OPT_BAJK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>轿厢到站钟</td>
                                                            <td>GNC</td>
                                                            <td>
                                                                <input name="OPT_JXDZZ_TEXT" id="OPT_JXDZZ_TEXT" type="checkbox" onclick="editOpt('OPT_JXDZZ');"  ${pd.OPT_JXDZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JXDZZ" id="OPT_JXDZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JXDZZ_TEMP" id="OPT_JXDZZ_TEMP" class="form-control"></td>
                                                            <td>19</td>
                                                            <td>语音报站</td>
                                                            <td>SR</td>
                                                            <td>
                                                                <input name="OPT_YXBZ_TEXT" id="OPT_YXBZ_TEXT" type="checkbox" onclick="editOpt('OPT_YYBZ');"  ${pd.OPT_YYBZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YYBZ" id="OPT_YYBZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YYBZ_TEMP" id="OPT_YYBZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>CCTV电缆(轿厢到机房)</td>
                                                            <td>CCTVC</td>
                                                            <td>
                                                                <input name="OPT_CCTVDL_TEXT" id="OPT_CCTVDL_TEXT" type="checkbox" onclick="editOpt('OPT_CCTVDL');"  ${pd.OPT_CCTVDL=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_CCTVDL" id="OPT_CCTVDL">
                                                            </td>
                                                            <td><input type="text" name="OPT_CCTVDL_TEMP" id="OPT_CCTVDL_TEMP" class="form-control"></td>
                                                            <td>20</td>
                                                            <td>强迫关门</td>
                                                            <td>NDG</td>
                                                            <td>
                                                                <input name="OPT_QPGM_TEXT" id="OPT_QPGM_TEXT" type="checkbox" onclick="editOpt('OPT_QPGM');"  ${pd.OPT_QPGM=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_QPGM" id="OPT_QPGM">
                                                            </td>
                                                            <td><input type="text" name="OPT_QPGM_TEMP" id="OPT_QPGM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>停电紧急救援</td>
                                                            <td>ARD</td>
                                                            <td>
                                                                <input name="OPT_TDJJJY_TEXT" id="OPT_TDJJJY_TEXT" type="checkbox" onclick="editOpt('OPT_TDJJJY');"  ${pd.OPT_TDJJJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TDJJJY" id="OPT_TDJJJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_TDJJJY_TEMP" id="OPT_TDJJJY_TEMP" class="form-control"></td>
                                                            <td>21</td>
                                                            <td>独立服务</td>
                                                            <td>ISC</td>
                                                            <td>
                                                                <input name="OPT_DLFW_TEXT" id="OPT_DLFW_TEXT" type="checkbox" onclick="editOpt('OPT_DLFW');"  ${pd.OPT_DLFW=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DLFW" id="OPT_DLFW">
                                                            </td>
                                                            <td><input type="text" name="OPT_DLFW_TEMP" id="OPT_DLFW_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>电机过热保护</td>
                                                            <td>THB</td>
                                                            <td>
                                                                <input name="OPT_DJGRBH_TEXT" id="OPT_DJGRBH_TEXT" type="checkbox" onclick="editOpt('OPT_DJGRBH');"  ${pd.OPT_DJGRBH=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DJGRBH" id="OPT_DJGRBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_DJGRBH_TEMP" id="OPT_DJGRBH_TEMP" class="form-control"></td>
                                                            <td>22</td>
                                                            <td>开门保持</td>
                                                            <td>DHB</td>
                                                            <td>
                                                                <input name="OPT_KMBC_TEXT" id="OPT_KMBC_TEXT" type="checkbox" onclick="editOpt('OPT_KMBC');"  ${pd.OPT_KMBC=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_KMBC" id="OPT_KMBC">
                                                            </td>
                                                            <td><input type="text" name="OPT_KMBC_TEMP" id="OPT_KMBC_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>空气净化装置</td>
                                                            <td>ANION</td>
                                                            <td>
                                                                <input name="OPT_KQJHZZ_TEXT" id="OPT_KQJHZZ_TEXT" type="checkbox" onclick="editOpt('OPT_KQJHZZ');"  ${pd.OPT_KQJHZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_KQJHZZ" id="OPT_KQJHZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_KQJHZZ_TEMP" id="OPT_KQJHZZ_TEMP" class="form-control"></td>
                                                            <td>23</td>
                                                            <td>地震运行</td>
                                                            <td>EQO</td>
                                                            <td>
                                                                <input name="OPT_DZYX_TEXT" id="OPT_DZYX_TEXT" type="checkbox" onclick="editOpt('OPT_DZYX');"  ${pd.OPT_DZYX=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DZYX" id="OPT_DZYX">
                                                            </td>
                                                            <td><input type="text" name="OPT_DZYX_TEMP" id="OPT_DZYX_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>纳米银抗菌按钮</td>
                                                            <td>NANOAGB</td>
                                                            <td>
                                                                <input name="OPT_NMYKJAN" id="OPT_NMYKJAN" type="text" onclick="editOpt('OPT_NMYKJAN');" class="form-control" style="width: 100%" value="${pd.OPT_NMYKJAN}"/>
                                                                <!-- <input name="OPT_NMYKJAN_TEXT" id="OPT_NMYKJAN_TEXT" type="checkbox" onclick="editOpt('OPT_NMYKJAN');"  ${pd.OPT_NMYKJAN=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_NMYKJAN" id="OPT_NMYKJAN"> -->
                                                            </td>
                                                            <td><input type="text" name="OPT_NMYKJAN_TEMP" id="OPT_NMYKJAN_TEMP" class="form-control"></td>
                                                            <td>24</td>
                                                            <td>能量回馈</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_NLHK_TEXT" id="OPT_NLHK_TEXT" type="checkbox" onclick="editOpt('OPT_NLHK');"  ${pd.OPT_NLHK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_NLHK" id="OPT_NLHK">
                                                            </td>
                                                            <td><input type="text" name="OPT_NLHK_TEMP" id="OPT_NLHK_TEMP" class="form-control"></td>
                                                          </tr><tr>
                                                            <td>10</td>
                                                            <td>远程监控(物联网系统)</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_YCJK_TEXT" id="OPT_YCJK_TEXT" type="checkbox" onclick="editOpt('OPT_YCJK');"  ${pd.OPT_YCJK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YCJK" id="OPT_YCJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_YCJK_TEMP" id="OPT_YCJK_TEMP" class="form-control"></td>
                                                            <td>25</td>
                                                            <td>IC卡(轿内控制)</td>
                                                            <td></td>
                                                            <td>
                                                                <select name="OPT_ICK" id="OPT_ICK" onchange="editOpt('OPT_ICK');" class="form-control" style="width: 100%">
                                                                    <option value="">请选择</option>
                                                                    <option value="刷卡后手动选择到达楼层" ${pd.OPT_ICK=='刷卡后手动选择到达楼层'?'selected':''}>刷卡后手动选择到达楼层</option>
                                                                    <option value="刷卡后自动选择到达楼层" ${pd.OPT_ICK=='刷卡后自动选择到达楼层'?'selected':''}>刷卡后自动选择到达楼层</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ICK_TEMP" id="OPT_ICK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>IC卡制卡设备</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_ICKZKSB_TEXT" id="OPT_ICKZKSB_TEXT" type="checkbox" onclick="editOpt('OPT_ICKZKSB');"  ${pd.OPT_ICKZKSB=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ICKZKSB" id="OPT_ICKZKSB">
                                                            </td>
                                                            <td><input type="text" name="OPT_ICKZKSB_TEMP" id="OPT_ICKZKSB_TEMP" class="form-control"></td>
                                                            <td>26</td>
                                                            <td>IC卡卡片(张)</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_ICKKP" id="OPT_ICKKP" type="text" onkeyup="editOpt('OPT_ICKKP');" class="form-control" style="width: 100%" value="${pd.OPT_ICKKP}"/>
                                                            </td>
                                                            <td><input type="text" name="OPT_ICKKP_TEMP" id="OPT_ICKKP_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>普通电梯空调</td>
                                                            <td></td>
                                                            <td>
                                                                <select name="OPT_PTDTKT" id="OPT_PTDTKT" onchange="editOpt('OPT_PTDTKT');" class="form-control" style="width: 100%">
                                                                    <option value=''>请选择</option>
                                                                    <option value='单冷型2200W' ${pd.OPT_PTDTKT=='单冷型2200W'?'selected':''}>单冷型2200W</option>
                                                                    <option value='冷暖型1500W' ${pd.OPT_PTDTKT=='冷暖型1500W'?'selected':''}>冷暖型1500W</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_PTDTKT_TEMP" id="OPT_PTDTKT_TEMP" class="form-control"></td>
                                                            <td>27</td>
                                                            <td>专用分体式电梯空调</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_ZYFTSDTKT" id="OPT_ZYFTSDTKT" onchange="editOpt('OPT_ZYFTSDTKT');" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value='单冷型2200W' ${pd.OPT_ZYFTSDTKT=='单冷型2200W'?'selected':''}>单冷型2200W</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ZYFTSDTKT_TEMP" id="OPT_ZYFTSDTKT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>13</td>
                                                            <td>进口光幕</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_JKGM_TEXT" id="OPT_JKGM_TEXT" type="checkbox" onclick="editOpt('OPT_JKGM');"  ${pd.OPT_JKGM=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JKGM" id="OPT_JKGM">
                                                            </td>
                                                            <td><input type="text" name="OPT_JKGM_TEMP" id="OPT_JKGM_TEMP" class="form-control"></td>
                                                            <td>28</td>
                                                            <td>进口曳引机</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_JKYYJ_TEXT" id="OPT_JKYYJ_TEXT" type="checkbox" onclick="editOpt('OPT_JKYYJ');"  ${pd.OPT_JKYYJ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JKYYJ" id="OPT_JKYYJ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JKYYJ_TEMP" id="OPT_JKYYJ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>14</td>
                                                            <td>贯通门(轿厢、轿门部分)</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_GTMJXJMBF_TEXT" id="OPT_GTMJXJMBF_TEXT" type="checkbox" onclick="editOpt('OPT_GTMJXJMBF');"  ${pd.OPT_GTMJXJMBF=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GTMJXJMBF" id="OPT_GTMJXJMBF">
                                                            </td>
                                                            <td><input type="text" name="OPT_GTMJXJMBF_TEMP" id="OPT_GTMJXJMBF_TEMP" class="form-control"></td>
                                                            <td>29</td>
                                                            <td>贯通门(厅门部分)</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_GTMTMBF_TEXT" id="OPT_GTMTMBF_TEXT" onchange="editOpt('OPT_GTMTMBF');" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value='发纹不锈钢' ${pd.OPT_GTMTMBF=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value='喷涂' ${pd.OPT_GTMTMBF=='喷涂'?'selected':''}>喷涂</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_GTMTMBF" id="OPT_GTMTMBF">
                                                            </td>
                                                            <td><input type="text" name="OPT_GTMTMBF_TEMP" id="OPT_GTMTMBF_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>15</td>
                                                            <td>贯通门数</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_GTMS_TEXT" id="OPT_GTMS_TEXT" type="text" onclick="editOpt('OPT_GTMS');" class="form-control" style="width: 100%" value="${pd.OPT_GTMS}"/>
                                                                <input type="hidden" name="OPT_GTMS" id="OPT_GTMS">
                                                            </td>
                                                            <td><input type="text" name="OPT_GTMS_TEMP" id="OPT_GTMS_TEMP" class="form-control"></td>
                                                            <td>30</td>
                                                            <td>层门装潢</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_CMZH_TEXT" id="OPT_CMZH_TEXT" onchange="editOpt('OPT_CMZH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JF-K-C01" ${pd.OPT_CMZH=='JF-K-C01'?'selected':''}>JF-K-C01</option>
                                                                    <option value="JF-K-C02" ${pd.OPT_CMZH=='JF-K-C02'?'selected':''}>JF-K-C02</option>
                                                                    <option value="JF-K-C03" ${pd.OPT_CMZH=='JF-K-C03'?'selected':''}>JF-K-C03</option>
                                                                    <option value="JF-K-C04" ${pd.OPT_CMZH=='JF-K-C04'?'selected':''}>JF-K-C04</option>
                                                                    <option value="JF-K-C05" ${pd.OPT_CMZH=='JF-K-C05'?'selected':''}>JF-K-C05</option>
                                                                    <option value="JF-K-C06" ${pd.OPT_CMZH=='JF-K-C06'?'selected':''}>JF-K-C06</option>
                                                                    <option value="JF-K-C07" ${pd.OPT_CMZH=='JF-K-C07'?'selected':''}>JF-K-C07</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_CMZH" id="OPT_CMZH">
                                                            <td><input type="text" name="OPT_CMZH_TEMP" id="OPT_CMZH_TEMP" class="form-control"></td>
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
                                                                <input name="DZJKSDJXT_DJTXFS" type="radio" value="一对一" ${pd.DZJKSDJXT_DJTXFS=='一对一'?'checked':''}/>
                                                                一对一
                                                                <input name="DZJKSDJXT_DJTXFS" type="radio" value="一对多" ${pd.DZJKSDJXT_DJTXFS=='一对多'?'checked':''}/>
                                                                一对多
                                                            </td>
                                                            <td width="326">对讲的电梯台数:    
                                                            <input name="DZJKSDJXT_DJTS" id="DZJKSDJXT_DJTS" type="text" class="form-control" value="${pd.DZJKSDJXT_DJTS}"/>
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
                                                          <!-- <tr>
                                                            <td>加价</td>
                                                            <td colspan="2"><input type="text" name="DZJKSDJXT_DJTS_TEMP" id="DZJKSDJXT_DJTS_TEMP" class="form-control"/></td>
                                                          </tr> -->
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
                                                                    <option value=''请选择</option>
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
                                                                <input name="JXZH_CWB" type="radio" value="SUS304发纹不锈钢" onclick="setCwbsbhDisable('1');" ${pd.JXZH_CWB=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_CWB" type="radio" value="镜面不锈钢" onclick="setCwbsbhDisable('1');" ${pd.JXZH_CWB=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_CWB" type="radio" value="喷涂" onclick="setCwbsbhDisable('0');" ${pd.JXZH_CWB=='喷涂'?'checked':''}/>
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
                                                                <input name="JXZH_JDZH" type="radio" value="悬吊式" onclick="setJdzhDisable('2');" ${pd.JXZH_JDZH=='悬吊式'?'checked':''} />
                                                                悬吊式:
                                                                <select name="JXZH_ZSDD" onchange="editJxzh('JXZH_ZSDD');" id="ZSDD_2" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="JF-CL-21" ${pd.JXZH_ZSDD=='JF-CL-21'?'selected':''}>JF-CL-21</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_ZSDD_TEMP" id="JXZH_ZSDD_TEMP" class="form-control"></td>
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
                                                                <input type="radio" name="JXZH_DBXH" value="JD-05" onclick="setDbxhDisable('1');" ${pd.JXZH_DBXH=='JD-05'?'checked':''}>
                                                                JD-05
                                                            </td>
                                                            <td>
                                                                可选:
                                                                <input name="JXZH_DBXH" type="radio" value="" onclick="setDbxhDisable('0');" ${pd.JXZH_DBXH=='JD-05'?'':'checked'}/>
                                                                <select name="JXZH_DBXH_SELECT" id="JXZH_DBXH_SELECT" class="form-control">
                                                                  <option value="无">请选择</option>
                                                                  <option value="JD-01" ${pd.JXZH_DBXH=='JD-01'?'selected':''}>JD-01</option>
                                                                  <option value="JD-02" ${pd.JXZH_DBXH=='JD-02'?'selected':''}>JD-02</option>
                                                                  <option value="JD-03" ${pd.JXZH_DBXH=='JD-03'?'selected':''}>JD-03</option>
                                                                  <option value="JD-04" ${pd.JXZH_DBXH=='JD-04'?'selected':''}>JD-04</option>
                                                                </select>
                                                                <input name="JXZH_DBXH" type="radio" value="大理石预留" onclick="setDbxhDisable('1');"${pd.JXZH_DBXH=='大理石预留'?'checked':''}/>
                                                                大理石预留
                                                            </td>
                                                            <td><input type="text" name="JXZH_DBXH_TEMP" id="JXZH_DBXH_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板装修厚度mm</td>
                                                            <td><input type="text" value="${pd.JXZH_DBZXHD}" name="JXZH_DBZXHD" id="JXZH_DBZXHD" class="form-control"></td>
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
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="后围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ=='后围壁'?'selected':''}/>
                                                                后围壁 轿厢外向内看:
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="左围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ=='左围壁'?'selected':''}/>
                                                                左围壁
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="右围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ=='右围壁'?'selected':''}/>
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
                                                            <td>减震不锈钢小门套</td>
                                                            <td colspan="2"><input type="checkbox" name="TMMT_JZBXGXMT_TEXT" id="TMMT_JZBXGXMT_TEXT" onclick="editTmmt('TMMT_JZBXGXMT');" ${pd.TMMT_JZBXGXMT=='1'?'checked':''}></td>
                                                            <input type="hidden" name="TMMT_JZBXGXMT" id="TMMT_JZBXGXMT">
                                                            <td><input type="text" name="TMMT_JZBXGXMT_TEMP" id="TMMT_JZBXGXMT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>喷涂→大门套(墙厚+装饰层)≤350mm</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_PTDMT" name="TMMT_PTDMT" onchange="editTmmt('TMMT_PTDMT');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="喷涂" ${pd.TMMT_PTDMT=='喷涂'?'selected':''}>喷涂</option>
                                                                    <option value="减震复合不锈钢" ${pd.TMMT_PTDMT=='减震复合不锈钢'?'selected':''}>减震复合不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_PTDMT=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_PTDMT_TEMP" id="TMMT_PTDMT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>喷涂镜面不锈钢厅门、小门套</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="TMMT_PTJMBXGTM_TEXT" id="TMMT_PTJMBXGTM_TEXT" onclick="editTmmt('TMMT_PTJMBXGTM');" ${pd.TMMT_PTJMBXGTM=='1'?'checked':''}>
                                                                <input type="hidden" name="TMMT_PTJMBXGTM" id="TMMT_PTJMBXGTM">
                                                            <td><input type="text" name="TMMT_PTJMBXGTM_TEMP" id="TMMT_PTJMBXGTM_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="41" rowspan="4">首层厅门门套</td>
                                                            <td width="155">厅门材质</td>
                                                            <td width="198">数量</td>
                                                            <td width="100">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                标准:
                                                                <input type="radio" name="TMMT_SCTMMT" value="SUS304发纹不锈钢" onclick="setScsbhDisable('1');" ${pd.TMMT_SCTMMT=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                各
                                                                <input name="text" type="text" class="form-control"/>
                                                                套
                                                            </td>
                                                            <td rowspan="3"><input type="text" name="TMMT_SCTMMT_TEMP" id="TMMT_SCTMMT_TEMP" class="form-control"></td>
                                                           </tr>
                                                           <tr>
                                                            <td>
                                                                可选1:
                                                                <input name="TMMT_SCTMMT" type="radio" value="镜面不锈钢" onclick="setScsbhDisable('1');" ${pd.TMMT_SCTMMT=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                            </td>
                                                            <td>
                                                                各
                                                                <input name="text3" type="text" class="form-control"/>
                                                                套
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                可选2:
                                                                <input name="TMMT_SCTMMT" type="radio" value="喷涂" onclick="setScsbhDisable('0');" ${pd.TMMT_SCTMMT=='喷涂'?'checked':''}/>
                                                                喷涂
                                                                色标号:
                                                                <select name="TMMT_SCSBH" id="TMMT_SCSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_SCSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_SCSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_SCSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_SCSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_SCSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_SCSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_SCSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>   
                                                            </td>
                                                            <td>
                                                                各
                                                                <input name="text5" type="text" class="form-control"/>
                                                                套
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="3">非首层厅门门套</td>
                                                            <td>
                                                                标准:
                                                                <input name="TMMT_FSCTMMT" type="radio" value="喷涂" onclick="setFscsbhDisable('0');" ${pd.TMMT_FSCTMMT=='喷涂'?'checked':''}/>
                                                                喷涂
                                                                色标号:
                                                                <select name="select" name="TMMT_FSCSBH" id="TMMT_FSCSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_FSCSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_FSCSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_FSCSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_FSCSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_FSCSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_FSCSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_FSCSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                各
                                                                <input name="text6" type="text" class="form-control"/>
                                                                套
                                                            </td>
                                                            <td rowspan="3"><input type="text" name="TMMT_FSCTMMT_TEMP" id="TMMT_FSCTMMT_TEMP" class="form-control"></td>
                                                           </tr>
                                                           <tr>
                                                            <td>
                                                                可选1:
                                                                <input name="TMMT_FSCTMMT" type="radio" value="镜面不锈钢" onclick="setFscsbhDisable('1');" ${pd.TMMT_FSCTMMT=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                            </td>
                                                            <td>
                                                                各
                                                                <input name="text32" type="text" class="form-control"/>
                                                                套
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                可选2:
                                                                <input name="TMMT_FSCTMMT" type="radio" value="SUS304发纹不锈钢" onclick="setFscsbhDisable('1');" ${pd.TMMT_FSCTMMT=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                各
                                                                <input name="text7" type="text" class="form-control"/>
                                                                套
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">备注</td>
                                                            <td colspan="5">
                                                                厅门和门套的数量,不管单台还是并联或多台群控,必须按单台计算,并注明合同号,多台可连写
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 厅门门套 -->
                                                </div>
                                                <div id="tab-7" class="tab-pane">
                                                    <!-- 操纵盘 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>操纵盘类型</td>
                                                            <td>
                                                                <select name="CZP_CZPLX" id="CZP_CZPLX">
                                                                    <option value="">请选择</option>
                                                                    <option value='IPX3' ${pd.CZP_CZPLX=='IPX3'?'selected':''}>IPX3</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            </td>
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
                                                                    <input type="radio" name="CZP_CZPXH" value="JFCOP09H-C1" onclick="setCzpxhDisable('2');" ${pd.CZP_CZPXH=='JFCOP09H-C1'?'checked':''}/>
                                                                    JFCOP09H-C1(标配只勾选本行,下列不必选)
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
                                                                    <input name="CZP_CZPXH" type="radio" value="XFCOP01H-C" onclick="setCzpxhDisable('1');" ${pd.CZP_CZPXH=='XFCOP01H-C'?'checked':''}/>
                                                                    XFCOP01H-C
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="CZP_XS" id="CZP_XS_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.CZP_XS=='LCD(标配)'?'selected':''}>LCD(标配)</option>
                                                                        <option value="LED(无偿选配)" ${pd.CZP_XS=='LED(无偿选配)'?'selected':''}>LED(无偿选配)</option>
                                                                        <option value="TFT(有偿选配)" ${pd.CZP_XS=='TFT(有偿选配)'?'selected':''}>TFT(有偿选配)</option>
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
                                                                    <input name="TMXHZZ_TWZHXH" type="radio" value="JFHB09H-D1" onclick="setTwzhxhDisable('2');"  ${pd.TMXHZZ_TWZHXH=='JFHB09H-D1'?'checked':''}/>
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
                                                                        <option value="发纹不锈钢(标准)" ${pd.TMXHZZ_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
                                                                        <option value="镜面不锈钢" ${pd.TMXHZZ_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    <input name="TMXHZZ_TWZHXH" type="radio" value="JFHB09H-D" onclick="setTwzhxhDisable('1');"/>
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
                                                                        <option value="发纹不锈钢" ${pd.TMXHZZ_CZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                        <option value="镜面不锈钢" ${pd.TMXHZZ_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
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
                                                                    <input name="TMXHZZ_ZDJC" type="text"  id="TMXHZZ_ZDJC_1" class="form-control" style="width: 50px" value="${pd.TMXHZZ_ZDJC}"/>
                                                                    层、每层
                                                                    <input name="TMXHZZ_MCGS" type="text" id="TMXHZZ_MCGS_1" class="form-control" style="width: 50px" value="${pd.TMXHZZ_MCGS}"/>
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
                                                                    <input name="TMXHZZ_ZDJC" type="text" id="TMXHZZ_ZDJC_2" class="form-control" style="width: 50px" value="${pd.TMXHZZ_ZDJC}"/>
                                                                    层、每层
                                                                    <input name="TMXHZZ_MCGS" type="text" id="TMXHZZ_MCGS_2" class="form-control" style="width: 50px" value="${pd.TMXHZZ_MCGS}"/>
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
                                                            <td>外召与COP盲文按钮:</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="TMXHZZ_WZYCOPMWAN_TEXT" id="TMXHZZ_WZYCOPMWAN_TEXT" onclick="editTmxhzz('TMXHZZ_WZYCOPMWAN');" ${pd.TMXHZZ_WZYCOPMWAN=='1'?'checked':''}>
                                                                <input type="hidden" name="TMXHZZ_WZYCOPMWAN" id="TMXHZZ_WZYCOPMWAN">
                                                            </td>
                                                            <td><input type="text" name="TMXHZZ_WZYCOPMWAN_TEMP" id="TMXHZZ_WZYCOPMWAN_TEMP" class="form-control"></td>
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
                                            <input type="text" class="form-control" id="FEIYANGXF_AZF_TEMP" name="FEIYANGXF_AZF_TEMP" onkeyup="countZhj();" value="${pd.FEIYANGXF_AZF}">
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

    //计算基础价
    function setSbj(){
        var sd_ = $("#BZ_SD").val();  //速度
        var c_ = $("#BZ_C").val();     //层站
        var zz_ = $("#BZ_ZZ").val();  //载重
        var price = 0;
        if(sd_=="1.0"){
            if(zz_=="800"){
                if(c_=="3"){
                    price = 154460;
                }else if(c_=="4"){
                    price = 160390;
                }else if(c_=="5"){
                    price = 166330;
                }else if(c_=="6"){
                    price = 172260;
                }else if(c_=="7"){
                    price = 178200;
                }else if(c_=="8"){
                    price = 184130;
                }else if(c_=="9"){
                    price = 190070;
                }else if(c_=="10"){
                    price = 196000;
                }else if(c_=="11"){
                    price = 201940;
                }else if(c_=="12"){
                    price = 207870;
                }else if(c_=="13"){
                    price = 214810;
                }else if(c_=="14"){
                    price = 220740;
                }else if(c_=="15"){
                    price = 226680;
                }else if(c_=="16"){
                    price = 232610;
                }else if(c_=="17"){
                    price = 238550;
                }else if(c_=="18"){
                    price = 244490;
                }else if(c_=="19"){
                    price = 250420;
                }else if(c_=="20"){
                    price = 256360;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 162160;
                }else if(c_=="4"){
                    price = 168090;
                }else if(c_=="5"){
                    price = 174030;
                }else if(c_=="6"){
                    price = 179960;
                }else if(c_=="7"){
                    price = 185900;
                }else if(c_=="8"){
                    price = 191830;
                }else if(c_=="9"){
                    price = 197770;
                }else if(c_=="10"){
                    price = 203700;
                }else if(c_=="11"){
                    price = 209640;
                }else if(c_=="12"){
                    price = 215570;
                }else if(c_=="13"){
                    price = 221510;
                }else if(c_=="14"){
                    price = 227440;
                }else if(c_=="15"){
                    price = 233380;
                }else if(c_=="16"){
                    price = 240310;
                }else if(c_=="17"){
                    price = 246250;
                }else if(c_=="18"){
                    price = 252190;
                }else if(c_=="19"){
                    price = 258120;
                }else if(c_=="20"){
                    price = 264060;
                }
            }else if(zz_=="1150"){
                if(c_=="3"){
                    price = 186890;
                }else if(c_=="4"){
                    price = 192780;
                }else if(c_=="5"){
                    price = 198670;
                }else if(c_=="6"){
                    price = 204560;
                }else if(c_=="7"){
                    price = 210450;
                }else if(c_=="8"){
                    price = 216340;
                }else if(c_=="9"){
                    price = 222230;
                }else if(c_=="10"){
                    price = 228120;
                }else if(c_=="11"){
                    price = 234010;
                }else if(c_=="12"){
                    price = 239900;
                }else if(c_=="13"){
                    price = 245790;
                }else if(c_=="14"){
                    price = 251680;
                }else if(c_=="15"){
                    price = 257570;
                }else if(c_=="16"){
                    price = 263460;
                }else if(c_=="17"){
                    price = 269350;
                }else if(c_=="18"){
                    price = 275240;
                }else if(c_=="19"){
                    price = 281130;
                }else if(c_=="20"){
                    price = 287020;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 208350;
                }else if(c_=="4"){
                    price = 214230;
                }else if(c_=="5"){
                    price = 220120;
                }else if(c_=="6"){
                    price = 226000;
                }else if(c_=="7"){
                    price = 231880;
                }else if(c_=="8"){
                    price = 237760;
                }else if(c_=="9"){
                    price = 243640;
                }else if(c_=="10"){
                    price = 249520;
                }else if(c_=="11"){
                    price = 255400;
                }else if(c_=="12"){
                    price = 261280;
                }else if(c_=="13"){
                    price = 267160;
                }else if(c_=="14"){
                    price = 273040;
                }else if(c_=="15"){
                    price = 278920;
                }else if(c_=="16"){
                    price = 284800;
                }else if(c_=="17"){
                    price = 290690;
                }else if(c_=="18"){
                    price = 296570;
                }else if(c_=="19"){
                    price = 302450;
                }else if(c_=="20"){
                    price = 308330;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 211430;
                }else if(c_=="4"){
                    price = 217420;
                }else if(c_=="5"){
                    price = 223410;
                }else if(c_=="6"){
                    price = 229400;
                }else if(c_=="7"){
                    price = 235390;
                }else if(c_=="8"){
                    price = 241370;
                }else if(c_=="9"){
                    price = 247360;
                }else if(c_=="10"){
                    price = 253350;
                }else if(c_=="11"){
                    price = 259340;
                }else if(c_=="12"){
                    price = 265330;
                }else if(c_=="13"){
                    price = 271320;
                }else if(c_=="14"){
                    price = 277300;
                }else if(c_=="15"){
                    price = 283290;
                }else if(c_=="16"){
                    price = 289280;
                }else if(c_=="17"){
                    price = 295270;
                }else if(c_=="18"){
                    price = 301260;
                }else if(c_=="19"){
                    price = 307250;
                }else if(c_=="20"){
                    price = 313230;
                }
            }
        }else if(sd_=="1.5"){   //速度=1.5m/s
            if(zz_=="800"){
                if(c_=="3"){
                    price = 159520;
                }else if(c_=="4"){
                    price = 165450;
                }else if(c_=="5"){
                    price = 171390;
                }else if(c_=="6"){
                    price = 177320;
                }else if(c_=="7"){
                    price = 183260;
                }else if(c_=="8"){
                    price = 189190;
                }else if(c_=="9"){
                    price = 195120;
                }else if(c_=="10"){
                    price = 201060;
                }else if(c_=="11"){
                    price = 206990;
                }else if(c_=="12"){
                    price = 212930;
                }else if(c_=="13"){
                    price = 219860;
                }else if(c_=="14"){
                    price = 225790;
                }else if(c_=="15"){
                    price = 231730;
                }else if(c_=="16"){
                    price = 237670;
                }else if(c_=="17"){
                    price = 243600;
                }else if(c_=="18"){
                    price = 249530;
                }else if(c_=="19"){
                    price = 255470;
                }else if(c_=="20"){
                    price = 261400;
                }else if(c_=="21"){
                    price = 267340;
                }else if(c_=="22"){
                    price = 273270;
                }else if(c_=="23"){
                    price = 279200;
                }else if(c_=="24"){
                    price = 285140;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 167220;
                }else if(c_=="4"){
                    price = 173150;
                }else if(c_=="5"){
                    price = 179090;
                }else if(c_=="6"){
                    price = 185020;
                }else if(c_=="7"){
                    price = 190960;
                }else if(c_=="8"){
                    price = 196890;
                }else if(c_=="9"){
                    price = 202820;
                }else if(c_=="10"){
                    price = 208760;
                }else if(c_=="11"){
                    price = 214690;
                }else if(c_=="12"){
                    price = 220630;
                }else if(c_=="13"){
                    price = 226560;
                }else if(c_=="14"){
                    price = 232490;
                }else if(c_=="15"){
                    price = 238430;
                }else if(c_=="16"){
                    price = 245370;
                }else if(c_=="17"){
                    price = 251300;
                }else if(c_=="18"){
                    price = 257230;
                }else if(c_=="19"){
                    price = 263170;
                }else if(c_=="20"){
                    price = 269100;
                }else if(c_=="21"){
                    price = 275040;
                }else if(c_=="22"){
                    price = 280970;
                }else if(c_=="23"){
                    price = 286900;
                }else if(c_=="24"){
                    price = 292840;
                }
            }else if(zz_=="1150"){
                if(c_=="3"){
                    price = 188210;
                }else if(c_=="4"){
                    price = 194080;
                }else if(c_=="5"){
                    price = 199950;
                }else if(c_=="6"){
                    price = 205820;
                }else if(c_=="7"){
                    price = 211700;
                }else if(c_=="8"){
                    price = 217570;
                }else if(c_=="9"){
                    price = 223440;
                }else if(c_=="10"){
                    price = 229310;
                }else if(c_=="11"){
                    price = 235180;
                }else if(c_=="12"){
                    price = 241060;
                }else if(c_=="13"){
                    price = 246930;
                }else if(c_=="14"){
                    price = 252800;
                }else if(c_=="15"){
                    price = 258670;
                }else if(c_=="16"){
                    price = 264550;
                }else if(c_=="17"){
                    price = 270420;
                }else if(c_=="18"){
                    price = 276290;
                }else if(c_=="19"){
                    price = 282160;
                }else if(c_=="20"){
                    price = 288030;
                }else if(c_=="21"){
                    price = 293910;
                }else if(c_=="22"){
                    price = 299780;
                }else if(c_=="23"){
                    price = 305650;
                }else if(c_=="24"){
                    price = 311520;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 212070;
                }else if(c_=="4"){
                    price = 217890;
                }else if(c_=="5"){
                    price = 223720;
                }else if(c_=="6"){
                    price = 229540;
                }else if(c_=="7"){
                    price = 235360;
                }else if(c_=="8"){
                    price = 241190;
                }else if(c_=="9"){
                    price = 247010;
                }else if(c_=="10"){
                    price = 252830;
                }else if(c_=="11"){
                    price = 258660;
                }else if(c_=="12"){
                    price = 264480;
                }else if(c_=="13"){
                    price = 270310;
                }else if(c_=="14"){
                    price = 276130;
                }else if(c_=="15"){
                    price = 281950;
                }else if(c_=="16"){
                    price = 287780;
                }else if(c_=="17"){
                    price = 293600;
                }else if(c_=="18"){
                    price = 299430;
                }else if(c_=="19"){
                    price = 305250;
                }else if(c_=="20"){
                    price = 311070;
                }else if(c_=="21"){
                    price = 316900;
                }else if(c_=="22"){
                    price = 322720;
                }else if(c_=="23"){
                    price = 328550;
                }else if(c_=="24"){
                    price = 334370;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 219780;
                }else if(c_=="4"){
                    price = 225650;
                }else if(c_=="5"){
                    price = 231530;
                }else if(c_=="6"){
                    price = 237400;
                }else if(c_=="7"){
                    price = 243270;
                }else if(c_=="8"){
                    price = 249150;
                }else if(c_=="9"){
                    price = 255020;
                }else if(c_=="10"){
                    price = 260890;
                }else if(c_=="11"){
                    price = 266770;
                }else if(c_=="12"){
                    price = 272640;
                }else if(c_=="13"){
                    price = 278510;
                }else if(c_=="14"){
                    price = 284380;
                }else if(c_=="15"){
                    price = 290260;
                }else if(c_=="16"){
                    price = 296130;
                }else if(c_=="17"){
                    price = 302000;
                }else if(c_=="18"){
                    price = 307880;
                }else if(c_=="19"){
                    price = 313750;
                }else if(c_=="20"){
                    price = 319620;
                }else if(c_=="21"){
                    price = 325490;
                }else if(c_=="22"){
                    price = 331370;
                }else if(c_=="23"){
                    price = 337240;
                }else if(c_=="24"){
                    price = 343110;
                }
            }
        }else if(sd_=="1.75"){  //速度=1.75m/s
            if(zz_=="800"){
                if(c_=="4"){
                    price = 169490;
                }else if(c_=="5"){
                    price = 175430;
                }else if(c_=="6"){
                    price = 181360;
                }else if(c_=="7"){
                    price = 187300;
                }else if(c_=="8"){
                    price = 193240;
                }else if(c_=="9"){
                    price = 199180;
                }else if(c_=="10"){
                    price = 205120;
                }else if(c_=="11"){
                    price = 211060;
                }else if(c_=="12"){
                    price = 217000;
                }else if(c_=="13"){
                    price = 223940;
                }else if(c_=="14"){
                    price = 229880;
                }else if(c_=="15"){
                    price = 235820;
                }else if(c_=="16"){
                    price = 241750;
                }else if(c_=="17"){
                    price = 247690;
                }else if(c_=="18"){
                    price = 253630;
                }else if(c_=="19"){
                    price = 259570;
                }else if(c_=="20"){
                    price = 265510;
                }else if(c_=="21"){
                    price = 271450;
                }else if(c_=="22"){
                    price = 277390;
                }else if(c_=="23"){
                    price = 283330;
                }else if(c_=="24"){
                    price = 289270;
                }else if(c_=="25"){
                    price = 295200;
                }else if(c_=="26"){
                    price = 301140;
                }else if(c_=="27"){
                    price = 307080;
                }else if(c_=="28"){
                    price = 313020;
                }else if(c_=="29"){
                    price = 318960;
                }else if(c_=="30"){
                    price = 324900;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price = 177190;
                }else if(c_=="5"){
                    price = 183130;
                }else if(c_=="6"){
                    price = 189060;
                }else if(c_=="7"){
                    price = 195000;
                }else if(c_=="8"){
                    price = 200940;
                }else if(c_=="9"){
                    price = 206880;
                }else if(c_=="10"){
                    price = 212820;
                }else if(c_=="11"){
                    price = 218760;
                }else if(c_=="12"){
                    price = 224700;
                }else if(c_=="13"){
                    price = 230640;
                }else if(c_=="14"){
                    price = 236580;
                }else if(c_=="15"){
                    price = 242520;
                }else if(c_=="16"){
                    price = 249450;
                }else if(c_=="17"){
                    price = 255390;
                }else if(c_=="18"){
                    price = 261330;
                }else if(c_=="19"){
                    price = 267270;
                }else if(c_=="20"){
                    price = 273210;
                }else if(c_=="21"){
                    price = 279150;
                }else if(c_=="22"){
                    price = 285090;
                }else if(c_=="23"){
                    price = 291030;
                }else if(c_=="24"){
                    price = 296970;
                }else if(c_=="25"){
                    price = 302900;
                }else if(c_=="26"){
                    price = 308840;
                }else if(c_=="27"){
                    price = 314780;
                }else if(c_=="28"){
                    price = 320720;
                }else if(c_=="29"){
                    price = 326660;
                }else if(c_=="30"){
                    price = 332600;
                }
            }else if(zz_=="1150"){
                if(c_=="4"){
                    price = 194890;
                }else if(c_=="5"){
                    price = 200860;
                }else if(c_=="6"){
                    price = 206820;
                }else if(c_=="7"){
                    price = 212790;
                }else if(c_=="8"){
                    price = 218760;
                }else if(c_=="9"){
                    price = 224730;
                }else if(c_=="10"){
                    price = 230700;
                }else if(c_=="11"){
                    price = 236670;
                }else if(c_=="12"){
                    price = 242640;
                }else if(c_=="13"){
                    price = 248610;
                }else if(c_=="14"){
                    price = 254580;
                }else if(c_=="15"){
                    price = 260550;
                }else if(c_=="16"){
                    price = 266510;
                }else if(c_=="17"){
                    price = 272480;
                }else if(c_=="18"){
                    price = 278450;
                }else if(c_=="19"){
                    price = 284420;
                }else if(c_=="20"){
                    price = 290390;
                }else if(c_=="21"){
                    price = 296360;
                }else if(c_=="22"){
                    price = 302330;
                }else if(c_=="23"){
                    price = 308300;
                }else if(c_=="24"){
                    price = 314270;
                }else if(c_=="25"){
                    price = 320230;
                }else if(c_=="26"){
                    price = 326200;
                }else if(c_=="27"){
                    price = 332170;
                }else if(c_=="28"){
                    price = 338140;
                }else if(c_=="29"){
                    price = 344110;
                }else if(c_=="30"){
                    price = 350080;
                }
            }else if(zz_=="1350"){
                if(c_=="4"){
                    price = 224230;
                }else if(c_=="5"){
                    price = 230020;
                }else if(c_=="6"){
                    price = 235810;
                }else if(c_=="7"){
                    price = 241610;
                }else if(c_=="8"){
                    price = 247400;
                }else if(c_=="9"){
                    price = 253190;
                }else if(c_=="10"){
                    price = 258980;
                }else if(c_=="11"){
                    price = 264780;
                }else if(c_=="12"){
                    price = 270570;
                }else if(c_=="13"){
                    price = 276360;
                }else if(c_=="14"){
                    price = 282160;
                }else if(c_=="15"){
                    price = 287950;
                }else if(c_=="16"){
                    price = 293740;
                }else if(c_=="17"){
                    price = 299530;
                }else if(c_=="18"){
                    price = 305330;
                }else if(c_=="19"){
                    price = 311120;
                }else if(c_=="20"){
                    price = 316910;
                }else if(c_=="21"){
                    price = 322700;
                }else if(c_=="22"){
                    price = 328500;
                }else if(c_=="23"){
                    price = 334290;
                }else if(c_=="24"){
                    price = 340080;
                }else if(c_=="25"){
                    price = 345880;
                }else if(c_=="26"){
                    price = 351670;
                }else if(c_=="27"){
                    price = 357460;
                }else if(c_=="28"){
                    price = 363250;
                }else if(c_=="29"){
                    price = 369050;
                }else if(c_=="30"){
                    price = 374840;
                }
            }else if(zz_=="1600"){
                if(c_=="4"){
                    price = 229750;
                }else if(c_=="5"){
                    price = 235650;
                }else if(c_=="6"){
                    price = 241560;
                }else if(c_=="7"){
                    price = 247460;
                }else if(c_=="8"){
                    price = 253370;
                }else if(c_=="9"){
                    price = 259270;
                }else if(c_=="10"){
                    price = 265180;
                }else if(c_=="11"){
                    price = 271080;
                }else if(c_=="12"){
                    price = 276990;
                }else if(c_=="13"){
                    price = 282890;
                }else if(c_=="14"){
                    price = 288800;
                }else if(c_=="15"){
                    price = 294700;
                }else if(c_=="16"){
                    price = 300610;
                }else if(c_=="17"){
                    price = 306510;
                }else if(c_=="18"){
                    price = 312420;
                }else if(c_=="19"){
                    price = 318320;
                }else if(c_=="20"){
                    price = 324230;
                }else if(c_=="21"){
                    price = 330130;
                }else if(c_=="22"){
                    price = 336040;
                }else if(c_=="23"){
                    price = 341940;
                }else if(c_=="24"){
                    price = 347850;
                }else if(c_=="25"){
                    price = 353750;
                }else if(c_=="26"){
                    price = 359660;
                }else if(c_=="27"){
                    price = 365560;
                }else if(c_=="28"){
                    price = 371470;
                }else if(c_=="29"){
                    price = 377370;
                }else if(c_=="30"){
                    price = 383280;
                }
            }
        }else if(sd_=="2.0"){
            if(zz_=="800"){
                if(c_=="4"){
                    price =   190040;
                }else if(c_=="5"){
                    price =   196610;
                }else if(c_=="6"){
                    price =   203180;
                }else if(c_=="7"){
                    price =   209750;
                }else if(c_=="8"){
                    price =   216320;
                }else if(c_=="9"){
                    price =   222890;
                }else if(c_=="10"){
                    price =   229460;
                }else if(c_=="11"){
                    price =   236030;
                }else if(c_=="12"){
                    price =   242600;
                }else if(c_=="13"){
                    price =   249180;
                }else if(c_=="14"){
                    price =   255740;
                }else if(c_=="15"){
                    price =   262310;
                }else if(c_=="16"){
                    price =   268890;
                }else if(c_=="17"){
                    price =   275460;
                }else if(c_=="18"){
                    price =   282020;
                }else if(c_=="19"){
                    price =   288600;
                }else if(c_=="20"){
                    price =   295170;
                }else if(c_=="21"){
                    price =   301740;
                }else if(c_=="22"){
                    price =   308300;
                }else if(c_=="23"){
                    price =   314880;
                }else if(c_=="24"){
                    price =   321450;
                }else if(c_=="25"){
                    price =   328020;
                }else if(c_=="26"){
                    price =   334600;
                }else if(c_=="27"){
                    price =   341160;
                }else if(c_=="28"){
                    price =   347730;
                }else if(c_=="29"){
                    price =   354310;
                }else if(c_=="30"){
                    price =   360880;
                }else if(c_=="31"){
                    price =   367440;
                }else if(c_=="32"){
                    price =   374020;
                }else if(c_=="33"){
                    price =   380590;
                }else if(c_=="34"){
                    price =   387160;
                }else if(c_=="35"){
                    price =   393720;
                }else if(c_=="36"){
                    price =   400300;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price =    195740;
                }else if(c_=="5"){
                    price =    202280;
                }else if(c_=="6"){
                    price =    208810;
                }else if(c_=="7"){
                    price =    215350;
                }else if(c_=="8"){
                    price =    221890;
                }else if(c_=="9"){
                    price =    228430;
                }else if(c_=="10"){
                    price =    234960;
                }else if(c_=="11"){
                    price =    241500;
                }else if(c_=="12"){
                    price =    248040;
                }else if(c_=="13"){
                    price =    254590;
                }else if(c_=="14"){
                    price =    261110;
                }else if(c_=="15"){
                    price =    267650;
                }else if(c_=="16"){
                    price =    274200;
                }else if(c_=="17"){
                    price =    280740;
                }else if(c_=="18"){
                    price =    287270;
                }else if(c_=="19"){
                    price =    293810;
                }else if(c_=="20"){
                    price =    300350;
                }else if(c_=="21"){
                    price =    306890;
                }else if(c_=="22"){
                    price =    313420;
                }else if(c_=="23"){
                    price =    319960;
                }else if(c_=="24"){
                    price =    326500;
                }else if(c_=="25"){
                    price =    333040;
                }else if(c_=="26"){
                    price =    339590;
                }else if(c_=="27"){
                    price =    346110;
                }else if(c_=="28"){
                    price =    352650;
                }else if(c_=="29"){
                    price =    359200;
                }else if(c_=="30"){
                    price =    365740;
                }else if(c_=="31"){
                    price =    372260;
                }else if(c_=="32"){
                    price =    378810;
                }else if(c_=="33"){
                    price =    385350;
                }else if(c_=="34"){
                    price =    391890;
                }else if(c_=="35"){
                    price =    398410;
                }else if(c_=="36"){
                    price =    404960;
                }
            }else if(zz_=="1150"){
                if(c_=="4"){
                    price =   228950;
                }else if(c_=="5"){
                    price =   235370;
                }else if(c_=="6"){
                    price =   241800;
                }else if(c_=="7"){
                    price =   248220;
                }else if(c_=="8"){
                    price =   254640;
                }else if(c_=="9"){
                    price =   261060;
                }else if(c_=="10"){
                    price =   267490;
                }else if(c_=="11"){
                    price =   273910;
                }else if(c_=="12"){
                    price =   280330;
                }else if(c_=="13"){
                    price =   286760;
                }else if(c_=="14"){
                    price =   293180;
                }else if(c_=="15"){
                    price =   299600;
                }else if(c_=="16"){
                    price =   306030;
                }else if(c_=="17"){
                    price =   312450;
                }else if(c_=="18"){
                    price =   318870;
                }else if(c_=="19"){
                    price =   325300;
                }else if(c_=="20"){
                    price =   331720;
                }else if(c_=="21"){
                    price =   338140;
                }else if(c_=="22"){
                    price =   344560;
                }else if(c_=="23"){
                    price =   350990;
                }else if(c_=="24"){
                    price =   357410;
                }else if(c_=="25"){
                    price =   363830;
                }else if(c_=="26"){
                    price =   370260;
                }else if(c_=="27"){
                    price =   376680;
                }else if(c_=="28"){
                    price =   383100;
                }else if(c_=="29"){
                    price =   389530;
                }else if(c_=="30"){
                    price =   395950;
                }else if(c_=="31"){
                    price =   402370;
                }else if(c_=="32"){
                    price =   408800;
                }else if(c_=="33"){
                    price =   415220;
                }else if(c_=="34"){
                    price =   421640;
                }else if(c_=="35"){
                    price =   428060;
                }else if(c_=="36"){
                    price =   434490;
                }
            }else if(zz_=="1350"){
                if(c_=="4"){
                    price =   251280;
                }else if(c_=="5"){
                    price =   257870;
                }else if(c_=="6"){
                    price =   264470;
                }else if(c_=="7"){
                    price =   271060;
                }else if(c_=="8"){
                    price =   277650;
                }else if(c_=="9"){
                    price =   284240;
                }else if(c_=="10"){
                    price =   290830;
                }else if(c_=="11"){
                    price =   297420;
                }else if(c_=="12"){
                    price =   304010;
                }else if(c_=="13"){
                    price =   310610;
                }else if(c_=="14"){
                    price =   317200;
                }else if(c_=="15"){
                    price =   323790;
                }else if(c_=="16"){
                    price =   330380;
                }else if(c_=="17"){
                    price =   336970;
                }else if(c_=="18"){
                    price =   343560;
                }else if(c_=="19"){
                    price =   350160;
                }else if(c_=="20"){
                    price =   356750;
                }else if(c_=="21"){
                    price =   363340;
                }else if(c_=="22"){
                    price =   369930;
                }else if(c_=="23"){
                    price =   376520;
                }else if(c_=="24"){
                    price =   383110;
                }else if(c_=="25"){
                    price =   389700;
                }else if(c_=="26"){
                    price =   396300;
                }else if(c_=="27"){
                    price =   402890;
                }else if(c_=="28"){
                    price =   409480;
                }else if(c_=="29"){
                    price =   416070;
                }else if(c_=="30"){
                    price =   422660;
                }else if(c_=="31"){
                    price =   429250;
                }else if(c_=="32"){
                    price =   435840;
                }else if(c_=="33"){
                    price =   442440;
                }else if(c_=="34"){
                    price =   449030;
                }else if(c_=="35"){
                    price =   455620;
                }else if(c_=="36"){
                    price =   462210;
                }
            }else if(zz_=="1600"){
                if(c_=="4"){
                    price =   253510;
                }else if(c_=="5"){
                    price =   260170;
                }else if(c_=="6"){
                    price =   266840;
                }else if(c_=="7"){
                    price =   273510;
                }else if(c_=="8"){
                    price =   280170;
                }else if(c_=="9"){
                    price =   286840;
                }else if(c_=="10"){
                    price =   293500;
                }else if(c_=="11"){
                    price =   300170;
                }else if(c_=="12"){
                    price =   306830;
                }else if(c_=="13"){
                    price =   313500;
                }else if(c_=="14"){
                    price =   320160;
                }else if(c_=="15"){
                    price =   326830;
                }else if(c_=="16"){
                    price =   333490;
                }else if(c_=="17"){
                    price =   340160;
                }else if(c_=="18"){
                    price =   346820;
                }else if(c_=="19"){
                    price =   353490;
                }else if(c_=="20"){
                    price =   360150;
                }else if(c_=="21"){
                    price =   366820;
                }else if(c_=="22"){
                    price =   373490;
                }else if(c_=="23"){
                    price =   380150;
                }else if(c_=="24"){
                    price =   386820;
                }else if(c_=="25"){
                    price =   393480;
                }else if(c_=="26"){
                    price =   400150;
                }else if(c_=="27"){
                    price =   406810;
                }else if(c_=="28"){
                    price =   413480;
                }else if(c_=="29"){
                    price =   420140;
                }else if(c_=="30"){
                    price =   426810;
                }else if(c_=="31"){
                    price =   433470;
                }else if(c_=="32"){
                    price =   440140;
                }else if(c_=="33"){
                    price =   446800;
                }else if(c_=="34"){
                    price =   453470;
                }else if(c_=="35"){
                    price =   460130;
                }else if(c_=="36"){
                    price =   466800;
                }
            }
        }else if(sd_=="2.5"){
            if(zz_=="800"){
                if(c_=="5"){
                    price =    202280;
                }else if(c_=="6"){
                    price =    208860;
                }else if(c_=="7"){
                    price =    215440;
                }else if(c_=="8"){
                    price =    222020;
                }else if(c_=="9"){
                    price =    228600;
                }else if(c_=="10"){
                    price =    235170;
                }else if(c_=="11"){
                    price =    241740;
                }else if(c_=="12"){
                    price =    248330;
                }else if(c_=="13"){
                    price =    254900;
                }else if(c_=="14"){
                    price =    261470;
                }else if(c_=="15"){
                    price =    268060;
                }else if(c_=="16"){
                    price =    274630;
                }else if(c_=="17"){
                    price =    281210;
                }else if(c_=="18"){
                    price =    287790;
                }else if(c_=="19"){
                    price =    294360;
                }else if(c_=="20"){
                    price =    300940;
                }else if(c_=="21"){
                    price =    307520;
                }else if(c_=="22"){
                    price =    314100;
                }else if(c_=="23"){
                    price =    320660;
                }else if(c_=="24"){
                    price =    327250;
                }else if(c_=="25"){
                    price =    333820;
                }else if(c_=="26"){
                    price =    340400;
                }else if(c_=="27"){
                    price =    346980;
                }else if(c_=="28"){
                    price =    353550;
                }else if(c_=="29"){
                    price =    360130;
                }else if(c_=="30"){
                    price =    366710;
                }else if(c_=="31"){
                    price =    373290;
                }else if(c_=="32"){
                    price =    379860;
                }else if(c_=="33"){
                    price =    386440;
                }else if(c_=="34"){
                    price =    393020;
                }else if(c_=="35"){
                    price =    399590;
                }else if(c_=="36"){
                    price =    406170;
                }else if(c_=="37"){
                    price =    412750;
                }else if(c_=="38"){
                    price =    419320;
                }else if(c_=="39"){
                    price =    425910;
                }else if(c_=="40"){
                    price =    432480;
                }
            }else if(zz_=="1000"){
                if(c_=="5"){
                    price =     208700;
                }else if(c_=="6"){
                    price =     215340;
                }else if(c_=="7"){
                    price =     221990;
                }else if(c_=="8"){
                    price =     228630;
                }else if(c_=="9"){
                    price =     235270;
                }else if(c_=="10"){
                    price =     241900;
                }else if(c_=="11"){
                    price =     248540;
                }else if(c_=="12"){
                    price =     255190;
                }else if(c_=="13"){
                    price =     261820;
                }else if(c_=="14"){
                    price =     268460;
                }else if(c_=="15"){
                    price =     275100;
                }else if(c_=="16"){
                    price =     281740;
                }else if(c_=="17"){
                    price =     288390;
                }else if(c_=="18"){
                    price =     295020;
                }else if(c_=="19"){
                    price =     301660;
                }else if(c_=="20"){
                    price =     308300;
                }else if(c_=="21"){
                    price =     314940;
                }else if(c_=="22"){
                    price =     321580;
                }else if(c_=="23"){
                    price =     328210;
                }else if(c_=="24"){
                    price =     334860;
                }else if(c_=="25"){
                    price =     341490;
                }else if(c_=="26"){
                    price =     348140;
                }else if(c_=="27"){
                    price =     354770;
                }else if(c_=="28"){
                    price =     361410;
                }else if(c_=="29"){
                    price =     368060;
                }else if(c_=="30"){
                    price =     374690;
                }else if(c_=="31"){
                    price =     381340;
                }else if(c_=="32"){
                    price =     387970;
                }else if(c_=="33"){
                    price =     394610;
                }else if(c_=="34"){
                    price =     401260;
                }else if(c_=="35"){
                    price =     407890;
                }else if(c_=="36"){
                    price =     414530;
                }else if(c_=="37"){
                    price =     421170;
                }else if(c_=="38"){
                    price =     427810;
                }else if(c_=="39"){
                    price =     434460;
                }else if(c_=="40"){
                    price =     441090;
                }
            }else if(zz_=="1150"){
                if(c_=="5"){
                    price =     238170;
                }else if(c_=="6"){
                    price =     244650;
                }else if(c_=="7"){
                    price =     251140;
                }else if(c_=="8"){
                    price =     257630;
                }else if(c_=="9"){
                    price =     264110;
                }else if(c_=="10"){
                    price =     270600;
                }else if(c_=="11"){
                    price =     277080;
                }else if(c_=="12"){
                    price =     283570;
                }else if(c_=="13"){
                    price =     290050;
                }else if(c_=="14"){
                    price =     296540;
                }else if(c_=="15"){
                    price =     303030;
                }else if(c_=="16"){
                    price =     309510;
                }else if(c_=="17"){
                    price =     316000;
                }else if(c_=="18"){
                    price =     322480;
                }else if(c_=="19"){
                    price =     328970;
                }else if(c_=="20"){
                    price =     335460;
                }else if(c_=="21"){
                    price =     341940;
                }else if(c_=="22"){
                    price =     348430;
                }else if(c_=="23"){
                    price =     354910;
                }else if(c_=="24"){
                    price =     361400;
                }else if(c_=="25"){
                    price =     367880;
                }else if(c_=="26"){
                    price =     374370;
                }else if(c_=="27"){
                    price =     380860;
                }else if(c_=="28"){
                    price =     387340;
                }else if(c_=="29"){
                    price =     393830;
                }else if(c_=="30"){
                    price =     400310;
                }else if(c_=="31"){
                    price =     406800;
                }else if(c_=="32"){
                    price =     413290;
                }else if(c_=="33"){
                    price =     419770;
                }else if(c_=="34"){
                    price =     426260;
                }else if(c_=="35"){
                    price =     432740;
                }else if(c_=="36"){
                    price =     439230;
                }else if(c_=="37"){
                    price =     445720;
                }else if(c_=="38"){
                    price =     452200;
                }else if(c_=="39"){
                    price =     458690;
                }else if(c_=="40"){
                    price =     465170;
                }
            }else if(zz_=="1350"){
                if(c_=="5"){
                    price =     263530;
                }else if(c_=="6"){
                    price =     270120;
                }else if(c_=="7"){
                    price =     276720;
                }else if(c_=="8"){
                    price =     283310;
                }else if(c_=="9"){
                    price =     289900;
                }else if(c_=="10"){
                    price =     296490;
                }else if(c_=="11"){
                    price =     303080;
                }else if(c_=="12"){
                    price =     309670;
                }else if(c_=="13"){
                    price =     316270;
                }else if(c_=="14"){
                    price =     322860;
                }else if(c_=="15"){
                    price =     329450;
                }else if(c_=="16"){
                    price =     336040;
                }else if(c_=="17"){
                    price =     342630;
                }else if(c_=="18"){
                    price =     349220;
                }else if(c_=="19"){
                    price =     355810;
                }else if(c_=="20"){
                    price =     362410;
                }else if(c_=="21"){
                    price =     369000;
                }else if(c_=="22"){
                    price =     375590;
                }else if(c_=="23"){
                    price =     382180;
                }else if(c_=="24"){
                    price =     388770;
                }else if(c_=="25"){
                    price =     395360;
                }else if(c_=="26"){
                    price =     401950;
                }else if(c_=="27"){
                    price =     408550;
                }else if(c_=="28"){
                    price =     415140;
                }else if(c_=="29"){
                    price =     421730;
                }else if(c_=="30"){
                    price =     428320;
                }else if(c_=="31"){
                    price =     434910;
                }else if(c_=="32"){
                    price =     441500;
                }else if(c_=="33"){
                    price =     448090;
                }else if(c_=="34"){
                    price =     454690;
                }else if(c_=="35"){
                    price =     461280;
                }else if(c_=="36"){
                    price =     467870;
                }else if(c_=="37"){
                    price =     474460;
                }else if(c_=="38"){
                    price =     481050;
                }else if(c_=="39"){
                    price =     487640;
                }else if(c_=="40"){
                    price =     494240;
                }
            }else if(zz_=="1600"){
                if(c_=="5"){
                    price =     267260;
                }else if(c_=="6"){
                    price =     273850;
                }else if(c_=="7"){
                    price =     280450;
                }else if(c_=="8"){
                    price =     287040;
                }else if(c_=="9"){
                    price =     293630;
                }else if(c_=="10"){
                    price =     300220;
                }else if(c_=="11"){
                    price =     306810;
                }else if(c_=="12"){
                    price =     313400;
                }else if(c_=="13"){
                    price =     320000;
                }else if(c_=="14"){
                    price =     326590;
                }else if(c_=="15"){
                    price =     333180;
                }else if(c_=="16"){
                    price =     339770;
                }else if(c_=="17"){
                    price =     346360;
                }else if(c_=="18"){
                    price =     352950;
                }else if(c_=="19"){
                    price =     359540;
                }else if(c_=="20"){
                    price =     366140;
                }else if(c_=="21"){
                    price =     372730;
                }else if(c_=="22"){
                    price =     379320;
                }else if(c_=="23"){
                    price =     385910;
                }else if(c_=="24"){
                    price =     392500;
                }else if(c_=="25"){
                    price =     399090;
                }else if(c_=="26"){
                    price =     405680;
                }else if(c_=="27"){
                    price =     412280;
                }else if(c_=="28"){
                    price =     418870;
                }else if(c_=="29"){
                    price =     425460;
                }else if(c_=="30"){
                    price =     432050;
                }else if(c_=="31"){
                    price =     438640;
                }else if(c_=="32"){
                    price =     445230;
                }else if(c_=="33"){
                    price =     451830;
                }else if(c_=="34"){
                    price =     458420;
                }else if(c_=="35"){
                    price =     465010;
                }else if(c_=="36"){
                    price =     471600;
                }else if(c_=="37"){
                    price =     478190;
                }else if(c_=="38"){
                    price =     484780;
                }else if(c_=="39"){
                    price =     491370;
                }else if(c_=="40"){
                    price =     497970;
                }
            }
        }
        $("#SBJ_TEMP").val(price);
        countZhj();
    }

    function cbjPrice(){
        //井道总高
        setJdzg();
        //导轨支架
        setDgzj();
        //可选项
        editOpt('OPT_HJZDFHJZ');
        editOpt('OPT_JXDZZ');
        editOpt('OPT_CCTVDL');
        editOpt('OPT_TDJJJY');
        editOpt('OPT_DJGRBH');
        editOpt('OPT_KQJHZZ');
        editOpt('OPT_NMYKJAN');
        editOpt('OPT_ZPC');
        editOpt('OPT_BAJK');
        editOpt('OPT_YYBZ');
        editOpt('OPT_DZYX');
        editOpt('OPT_NLHK');
        editOpt('OPT_YCJK');
        editOpt('OPT_ICK');
        editOpt('OPT_ICKZKSB');
        editOpt('OPT_ICKKP');
        editOpt('OPT_PTDTKT');
        editOpt('OPT_ZYFTSDTKT');
        editOpt('OPT_JKGM');
        editOpt('OPT_JKYYJ');
        editOpt('OPT_GTMJXJMBF');
        editOpt('OPT_GTMTMBF');
        editOpt('OPT_CMZH');
        //轿厢装潢
        editJxzh('JXZH_JM');
        editJxzh('JXZH_JMZH');
        editJxzh('JXZH_JXZH');
        editJxzh('JXZH_QWB');
        editJxzh('JXZH_CWB');
        editJxzh('JXZH_HWB');
        editJxzh('JXZH_ZSDD');
        editJxzh('JXZH_BGJ');
        editJxzh('JXZH_DBXH');
        editJxzh('JXZH_YLZHZL');
        editJxzh('JXZH_FSXH');
        editJxzh('JXZH_FSAZWZ');
        //厅门门套
        editTmmt('TMMT_JZBXGXMT');
        editTmmt('TMMT_PTDMT');
        editTmmt('TMMT_PTJMBXGTM');
        editTmmt('TMMT_SCTMMT');
        editTmmt('TMMT_FSCTMMT');
        //厅门信号装置
        editTmxhzz('TMXHZZ_CZ');
        editTmxhzz('TMXHZZ_WZYCOPMWAN');
    }


    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#FEIYANGXF_SL").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=feiyangxf&FEIYANGXF_SL="+sl_,
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
        var sl_ = $("#FEIYANGXF_SL").val();
        var zk_ = $("#FEIYANGXF_ZK").val();
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selZhj.do?models=feiyangxf&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYANGXF_SL="+sl_+"&FEIYANGXF_ZK="+zk_,
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


    //修改载重时
    function editZz(){
        var zz_ = $("#BZ_ZZ").val();
        var kmkd_ = $("#BZ_KMKD").val();

        if(zz_=="800"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='800W-1350×1400'>800W-1350×1400</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='800'>800</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='800mm×2100mm(800kg)'>800mm×2100mm(800kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");

        }else if(zz_=="1000"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1000W-1600×1400'>1000W-1600×1400</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='900'>900</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='900mm×2100mm(1000kg)'>900mm×2100mm(1000kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");
        }else if(zz_=="1150"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1150W-2000×1350'>1150W-2000×1350</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1100'>1100</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='1100mm×2100mm(1150kg-1600kg)'>1100mm×2100mm(1150kg-1600kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2500']").prop("checked", "checked");
        }else if(zz_=="1350"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1350W-2000×1500'>1350W-2000×1500</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1100'>1100</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='1100mm×2100mm(1150kg-1600kg)'>1100mm×2100mm(1150kg-1600kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2500']").prop("checked", "checked");
        }else if(zz_=="1600"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1600W-2000×1700'>1600W-2000×1700</option><option value='1000D-1100×2100担架梯'>1000D-1100×2100担架梯</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1100'>1100</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='1100mm×2100mm(1150kg-1600kg)'>1100mm×2100mm(1150kg-1600kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2500']").prop("checked", "checked");
        }
    }

    //修改速度时
    function editSd(){
        var sd_ = $("#BZ_SD").val();
        if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="1.5"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option>";
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
        }else if(sd_=="2.5"){
            var appendStr = "<option value=''>请选择</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option><option value='32'>32</option><option value='33'>33</option><option value='34'>34</option><option value='35'>35</option><option value='36'>36</option><option value='37'>37</option><option value='38'>38</option><option value='39'>39</option><option value='40'>40</option>";
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
        var price = parseInt($("#FEIYANGXF_SBJ").val());
        var kmkd_ = parseInt($("#BZ_KMKD").val());
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(price)){
            var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="800"){
                    price = price-2100*jm;
                }else if(kmkd_=="900"){
                    price = price-2400*jm;
                }else if(kmkd_=="1100"){
                    price = price-2800*jm;
                }else if(kmkd_=="1200"){
                    price = price-3000*jm;
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
        var opt_hjzdfhjz_temp = $("#OPT_HJZDFHJZ_TEMP").val()==""?0:parseInt($("#OPT_HJZDFHJZ_TEMP").val());
        var opt_jxdzz_temp = $("#OPT_JXDZZ_TEMP").val()==""?0:parseInt($("#OPT_JXDZZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt($("#OPT_CCTVDL_TEMP").val());
        var opt_tdjjjy_temp = $("#OPT_TDJJJY_TEMP").val()==""?0:parseInt($("#OPT_TDJJJY_TEMP").val());
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt($("#OPT_DJGRBH_TEMP").val());
        var opt_kqjhzz_temp = $("#OPT_KQJHZZ_TEMP").val()==""?0:parseInt($("#OPT_KQJHZZ_TEMP").val());
        var opt_nmykjan_temp = $("#OPT_NMYKJAN_TEMP").val()==""?0:parseInt($("#OPT_NMYKJAN_TEMP").val());
        var opt_zpc_temp = $("#OPT_ZPC_TEMP").val()==""?0:parseInt($("#OPT_ZPC_TEMP").val());
        var opt_bajk_temp = $("#OPT_BAJK_TEMP").val()==""?0:parseInt($("#OPT_BAJK_TEMP").val());
        var opt_yybz_temp = $("#OPT_YYBZ_TEMP").val()==""?0:parseInt($("#OPT_YYBZ_TEMP").val());
        var opt_dzyx_temp = $("#OPT_DZYX_TEMP").val()==""?0:parseInt($("#OPT_DZYX_TEMP").val());
        var opt_nlhk_temp = $("#OPT_NLHK_TEMP").val()==""?0:parseInt($("#OPT_NLHK_TEMP").val());
        var opt_ycjk_temp = $("#OPT_YCJK_TEMP").val()==""?0:parseInt($("#OPT_YCJK_TEMP").val());
        var opt_ick_temp = $("#OPT_ICK_TEMP").val()==""?0:parseInt($("#OPT_ICK_TEMP").val());
        var opt_ickzksb_temp = $("#OPT_ICKZKSB_TEMP").val()==""?0:parseInt($("#OPT_ICKZKSB_TEMP").val());
        var opt_ickkp_temp = $("#OPT_ICKKP_TEMP").val()==""?0:parseInt($("#OPT_ICKKP_TEMP").val());
        var opt_ptdtkt_temp = $("#OPT_PTDTKT_TEMP").val()==""?0:parseInt($("#OPT_PTDTKT_TEMP").val());
        var opt_zyftsdtkt_temp = $("#OPT_ZYFTSDTKT_TEMP").val()==""?0:parseInt($("#OPT_ZYFTSDTKT_TEMP").val());
        var opt_jkgm_temp = $("#OPT_JKGM_TEMP").val()==""?0:parseInt($("#OPT_JKGM_TEMP").val());
        var opt_jkyyj_temp = $("#OPT_JKYYJ_TEMP").val()==""?0:parseInt($("#OPT_JKYYJ_TEMP").val());
        var opt_gtmjxjmbf_temp = $("#OPT_GTMJXJMBF_TEMP").val()==""?0:parseInt($("#OPT_GTMJXJMBF_TEMP").val());
        var opt_gtmtmbf = $("#OPT_GTMTMBF_TEMP").val()==""?0:parseInt($("#OPT_GTMTMBF_TEMP").val());
        var opt_cmzh_temp = $("#OPT_CMZH_TEMP").val()==""?0:parseInt($("#OPT_CMZH_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt($("#JXZH_JM_TEMP").val());
        var jxzh_jmzh_temp = $("#JXZH_JMZH_TEMP").val()==""?0:parseInt($("#JXZH_JMZH_TEMP").val());
        var jxzh_jxzh_temp = $("#JXZH_JXZH_TEMP").val()==""?0:parseInt($("#JXZH_JXZH_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt($("#JXZH_QWB_TEMP").val());
        var jxzh_cwb_temp = $("#JXZH_CWB_TEMP").val()==""?0:parseInt($("#JXZH_CWB_TEMP").val());
        var jxzh_hwb_temp = $("#JXZH_HWB_TEMP").val()==""?0:parseInt($("#JXZH_HWB_TEMP").val());
        var jxzh_zsdd_temp = $("#JXZH_ZSDD_TEMP").val()==""?0:parseInt($("#JXZH_ZSDD_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt($("#JXZH_BGJ_TEMP").val());
        var jxzh_dbxh_temp = $("#JXZH_DBXH_TEMP").val()==""?0:parseInt($("#JXZH_DBXH_TEMP").val());
        var jxzh_ylzhzl_temp = $("#JXZH_YLZHZL_TEMP").val()==""?0:parseInt($("#JXZH_YLZHZL_TEMP").val());
        var jxzh_fsxh_temp = $("#JXZH_FSXH_TEMP").val()==""?0:parseInt($("#JXZH_FSXH_TEMP").val());
        var jxzh_fsazwz_temp = $("#JXZH_FSAZWZ_TEMP").val()==""?0:parseInt($("#JXZH_FSAZWZ_TEMP").val());
        var tmmt_jzbxgxmt_temp = $("#TMMT_JZBXGXMT_TEMP").val()==""?0:parseInt($("#TMMT_JZBXGXMT_TEMP").val());
        var tmmt_ptdmt_temp = $("#TMMT_PTDMT_TEMP").val()==""?0:parseInt($("#TMMT_PTDMT_TEMP").val());
        var tmmt_ptjmbxgtm_temp = $("#TMMT_PTJMBXGTM_TEMP").val()==""?0:parseInt($("#TMMT_PTJMBXGTM_TEMP").val());
        var tmmt_sctmmt_temp = $("#TMMT_SCTMMT_TEMP").val()==""?0:parseInt($("#TMMT_SCTMMT_TEMP").val());
        var tmmt_fsctmmt_temp = $("#TMMT_FSCTMMT_TEMP").val()==""?0:parseInt($("#TMMT_FSCTMMT_TEMP").val());
        var czp_czpxh_temp = $("#CZP_CZPXH_TEMP").val()==""?0:parseInt($("#CZP_CZPXH_TEMP").val());
        var tmxhzz_cz_temp = $("#TMXHZZ_CZ_TEMP").val()==""?0:parseInt($("#TMXHZZ_CZ_TEMP").val());
        var tmxhzz_wzycopmwan_temp = $("#TMXHZZ_WZYCOPMWAN_TEMP").val()==""?0:parseInt($("#TMXHZZ_WZYCOPMWAN_TEMP").val());

        zhj_count = jxzh_jm_temp+jxzh_jmzh_temp+jxzh_jxzh_temp+jxzh_qwb_temp+jxzh_cwb_temp+jxzh_hwb_temp+jxzh_zsdd_temp+jxzh_bgj_temp+jxzh_dbxh_temp+jxzh_ylzhzl_temp+jxzh_fsxh_temp+jxzh_fsazwz_temp;
        $("#FEIYANGXF_ZHJ").val(zhj_count);

        count = base_jdzg_temp+base_dgzj_temp+opt_hjzdfhjz_temp+opt_jxdzz_temp+opt_cctvdl_temp+opt_tdjjjy_temp+opt_djgrbh_temp+opt_kqjhzz_temp+opt_nmykjan_temp+opt_zpc_temp+opt_bajk_temp+opt_yybz_temp+opt_dzyx_temp+opt_nlhk_temp+opt_ycjk_temp+opt_ick_temp+opt_ickzksb_temp+opt_ickkp_temp+opt_ptdtkt_temp+opt_zyftsdtkt_temp+opt_jkgm_temp+opt_jkyyj_temp+opt_gtmjxjmbf_temp+opt_gtmtmbf+opt_cmzh_temp+tmmt_jzbxgxmt_temp+tmmt_ptdmt_temp+tmmt_ptjmbxgtm_temp+tmmt_sctmmt_temp+tmmt_fsctmmt_temp+czp_czpxh_temp+tmxhzz_cz_temp+tmxhzz_wzycopmwan_temp;
        //设备标准价格
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#FEIYANGXF_SBJ").val(sbj_temp+sbj_count);

        //运输费
        var feiyangxf_ysf = $("#FEIYANGXF_YSF").val()==""?0:parseInt($("#FEIYANGXF_YSF").val());
        $("#FEIYANGXF_YSF").val(feiyangxf_ysf);
        //安装费
        var feiyangxf_azf = $("#FEIYANGXF_AZF_TEMP").val()==""?0:parseInt($("#FEIYANGXF_AZF_TEMP").val());
        $("#FEIYANGXF_AZF").val(feiyangxf_azf);

        var feiyangxf_zk = parseFloat($("#FEIYANGXF_ZK").val())/100;
        if(!isNaN(feiyangxf_zk)){
            var feiyangxf_sbj = parseInt($("#SBJ_TEMP").val());
            var feiyangxf_sjbj = (feiyangxf_sbj+zhj_count+sbj_count+feiyangxf_azf+feiyangxf_ysf)*feiyangxf_zk;
            var feiyangxf_zhsbj = feiyangxf_sbj*feiyangxf_zk;
            $("#FEIYANGXF_SJBJ").val(feiyangxf_sjbj);
            $("#FEIYANGXF_ZHSBJ").val(feiyangxf_zhsbj);
            $("#zk_").text($("#FEIYANGXF_ZK").val()+"%");
        }
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
            var sd_ = $("#BZ_SD").val();    //速度
            var jxgd_ = $("#BASE_JXGD").val();  //轿厢高度
            var c_ = parseInt($("#BZ_C").val())   //层数
            var K = 0;
            var S = 0;
            if(zz_=="800"||zz_=="1000"){
                if(sd_=="1"){
                    K = 3950;
                    S = 1200;
                }else if(sd_=="1.5"){
                    K = 4150;
                    S = 1300;
                }else if(sd_=="1.75"){
                    K = 4200;
                    S = 1350;
                }else if(sd_=="2.0"){
                    K = 4500;
                    S = 1600;
                }else if(sd_=="2.5"){
                    K = 4750;
                    S = 1850;
                }
            }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                if(sd_=="1"){
                    K = 4300;
                    S = 1400;
                }else if(sd_=="1.5"){
                    K = 4450;
                    S = 1550;
                }else if(sd_=="1.75"){
                    K = 4500;
                    S = 1600;
                }else if(sd_=="2.0"){
                    K = 4600;
                    S = 1650;
                }else if(sd_=="2.5"){
                    K = 4850;
                    S = 1850;
                }
            }
            var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            if(sd_=="1.0"||sd_=="1.5"||sd_=="1.75"){
                if(zz_=="800"||zz_=="1000"){
                    price = 1100*((jdzg_-jdzg_std)/100);
                }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                    price = 1300*((jdzg_-jdzg_std)/100);
                }
            }else if(sd_=="2.0"||sd_=="2.5"){
                if(zz_=="800"||zz_=="1000"){
                    price = 1300*((jdzg_-jdzg_std)/100);
                }else if(zz_=="1150"){
                    price = 1500*((jdzg_-jdzg_std)/100);
                }else if(zz_=="1350"||zz_=="1600"){
                    price = 1600*((jdzg_-jdzg_std)/100);
                }
            }

            //计算标准导轨支架数量
            var dgzj_std = 0;
            if(zz_=="800"||zz_=="1000"){
                dgzj_std = Math.ceil((jdzg_std/2500)+1);
            }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
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
            if(zz_=="800"||zz_=="1000"){
                if(sd_=="1"){
                    K = 3950;
                    S = 1200;
                }else if(sd_=="1.5"){
                    K = 4150;
                    S = 1300;
                }else if(sd_=="1.75"){
                    K = 4200;
                    S = 1350;
                }else if(sd_=="2.0"){
                    K = 4500;
                    S = 1600;
                }else if(sd_=="2.5"){
                    K = 4750;
                    S = 1850;
                }
            }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                if(sd_=="1"){
                    K = 4300;
                    S = 1400;
                }else if(sd_=="1.5"){
                    K = 4450;
                    S = 1550;
                }else if(sd_=="1.75"){
                    K = 4500;
                    S = 1600;
                }else if(sd_=="2.0"){
                    K = 4600;
                    S = 1650;
                }else if(sd_=="2.5"){
                    K = 4850;
                    S = 1850;
                }
            }
            jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            if(zz_=="800"||zz_=="1000"){
                dgzj_std = (jdzg_std/2500)+1;
                price = (dgzj_-dgzj_std)*310;
            }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
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
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt($("#FEIYANGXF_SL").val());
        //价格
        var price = 0;
        if(option=="OPT_HJZDFHJZ"){
            //火警自动返回基站
            if($("#OPT_HJZDFHJZ_TEXT").is(":checked")){
                price = 160*sl_;
            }else{
                price = 0;
            }
            $("#OPT_HJZDFHJZ_TEMP").val(price);
        }else if(option=="OPT_JXDZZ"){
            //轿厢到站钟
            if($("#OPT_JXDZZ_TEXT").is(":checked")){
                price = 200*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JXDZZ_TEMP").val(price);
        }else if(option=="OPT_CCTVDL"){
            //CCTV电缆
            var tsgd_ = parseInt($("#BASE_TSGD").val());
            if($("#OPT_CCTVDL_TEXT").is(":checked")){
                price = 17*(tsgd_+15)*sl_;
            }else{
                price = 0;
            }
            $("#OPT_CCTVDL_TEMP").val(price);
        }else if(option=="OPT_TDJJJY"){
            //停电紧急救援
            if($("#OPT_TDJJJY_TEXT").is(":checked")){
                price = 7300*sl_;
            }else{
                price = 0;
            }
            $("#OPT_TDJJJY_TEMP").val(price);
        }else if(option=="OPT_DJGRBH"){
            //电机过热保护
            if($("#OPT_DJGRBH_TEXT").is(":checked")){
                price = 650*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DJGRBH_TEMP").val(price);
        }else if(option=="OPT_KQJHZZ"){
            //空气净化装置
            if($("#OPT_KQJHZZ_TEXT").is(":checked")){
                price = 2400*sl_;
            }else{
                price = 0;
            }
            $("#OPT_KQJHZZ_TEMP").val(price);
        }else if(option=="OPT_NMYKJAN"){
            //纳米银抗菌按钮
            if($("#OPT_NMYKJAN").val()!=""&&!isNaN($("#OPT_NMYKJAN").val())){
                price = 84*parseInt($("#OPT_NMYKJAN").val());
            }else{
                price = 0;
            }
            $("#OPT_NMYKJAN_TEMP").val(price);
        }else if(option=="OPT_ZPC"){
            //再平层
            if($("#OPT_ZPC_TEXT").is(":checked")){
                price = 1600*sl_;
            }else{
                price = 0;
            }
            $("#OPT_ZPC_TEMP").val(price);
        }else if(option=="OPT_BAJK"){
            //BA接口
            if($("#OPT_BAJK_TEXT").is(":checked")){
                price = 650*sl_;
            }else{
                price = 0;
            }
            $("#OPT_BAJK_TEMP").val(price);
        }else if(option=="OPT_YYBZ"){
            //语音报站
            if($("#OPT_YYBZ_TEXT").is(":checked")){
                price = 1300*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YYBZ_TEMP").val(price);
        }else if(option=="OPT_DZYX"){
            //地震运行
            if($("#OPT_DZYX_TEXT").is(":checked")){
                price = 4320*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DZYX_TEMP").val(price);
        }else if(option=="OPT_NLHK"){
            //能量回馈
            if($("#OPT_NLHK_TEXT").is(":checked")){
                price = 11520*sl_;
            }else{
                price = 0;
            }
            $("#OPT_NLHK_TEMP").val(price);
        }else if(option=="OPT_YCJK"){
            //远程监控(物联网系统)
            if($("#OPT_YCJK_TEXT").is(":checked")){
                price = 6010*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YCJK_TEMP").val(price);
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
        }else if(option=="OPT_PTDTKT"){
            //普通电梯空调
            if($("#OPT_PTDTKT").val()=="单冷型2200W"){
                price = 12000;
            }else if($("#OPT_PTDTKT").val()=="冷暖型1500W"){
                price = 13200;
            }else{
                price = 0;
            }
            $("#OPT_PTDTKT_TEMP").val(price);
        }else if(option=="OPT_ZYFTSDTKT"){
            //专用分体式电梯空调
            if($("#OPT_ZYFTSDTKT").val()=="单冷型2200W"){
                price = 15120;
            }else{
                price = 0;
            }
            $("#OPT_ZYFTSDTKT_TEMP").val(price);
        }else if(option=="OPT_JKGM"){
            //进口光幕
            if($("#OPT_JKGM_TEXT").is(":checked")){
                price = 960*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JKGM_TEMP").val(price);
        }else if(option=="OPT_JKYYJ"){
            //进口曳引机
            if($("#OPT_JKYYJ_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();
                if(zz_=="800"||zz_=="1000"||zz_=="1150"){
                    price = 12000*sl_;
                }else if(zz_=="1350"||zz_=="1600"){
                    price = 14400*sl_
                }else{
                    price = 0;
                }
            }else{
                price = 0;
            }
            $("#OPT_JKYYJ_TEMP").val(price);
        }else if(option=="OPT_GTMJXJMBF"){
            //贯通门(轿厢轿门部分)
            if($("#OPT_GTMJXJMBF_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();
                if(zz_=="800"){
                    price = 13000*sl_;
                }else if(zz_=="1000"){
                    price = 13900*sl_;
                }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                    price = 14700*sl_
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
            if($("#OPT_GTMTMBF_TEXT").val()=="发纹不锈钢"){
                if(zz_=="800"){
                    price = 3250*sl_;
                }else if(zz_=="1000"){
                    price = 3800*sl_;
                }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                    price = 4500*sl_
                }else{
                    price = 0;
                }    
            }else if($("#OPT_GTMTMBF_TEXT").val()=="喷涂"){
                if(zz_=="800"){
                    price = 2100*sl_;
                }else if(zz_=="1000"){
                    price = 2400*sl_;
                }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                    price = 2770*sl_
                }else{
                    price = 0;
                }    
            }else{
                price = 0;
            }
            $("#OPT_GTMTMBF_TEMP").val(price);
        }else if(option=="OPT_CMZH"){
            //层门装潢
            if($("#OPT_CMZH_TEXT").val()=="JF-K-C01"){
                price = 0;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C02"){
                price = 3400*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C03"){
                price = 3400*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C04"){
                price = 4100*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C05"){
                price = 3900*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C06"){
                price = 3900*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C07"){
                price = 3900*sl_;
            }else{
                price = 0;
            }
            $("#OPT_CMZH_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }


    //单组监控室对讲系统-加价
    /*function editDzjksdjxt(){
        var sl_ = parseInt($("#FEIYANGXF_SL").val());
        var price = 0;
        if(sl_<10){
            var djts_ = parseInt($("#DZJKSDJXT_DJTS").val());
            if($("#DZJKSDJXT_DJTXFS").val()=="分线制"){
                price = 2330*djts_+3570;
            }else if($("#DZJKSDJXT_DJTXFS").val()=="总线制"){
                price = 720*djts_+4080;
            }
        }
        $("#DZJKSDJXT_DJTS_TEMP").val(price);
        //放入价格
        countZhj();
    }*/


    //轿厢装潢部分-加价
    function editJxzh(option){
        //数量
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt($("#FEIYANGXF_SL").val());
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
                if(zz_=="800"){
                    price = -5400*sl_;
                }else if(zz_=="1000"){
                    price = -5700*sl_;
                }else if(zz_=="1150"){
                    price = -6500*sl_;
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
                }
            }else if(qwb_=="SUS304发纹不锈钢"){
                price = 0;
            }else if(qwb_=="镜面不锈钢"){
                if(zz_=="800"){
                    price = 5700*sl_;
                }else if(zz_=="1000"){
                    price = 5700*sl_;
                }else if(zz_=="1150"){
                    price = 8200*sl_;
                }else if(zz_=="1350"){
                    price = 8200*sl_;
                }else if(zz_=="1600"){
                    price = 8200*sl_;
                }
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_CWB"){
            //侧围壁
            var cwb_ = $("input[name='JXZH_CWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(cwb_=="喷涂"){
                if(zz_=="800"){
                    price = -5400*sl_;
                }else if(zz_=="1000"){
                    price = -5700*sl_;
                }else if(zz_=="1150"){
                    price = -6500*sl_;
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
                }
            }else if(cwb_=="SUS304发纹不锈钢"){
                price = 0;
            }else if(cwb_=="镜面不锈钢"){
                if(zz_=="800"){
                    price = 5700*sl_;
                }else if(zz_=="1000"){
                    price = 5700*sl_;
                }else if(zz_=="1150"){
                    price = 8200*sl_;
                }else if(zz_=="1350"){
                    price = 8200*sl_;
                }else if(zz_=="1600"){
                    price = 8200*sl_;
                }
            }
            $("#JXZH_CWB_TEMP").val(price);
        }else if(option=="JXZH_HWB"){
            //后围壁
            var hwb_ = $("input[name='JXZH_HWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(hwb_=="喷涂"){
                if(zz_=="800"){
                    price = -5400*sl_;
                }else if(zz_=="1000"){
                    price = -5700*sl_;
                }else if(zz_=="1150"){
                    price = -6500*sl_;
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
                }
            }else if(hwb_=="SUS304发纹不锈钢"){
                price = 0;
            }else if(hwb_=="镜面不锈钢"){
                if(zz_=="800"){
                    price = 5700*sl_;
                }else if(zz_=="1000"){
                    price = 5700*sl_;
                }else if(zz_=="1150"){
                    price = 8200*sl_;
                }else if(zz_=="1350"){
                    price = 8200*sl_;
                }else if(zz_=="1600"){
                    price = 8200*sl_;
                }
            }
            $("#JXZH_HWB_TEMP").val(price);
        }else if(option=="JXZH_ZSDD"){
            //轿顶装潢-装饰吊顶
            var zsdd_ = $("select[name='JXZH_ZSDD']").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(zsdd_=="JF-CL-01"){
                if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-02"){
                if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-03"){
                if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-04"){
                if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-21"){
                if(zz_=="800"){
                    price = 240*sl_;
                }else if(zz_=="1000"){
                    price = 240*sl_;
                }else if(zz_=="1350"){
                    price = 280*sl_;
                }else if(zz_=="1600"){
                    price = 390*sl_;
                }
            }
            $("#JXZH_ZSDD_TEMP").val(price);
        }else if(option=="JXZH_BGJ"){
            //半高镜
            var bgj_ = $("input[name='JXZH_BGJ']:checked").val();
            if(bgj_=="有"){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="800"){
                    price = 980;
                }else if(zz_=="1000"){
                    price = 1300;
                }else if(zz_=="1150"){
                    price = 1600;
                }else if(zz_=="1350"){
                    price = 1600;
                }else if(zz_=="1600"){
                    price = 1600;
                }
            }else if(bgj_=="无"){
                price = 0;
            }
            $("#JXZH_BGJ_TEMP").val(price);
        }else if(option=="JXZH_DBXH"){
            //地板型号
            var dbxh_ = $("input[name='JXZH_DBXH']:checked").val();
            if(dbxh_=="JD-05"){
                price = 490;
            }else if(dbxh_==""){
                dbxh_ = $("#JXZH_DBXH_SELECT").val();
                if(dbxh_=="JD-01"||dbxh_=="JD-02"||dbxh_=="JD-03"){
                    price = 0;
                }else if(dbxh_=="JD-04"){
                    price = 490;
                }
            }
            $("#JXZH_DBXH_TEMP").val(price);
        }else if(option=="JXZH_YLZHZL"){
            //预留装潢重量
            var ylzhzl_ = parseInt($("#JXZH_YLZHZL").val());
            var zz_ = $("#BZ_ZZ").val();  //载重
            if(ylzhzl_<=200){
                if(zz_=="800"){
                    price = 900
                }else if(zz_=="1000"){
                    price = 1100;
                }
            }else if(ylzhzl_<=250){
                if(zz_=="1150"){
                    price = 1500;
                }else if(zz_=="1350"){
                    price = 1600;
                }
            }else if(ylzhzl_<=300){
                if(zz_=="1600"){
                    price = 2000;
                }
            }
            $("#JXZH_YLZHZL_TEMP").val(price);
        }else if(option=="JXZH_FSXH"){
            //扶手型号
            var fsxh_ = $("#JXZH_FSXH_SELECT").val();
            if(fsxh_=="JF-FS-01"){
                price = 650;
            }else if(fsxh_=="JF-FS-02"){
                price = 490;
            }else if(fsxh_=="JF-FS-03"){
                price = 490;
            }else if(fsxh_=="JF-FS-04"){
                price = 520;
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
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt($("#FEIYANGXF_SL").val());
        //价格
        var price = 0;
        if(option=="TMMT_JZBXGXMT"){
            //减震不锈钢小门套
            if($("#TMMT_JZBXGXMT_TEXT").is(":checked")){
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                var c_ = parseInt($("#BZ_C").val());    //层数
                if(kmkd_=="800"){
                    price = 240*c_*sl_;
                }else if(kmkd_=="900"){
                    price = 310*c_*sl_;
                }else if(kmkd_=="1100"){
                    price = 390*c_*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_JZBXGXMT_TEMP").val(price);
        }else if(option=="TMMT_PTDMT"){
            //喷涂大门套
            var ptdmt_ = $("#TMMT_PTDMT").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var c_ = parseInt($("#BZ_C").val());    //层数
            if(ptdmt_=="喷涂"){
                if(kmkd_=="800"){
                    price = 1300*c_*sl_;
                }else if(kmkd_=="900"){
                    price = 1500*c_*sl_;
                }else if(kmkd_=="1100"){
                    price = 1600*c_*sl_;
                }
            }else if(ptdmt_=="减震复合不锈钢"){
                if(kmkd_=="800"){
                    price = 2000*c_*sl_;
                }else if(kmkd_=="900"){
                    price = 2100*c_*sl_;
                }else if(kmkd_=="1100"){
                    price = 2300*c_*sl_;
                }
            }else if(ptdmt_=="镜面不锈钢"){
                if(kmkd_=="800"){
                    price = 2400*c_*sl_;
                }else if(kmkd_=="900"){
                    price = 2600*c_*sl_;
                }else if(kmkd_=="1100"){
                    price = 2800*c_*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_PTDMT_TEMP").val(price);
        }else if(option=="TMMT_PTJMBXGTM"){
            //喷涂镜面不锈钢厅门小门套
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var c_ = parseInt($("#BZ_C").val());    //层数
            if($("#TMMT_PTJMBXGTM_TEXT").is(":checked")){
                if(kmkd_=="800"){
                    price = 2000*c_*sl_;
                }else if(kmkd_=="900"){
                    price = 2000*c_*sl_;
                }else if(kmkd_=="1000"){
                    price = 2300*c_*sl_;
                }else if(kmkd_=="1100"){
                    price = 2300*c_*sl_;
                }
            }
            $("#TMMT_PTJMBXGTM_TEMP").val(price);
        }else if(option=="TMMT_SCTMMT"){
            //首层厅门门套
            var kmkd_ = $("#BZ_KMKD").val();    //开门宽度
            if(kmkd_=="800"){
                price = 810*sl_;
            }else if(kmkd_=="900"){
                price = 980*sl_;
            }else if(kmkd_=="1100"){
                price = 1300*sl_;
            }
            $("#TMMT_SCTMMT_TEMP").val(price);
        }else if(option=="TMMT_FSCTMMT"){
            //非首层厅门门套
            var kmkd_ = $("#BZ_KMKD").val();    //开门宽度
            var c_ = parseInt($("#BZ_C").val());  //层
            if(kmkd_=="800"){
                price = 810*(c_-1)*sl_;
            }else if(kmkd_=="900"){
                price = 980*(c_-1)*sl_;
            }else if(kmkd_=="1100"){
                price = 1300*(c_-1)*sl_;
            }
            $("#TMMT_FSCTMMT_TEMP").val(price);
        }
        
        //放入价格
        countZhj();
    }
    

    //操纵盘-加价
    function editCzp(option){
        var sl_ = parseInt($("#FEIYANGXF_SL").val());
        var price = 0;
        if(option=="CZP_CZPXH"){
            var xh_ = $("input[name='CZP_CZPXH']:checked").val();
            if(xh_=="JFCOP09H-C1"){
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
        var sl_ = $("#FEIYANGXF_SL").val();
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
        }else if(option=="TMXHZZ_WZYCOPMWAN"){

            if($("#TMXHZZ_WZYCOPMWAN_TEXT").is(":checked")){
                var c_ = parseInt($("#BZ_C").val());
                if(c_<=16){
                    price = 2900*sl_;
                }else if(c<=30){
                    price = 4100*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMXHZZ_WZYCOPMWAN_TEMP").val(price);
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
                        $("#FEIYANGXF_YSF").val(transPrice);
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
                        $("#FEIYANGXF_YSF").val(transPrice);
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
        if($("#OPT_MWAN_TEXT").is(":checked")){
            $("#OPT_MWAN").val("1");
        }else{
            $("#OPT_MWAN").val("0");
        }
        if($("#OPT_HJZDFHJZ_TEXT").is(":checked")){
            $("#OPT_HJZDFHJZ").val("1");
        }else{
            $("#OPT_HJZDFHJZ").val("0");
        }
        if($("#OPT_XFYYX_TEXT").is(":checked")){
            $("#OPT_XFYYX").val("1");
        }else{
            $("#OPT_XFYYX").val("0");
        }
        if($("#OPT_JXDZZ_TEXT").is(":checked")){
            $("#OPT_JXDZZ").val("1");
        }else{
            $("#OPT_JXDZZ").val("0");
        }
        if($("#OPT_CCTVDL_TEXT").is(":checked")){
            $("#OPT_CCTVDL").val("1");
        }else{
            $("#OPT_CCTVDL").val("0");
        }
        if($("#OPT_TDJJJY_TEXT").is(":checked")){
            $("#OPT_TDJJJY").val("1");
        }else{
            $("#OPT_TDJJJY").val("0");
        }
        if($("#OPT_DJGRBH_TEXT").is(":checked")){
            $("#OPT_DJGRBH").val("1");
        }else{
            $("#OPT_DJGRBH").val("0");
        }
        if($("#OPT_KQJHZZ_TEXT").is(":checked")){
            $("#OPT_KQJHZZ").val("1");
        }else{
            $("#OPT_KQJHZZ").val("0");
        }
        if($("#OPT_FDLCZ_TEXT").is(":checked")){
            $("#OPT_FDLCZ").val("1");
        }else{
            $("#OPT_FDLCZ").val("0");
        }
        if($("#OPT_ZPC_TEXT").is(":checked")){
            $("#OPT_ZPC").val("1");
        }else{
            $("#OPT_ZPC").val("0");
        }
        if($("#OPT_BAJK_TEXT").is(":checked")){
            $("#OPT_BAJK").val("1");
        }else{
            $("#OPT_BAJK").val("0");
        }
        if($("#OPT_YYBZ_TEXT").is(":checked")){
            $("#OPT_YYBZ").val("1");
        }else{
            $("#OPT_YYBZ").val("0");
        }
        if($("#OPT_QPGM_TEXT").is(":checked")){
            $("#OPT_QPGM").val("1");
        }else{
            $("#OPT_QPGM").val("0");
        }
        if($("#OPT_DLFW_TEXT").is(":checked")){
            $("#OPT_DLFW").val("1");
        }else{
            $("#OPT_DLFW").val("0");
        }
        if($("#OPT_DLFW_TEXT").is(":checked")){
            $("#OPT_DLFW").val("1");
        }else{
            $("#OPT_DLFW").val("0");
        }
        if($("#OPT_KMBC_TEXT").is(":checked")){
            $("#OPT_KMBC").val("1");
        }else{
            $("#OPT_KMBC").val("0");
        }
        if($("#OPT_DZYX_TEXT").is(":checked")){
            $("#OPT_DZYX").val("1");
        }else{
            $("#OPT_DZYX").val("0");
        }
        if($("#OPT_NLHK_TEXT").is(":checked")){
            $("#OPT_NLHK").val("1");
        }else{
            $("#OPT_NLHK").val("0");
        }
        if($("#OPT_YCJK_TEXT").is(":checked")){
            $("#OPT_YCJK").val("1");
        }else{
            $("#OPT_YCJK").val("0");
        }
        if($("#OPT_ICKZKSB_TEXT").is(":checked")){
            $("#OPT_ICKZKSB").val("1");
        }else{
            $("#OPT_ICKZKSB").val("0");
        }
        if($("#OPT_JKGM_TEXT").is(":checked")){
            $("#OPT_JKGM").val("1");
        }else{
            $("#OPT_JKGM").val("0");
        }
        if($("#OPT_JKYYJ_TEXT").is(":checked")){
            $("#OPT_JKYYJ").val("1");
        }else{
            $("#OPT_JKYYJ").val("0");
        }
        if($("#OPT_GTMJXJMBF_TEXT").is(":checked")){
            $("#OPT_GTMJXJMBF").val("1");
        }else{
            $("#OPT_GTMJXJMBF").val("0");
        }
        if($("#OPT_GTMS_TEXT").is(":checked")){
            $("#OPT_GTMS").val("1");
        }else{
            $("#OPT_GTMS").val("0");
        }
        if($("#OPT_JFGT_TEXT").is(":checked")){
            $("#OPT_JFGT").val("1");
        }else{
            $("#OPT_JFGT").val("0");
        }
            //厅门门套部分
        if($("#TMMT_FWBXGXMT_TEXT").is(":checked")){
            $("#TMMT_FWBXGXMT").val("1");
        }else{
            $("#TMMT_FWBXGXMT").val("0");
        }
        if($("#TMMT_PTJMBXGTM_TEXT").is(":checked")){
            $("#TMMT_PTJMBXGTM").val("1");
        }else{
            $("#TMMT_PTJMBXGTM").val("0");
        }
            //厅门信号装置部分
        if($("#TMXHZZ_WZYCOPMWAN_TEXT").is(":checked")){
            $("#TMXHZZ_WZYCOPMWAN").val("1");
        }else{
            $("#TMXHZZ_WZYCOPMWAN").val("0");
        }
        //门类型门保护
        if($("input[name='BASE_MLXMBH']:checked").val()==""){
            $("input[name='BASE_MLXMBH']:checked").val($("#BASE_MLXMBH_TEXT").val())
        }
        //井道承重墙厚度
        if($("input[name='BASE_JDCZQHD']:checked").val()==""){
            $("input[name='BASE_JDCZQHD']:checked").val($("#BASE_JDCZQHD_TEXT").val())
        }
        //地板型号
        if($("input[name='JXZH_DBXH']:checked").val()==""){
            $("input[name='JXZH_DBXH']:checked").val($("#JXZH_DBXH_SELECT").val())
        }
        //扶手型号
        if($("input[name='JXZH_FSXH']:checked").val()==""){
            $("input[name='JXZH_FSXH']:checked").val($("#JXZH_FSXH_SELECT").val())
        }
        


        $("#feiyangxfForm").submit();
    }
</script>
</body>

</html>
