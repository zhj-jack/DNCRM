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
    <form action="e_offer/${msg}.do" name="feiyang3000mrlForm" id="feiyang3000mrlForm" method="post">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="FEIYANGMRL_ID" id="FEIYANGMRL_ID" value="${pd.FEIYANGMRL_ID}">
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
                                                <option value="飞扬3000+MRL">飞扬3000+MRL</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()">
                                                <option value="450" ${regelevStandardPd.ZZ=='450'?'selected':''}>450</option>
                                                <option value="630" ${regelevStandardPd.ZZ=='630'?'selected':''}>630</option>
                                                <option value="800" ${regelevStandardPd.ZZ=='800'?'selected':''}>800</option>
                                                <option value="1000" ${regelevStandardPd.ZZ=='1000'?'selected':''}>1000</option>
                                                <option value="1150" ${regelevStandardPd.ZZ=='1150'?'selected':''}>1150</option>
                                                <option value="1350" ${regelevStandardPd.ZZ=='1350'?'selected':''}>1350</option>
                                                <option value="1600" ${regelevStandardPd.ZZ=='1600'?'selected':''}>1600</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">速度(m/s):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_SD" name="BZ_SD" onchange="editSd();">
                                                <option value="1.0" ${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>
                                                <option value="1.5" ${regelevStandardPd.SD=='1.5'?'selected':''}>1.5</option>
                                                <option value="1.75" ${regelevStandardPd.SD=='1.75'?'selected':''}>1.75</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_KMXS" name="BZ_KMXS">
                                                <option value="中分" ${regelevStandardPd.KMXS=='中分'?'selected':''}>中分</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="BZ_KMKD" name="BZ_KMKD" onchange="setMPrice();">
                                                <option value="900" ${regelevStandardPd.KMXS=='900'?'selected':''}>900</option>
                                                <option value="1500" ${regelevStandardPd.KMXS=='1500'?'selected':''}>1500</option>
                                                <option value="2000" ${regelevStandardPd.KMXS=='2000'?'selected':''}>2000</option>
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
                                            <label style="width:20%;margin-left:57px"><input type="text" class="form-control m-b" id="FEIYANGMRL_SL" name="FEIYANGMRL_SL" value="${pd.FEIYANGMRL_SL}" readonly="readonly"></label>

                                            <label style="width:9%;margin-top: 25px;margin-bottom: 10px;margin-left: 20px">折扣申请:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="FEIYANGMRL_ZK" name="FEIYANGMRL_ZK" value="${pd.FEIYANGMRL_ZK}" onkeyup="countZhj();"></label>%
                                            <!-- <select  class="form-control m-b" id="FEIYANGMRL_ZK" name="FEIYANGMRL_ZK" onchange="countZhj();">
                                                <option value="1">请选择折扣</option>
                                                <option value="0.9" ${pd.FEIYANGMRL_ZK=='0.9'?'selected':''}>90%</option>
                                                <option value="0.6" ${pd.FEIYANGMRL_ZK=='0.6'?'selected':''}>60%</option>
                                                <option value="0.5" ${pd.FEIYANGMRL_ZK=='0.5'?'selected':''}>50%</option>
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
                                                    <td>${pd.FEIYANGMRL_SL}</td>
                                                    <td>
                                                        ${regelevStandardPd.C}
                                                        /
                                                        ${regelevStandardPd.Z}
                                                        /
                                                        ${regelevStandardPd.M}
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGMRL_ZHJ" id="FEIYANGMRL_ZHJ" value="${pd.FEIYANGMRL_ZHJ}"></td>
                                                    <td>
                                                        <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGMRL_SBJ" id="FEIYANGMRL_SBJ" value="${regelevStandardPd.PRICE}">
                                                        <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}">
                                                    </td>
                                                    <td><font color="red"><span id="zk_">${pd.FEIYANGMRL_ZK}</span></font></td>
                                                    <td><font color="red"><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGMRL_ZHSBJ" id="FEIYANGMRL_ZHSBJ" value="${pd.FEIYANGMRL_ZHSBJ}"></font></td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" name="FEIYANGMRL_AZF" id="FEIYANGMRL_AZF" value="${pd.FEIYANGMRL_AZF}"  style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' onkeyup="countZhj();" />
                                                        </font>
                                                    </td>
                                                    <td>
                                                        <font color="red">
                                                            <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGMRL_YSF" id="FEIYANGMRL_YSF" value="${pd.FEIYANGMRL_YSF}">
                                                        </font>
                                                    </td>
                                                    <td><input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEIYANGMRL_SJBJ" id="FEIYANGMRL_SJBJ" value="${pd.FEIYANGMRL_SJBJ}"></td>
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
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td width="173">控制系统</td>
                                                            <td colspan="2"><input type="hidden" name="BASE_KZXT" id="BASE_KZXT" value="VVVF变频变压控制">VVVF变频变压控制</td>
                                                            <td width="12">加价</td>
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
                                                                <select name="BASE_YYZJ" id="BASE_YYZJ" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="永磁同步无齿轮曳引机"  ${pd.BASE_YYZJ=='永磁同步无齿轮曳引机'?'selected':''}>永磁同步无齿轮曳引机</option>
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
                                                            <td width="100"></td>
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
                                                                    <option value="450D-1000×1200" ${pd.BASE_JXGG=='450D-1000×1200'?'selected':''}>450D-1000×1200</option>
                                                                    <option value="630D-1100×1400" ${pd.BASE_JXGG=='630D-1100×1400'?'selected':''}>630D-1100×1400</option>
                                                                    <option value="800D-1350×1400" ${pd.BASE_JXGG=='800D-1350×1400'?'selected':''}>800D-1350×1400</option>
                                                                    <option value="1000W-1600×1400" ${pd.BASE_JXGG=='1000W-1600×1400'?'selected':''}>1000W-1600×1400</option>
                                                                    <option value="1000D-1100×2100担架梯" ${pd.BASE_JXGG=='1000D-1100×2100担架梯'?'selected':''}>1000D-1100×2100担架梯</option>
                                                                    <option value="1350W-2000×1500" ${pd.BASE_JXGG=='1350W-2000×1500'?'selected':''}>1350W-2000×1500</option>
                                                                    <option value="1600W-2000×1700" ${pd.BASE_JXGG=='1600W-2000×1700'?'selected':''}>1600W-2000×1700</option>
                                                                    <option value="1600W-1400×2400" ${pd.BASE_JXGG=='1600W-1400×2400'?'selected':''}>1600W-1400×2400</option>
                                                                </select>   
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">轿厢高度(非净高)</td>
                                                            <td><input type="radio" name="BASE_JXGD" id="BASE_JXGD" value="2400" ${pd.BASE_JXGD=='2400'?'checked':''}/>2400mm
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
                                                                <input type="radio" name="BASE_JXGD" value="2700" ${pd.BASE_JXGD=='2700'?'checked':''}/>
                                                                2700mm 
                                                                <input type="radio" name="BASE_JXGD" value="2800" ${pd.BASE_JXGD=='2800'?'checked':''}/>
                                                                2800mm 
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td><input type="radio" name="BASE_JXGD" value="2500"${pd.BASE_JXGD=='2500'?'checked':''}/>2500mm
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
                                                                <select name="BASE_KMCC" id="BASE_KMCC" class="form-control">
                                                                  <option value=''>请选择</option>
                                                                  <option value="700mm×2100mm(450kg-630kg)" ${pd.BASE_KMCC=='700mm×2100mm(450kg-630kg)'?'selected':''}>700mm×2100mm(450kg-630kg)</option>
                                                                  <option value="800mm×2100mm(800kg)" ${pd.BASE_KMCC=='800mm×2100mm(800kg)'?'selected':''}>800mm×2100mm(800kg)</option>
                                                                  <option value="900mm×2100mm(1000kg)" ${pd.BASE_KMCC=='900mm×2100mm(1000kg)'?'selected':''}>900mm×2100mm(1000kg)</option>
                                                                  <option value="1100mm×2100mm(1350kg)" ${pd.BASE_KMCC=='1100mm×2100mm(1350kg)'?'selected':''}>1100mm×2100mm(1350kg)</option>
                                                                  <option value="1100mm×2100mm(1600kg)" ${pd.BASE_KMCC=='1100mm×2100mm(1600kg)'?'selected':''}>1100mm×2100mm(1600kg)</option>
                                                                  <option value="1200mm×2100mm(1600kg)" ${pd.BASE_KMCC=='1200mm×2100mm(1600kg)'?'selected':''}>1200mm×2100mm(1600kg)</option>
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
                                                                <select name="BASE_MLXMBH_TEXT" id="BASE_MLXMBH_TEXT" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="VVVF门机/2D光幕" ${pd.BASE_MLXMBH=='PM门机/2D光幕'?'selected':''}>VVVF门机</option>
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
                                                                <input name="BASE_JDCZQHD_TEXT" id="BASE_JDCZQHD_TEXT" type="text" class="form-control" value="${BASE_JDCZQHD=='250'?'':pd.BASE_JDCZQHD}"/>
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
                                                                <input type="text" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP"></td>
                                                          </tr><tr>
                                                            <td>导轨支架</td>
                                                            <td colspan="2">
                                                                <input name="BASE_DGZJ" id="BASE_DGZJ" type="text" class="form-control" onkeyup="setDgzj();"  value="${pd.BASE_DGZJ}"/>
                                                            </td>
                                                            <td><input type="text" name="BASE_DGZJ_TEMP" id="BASE_DGZJ_TEMP" ></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
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
                                                            <td>物联网</td>
                                                            <td>WLW</td>
                                                          </tr>
                                                        </table>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <!-- 可选功能 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
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
                                                            <td>17</td>
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
                                                                <input name="OPT_HJZDFHJZ_TEXT" id="OPT_HJZDFHJZ_TEXT" type="checkbox" onclick="editOpt('OPT_HJZDFHJZ');" ${pd.OPT_HJZDFHJZ=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_HJZDFHJZ" id="OPT_HJZDFHJZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJZDFHJZ_TEMP" id="OPT_HJZDFHJZ_TEMP" class="form-control"></td>
                                                            <td>18</td>
                                                            <td>再平层</td>
                                                            <td>RLEV</td>
                                                            <td>
                                                                <input name="OPT_ZPC_TEXT" id="OPT_ZPC_TEXT" type="checkbox" onclick="editOpt('OPT_ZPC')" ${pd.OPT_ZPC=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_ZPC" id="OPT_ZPC">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZPC_TEMP" id="OPT_ZPC_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>消防员运行</td>
                                                            <td>EFS</td>
                                                            <td>
                                                                <input name="OPT_XFYYX_TEXT" id="OPT_XFYYX_TEXT" type="checkbox" onclick="editOpt('OPT_XFYYX');" ${pd.OPT_XFYYX=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_XFYYX" id="OPT_XFYYX">
                                                            </td>
                                                            <td><input type="text" name="OPT_XFYYX_TEMP" id="OPT_XFYYX_TEMP" class="form-control"></td>
                                                            <td>19</td>
                                                            <td>BA接口</td>
                                                            <td>BA</td>
                                                            <td>
                                                                <input name="OPT_BAJK_TEXT" id="OPT_BAJK_TEXT" type="checkbox" onclick="editOpt('OPT_BAJK');" ${pd.OPT_BAJK=='1'?'checked':''} />
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
                                                            <td>20</td>
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
                                                            <td>21</td>
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
                                                            <td>22</td>
                                                            <td>独立服务</td>
                                                            <td>ISC</td>
                                                            <td>
                                                                <input name="OPT_DLFW_TEXT" id="OPT_DLFW_TEXT" type="checkbox" onclick="editOpt('OPT_DLFW');" ${pd.OPT_DLFW=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_DLFW" id="OPT_DLFW">
                                                            </td>
                                                            <td><input type="text" name="OPT_DLFW_TEMP" id="OPT_DLFW_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>电机过热保护</td>
                                                            <td>THB</td>
                                                            <td>
                                                                <input name="OPT_DJGRBH_TEXT" id="OPT_DJGRBH_TEXT" type="checkbox" onclick="editOpt('OPT_DJGRBH');" ${pd.OPT_DJGRBH=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_DJGRBH" id="OPT_DJGRBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_DJGRBH_TEMP" id="OPT_DJGRBH_TEMP" class="form-control"></td>
                                                            <td>23</td>
                                                            <td>开门保持</td>
                                                            <td>DHB</td>
                                                            <td>
                                                                <input name="OPT_KMBC_TEXT" id="OPT_KMBC_TEXT" type="checkbox" onclick="editOpt('OPT_KMBC');" ${pd.OPT_KMBC=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_KMBC" id="OPT_KMBC">
                                                            </td>
                                                            <td><input type="text" name="OPT_KMBC_TEMP" id="OPT_KMBC_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>空气净化装置</td>
                                                            <td>ANION</td>
                                                            <td>
                                                                <input name="OPT_KQJHZZ_TEXT" id="OPT_KQJHZZ_TEXT" type="checkbox" onclick="editOpt('OPT_KQJHZZ');" ${pd.OPT_KQJHZZ=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_KQJHZZ" id="OPT_KQJHZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_KQJHZZ_TEMP" id="OPT_KQJHZZ_TEMP" class="form-control"></td>
                                                            <td>24</td>
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
                                                                <!-- <input name="OPT_NMYKJAN_TEXT" id="OPT_NMYKJAN_TEXT" type="checkbox" onclick="editOpt('OPT_NMYKJAN');" ${pd.OPT_NMYKJAN=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_NMYKJAN" id="OPT_NMYKJAN"> -->
                                                            </td>
                                                            <td><input type="text" name="OPT_NMYKJAN_TEMP" id="OPT_NMYKJAN_TEMP" class="form-control"></td>
                                                            <td>25</td>
                                                            <td>能量回馈</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_NLHK_TEXT" id="OPT_NLHK_TEXT" type="checkbox" onclick="editOpt('OPT_NLHK');" ${pd.OPT_NLHK=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_NLHK" id="OPT_NLHK">
                                                            </td>
                                                            <td><input type="text" name="OPT_NLHK_TEMP" id="OPT_NLHK_TEMP" class="form-control"></td>
                                                          </tr><tr>
                                                            <td>10</td>
                                                            <td>远程监控(物联网系统)</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_YCJK_TEXT" id="OPT_YCJK_TEXT" type="checkbox" onclick="editOpt('OPT_YCJK');" ${pd.OPT_YCJK=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_YCJK" id="OPT_YCJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_YCJK_TEMP" id="OPT_YCJK_TEMP" class="form-control"></td>
                                                            <td>26</td>
                                                            <td>IC卡(轿内控制)</td>
                                                            <td></td>
                                                            <td>
                                                                <select name="OPT_ICK_TEXT" id="OPT_ICK_TEXT" onchange="editOpt('OPT_ICK');" class="form-control" style="width:100% ">
                                                                    <option value="">请选择</option>
                                                                    <option value="刷卡后手动选择到达楼层" ${pd.OPT_ICK=='刷卡后手动选择到达楼层'?'selected':''}>刷卡后手动选择到达楼层</option>
                                                                    <option value="刷卡后自动选择到达楼层" ${pd.OPT_ICK=='刷卡后自动选择到达楼层'?'selected':''}>刷卡后自动选择到达楼层</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_ICK" id="OPT_ICK">
                                                            </td>
                                                            <td><input type="text" name="OPT_ICK_TEMP" id="OPT_ICK_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>IC卡制卡设备</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_ICKZKSB_TEXT" id="OPT_ICKZKSB_TEXT" type="checkbox" onclick="editOpt('OPT_ICKZKSB');" ${pd.OPT_ICKZKSB=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_ICKZKSB" id="OPT_ICKZKSB">
                                                            </td>
                                                            <td><input type="text" name="OPT_ICKZKSB_TEMP" id="OPT_ICKZKSB_TEMP" class="form-control"></td>
                                                            <td>27</td>
                                                            <td>IC卡卡片(张)</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_ICKKP_TEXT" id="OPT_ICKKP_TEXT" type="text" onkeyup="editOpt('OPT_ICKKP');" class="form-control" style="width:100% " value="${pd.OPT_ICKKP}"/>
                                                                <input type="hidden" name="OPT_ICKKP" id="OPT_ICKKP">
                                                            </td>
                                                            <td><input type="text" name="OPT_ICKKP_TEMP" id="OPT_ICKKP_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>普通电梯空调</td>
                                                            <td></td>
                                                            <td>
                                                                <select name="OPT_PTDTKT_TEXT" id="OPT_PTDTKT_TEXT" onchange="editOpt('OPT_PTDTKT');" class="form-control" style="width:100% ">
                                                                    <option value=''>请选择</option>
                                                                    <option value='单冷型2200W' ${pd.OPT_PTDTKT=='单冷型2200W'?'selected':''}>单冷型2200W</option>
                                                                    <option value='冷暖型1500W' ${pd.OPT_PTDTKT=='冷暖型1500W'?'selected':''}>冷暖型1500W</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_PTDTKT" id="OPT_PTDTKT">
                                                            </td>
                                                            <td><input type="text" name="OPT_PTDTKT_TEMP" id="OPT_PTDTKT_TEMP" class="form-control"></td>
                                                            <td>28</td>
                                                            <td>专用分体式电梯空调</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_ZYFTSDTKT_TEXT" id="OPT_ZYFTSDTKT_TEXT" onchange="editOpt('OPT_ZYFTSDTKT');"class="form-control" style="width:100% "> 
                                                                    <option value=''>请选择</option>
                                                                    <option value='单冷型2200W' ${pd.OPT_ZYFTSDTKT=='单冷型2200W'?'selected':''}>单冷型2200W</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_ZYFTSDTKT" id="OPT_ZYFTSDTKT">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZYFTSDTKT_TEMP" id="OPT_ZYFTSDTKT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>13</td>
                                                            <td>进口光幕</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_JKGM_TEXT" id="OPT_JKGM_TEXT" type="checkbox" onclick="editOpt('OPT_JKGM');" ${pd.OPT_JKGM=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_JKGM" id="OPT_JKGM">
                                                            </td>
                                                            <td><input type="text" name="OPT_JKGM_TEMP" id="OPT_JKGM_TEMP" class="form-control"></td>
                                                            <td>29</td>
                                                            <td>进口曳引机</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_JKYYJ_TEXT" id="OPT_JKYYJ_TEXT" type="checkbox" onclick="editOpt('OPT_JKYYJ');" ${pd.OPT_JKYYJ=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_JKYYJ" id="OPT_JKYYJ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JKYYJ_TEMP" id="OPT_JKYYJ_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>14</td>
                                                            <td>贯通门(轿厢、轿门部分)</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_GTMJXJMBF_TEXT" id="OPT_GTMJXJMBF_TEXT" type="checkbox" onclick="editOpt('OPT_GTMJXJMBF');" ${pd.OPT_GTMJXJMBF=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_GTMJXJMBF" id="OPT_GTMJXJMBF">
                                                            </td>
                                                            <td><input type="text" name="OPT_GTMJXJMBF_TEMP" id="OPT_GTMJXJMBF_TEMP" class="form-control"></td>
                                                            <td>30</td>
                                                            <td>贯通门(厅门部分)</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_GTMTMBF_TEXT" id="OPT_GTMTMBF_TEXT" onchange="editOpt('OPT_GTMTMBF');" class="form-control" style="width:100% "> 
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
                                                                <input name="OPT_GTMS_TEXT" id="OPT_GTMS_TEXT" type="text" onclick="editOpt('OPT_GTMS');" class="form-control" style="width:100% " value="${pd.OPT_GTMS}"/>
                                                                <input type="hidden" name="OPT_GTMS" id="OPT_GTMS">
                                                            </td>
                                                            <td><input type="text" name="OPT_GTMS_TEMP" id="OPT_GTMS_TEMP" class="form-control"></td>
                                                            <td>31</td>
                                                            <td>层门装潢</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_CMZH_TEXT" id="OPT_CMZH_TEXT" onchange="editOpt('OPT_CMZH');" class="form-control" style="width:100% ">
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
                                                          </tr><tr>
                                                            <td>16</td>
                                                            <td>500mm&lt;机房高台&le;2000mm</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_JFGT_TEXT" id="OPT_JFGT_TEXT" type="checkbox" onclick="editOpt('OPT_JFGT');" ${pd.OPT_JFGT=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_JFGT" id="OPT_JFGT">
                                                            </td>
                                                            <td><input type="text" name="OPT_JFGT_TEMP" id="OPT_JFGT_TEMP" class="form-control"></td>
                                                            <td>32</td>
                                                            <td>担架梯</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_DJT_TEXT" id="OPT_DJT_TEXT" type="checkbox" onclick="editOpt('OPT_DJT');" ${pd.OPT_DJT=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_DJT" id="OPT_DJT">
                                                            </td>
                                                            <td><input type="text" name="OPT_DJT_TEMP" id="OPT_DJT_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 可选功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <!-- 单组监控室对讲系统 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
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
                                                                    <option value=''>--</option>
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
                                                                <input name="JXZH_JDZH" type="radio" value="悬吊式:JF-CL20(450-1600kg标准)" onclick="setJdzhDisable('0');"  ${pd.JXZH_JDZH=='悬吊式:JF-CL20(450-1600kg标准)'?'checked':''}/>
                                                                悬吊式:JF-CL20(450-1600kg标准)
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
                                                                <input name="JXZH_DBXH" type="radio" value="大理石预留" onclick="setDbxhDisable('1');" ${pd.JXZH_DBXH=='大理石预留'?'checked':''}/>
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
                                                                <input name="JXZH_YLZHZL" id="JXZH_YLZHZL" type="text" onkeyup="editJxzh('JXZH_YLZHZL');" class="form-control"/>
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
                                                            <td><input name="JXZH_FSXH" type="radio" value="" onclick="setFsxhDisable('0');" ${pd.JXZH_FSXH==''?'checked':''}/>
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
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="后围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.checkbox=='后围壁'?'checked':''}/>
                                                                后围壁 轿厢外向内看:
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="左围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.checkbox=='后围壁'?'checked':''}/>
                                                                左围壁
                                                                <input name="JXZH_FSAZWZ" type="checkbox" value="右围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.checkbox=='后围壁'?'checked':''}/>
                                                                右围壁
                                                            </td>
                                                            <td><input type="text" name="JXZH_FSAZWZ_TEMP" id="JXZH_FSAZWZ_TEMP" class="form-control"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 轿厢装潢 -->
                                                </div>
                                                <div id="tab-6" class="tab-pane">
                                                    <!-- 厅门门套 -->
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
                                                          <tr>
                                                            <td>发纹不锈钢小门套</td>
                                                            <td colspan="2"><input type="checkbox" name="TMMT_FWBXGXMT_TEXT" id="TMMT_FWBXGXMT_TEXT" onclick="editTmmt('TMMT_FWBXGXMT');" ${pd.TMMT_FWBXGXMT=='1'?'checked':''}></td>
                                                            <input type="hidden" name="TMMT_FWBXGXMT" id="TMMT_FWBXGXMT">
                                                            <td><input type="text" name="TMMT_FWBXGXMT_TEMP" id="TMMT_FWBXGXMT_TEMP" class="form-control"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>喷涂→大门套(墙厚+装饰层)≤350mm</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_PTDMT" name="TMMT_PTDMT" onchange="editTmmt('TMMT_PTDMT');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="喷涂" ${pd.TMMT_PTDMT=='喷涂'?'selected':''}>喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_PTDMT=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
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
                                                            <td width="125">厅门材质</td>
                                                            <td width="180">数量</td>
                                                            <td width="20">加价</td>
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
                                                                <input name="TMMT_SCTMMT" type="radio" value="镜面不锈钢" onclick="setScsbhDisable('1');"  ${pd.TMMT_SCTMMT=='镜面不锈钢'?'checked':''}/>
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
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
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
                                                        <table class="table table-striped table-bordered table-hover"  border="1" cellspacing="0">
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
                                                                      <option value="BAS241" ${pd.TMXHZZ_AN==''?'selected':''}>BAS241</option>
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
                                                                    <input name="TMXHZZ_ZDJC" type="text"  id="TMXHZZ_ZDJC_1" class="form-control" style="width: 30px" value="${pd.TMXHZZ_ZDJC}"/>
                                                                    层、每层
                                                                    <input name="TMXHZZ_MCGS" type="text" id="TMXHZZ_MCGS_1" class="form-control" style="width: 30px" value="${pd.TMXHZZ_MCGS}"/>
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
                                                                    <input name="TMXHZZ_ZDJC" type="text" id="TMXHZZ_ZDJC_2" class="form-control" style="width: 30px" value="${pd.TMXHZZ_ZDJC}"/>
                                                                    层、每层
                                                                    <input name="TMXHZZ_MCGS" type="text" id="TMXHZZ_MCGS_2" class="form-control" style="width: 30px" value="${pd.TMXHZZ_MCGS}"/>
                                                                    个
                                                                </p>
                                                                <p>
                                                                    附加说明:
                                                                    <input name="TMXHZZ_FJSM" type="text" id="TMXHZZ_FJSM_2" class="form-control"  value="${pd.TMXHZZ_FJSM}"/>
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
                                            <input type="text" class="form-control" id="FEIYANGMRL_AZF_TEMP" name="FEIYANGMRL_AZF_TEMP" onkeyup="countZhj();" value="${pd.FEIYANGMRL_AZF}">
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
                                        </div>
                                        <div class="form-group form-inline">
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
                                        <div class="form-group form-inline" id="ld">
                                            吨数:<input type="text" id="less_num" name="less_num" class="form-control">
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

    function cbjPrice(){
        //井道总高
        setJdzg();
        //导轨支架
        setDgzj();
        //可选项
        editOpt('OPT_HJZDFHJZ');
        editOpt('OPT_CCTVDL');
        editOpt('OPT_TDJJJY');
        editOpt('OPT_DJGRBH');
        editOpt('OPT_KQJHZZ');
        editOpt('OPT_NMYKJAN');
        editOpt('OPT_FDLCZ');
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
        editOpt('OPT_JFGT');
        editOpt('OPT_DJT');
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
        editTmmt('TMMT_FWBXGXMT');
        editTmmt('TMMT_PTDMT');
        editTmmt('TMMT_PTJMBXGTM');
        editTmmt('TMMT_SCTMMT');
        editTmmt('TMMT_FSCTMMT');
        //操纵盘
        editCzp('CZP_CZPXH');
        //厅门信号装置
        editTmxhzz('TMXHZZ_CZ');
        editTmxhzz('TMXHZZ_WZYCOPMWAN');
    }

    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#FEIYANGMRL_SL").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=feiyangmrl&FEIYANGMRL_SL="+sl_,
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
        var sl_ = $("#FEIYANGMRL_SL").val();
        var zk_ = $("#FEIYANGMRL_ZK").val();
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selZhj.do?models=feiyangmrl&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYANGMRL_SL="+sl_+"&FEIYANGMRL_ZK="+zk_,
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


    



    //计算基础价
    function setSbj(){
        var sd_ = $("#BZ_SD").val();  //速度
        var c_ = $("#BZ_C").val();     //层站
        var zz_ = $("#BZ_ZZ").val();  //载重
        var price = 0;
        if(sd_=="1.0"){
            if(zz_=="450"){
                if(c_=="3"){
                    price = 134900;
                }else if(c_=="4"){
                    price = 139900;
                }else if(c_=="5"){
                    price = 144900;
                }else if(c_=="6"){
                    price = 149900;
                }else if(c_=="7"){
                    price = 155900;
                }else if(c_=="8"){
                    price = 160900;
                }else if(c_=="9"){
                    price = 165900;
                }else if(c_=="10"){
                    price = 170900;
                }else if(c_=="11"){
                    price = 175900;
                }else if(c_=="12"){
                    price = 180900;
                }else if(c_=="13"){
                    price = 185900;
                }else if(c_=="14"){
                    price = 190900;
                }else if(c_=="15"){
                    price = 195900;
                }else if(c_=="16"){
                    price = 200900;
                }else if(c_=="17"){
                    price = 205900;
                }else if(c_=="18"){
                    price = 210900;
                }else if(c_=="19"){
                    price = 215900;
                }else if(c_=="20"){
                    price = 221900;
                }
            }else if(zz_=="630"){
                if(c_=="3"){
                    price = 137400;
                }else if(c_=="4"){
                    price = 142400;
                }else if(c_=="5"){
                    price = 147400;
                }else if(c_=="6"){
                    price = 152400;
                }else if(c_=="7"){
                    price = 158400;
                }else if(c_=="8"){
                    price = 163400;
                }else if(c_=="9"){
                    price = 168400;
                }else if(c_=="10"){
                    price = 173400;
                }else if(c_=="11"){
                    price = 178400;
                }else if(c_=="12"){
                    price = 183400;
                }else if(c_=="13"){
                    price = 188400;
                }else if(c_=="14"){
                    price = 193400;
                }else if(c_=="15"){
                    price = 198400;
                }else if(c_=="16"){
                    price = 203400;
                }else if(c_=="17"){
                    price = 208400;
                }else if(c_=="18"){
                    price = 213400;
                }else if(c_=="19"){
                    price = 218400;
                }else if(c_=="20"){
                    price = 224400;
                }
            }else if(zz_=="800"){
                if(c_=="3"){
                    price = 139910;
                }else if(c_=="4"){
                    price = 144910;
                }else if(c_=="5"){
                    price = 149910;
                }else if(c_=="6"){
                    price = 154910;
                }else if(c_=="7"){
                    price = 159910;
                }else if(c_=="8"){
                    price = 164910;
                }else if(c_=="9"){
                    price = 169910;
                }else if(c_=="10"){
                    price = 174910;
                }else if(c_=="11"){
                    price = 180910;
                }else if(c_=="12"){
                    price = 185910;
                }else if(c_=="13"){
                    price = 190910;
                }else if(c_=="14"){
                    price = 195910;
                }else if(c_=="15"){
                    price = 200910;
                }else if(c_=="16"){
                    price = 205910;
                }else if(c_=="17"){
                    price = 210910;
                }else if(c_=="18"){
                    price = 215910;
                }else if(c_=="19"){
                    price = 220910;
                }else if(c_=="20"){
                    price = 225910;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 147670;
                }else if(c_=="4"){
                    price = 152670;
                }else if(c_=="5"){
                    price = 157670;
                }else if(c_=="6"){
                    price = 162670;
                }else if(c_=="7"){
                    price = 167670;
                }else if(c_=="8"){
                    price = 172670;
                }else if(c_=="9"){
                    price = 177670;
                }else if(c_=="10"){
                    price = 182670;
                }else if(c_=="11"){
                    price = 187670;
                }else if(c_=="12"){
                    price = 192670;
                }else if(c_=="13"){
                    price = 197670;
                }else if(c_=="14"){
                    price = 203670;
                }else if(c_=="15"){
                    price = 208670;
                }else if(c_=="16"){
                    price = 213670;
                }else if(c_=="17"){
                    price = 218670;
                }else if(c_=="18"){
                    price = 223670;
                }else if(c_=="19"){
                    price = 228670;
                }else if(c_=="20"){
                    price = 233670;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 192850;
                }else if(c_=="4"){
                    price = 197790;
                }else if(c_=="5"){
                    price = 202740;
                }else if(c_=="6"){
                    price = 207690;
                }else if(c_=="7"){
                    price = 212630;
                }else if(c_=="8"){
                    price = 217580;
                }else if(c_=="9"){
                    price = 222520;
                }else if(c_=="10"){
                    price = 227470;
                }else if(c_=="11"){
                    price = 232410;
                }else if(c_=="12"){
                    price = 237360;
                }else if(c_=="13"){
                    price = 242310;
                }else if(c_=="14"){
                    price = 247250;
                }else if(c_=="15"){
                    price = 252200;
                }else if(c_=="16"){
                    price = 257140;
                }else if(c_=="17"){
                    price = 262090;
                }else if(c_=="18"){
                    price = 267040;
                }else if(c_=="19"){
                    price = 271980;
                }else if(c_=="20"){
                    price = 276930;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 195780;
                }else if(c_=="4"){
                    price = 200830;
                }else if(c_=="5"){
                    price = 205880;
                }else if(c_=="6"){
                    price = 210920;
                }else if(c_=="7"){
                    price = 215970;
                }else if(c_=="8"){
                    price = 221020;
                }else if(c_=="9"){
                    price = 226070;
                }else if(c_=="10"){
                    price = 231120;
                }else if(c_=="11"){
                    price = 236170;
                }else if(c_=="12"){
                    price = 241220;
                }else if(c_=="13"){
                    price = 246260;
                }else if(c_=="14"){
                    price = 251310;
                }else if(c_=="15"){
                    price = 256360;
                }else if(c_=="16"){
                    price = 261410;
                }else if(c_=="17"){
                    price = 266460;
                }else if(c_=="18"){
                    price = 271510;
                }else if(c_=="19"){
                    price = 276550;
                }else if(c_=="20"){
                    price = 281600;
                }
            }
        }else if(sd_=="1.5"){   //速度=1.5m/s
            if(zz_=="450"){
                if(c_=="3"){
                    price = 139900;
                }else if(c_=="4"){
                    price = 144900;
                }else if(c_=="5"){
                    price = 149900;
                }else if(c_=="6"){
                    price = 154900;
                }else if(c_=="7"){
                    price = 160900;
                }else if(c_=="8"){
                    price = 165900;
                }else if(c_=="9"){
                    price = 170900;
                }else if(c_=="10"){
                    price = 175900;
                }else if(c_=="11"){
                    price = 180900;
                }else if(c_=="12"){
                    price = 185900;
                }else if(c_=="13"){
                    price = 190900;
                }else if(c_=="14"){
                    price = 195900;
                }else if(c_=="15"){
                    price = 200900;
                }else if(c_=="16"){
                    price = 205900;
                }else if(c_=="17"){
                    price = 210900;
                }else if(c_=="18"){
                    price = 215900;
                }else if(c_=="19"){
                    price = 220900;
                }else if(c_=="20"){
                    price = 226900;
                }else if(c_=="21"){
                    price = 231900;
                }else if(c_=="22"){
                    price = 236900;
                }else if(c_=="23"){
                    price = 241900;
                }else if(c_=="24"){
                    price = 246900;
                }
            }else if(zz_=="630"){
                if(c_=="3"){
                    price = 142400;
                }else if(c_=="4"){
                    price = 147400;
                }else if(c_=="5"){
                    price = 152400;
                }else if(c_=="6"){
                    price = 157400;
                }else if(c_=="7"){
                    price = 163400;
                }else if(c_=="8"){
                    price = 168400;
                }else if(c_=="9"){
                    price = 173400;
                }else if(c_=="10"){
                    price = 178400;
                }else if(c_=="11"){
                    price = 183400;
                }else if(c_=="12"){
                    price = 188400;
                }else if(c_=="13"){
                    price = 193400;
                }else if(c_=="14"){
                    price = 198400;
                }else if(c_=="15"){
                    price = 203400;
                }else if(c_=="16"){
                    price = 208400;
                }else if(c_=="17"){
                    price = 213400;
                }else if(c_=="18"){
                    price = 218400;
                }else if(c_=="19"){
                    price = 223400;
                }else if(c_=="20"){
                    price = 229400;
                }else if(c_=="21"){
                    price = 234400;
                }else if(c_=="22"){
                    price = 239400;
                }else if(c_=="23"){
                    price = 244400;
                }else if(c_=="24"){
                    price = 249400;
                }
            }else if(zz_=="800"){
                if(c_=="3"){
                    price = 144910;
                }else if(c_=="4"){
                    price = 149910;
                }else if(c_=="5"){
                    price = 154910;
                }else if(c_=="6"){
                    price = 159910;
                }else if(c_=="7"){
                    price = 164910;
                }else if(c_=="8"){
                    price = 169910;
                }else if(c_=="9"){
                    price = 174910;
                }else if(c_=="10"){
                    price = 179910;
                }else if(c_=="11"){
                    price = 185910;
                }else if(c_=="12"){
                    price = 190910;
                }else if(c_=="13"){
                    price = 195910;
                }else if(c_=="14"){
                    price = 200910;
                }else if(c_=="15"){
                    price = 205910;
                }else if(c_=="16"){
                    price = 210910;
                }else if(c_=="17"){
                    price = 215910;
                }else if(c_=="18"){
                    price = 220910;
                }else if(c_=="19"){
                    price = 225910;
                }else if(c_=="20"){
                    price = 230910;
                }else if(c_=="21"){
                    price = 235910;
                }else if(c_=="22"){
                    price = 240910;
                }else if(c_=="23"){
                    price = 245910;
                }else if(c_=="24"){
                    price = 250910;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 152670;
                }else if(c_=="4"){
                    price = 157670;
                }else if(c_=="5"){
                    price = 162670;
                }else if(c_=="6"){
                    price = 167670;
                }else if(c_=="7"){
                    price = 172670;
                }else if(c_=="8"){
                    price = 177670;
                }else if(c_=="9"){
                    price = 182670;
                }else if(c_=="10"){
                    price = 187670;
                }else if(c_=="11"){
                    price = 192670;
                }else if(c_=="12"){
                    price = 197670;
                }else if(c_=="13"){
                    price = 202670;
                }else if(c_=="14"){
                    price = 208670;
                }else if(c_=="15"){
                    price = 213670;
                }else if(c_=="16"){
                    price = 218670;
                }else if(c_=="17"){
                    price = 223670;
                }else if(c_=="18"){
                    price = 228670;
                }else if(c_=="19"){
                    price = 233670;
                }else if(c_=="20"){
                    price = 238670;
                }else if(c_=="21"){
                    price = 243670;
                }else if(c_=="22"){
                    price = 248670;
                }else if(c_=="23"){
                    price = 253670;
                }else if(c_=="24"){
                    price = 258670;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 196350;
                }else if(c_=="4"){
                    price = 201280;
                }else if(c_=="5"){
                    price = 206170;
                }else if(c_=="6"){
                    price = 211060;
                }else if(c_=="7"){
                    price = 215950;
                }else if(c_=="8"){
                    price = 220840;
                }else if(c_=="9"){
                    price = 225730;
                }else if(c_=="10"){
                    price = 230630;
                }else if(c_=="11"){
                    price = 235520;
                }else if(c_=="12"){
                    price = 240410;
                }else if(c_=="13"){
                    price = 245300;
                }else if(c_=="14"){
                    price = 250190;
                }else if(c_=="15"){
                    price = 255090;
                }else if(c_=="16"){
                    price = 259980;
                }else if(c_=="17"){
                    price = 264780;
                }else if(c_=="18"){
                    price = 269760;
                }else if(c_=="19"){
                    price = 274650;
                }else if(c_=="20"){
                    price = 279540;
                }else if(c_=="21"){
                    price = 284440;
                }else if(c_=="22"){
                    price = 289330;
                }else if(c_=="23"){
                    price = 294220;
                }else if(c_=="24"){
                    price = 299110;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 203730;
                }else if(c_=="4"){
                    price = 208670;
                }else if(c_=="5"){
                    price = 213610;
                }else if(c_=="6"){
                    price = 218550;
                }else if(c_=="7"){
                    price = 223480;
                }else if(c_=="8"){
                    price = 228420;
                }else if(c_=="9"){
                    price = 233360;
                }else if(c_=="10"){
                    price = 238300;
                }else if(c_=="11"){
                    price = 243240;
                }else if(c_=="12"){
                    price = 248180;
                }else if(c_=="13"){
                    price = 253120;
                }else if(c_=="14"){
                    price = 258050;
                }else if(c_=="15"){
                    price = 262990;
                }else if(c_=="16"){
                    price = 267930;
                }else if(c_=="17"){
                    price = 272870;
                }else if(c_=="18"){
                    price = 277810;
                }else if(c_=="19"){
                    price = 282750;
                }else if(c_=="20"){
                    price = 287690;
                }else if(c_=="21"){
                    price = 292620;
                }else if(c_=="22"){
                    price = 297560;
                }else if(c_=="23"){
                    price = 302500;
                }else if(c_=="24"){
                    price = 307440;
                }
            }
        }else if(sd_=="1.75"){  //速度=1.75m/s
            if(zz_=="450"){
                if(c_=="4"){
                    price = 148900;
                }else if(c_=="5"){
                    price = 153900;
                }else if(c_=="6"){
                    price = 158900;
                }else if(c_=="7"){
                    price = 164900;
                }else if(c_=="8"){
                    price = 169900;
                }else if(c_=="9"){
                    price = 174900;
                }else if(c_=="10"){
                    price = 179900;
                }else if(c_=="11"){
                    price = 184900;
                }else if(c_=="12"){
                    price = 189900;
                }else if(c_=="13"){
                    price = 194900;
                }else if(c_=="14"){
                    price = 199900;
                }else if(c_=="15"){
                    price = 204900;
                }else if(c_=="16"){
                    price = 209900;
                }else if(c_=="17"){
                    price = 214900;
                }else if(c_=="18"){
                    price = 219900;
                }else if(c_=="19"){
                    price = 224900;
                }else if(c_=="20"){
                    price = 230900;
                }else if(c_=="21"){
                    price = 235900;
                }else if(c_=="22"){
                    price = 240900;
                }else if(c_=="23"){
                    price = 245900;
                }else if(c_=="24"){
                    price = 250900;
                }else if(c_=="25"){
                    price = 255900;
                }else if(c_=="26"){
                    price = 260900;
                }else if(c_=="27"){
                    price = 265900;
                }else if(c_=="28"){
                    price = 270900;
                }else if(c_=="29"){
                    price = 275900;
                }else if(c_=="30"){
                    price = 280900;
                }
            }else if(zz_=="630"){
                if(c_=="4"){
                    price = 151400;
                }else if(c_=="5"){
                    price = 156400;
                }else if(c_=="6"){
                    price = 161400;
                }else if(c_=="7"){
                    price = 167400;
                }else if(c_=="8"){
                    price = 172400;
                }else if(c_=="9"){
                    price = 177400;
                }else if(c_=="10"){
                    price = 182400;
                }else if(c_=="11"){
                    price = 187400;
                }else if(c_=="12"){
                    price = 192400;
                }else if(c_=="13"){
                    price = 197400;
                }else if(c_=="14"){
                    price = 202400;
                }else if(c_=="15"){
                    price = 207400;
                }else if(c_=="16"){
                    price = 212400;
                }else if(c_=="17"){
                    price = 217400;
                }else if(c_=="18"){
                    price = 222400;
                }else if(c_=="19"){
                    price = 227400;
                }else if(c_=="20"){
                    price = 233400;
                }else if(c_=="21"){
                    price = 238400;
                }else if(c_=="22"){
                    price = 243400;
                }else if(c_=="23"){
                    price = 248400;
                }else if(c_=="24"){
                    price = 253400;
                }else if(c_=="25"){
                    price = 258400;
                }else if(c_=="26"){
                    price = 263400;
                }else if(c_=="27"){
                    price = 268400;
                }else if(c_=="28"){
                    price = 273400;
                }else if(c_=="29"){
                    price = 278400;
                }else if(c_=="30"){
                    price = 283400;
                }
            }else if(zz_=="800"){
                if(c_=="4"){
                    price = 153910;
                }else if(c_=="5"){
                    price = 158910;
                }else if(c_=="6"){
                    price = 163910;
                }else if(c_=="7"){
                    price = 168910;
                }else if(c_=="8"){
                    price = 173910;
                }else if(c_=="9"){
                    price = 178910;
                }else if(c_=="10"){
                    price = 183910;
                }else if(c_=="11"){
                    price = 189910;
                }else if(c_=="12"){
                    price = 194910;
                }else if(c_=="13"){
                    price = 199910;
                }else if(c_=="14"){
                    price = 204910;
                }else if(c_=="15"){
                    price = 209910;
                }else if(c_=="16"){
                    price = 214910;
                }else if(c_=="17"){
                    price = 219910;
                }else if(c_=="18"){
                    price = 224910;
                }else if(c_=="19"){
                    price = 229910;
                }else if(c_=="20"){
                    price = 234910;
                }else if(c_=="21"){
                    price = 239910;
                }else if(c_=="22"){
                    price = 244910;
                }else if(c_=="23"){
                    price = 249910;
                }else if(c_=="24"){
                    price = 254910;
                }else if(c_=="25"){
                    price = 259910;
                }else if(c_=="26"){
                    price = 264910;
                }else if(c_=="27"){
                    price = 269910;
                }else if(c_=="28"){
                    price = 274910;
                }else if(c_=="29"){
                    price = 279910;
                }else if(c_=="30"){
                    price = 284910;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price = 161670;
                }else if(c_=="5"){
                    price = 166670;
                }else if(c_=="6"){
                    price = 171670;
                }else if(c_=="7"){
                    price = 176670;
                }else if(c_=="8"){
                    price = 181670;
                }else if(c_=="9"){
                    price = 186670;
                }else if(c_=="10"){
                    price = 191670;
                }else if(c_=="11"){
                    price = 196670;
                }else if(c_=="12"){
                    price = 201670;
                }else if(c_=="13"){
                    price = 206670;
                }else if(c_=="14"){
                    price = 212670;
                }else if(c_=="15"){
                    price = 217670;
                }else if(c_=="16"){
                    price = 222670;
                }else if(c_=="17"){
                    price = 227670;
                }else if(c_=="18"){
                    price = 232670;
                }else if(c_=="19"){
                    price = 237670;
                }else if(c_=="20"){
                    price = 242670;
                }else if(c_=="21"){
                    price = 247670;
                }else if(c_=="22"){
                    price = 252670;
                }else if(c_=="23"){
                    price = 257670;
                }else if(c_=="24"){
                    price = 262670;
                }else if(c_=="25"){
                    price = 267670;
                }else if(c_=="26"){
                    price = 272670;
                }else if(c_=="27"){
                    price = 277670;
                }else if(c_=="28"){
                    price = 282670;
                }else if(c_=="29"){
                    price = 287670;
                }else if(c_=="30"){
                    price = 292670;
                }
            }else if(zz_=="1350"){
                if(c_=="4"){
                    price = 207310;
                }else if(c_=="5"){
                    price = 212170;
                }else if(c_=="6"){
                    price = 217030;
                }else if(c_=="7"){
                    price = 221900;
                }else if(c_=="8"){
                    price = 226760;
                }else if(c_=="9"){
                    price = 231620;
                }else if(c_=="10"){
                    price = 236480;
                }else if(c_=="11"){
                    price = 241350;
                }else if(c_=="12"){
                    price = 246210;
                }else if(c_=="13"){
                    price = 251070;
                }else if(c_=="14"){
                    price = 255930;
                }else if(c_=="15"){
                    price = 260790;
                }else if(c_=="16"){
                    price = 265660;
                }else if(c_=="17"){
                    price = 270520;
                }else if(c_=="18"){
                    price = 275380;
                }else if(c_=="19"){
                    price = 280240;
                }else if(c_=="20"){
                    price = 285100;
                }else if(c_=="21"){
                    price = 289970;
                }else if(c_=="22"){
                    price = 294830;
                }else if(c_=="23"){
                    price = 299690;
                }else if(c_=="24"){
                    price = 304550;
                }else if(c_=="25"){
                    price = 309420;
                }else if(c_=="26"){
                    price = 314280;
                }else if(c_=="27"){
                    price = 319140;
                }else if(c_=="28"){
                    price = 324000;
                }else if(c_=="29"){
                    price = 328860;
                }else if(c_=="30"){
                    price = 333730;
                }
            }else if(zz_=="1600"){
                if(c_=="4"){
                    price = 212570;
                }else if(c_=="5"){
                    price = 217530;
                }else if(c_=="6"){
                    price = 222500;
                }else if(c_=="7"){
                    price = 227470;
                }else if(c_=="8"){
                    price = 232440;
                }else if(c_=="9"){
                    price = 237410;
                }else if(c_=="10"){
                    price = 242380;
                }else if(c_=="11"){
                    price = 247350;
                }else if(c_=="12"){
                    price = 252320;
                }else if(c_=="13"){
                    price = 257390;
                }else if(c_=="14"){
                    price = 262260;
                }else if(c_=="15"){
                    price = 267230;
                }else if(c_=="16"){
                    price = 272190;
                }else if(c_=="17"){
                    price = 277160;
                }else if(c_=="18"){
                    price = 282130;
                }else if(c_=="19"){
                    price = 287100;
                }else if(c_=="20"){
                    price = 292070;
                }else if(c_=="21"){
                    price = 297040;
                }else if(c_=="22"){
                    price = 302010;
                }else if(c_=="23"){
                    price = 306980;
                }else if(c_=="24"){
                    price = 311950;
                }else if(c_=="25"){
                    price = 316920;
                }else if(c_=="26"){
                    price = 321890;
                }else if(c_=="27"){
                    price = 326850;
                }else if(c_=="28"){
                    price = 331820;
                }else if(c_=="29"){
                    price = 336790;
                }else if(c_=="30"){
                    price = 341760;
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
        var price = parseInt($("#FEIYANGMRL_SBJ").val());
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
                }
            }
            $("#SBJ_TEMP").val(price);
            countZhj();
        }
    }

    //修改载重时
    function editZz(){
        var zz_ = $("#BZ_ZZ").val();
        var kmkd_ = $("#BZ_KMKD").val();

        if(zz_=="450"){ //载重450时
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='450D-1000×1200'>450D-1000×1200</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='800'>800</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='700mm×2100mm(450kg-630kg)'>700mm×2100mm(450kg-630kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");

        }else if(zz_=="630"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='630D-1100×1400'>630D-1100×1400</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='800'>800</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='700mm×2100mm(450kg-630kg)'>700mm×2100mm(450kg-630kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");

        }else if(zz_=="800"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='800D-1350×1400'>800D-1350×1400</option>");
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
            $("#BASE_JXGG").append("<option value='1000W-1600×1400'>1000W-1600×1400</option><option value='1000D-1100×2100担架梯'>1000D-1100×2100担架梯</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='900'>900</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='900mm×2100mm(1000kg)'>900mm×2100mm(1000kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");
        }else if(zz_=="1350"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1350W-2000×1500'>1350W-2000×1500</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1100'>1100</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='1100mm×2100mm(1350kg)'>1100mm×2100mm(1350kg)</option>");
            //修改轿厢总高
             $(":radio[name='BASE_JXGD'][value='2500']").prop("checked", "checked");
        }else if(zz_=="1600"){
            //修改轿厢规格
            $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1600W-2000×1700'>1600W-2000×1700</option>");
            //修改开门宽度
            $("#BZ_KMKD").empty();
            $("#BZ_KMKD").append("<option value='1100'>1100</option>");
            //修改开门尺寸
            $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value='1100mm×2100mm(1600kg)'>1100mm×2100mm(1600kg)</option>");
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
        }
    }

    //修改(层站)门
    function editM(){
        var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
        var c_ = parseInt($("#BZ_C").val());    //层
        var m_ = parseInt($("#BZ_M").val());    //门
        var price = 0;
        if(kmkd_=="900"){
            price = (c_-m_)*2400;
        }else if(kmkd_=="1500"){
            price = (c_-m_)*4300;
        }else if(kmkd_=="2000"){
            price = (c_-m_)*5800;
        }
    }

    function countZhj(){
        var zhj_count = 0;
        var sbj_count = 0;
        var base_jdzg_temp = $("#BASE_JDZG_TEMP").val()==""?0:parseInt($("#BASE_JDZG_TEMP").val());
        var base_dgzj_temp = $("#BASE_DGZJ_TEMP").val()==""?0:parseInt($("#BASE_DGZJ_TEMP").val());
        var opt_hjzdfhjz_temp = $("#OPT_HJZDFHJZ_TEMP").val()==""?0:parseInt($("#OPT_HJZDFHJZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt($("#OPT_CCTVDL_TEMP").val());
        var opt_tdjjjy_temp = $("#OPT_TDJJJY_TEMP").val()==""?0:parseInt($("#OPT_TDJJJY_TEMP").val());
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt($("#OPT_DJGRBH_TEMP").val());
        var opt_kqjhzz_temp = $("#OPT_KQJHZZ_TEMP").val()==""?0:parseInt($("#OPT_KQJHZZ_TEMP").val());
        var opt_nmykjan_temp = $("#OPT_NMYKJAN_TEMP").val()==""?0:parseInt($("#OPT_NMYKJAN_TEMP").val());
        var opt_fdlcz_temp = $("#OPT_FDLCZ_TEMP").val()==""?0:parseInt($("#OPT_FDLCZ_TEMP").val());
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
        var opt_jfgt_temp = $("#OPT_JFGT_TEMP").val()==""?0:parseInt($("#OPT_JFGT_TEMP").val());
        var opt_djt_temp = $("#OPT_DJT_TEMP").val()==""?0:parseInt($("#OPT_DJT_TEMP").val());
        var dzjksdjxt_djts_temp = $("#DZJKSDJXT_DJTS_TEMP").val()==""?0:parseInt($("#DZJKSDJXT_DJTS_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt($("#JXZH_JM_TEMP").val());
        var jxzh_jmzh_temp = $("#JXZH_JMZH_TEMP").val()==""?0:parseInt($("#JXZH_JMZH_TEMP").val());
        var jxzh_jxzh_temp = $("#JXZH_JXZH_TEMP").val()==""?0:parseInt($("#JXZH_JXZH_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt($("#JXZH_QWB_TEMP").val());
        var jxzh_cwb_temp = $("#JXZH_CWB_TEMP").val()==""?0:parseInt($("#JXZH_CWB_TEMP").val());
        var jxzh_hwb_temp = $("#JXZH_HWB_TEMP").val()==""?0:parseInt($("#JXZH_HWB_TEMP").val());
        var jxzh_zsdd_temp = $("#JXZH_ZSDD_TEMP").val()==""?0:parseInt($("#JXZH_ZSDD_TEMP").val());
        var jxzh_aqc_temp = $("#JXZH_AQC_TEMP").val()==""?0:parseInt($("#JXZH_AQC_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt($("#JXZH_BGJ_TEMP").val());
        var jxzh_ylzhzl_temp = $("#JXZH_YLZHZL_TEMP").val()==""?0:parseInt($("#JXZH_YLZHZL_TEMP").val());
        var jxzh_fsxh_temp = $("#JXZH_FSXH_TEMP").val()==""?0:parseInt($("#JXZH_FSXH_TEMP").val());
        var jxzh_fsazwz_temp = $("#JXZH_FSAZWZ_TEMP").val()==""?0:parseInt($("#JXZH_FSAZWZ_TEMP").val());
        var tmmt_fwbxgxmt_temp = $("#TMMT_FWBXGXMT_TEMP").val()==""?0:parseInt($("#TMMT_FWBXGXMT_TEMP").val());
        var tmmt_ptdmt_temp = $("#TMMT_PTDMT_TEMP").val()==""?0:parseInt($("#TMMT_PTDMT_TEMP").val());
        var tmmt_ptjmbxgtm_temp = $("#TMMT_PTJMBXGTM_TEMP").val()==""?0:parseInt($("#TMMT_PTJMBXGTM_TEMP").val());
        var tmmt_sctmmt_temp = $("#TMMT_SCTMMT_TEMP").val()==""?0:parseInt($("#TMMT_SCTMMT_TEMP").val());
        var tmmt_fsctmmt_temp = $("#TMMT_FSCTMMT_TEMP").val()==""?0:parseInt($("#TMMT_FSCTMMT_TEMP").val());
        var czp_czpxh_temp = $("#CZP_CZPXH_TEMP").val()==""?0:parseInt($("#CZP_CZPXH_TEMP").val());
        var tmxhzz_cz_temp = $("#TMXHZZ_CZ_TEMP").val()==""?0:parseInt($("#TMXHZZ_CZ_TEMP").val());
        var tmxhzz_wzycopmwan_temp = $("#TMXHZZ_WZYCOPMWAN_TEMP").val()==""?0:parseInt($("#TMXHZZ_WZYCOPMWAN_TEMP").val());

        zhj_count = jxzh_jm_temp+jxzh_jmzh_temp+jxzh_jxzh_temp+jxzh_qwb_temp+jxzh_cwb_temp+jxzh_hwb_temp+jxzh_zsdd_temp+jxzh_aqc_temp+jxzh_bgj_temp+jxzh_ylzhzl_temp+jxzh_fsxh_temp+jxzh_fsazwz_temp;
        $("#FEIYANGMRL_ZHJ").val(zhj_count);

        sbj_count = base_jdzg_temp+base_dgzj_temp+opt_hjzdfhjz_temp+opt_cctvdl_temp+opt_tdjjjy_temp+opt_djgrbh_temp+opt_kqjhzz_temp+opt_nmykjan_temp+opt_fdlcz_temp+opt_bajk_temp+opt_yybz_temp+opt_dzyx_temp+opt_nlhk_temp+opt_ycjk_temp+opt_ick_temp+opt_ickzksb_temp+opt_ickkp_temp+opt_ptdtkt_temp+opt_zyftsdtkt_temp+opt_jkgm_temp+opt_jkyyj_temp+opt_gtmjxjmbf_temp+opt_gtmtmbf+opt_cmzh_temp+opt_jfgt_temp+opt_djt_temp+tmmt_fwbxgxmt_temp+tmmt_ptdmt_temp+tmmt_ptjmbxgtm_temp+tmmt_sctmmt_temp+tmmt_fsctmmt_temp+czp_czpxh_temp+tmxhzz_cz_temp+tmxhzz_wzycopmwan_temp;
        //设备标准价格
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#FEIYANGMRL_SBJ").val(sbj_temp+sbj_count);

        //运输费
        var feiyangmrl_ysf = $("#FEIYANGMRL_YSF").val()==""?0:parseInt($("#FEIYANGMRL_YSF").val());
        $("#FEIYANGMRL_YSF").val(feiyangmrl_ysf);
        //安装费
        var feiyangmrl_azf = $("#FEIYANGMRL_AZF_TEMP").val()==""?0:parseInt($("#FEIYANGMRL_AZF_TEMP").val());
        $("#FEIYANGMRL_AZF").val(feiyangmrl_azf);

        var feiyangmrl_zk = parseFloat($("#FEIYANGMRL_ZK").val())/100;
        if(!isNaN(feiyangmrl_zk)){
            var feiyangmrl_sbj = parseInt($("#SBJ_TEMP").val());
            var feiyangmrl_sjbj = (feiyangmrl_sbj+zhj_count+sbj_count+feiyangmrl_ysf+feiyangmrl_azf)*feiyangmrl_zk;
            var feiyangmrl_zhsbj = feiyangmrl_sbj*feiyangmrl_zk;
            $("#FEIYANGMRL_SJBJ").val(feiyangmrl_sjbj);
            $("#FEIYANGMRL_ZHSBJ").val(feiyangmrl_zhsbj);
            $("#zk_").text($("#FEIYANGMRL_ZK").val()+"%");
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
            if(zz_=="450"||zz_=="630"||zz_=="800"||zz_=="1000"){
                if(sd_=="1"){
                    K = 4000;
                    S = 1400;
                }else if(sd_=="1.5"){
                    if(jxgd_=="2400"){
                        K = 4150;
                    }else if(jxgd_=="2500"){
                        K = 4250;
                    }
                    S = 1450;
                }else if(sd_=="1.75"){
                    if(jxgd_=="2400"){
                        K = 4250;
                    }else if(jxgd_=="2500"){
                        K = 4350;
                    }
                    S = 1500;
                }
            }else if(zz_=="1350"){
                if(sd_=="1"){
                    K = 4100;
                    S = 1500;
                }else if(sd_=="1.5"){
                    K = 4200;
                    S = 1600;
                }else if(sd_=="1.75"){
                    K = 4300;
                    S = 1700;
                }
            }else if(zz_=="1600"){
                if(sd_=="1"){
                    K = 4100;
                    S = 1500;
                }else if(sd_=="1.5"){
                    K = 4200;
                    S = 1600;
                }else if(sd_=="1.75"){
                    K = 4300;
                    S = 1700;
                }
            }
            var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            if(zz_=="450"||zz_=="630"||zz_=="800"){
                price = 1000*((jdzg_-jdzg_std)/100);
            }else if(zz_=="1000"){
                price = 1100*((jdzg_-jdzg_std)/100);
            }else if(zz_=="1350"||zz_=="1600"){
                price = 1300*((jdzg_-jdzg_std)/100);
            }

            //计算导轨支架标准档数
            var dgzj_std = Math.ceil((jdzg_std/2000)+1);
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
            if(zz_=="450"||zz_=="630"||zz_=="800"||zz_=="1000"){
                if(sd_=="1"){
                    K = 4000;
                    S = 1400;
                }else if(sd_=="1.5"){
                    if(jxgd_=="2400"){
                        K = 4150;
                    }else if(jxgd_=="2500"){
                        K = 4250;
                    }
                    S = 1450;
                }else if(sd_=="1.75"){
                    if(jxgd_=="2400"){
                        K = 4250;
                    }else if(jxgd_=="2500"){
                        K = 4350;
                    }
                    S = 1500;
                }
            }else if(zz_=="1350"){
                if(sd_=="1"){
                    K = 4100;
                    S = 1500;
                }else if(sd_=="1.5"){
                    K = 4200;
                    S = 1600;
                }else if(sd_=="1.75"){
                    K = 4300;
                    S = 1700;
                }
            }else if(zz_=="1600"){
                if(sd_=="1"){
                    K = 4100;
                    S = 1500;
                }else if(sd_=="1.5"){
                    K = 4200;
                    S = 1600;
                }else if(sd_=="1.75"){
                    K = 4300;
                    S = 1700;
                }
            }
            jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            dgzj_std = (jdzg_std/2000)+1;
            var price = (dgzj_-dgzj_std)*310;
            $("#BASE_DGZJ_TEMP").val(price);
            //放入价格
            countZhj();
        }
    }

    //可选功能部分加价
    function editOpt(option){
        //数量
        var sl_ = $("#FEIYANGMRL_SL").val()==""?0:parseInt($("#FEIYANGMRL_SL").val());
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
        }else if(option=="OPT_CCTVDL"){
            //CCTV电缆
            if($("#OPT_CCTVDL_TEXT").is(":checked")){
                price = 200*sl_;
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
                if(!isNaN(parseInt($("#BASE_TSGD").val()))){
                    var tsgd_ = parseInt($("#BASE_TSGD").val());  //提升高度
                    price = 17*(tsgd_+15)*sl_;
                }
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
        }else if(option=="OPT_FDLCZ"){
            //防捣乱操作
            if($("#OPT_FDLCZ_TEXT").is(":checked")){
                price = 130*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FDLCZ_TEMP").val(price);
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
            if($("#OPT_ICK_TEXT").val()=="刷卡后手动选择到达楼层"){
                price = 1920;
            }else if($("#OPT_ICK_TEXT").val()=="刷卡后自动选择到达楼层"){
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
            if(!isNaN(parseInt($("#OPT_ICKKP_TEXT").val()))){
                price = parseInt($("#OPT_ICKKP_TEXT").val())*12;
            }else{
                price = 0;
            }
            $("#OPT_ICKKP_TEMP").val(price);
        }else if(option=="OPT_PTDTKT"){
            //普通电梯空调
            if($("#OPT_PTDTKT_TEXT").val()=="单冷型2200W"){
                price = 12000;
            }else if($("#OPT_PTDTKT_TEXT").val()=="冷暖型1500W"){
                price = 13200;
            }else{
                price = 0;
            }
            $("#OPT_PTDTKT_TEMP").val(price);
        }else if(option=="OPT_ZYFTSDTKT"){
            //专用分体式电梯空调
            if($("#OPT_ZYFTSDTKT_TEXT").val()=="单冷型2200W"){
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
                if(zz_=="450"||zz_=="630"||zz_=="800"||zz_=="1000"){
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
                if(zz_=="450"||zz_=="630"||zz_=="800"){
                    price = 13000*sl_;
                }else if(zz_=="1000"){
                    price = 13900*sl_;
                }else if(zz_=="1350"||zz_=="1600"){
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
                if(zz_=="450"||zz_=="630"||zz_=="800"){
                    price = 3250*sl_;
                }else if(zz_=="1000"){
                    price = 3800*sl_;
                }else if(zz_=="1350"||zz_=="1600"){
                    price = 4500*sl_
                }else{
                    price = 0;
                }    
            }else if($("#OPT_GTMTMBF_TEXT").val()=="喷涂"){
                if(zz_=="450"||zz_=="630"||zz_=="800"){
                    price = 2100*sl_;
                }else if(zz_=="1000"){
                    price = 2400*sl_;
                }else if(zz_=="1350"||zz_=="1600"){
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
        }else if(option=="OPT_JFGT"){
            //500mm<机房高台<=2000mm
            if($("#OPT_JFGT_TEXT").is(":checked")){
                price = 410*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JFGT_TEMP").val(price);
        }else if(option=="OPT_DJT"){
            //担架梯
            if($("#OPT_DJT_TEXT").is(":checked")){
                price = 2000*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DJT_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }


    //单组监控室对讲系统-加价
    function editDzjksdjxt(){
        var sl_ = parseInt($("#FEIYANGMRL_SL").val());
        var price = 0;
        if(sl_<10){
            var djts_ = parseInt($('#DZJKSDJXT_DJTS').val());
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
        var sl_ = $("#FEIYANGMRL_SL").val()==""?0:parseInt($("#FEIYANGMRL_SL").val());
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
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
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
                if(zz_=="450"){
                    price = -4700*sl_;
                }else if(zz_=="630"){
                    price = -4900*sl_;
                }else if(zz_=="800"){
                    price = -5400*sl_;
                }else if(zz_=="1000"){
                    price = -5700*sl_;
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
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
                if(zz_=="450"){
                    price = -4700*sl_;
                }else if(zz_=="630"){
                    price = -4900*sl_;
                }else if(zz_=="800"){
                    price = -5400*sl_;
                }else if(zz_=="1000"){
                    price = -5700*sl_;
                }else if(zz_=="1350"){
                    price = -7300*sl_;
                }else if(zz_=="1600"){
                    price = -7700*sl_;
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
                }
            }
            $("#JXZH_ZSDD_TEMP").val(price);
        }else if(option=="JXZH_AQC"){
            //安全窗
            var aqc_ = $("input[name='JXZH_AQC']:checked").val();
            if(aqc_=="有"){
                price = 1200;
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
                    price = 950;
                }else if(zz_=="630"){
                    price = 980;
                }else if(zz_=="800"){
                    price = 1300;
                }else if(zz_=="1000"){
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
        }else if(option=="JXZH_YLZHZL"){
            //预留装潢重量
            var ylzhzl_ = parseInt($("#JXZH_YLZHZL").val());
            var zz_ = $("#BZ_ZZ").val();  //载重
            if(ylzhzl_<=200){
                if(zz_=="450"){
                    price = 650;
                }else if(zz_=="630"){
                    price = 730;
                }else if(zz_=="800"){
                    price = 900
                }else if(zz_=="1000"){
                    price = 1100;
                }
            }else if(ylzhzl_<=250){
                if(zz_=="1350"){
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
        var sl_ = $("#FEIYANGMRL_SL").val()==""?0:parseInt($("#FEIYANGMRL_SL").val());
        //价格
        var price = 0;
        if(option=="TMMT_FWBXGXMT"){
            //发纹不锈钢小门套
            if($("#TMMT_FWBXGXMT_TEXT").is(":checked")){
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
            $("#TMMT_FWBXGXMT_TEMP").val(price);
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
            }else if(ptdmt_=="发纹不锈钢"){
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
        var sl_ = parseInt($("#FEIYANGMRL_SL").val());
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
        var sl_ = $("#FEIYANGMRL_SL").val();
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
                        $("#FEIYANGMRL_YSF").val(transPrice);
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
                        $("#FEIYANGMRL_YSF").val(transPrice);
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
        if($("#OPT_DJT_TEXT").is(":checked")){
            $("#OPT_DJT").val("1");
        }else{
            $("#OPT_DJT").val("0");
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

        $("#feiyang3000mrlForm").submit();
    }
</script>
</body>

</html>
