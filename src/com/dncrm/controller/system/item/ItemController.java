package com.dncrm.controller.system.item;

import com.dncrm.controller.base.BaseController;
import com.dncrm.controller.system.message.MessageController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.city.CityService;
import com.dncrm.service.system.customer.CustomerService;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.elevatorInfo.ElevatorInfoService;
import com.dncrm.service.system.item.ElevatorService;
import com.dncrm.service.system.item.ElevatorSpecService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.message.MessageService;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.modelsInfo.ModelsInfoService;
import com.dncrm.service.system.offer.OfferService;
import com.dncrm.service.system.position.PositionService;
import com.dncrm.service.system.productInfo.ProductInfoService;
import com.dncrm.service.system.role.RoleService;
import com.dncrm.service.system.sysAgent.SysAgentService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.Const;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.SelectByRole;
import com.dncrm.util.SelectNode;
import com.dncrm.util.echarts.Echarts;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import com.github.abel533.echarts.json.GsonOption;
import com.mysql.fabric.xmlrpc.base.Array;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("/item")
@Controller
public class ItemController extends BaseController {
	@Resource(name="itemService")
	private ItemService itemService;
	@Resource(name="customerService")
	private CustomerService customerService;
	@Resource(name="sysUserService")
	private sysUserService sysUserService;
	@Resource(name="elevatorService")
	private ElevatorService elevatorService;
	@Resource(name="positionService")
	private PositionService positionService;
	@Resource(name="departmentService")
	private DepartmentService departmentService;
	@Resource(name="messageService")
	private MessageService messageService;
	@Resource(name="productInfoService")
	private ProductInfoService productInfoService;
	@Resource(name="offerService")
	private OfferService offerService;
	@Resource(name="roleService")
	private RoleService roleService;
	@Resource(name="cityService")
	private CityService cityService;
	@Resource(name="sysAgentService")
	private SysAgentService sysAgentService;
	@Resource(name="modelsService")
	private ModelsService modelsService;
	@Resource(name="modelsInfoService")
	private ModelsInfoService modelsInfoService;
	@Resource(name="elevatorInfoService")
	private ElevatorInfoService elevatorInfoService;
	
	
    //保存所有父节点
    private List<PageData> parentDepartments = new ArrayList<PageData>();
	
	/**
	 *显示列表 
	 * @throws Exception 
	 */
	@RequestMapping(value="listItem")
	public ModelAndView listItem(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		SelectByRole sbr = new SelectByRole();
		PageData pd = this.getPageData();
		//将当前登录人添加至列表查询条件
		pd.put("input_user", getUser().getUSER_ID());
		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
		pd.put("userList", userList);
        page.setPd(pd);
        try{
			/*List<PageData> itemList = itemService.listPageAllItem(page);*/
        	List<PageData> itemList = itemService.listPageAllItemByRole(page);
			mv.setViewName("system/item/item_list");
			mv.addObject("itemList",itemList);
			mv.addObject("pd",pd);
			mv.addObject("page",page);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        }catch(Exception e){
        	logger.error(e.getMessage(),e);
        }
		return mv;
	}
	
	/**
	 *跳转至新增页面 
	 * @throws Exception 
	 */
	@RequestMapping(value="goAddItem")
	public ModelAndView goAddItem() throws Exception{
		ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        //加载客户信息-用于最终用户
        List<PageData> customerList = customerService.findCustomerInfo();
        if(customerList.size()==0){
        	mv.addObject("showAddEndUser", true);
        }
        mv.addObject("customerList",customerList);
        //加载用户信息-用于项目负责人
        List<PageData> userList = sysUserService.findUserInfo();
        mv.addObject("userList", userList);
        //加载电梯信息
        List<PageData> elevatorList = elevatorService.findAllElevator();
        mv.addObject("elevatorList", elevatorList);
		//加载省份
		List<PageData> provinceList=cityService.findAllProvince();
		mv.addObject("provinceList", provinceList);
		//加载城市
		List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
		mv.addObject("cityList", cityList);
		//加载郡县
		List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
		mv.addObject("coundtyList", coundtyList);
		
		//加载区域列表
        List<PageData> area = departmentService.findAllAreaNode();
		//获取所有区域节点和父级节点
        List<PageData> areas = getAreaLists(area);
        if (areas.size() > 0) {
            //构建多叉数
            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
            MultipleTree tree = new MultipleTree();
            dataList = ConvertPageDataToList.make(areas);
            Node node = tree.makeTreeWithOderNo(dataList, 1);
            mv.addObject("areas", node);
        }else{
        	mv.addObject("areas", areas);
        }
        parentDepartments.clear();
        SelectNode sn = new SelectNode();
        PageData areaPd = sn.findNode(getUser().getUSER_ID(), "8");
        PageData branchPd = sn.findNode(getUser().getUSER_ID(), "10");
        mv.addObject("areaId", areaPd.containsKey("id")?areaPd.get("id").toString():"");
        mv.addObject("areaName", areaPd.containsKey("name")?areaPd.get("name").toString():"");
        mv.addObject("branchId", branchPd.containsKey("id")?branchPd.get("id").toString():"");
        mv.addObject("branchName", branchPd.containsKey("name")?branchPd.get("name").toString():"");
        mv.setViewName("system/item/item_edit");
        mv.addObject("msg", "saveItem");
        mv.addObject("input_user",getUser().getUSER_ID());
        mv.addObject("operateType","add");
        mv.addObject("pd", pd);
        return mv;
	}
	
	
	/**
	 *跳转至修改页面 
	 */
	@RequestMapping(value="goEditItem")
	public ModelAndView goEditItem(){
		ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try{
        	pd = this.getPageData();
        	String operateType = pd.get("operateType").toString();
        	//加载项目报备信息
        	pd = itemService.findItemAndAddressById(pd);
            //加载客户信息-用于最终用户
            List<PageData> customerList = customerService.findCustomerInfo();
            mv.addObject("customerList",customerList);
            //加载用户信息-用于项目负责人
            List<PageData> userList = sysUserService.findUserInfo();
            mv.addObject("userList", userList);
            //加载负责人职位信息
            List<PageData>positionList = positionService.listAllPositions();
            mv.addObject("positionList", positionList);
            //加载电梯信息
            List<PageData> elevatorList = elevatorService.findAllElevator();
            mv.addObject("elevatorList", elevatorList);
            //加载电梯json
            /*List<PageData> elevatorInfoPdList = elevatorInfoService.findElevatorInfoListById(pd);
            String jsonStr = "[";
            for(PageData elevatorInfoPd : elevatorInfoPdList){
            	jsonStr += "{'elevatorType':'"+(elevatorInfoPd.containsKey("elevator_id")?elevatorInfoPd.get("elevator_id").toString():"")+"','elevatorModel':'"+(elevatorInfoPd.containsKey("models_id")?elevatorInfoPd.get("models_id"):"")+"','elevatorNum':'"+(elevatorInfoPd.containsKey("num")?elevatorInfoPd.get("num").toString():"")+"'},";
            	
            }
            jsonStr = jsonStr.substring(0,jsonStr.length()-1)+"]";
            pd.put("elevator_info", jsonStr);*/
            pd.put("elevatorInfo", pd.getString("elevator_info"));
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			mv.addObject("cityList", cityList);
			//加载郡县
			List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
			mv.addObject("coundtyList", coundtyList);
			//加载区域列表
	        List<PageData> area = departmentService.findAllAreaNode();
			//获取所有区域节点和父级节点
	        List<PageData> areas = getAreaLists(area);
	        if (areas.size() > 0) {
	            //构建多叉数
	            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
	            MultipleTree tree = new MultipleTree();
	            dataList = ConvertPageDataToList.make(areas);
	            Node node = tree.makeTreeWithOderNo(dataList, 1);
	            mv.addObject("areas", node);
	        }else{
	        	mv.addObject("areas", areas);
	        }
	        parentDepartments.clear();
            
            mv.setViewName("system/item/item_edit");
            mv.addObject("msg", "editItem");
            mv.addObject("input_user",getUser().getUSER_ID());
            mv.addObject("operateType",operateType);
            mv.addObject("pd", pd);
        }catch(Exception e){
        	logger.error(e.getMessage(),e);
        }
        return mv;
	}
	
	/**
	 *保存新增 
	 */
	@RequestMapping(value="saveItem")
	public ModelAndView saveItem(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		PageData addressPd = new PageData();
		try{
			String item_id = get32UUID();
			pd = this.getPageData();
        	//放入添加操作人
        	pd.put("input_user", getUser().getUSER_ID());
			//放入主键id
        	pd.put("item_id", item_id);
        	//放入生成编号
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        	String item_no = "DN"+"I"+sdf.format(new Date()).toString()+((int)((Math.random()*9+1)*100000)+"");
        	pd.put("item_no", item_no);
			//处理最终用户字符串
			String end_user = pd.containsKey("end_user")?pd.get("end_user").toString():"";
			pd.put("end_user", end_user.substring(0, end_user.lastIndexOf("_")));
			
			//将电梯信息插入tb_elevator_info表;
			/*PageData elevatorInfoPd = new PageData();
			String elevatorJsonStr = pd.get("elevator_info").toString();
			JSONArray jsonArray = JSONArray.fromObject(elevatorJsonStr);
			for(int i =0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				for(int j=0;j<jsonObj.getInt("elevatorNum");j++){
					elevatorInfoPd.put("item_id", item_id);
					elevatorInfoPd.put("elevator_id", jsonObj.get("elevatorType").toString());
					elevatorInfoPd.put("models_id", jsonObj.get("elevatorModel").toString());
					elevatorInfoPd.put("num", jsonObj.get("elevatorNum").toString());
					elevatorInfoPd.put("num", "1");//改为1台梯1行数据
					elevatorInfoPd.put("total", "0");
					elevatorInfoPd.put("flag", "1");
					elevatorInfoService.elevatorInfoAdd(elevatorInfoPd);
				}
			}*/
			
			//更新tb_elevator_details
			updateElevatorDetails(pd);
			
			//处理地址
			//1:项目安装地址 item_address
			addressPd.put("province_id", pd.get("province_id1")==null?"":pd.get("province_id1").toString());
			addressPd.put("city_id", pd.get("city_id1")==null?"":pd.get("city_id1").toString());
			addressPd.put("county_id", pd.get("county_id1")==null?"":pd.get("county_id1").toString());
			addressPd.put("address_info", pd.get("address_info1")==null?"":pd.get("address_info1").toString());
			addressPd.put("address_name", pd.get("address_name1")==null?"":pd.get("address_name1").toString());
			itemService.saveItemAddress(addressPd);
			pd.put("item_install_address", addressPd.get("id").toString());
			//2:设计院地址 design_address
			addressPd.clear();
			addressPd.put("province_id", pd.get("province_id2")==null?"":pd.get("province_id2").toString());
			addressPd.put("city_id", pd.get("city_id2")==null?"":pd.get("city_id2").toString());
			addressPd.put("county_id", pd.get("county_id2")==null?"":pd.get("county_id2").toString());
			addressPd.put("address_info", pd.get("address_info2")==null?"":pd.get("address_info2").toString());
			addressPd.put("address_name", pd.get("address_name2")==null?"":pd.get("address_name2").toString());
			itemService.saveItemAddress(addressPd);
			pd.put("design_address", addressPd.get("id").toString());
			//3:项目地址 item_address
			addressPd.clear();
			addressPd.put("province_id", pd.get("province_id3")==null?"":pd.get("province_id3").toString());
			addressPd.put("city_id", pd.get("city_id3")==null?"":pd.get("city_id3").toString());
			addressPd.put("county_id", pd.get("county_id3")==null?"":pd.get("county_id3").toString());
			addressPd.put("address_info", pd.get("address_info3")==null?"":pd.get("address_info3").toString());
			addressPd.put("address_name", pd.get("address_name3")==null?"":pd.get("address_name3").toString());
			itemService.saveItemAddress(addressPd);
			pd.put("item_address", addressPd.get("id").toString());
        	itemService.saveItem(pd);
        	
            //保存完成之后检测该项目是否需要抄送通知
            //加载抄送通知配置
            List<PageData> itemReportPdList = itemService.findItemReportConfig();
            for(PageData itemReportPd: itemReportPdList){
                String positionId = itemReportPd.containsKey("position")?itemReportPd.get("position").toString():"";
                String content = itemReportPd.containsKey("content")?itemReportPd.get("content").toString():"";
                String send_id = getUser().getUSER_ID();
                //根据职位id取到用户
                HashSet<String> userIds = sysUserService.getUserIdByPosition(positionId);
                for(String recv_id : userIds){
                	//发送信息
                	messageService.sendMesAction(send_id, recv_id, content);
                }
            }
        	mv.addObject("msg","success");
            mv.addObject("id", "EditItem");
            mv.addObject("form", "ItemForm");
            mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}
		return mv;
	}
	
	
	/**
	 *保存修改 
	 */
	@RequestMapping(value="editItem")
	public ModelAndView editItem(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		PageData addressPd = new PageData();
		try{
			pd = this.getPageData();
			String item_id = pd.get("item_id").toString();
			//处理地址
			//查询项目的4个地址id
			PageData addressIdPd = itemService.findAddressIdByItemId(pd);
			if(addressIdPd.get("address1")!=null&&!addressIdPd.get("address1").toString().equals("")){
				addressPd.clear();
				addressPd.put("id", addressIdPd.get("address1").toString());
				addressPd.put("province_id", pd.get("province_id1")==null?"":pd.get("province_id1").toString());
				addressPd.put("city_id", pd.get("city_id1")==null?"":pd.get("city_id1").toString());
				addressPd.put("county_id", pd.get("county_id1")==null?"":pd.get("county_id1").toString());
				addressPd.put("address_info", pd.get("address_info1")==null?"":pd.get("address_info1").toString());
				addressPd.put("address_name", pd.get("address_name1")==null?"":pd.get("address_name1").toString());
				itemService.editItemAddressById(addressPd);
			}else{
				addressPd.clear();
				addressPd.put("province_id", pd.get("province_id1")==null?"":pd.get("province_id1").toString());
				addressPd.put("city_id", pd.get("city_id1")==null?"":pd.get("city_id1").toString());
				addressPd.put("county_id", pd.get("county_id1")==null?"":pd.get("county_id1").toString());
				addressPd.put("address_info", pd.get("address_info1")==null?"":pd.get("address_info1").toString());
				addressPd.put("address_name", pd.get("address_name1")==null?"":pd.get("address_name1").toString());
				itemService.saveItemAddress(addressPd);
				pd.put("item_address", addressPd.get("id").toString());
			}
			if(addressIdPd.get("address2")!=null&&!addressIdPd.get("address2").toString().equals("")){
				addressPd.clear();
				addressPd.put("id", addressIdPd.get("address2").toString());
				addressPd.put("province_id", pd.get("province_id2")==null?"":pd.get("province_id2").toString());
				addressPd.put("city_id", pd.get("city_id2")==null?"":pd.get("city_id2").toString());
				addressPd.put("county_id", pd.get("county_id2")==null?"":pd.get("county_id2").toString());
				addressPd.put("address_info", pd.get("address_info2")==null?"":pd.get("address_info2").toString());
				addressPd.put("address_name", pd.get("address_name2")==null?"":pd.get("address_name2").toString());
				itemService.editItemAddressById(addressPd);
			}else{
				addressPd.clear();
				addressPd.put("province_id", pd.get("province_id2")==null?"":pd.get("province_id2").toString());
				addressPd.put("city_id", pd.get("city_id2")==null?"":pd.get("city_id2").toString());
				addressPd.put("county_id", pd.get("county_id2")==null?"":pd.get("county_id2").toString());
				addressPd.put("address_info", pd.get("address_info2")==null?"":pd.get("address_info2").toString());
				addressPd.put("address_name", pd.get("address_name2")==null?"":pd.get("address_name2").toString());
				itemService.saveItemAddress(addressPd);
				pd.put("item_install_address", addressPd.get("id").toString());
			}
			if(addressIdPd.get("address3")!=null&&!addressIdPd.get("address3").toString().equals("")){
				addressPd.clear();
				addressPd.put("id", addressIdPd.get("address3").toString());
				addressPd.put("province_id", pd.get("province_id3")==null?"":pd.get("province_id3").toString());
				addressPd.put("city_id", pd.get("city_id3")==null?"":pd.get("city_id3").toString());
				addressPd.put("county_id", pd.get("county_id3")==null?"":pd.get("county_id3").toString());
				addressPd.put("address_info", pd.get("address_info3")==null?"":pd.get("address_info3").toString());
				addressPd.put("address_name", pd.get("address_name3")==null?"":pd.get("address_name3").toString());
				itemService.editItemAddressById(addressPd);
			}else{
				addressPd.clear();
				addressPd.put("province_id", pd.get("province_id3")==null?"":pd.get("province_id3").toString());
				addressPd.put("city_id", pd.get("city_id3")==null?"":pd.get("city_id3").toString());
				addressPd.put("county_id", pd.get("county_id3")==null?"":pd.get("county_id3").toString());
				addressPd.put("address_info", pd.get("address_info3")==null?"":pd.get("address_info3").toString());
				addressPd.put("address_name", pd.get("address_name3")==null?"":pd.get("address_name3").toString());
				itemService.saveItemAddress(addressPd);
				pd.put("order_org_address", addressPd.get("id").toString());
			}
			//放入当前登录人
			pd.put("input_user", getUser().getUSER_ID());
			//处理最终用户字符串
			String end_user = pd.containsKey("end_user")?pd.get("end_user").toString():"";
			pd.put("end_user", end_user.substring(0, end_user.lastIndexOf("_")));
			
			//更新tb_elevator_details
			updateElevatorDetails(pd);
			
			itemService.editItem(pd);
			
			/*//删除和编辑之后修改报价总价
			PageData offerPd = new PageData();
			offerPd.put("offer_total_price", itemService.findOfferCountPriceByItemId(pd));
			offerPd.put("item_id", item_id);
			offerService.offerUpdateByItemId(offerPd);*/
			mv.addObject("msg", "success");
			mv.addObject("id", "EditItem");
			mv.addObject("form", "ItemForm");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg","faild");
			mv.addObject("err","保存失败");
			logger.error(e.getMessage(),e);
		}
		return mv;
	}
	
	
	/**
	 *删除
	 */
	@RequestMapping(value="delItem")
	@ResponseBody
	public Object delItem(){
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//删除项目报备信息
			itemService.delItem(pd);
			map.put("msg", "success");
			obj = JSONObject.fromObject(map);
		}catch(Exception e){
			map.put("msg", "failed");
			obj = JSONObject.fromObject(map);
			logger.error(e.getMessage(),e);
		}
		return obj;
	}
	
	/**
	 *批量操作 
	 */
	@RequestMapping(value="delAllItem")
	@ResponseBody
	public Object delAllItem(){
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
        PageData pd = this.getPageData();
        Page page = this.getPage();
        try {
            page.setPd(pd);
            String item_ids = (String) pd.get("item_ids");
            for (String item_id : item_ids.split(",")) {
            	pd.put("item_id",  item_id);
    			//删除电梯数量信息
    			itemService.delElevatorNum(pd);
    			//删除项目报备信息
    			itemService.delItem(pd);
                pd.remove("item_id");
            }
            map.put("msg", "success");
            obj = JSONObject.fromObject(map);
        } catch (Exception e) {
            map.put("msg", "failed");
            obj = JSONObject.fromObject(map);
        }
        return obj;
	}
	
	/**
	 *提交至报价流程 
	 */
	@RequestMapping(value="subItem")
	@ResponseBody
	public Object subItem(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("item_status", "2");
			itemService.updateItemStatus(pd);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *检测项目名是否重复 
	 */
	@RequestMapping(value="checkItemName")
	@ResponseBody
	public Object checkItemName(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		JSONObject obj = new JSONObject();
		boolean flag = false;
		try{
			pd = this.getPageData();
			if(pd.get("operateType").toString().equals("add")){
				flag = itemService.checkItemName(pd);
			}else if(pd.get("operateType").toString().equals("edit")){
				flag = itemService.checkItemOldName(pd);
			}
			if(!flag){
				map.put("msg", "isExsit");
			}else{
				map.put("msg", "success");
			}
			obj = JSONObject.fromObject(map);
		}catch(Exception e){
			map.put("msg", "error");
			obj = JSONObject.fromObject(map);
			logger.error(e.getMessage(),e);
		}
		return obj;
	}
	
	/**
	 *根据用户id获取用户职位和用户电话
	 */
	@RequestMapping(value="getUserInfo")
	@ResponseBody
	public Object getUserInfo(@RequestParam String USER_ID){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		JSONObject obj = new JSONObject();
		try{
			pd.put("USER_ID", USER_ID);
			//放入职位
			PageData positionPd = positionService.findPositionInfoByUid(pd);
			if(positionPd!=null){
				map.put("POSITION_ID", positionPd.get("id").toString());
				map.put("POSITION_NAME", positionPd.get("name").toString());
			}
			//放入用户电话
			PageData userPd = sysUserService.findUserInfoByUid(pd);
			if(userPd!=null){
				map.put("PHONE", userPd.get("PHONE").toString());
			}
			obj = JSONObject.fromObject(map);
		}catch(Exception e){
			logger.debug(e.getMessage(),e);
		}
		return obj;
	}
	
	/**
	 *加载区域列表返回json 
	 */
	@RequestMapping(value="getCrossRegionList")
	@ResponseBody
	public Object getCrossRegionList(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			List<PageData> crossRegionList = departmentService.findAllAreaNode();
			if(crossRegionList!=null){
				map.put("crossRegionList", crossRegionList);
			}else{
				map.put("crossRegionList", "");
			}
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return map;
	}
	
	/**
     *递归获取所有父节点 
     */
    public List<PageData> getAllParentDepartments(PageData pd)throws Exception{
    	PageData parentPd = departmentService.findAllParentDepartments(pd);
    	if(parentPd!=null){
    		parentDepartments.add(parentPd);
    		getAllParentDepartments(parentPd);
    	}
    	return parentDepartments;
    }

    /**
     *获取区域列表 
     * @throws Exception 
     */
    public List<PageData> getAreaLists(List<PageData> pds) throws Exception{
    	for(PageData pd : pds){
    		getAllParentDepartments(pd);
    		parentDepartments.add(pd);
    	}
    	return parentDepartments;
    }
    
    
    /**
     *列表抄送通知设置 
     */
    @RequestMapping(value="listItemReport")
    public ModelAndView listItemReport(Page page){
    	ModelAndView mv = new ModelAndView();
    	PageData positionPd = new PageData();
    	String position = "";
    	String positionName = "";
    	try{
    		List<PageData> itemReportList = itemService.listPageAllItemReport(page);
    		List<PageData> list = new ArrayList<PageData>();
    		for(PageData pd : itemReportList){
    			if(pd.containsKey("position")){
    				position = pd.get("position").toString();
    				if(position.lastIndexOf(",")>-1){
    					for(String str : position.split(",")){
    						positionPd.put("id", str);
    						positionName += positionService.getPositionById(positionPd).get("name").toString()+",";
    					}
    					positionName = positionName.substring(0,positionName.length()-1);
    	    			pd.put("position", positionName);
    	    			list.add(pd);
    	    			positionName = "";
    					positionPd.remove("id");
    				}else{
    					positionPd.put("id", position);
    					positionName = positionService.getPositionById(positionPd).get("name").toString();
    	    			pd.put("position", positionName);
    	    			list.add(pd);
    	    			positionName = "";
    					positionPd.remove("id");
    				}
    			}
    		}
    		mv.addObject("itemReportList", list);
    		mv.setViewName("system/item/item_report_list");
    	}catch(Exception e){
    		logger.error(e.getMessage(),e);
    	}
    	return mv;
    } 
    
    
    /**
     *跳转至新增抄送设置 
     */
    @RequestMapping(value="goAddItemReport")
    public ModelAndView goAddItemReport(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		List<PageData> positionList = positionService.listAllPositions();
    		mv.addObject("positionList", positionList);
    		mv.setViewName("system/item/item_report_edit");
    		mv.addObject("msg", "saveItemReport");
    		mv.addObject("operateType", "add");
    	}catch(Exception e){
    		logger.error(e.getMessage(),e);
    	}
    	return mv;
    }
    
    /**
     *保存新增的抄送信息 
     */
    @RequestMapping(value="saveItemReport")
    public ModelAndView saveItemReport(){
    	PageData pd = new PageData();
    	ModelAndView mv = new  ModelAndView();
    	try{
    		pd = this.getPageData();
    		pd.put("id", get32UUID());
    		itemService.saveItemReport(pd);
    		mv.addObject("form","ItemReportForm");
    		mv.addObject("id","EditItemReport");
    		mv.addObject("msg", "success");
    		mv.setViewName("save_result");
    	}catch(Exception e){
    		mv.addObject("msg", "failed");
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *删除抄送设置 
     */
    @RequestMapping(value="delItemReport")
    @ResponseBody
    public Object delItemReport(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		itemService.delItemReport(pd);
    		map.put("msg", "success");
    	}catch(Exception e){
    		map.put("msg", "faild");
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *批量删除抄送通知 
     */
    @RequestMapping(value="delAllItemReport")
    @ResponseBody
    public Object delAllItemReport(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	PageData pd = new PageData();
    	PageData delPd = new PageData();
    	try{
    		pd = this.getPageData();
    		String ids = pd.get("ids").toString();
    		if(ids.lastIndexOf(",")>-1){
    			for(String id : ids.split(",")){
    				delPd.put("id", id);
    				itemService.delItemReport(delPd);
    			}
    		}else{
    			delPd.put("id", ids);
    			itemService.delItemReport(delPd);
    		}
    		map.put("msg", "success");
    	}catch(Exception e){
    		map.put("msg", "faild");
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *跳转至修改抄送设置页面
     */
    @RequestMapping(value="goEditItemReport")
    public ModelAndView goEditItemReport(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	String operateType = "";
    	String position = "";
    	try{
    		pd = this.getPageData();
    		operateType = pd.containsKey("operateType")?pd.get("operateType").toString():"";
    		pd = itemService.findItemReportById(pd);
    		position = pd.containsKey("position")?pd.get("position").toString():"";
    		List<PageData> positionList = positionService.listAllPositions();
    		List<String> positions = new ArrayList<String>();
    		if(position.indexOf(",")>-1){
    			for(String str : position.split(",")){
    				positions.add(str);
    			}
    		}else{
    			positions.add(position);
    		}
    		mv.addObject("positions", positions);
    		mv.addObject("pd",pd);
    		mv.addObject("positionList", positionList);
    		mv.addObject("operateType", operateType);
    		mv.addObject("msg", "editItemReport");
    		mv.setViewName("system/item/item_report_edit");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *修改抄送设置
     */
    @RequestMapping(value="editItemReport")
    public ModelAndView editItemReport(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		itemService.editItemReport(pd);
    		mv.addObject("msg", "success");
    		mv.addObject("id","EditItemReport");
    		mv.addObject("form","ItemReportForm");
    		mv.setViewName("save_result");
    	}catch(Exception e){
    		mv.addObject("msg", "failed");
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    
    /**
     *列表销售考核设置 
     */
    @RequestMapping(value="listItemExamin")
    public ModelAndView listItemExamin(Page page){
    	ModelAndView mv = new ModelAndView();
    	try{
    		List<PageData> itemExaminList = itemService.listPageAllItemExamin(page);
    		for(PageData pd : itemExaminList){
        		//将角色id转换成角色名
        		String sale_role = pd.containsKey("sale_role")?pd.get("sale_role").toString():"";
        		String examin_role = pd.containsKey("examin_role")?pd.get("examin_role").toString():"";
        		String sale_role_text = roleService.CastNameById(sale_role);
        		String examin_role_text = roleService.CastNameById(examin_role);
        		pd.put("sale_role_text", sale_role_text);
        		pd.put("examin_role_text", examin_role_text);
    		}
    		mv.addObject("itemExaminList", itemExaminList);
    		mv.setViewName("system/item/item_examin_list");
    	}catch(Exception e){
    		logger.error(e.getMessage(),e);
    	}
    	return mv;
    }
    
    
    /**
     *跳转到修改销售考核页面 
     */
    @RequestMapping(value="goEditItemExamin")
    public ModelAndView goEditItemExamin(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		pd = itemService.findExaminById(pd);
    		mv.addObject("pd", pd);
    		//放入已选择销售权限角色
    		List<String> saleRoleList = new ArrayList<String>();
    		if(pd!=null&&pd.containsKey("sale_role")){
    			String sale_role = pd.get("sale_role").toString();
    			if(sale_role.lastIndexOf(",")>-1){
    				saleRoleList = Arrays.asList(sale_role.split(","));
    			}else{
    				saleRoleList.add(sale_role);
    			}
    		}
    		mv.addObject("saleRoleList", saleRoleList);
    		//放入已选择销售考核角色
    		List<String> examinRoleList = new ArrayList<String>();
    		if(pd!=null&&pd.containsKey("examin_role")){
    			String examin_role = pd.get("examin_role").toString();
    			if(examin_role.lastIndexOf(",")>-1){
    				examinRoleList = Arrays.asList(examin_role.split(","));
    			}else{
    				examinRoleList.add(examin_role);
    			}
    		}
    		mv.addObject("examinRoleList", examinRoleList);
    		//放入角色列表
    		List<PageData> subRoleList = roleService.findAllSubRole();
    		mv.addObject("subRoleList", subRoleList);
    		mv.addObject("msg", "editItemExamin");
    		mv.setViewName("system/item/item_examin_edit");
    	}catch(Exception e){
    		logger.error(e.getMessage(),e);
    	}
    	return mv;
    }
    
    /**
     *保存修改销售考核 
     */
    @RequestMapping(value="editItemExamin")
    public ModelAndView editItemExamin(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		itemService.updateExamin(pd);
    		mv.addObject("msg", "success");
    		mv.addObject("id", "EditItemExamin");
    		mv.addObject("form", "ItemExaminForm");
    		mv.setViewName("save_result");
    	}catch(Exception e){
    		mv.addObject("msg", "faild");
    		logger.error(e.getMessage(),e);
    	}
    	return mv;
    }
    
    /**
	 *修改区域节点时改变归属分公司节点列表 
	 */
	@RequestMapping(value="getBranchCompany")
	@ResponseBody
	public Object getBranchCompany(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//加载所属子公司列表
	    	List<PageData> branch = departmentService.findAllBranchNodeByParentId(pd);
	    	//获取所有区域节点和父级节点
	    	List<PageData> branchs = getNodeLists(branch);
	    	if (branchs.size() > 0) {
	        		//构建多叉数
	        		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
	        		MultipleTree tree = new MultipleTree();
	        		dataList = ConvertPageDataToList.make(branchs);
	        		Node node = tree.makeTreeWithOderNo(dataList, 1);
	        		map.put("branchs", node.toString());
	    	}else{
	    		map.put("branchs", branchs.toString());
	    	}
	    	parentDepartments.clear();
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
     *获取指定节点列表 
     * @throws Exception 
     */
    public List<PageData> getNodeLists(List<PageData> pds) throws Exception{
    	for(PageData pd : pds){
    		getAllParentDepartments(pd);
    		parentDepartments.add(pd);
    	}
    	return parentDepartments;
    }
    
    /**
	 *点击区域输入框节点查询该节点是否是区域节点 
	 * @throws Exception 
	 */
	@RequestMapping(value="/checkAreaNode")
	@ResponseBody
	public Object checkAreaNode(@RequestParam(value = "id") String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd.put("id", id);
		pd = departmentService.getDepartmentById(pd).get(0);
		if(((String)pd.get("type")).equals("8")){
			map.put("msg", "success");
		}else{
			map.put("msg", "faild");
		}
		JSONObject obj = JSONObject.fromObject(map);
		return obj;
	}
	
	
	/**
	 *点击区域输入框节点查询该节点是否是所属公司节点 
	 * @throws Exception 
	 */
	@RequestMapping("/checkSubCompanyNode")
	@ResponseBody
	public Object checkSubCompanyNode(@RequestParam(value = "id") String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd.put("id", id);
		pd = departmentService.getDepartmentById(pd).get(0);
		if(((String)pd.get("type")).equals("10")){
			map.put("msg", "success");
		}else{
			map.put("msg", "faild");
		}
		JSONObject obj = JSONObject.fromObject(map);
		return obj;
	}
	
	/**
	 *项目跨区时获取项目安装管辖分公司 
	 */
	@RequestMapping(value="getItemSubBranch")
	@ResponseBody
	public Object getItemSubBranch(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//加载所属子公司列表
	    	List<PageData> sub = departmentService.findOtherAllBranchNode(pd);
	    	//获取所有区域节点和父级节点
	    	List<PageData> subs = getNodeLists(sub);
	    	if (subs.size() > 0) {
	        		//构建多叉数
	        		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
	        		MultipleTree tree = new MultipleTree();
	        		dataList = ConvertPageDataToList.make(subs);
	        		Node node = tree.makeTreeWithOderNo(dataList, 1);
	        		map.put("subs", node.toString());
	    	}else{
	    		map.put("subs", subs.toString());
	    	}
			map.put("msg", "success");
	        parentDepartments.clear();
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *编辑销售类型时修改订购单位下拉框 
	 */
	@RequestMapping(value="getOrderOrg")
	@ResponseBody
	public Object getOrderOrg(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		List<PageData> orderOrgList = new ArrayList<PageData>();
		String jsonStr = "[";
		try{
			pd = this.getPageData();
			String saleType = pd.get("sale_type").toString();
			if(saleType.equals("1")){
				orderOrgList = sysAgentService.findAgentIdAndNameList();
			}else if(saleType.equals("2")||saleType.equals("3")){
				orderOrgList = customerService.findCustomerIdAndNameList();
			}
			for(PageData orgPd : orderOrgList){
				jsonStr += "{\'id\':\'"+orgPd.get("id").toString()+"\',\'name\':\'"+orgPd.get("name").toString()+"\'},";
			}
			jsonStr =jsonStr.length()>1? jsonStr.substring(0, jsonStr.length()-1)+"]":jsonStr+"]";
			map.put("orderOrgs", jsonStr);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *更新项目是否是top10项目 
	 */
	@RequestMapping(value="updateTopStatus")
	@ResponseBody
	public Object updateTopStatus(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		try{
			pd =this.getPageData();
			itemService.updateTopStatus(pd);
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *更新项目是否是重点关注项目 
	 */
	@RequestMapping(value="updateAtnStatus")
	@ResponseBody
	public Object updateAtnStatus(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		try{
			pd =this.getPageData();
			itemService.updateAtnStatus(pd);
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *修改电梯种类时查询对应的电梯型号 
	 */
	@RequestMapping(value="findElevatorModels")
	@ResponseBody
	public Object findElevatorModels(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			List<PageData>modelList = new ArrayList<PageData>();
			PageData pd = this.getPageData();
			modelList = modelsService.findModelsByElevatorIdList(pd);
			map.put("modelList", modelList);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	
	/**
	 *更新tb_elevator_details 
	 */
	public void updateElevatorDetails(PageData pd){
		try{
			//将电梯信息插入tb_elevator_details表;
			PageData savePd = new PageData();
			//新增完成后取到电梯编号插入tb_elevator_info表
			PageData elevatorInfoPd = new PageData();
			String item_id = pd.get("item_id").toString();
			String elevatorJsonStr = pd.get("elevator_info").toString();
			JSONArray jsonArray = JSONArray.fromObject(elevatorJsonStr);
			//清空tb_elevator_info
			//删除当前tb_elevator_info表中的电梯信息
			elevatorInfoService.deleteElevatorInfoByItemId(item_id);
			//清空tb_elevator_details
			itemService.delElevatorDetails(item_id);
			for(int i =0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				/*Integer num =  Integer.parseInt(jsonObj.get("elevatorNum").toString());*/
				String enoStr = jsonObj.getString("elevatorNo");
				List<String> enoList = Arrays.asList(enoStr.split(","));
				savePd.put("item_id", item_id);
				for(int j =0;j<enoList.size();j++){
					savePd.put("eno", enoList.get(j));
					savePd.put("item_id", item_id);
					savePd.put("elevator_id", jsonObj.get("elevatorType").toString());
					savePd.put("models_id", jsonObj.get("elevatorModel").toString());
					savePd.put("total", "0");
					savePd.put("flag", "1");
					itemService.saveElevatorDetails(savePd);
					elevatorInfoPd.put("details_id", savePd.get("id").toString());//电梯id放入elevatorinfo
					elevatorInfoPd.put("item_id", item_id);
					elevatorInfoPd.put("elevator_id", jsonObj.get("elevatorType").toString());
					elevatorInfoPd.put("models_id", jsonObj.get("elevatorModel").toString());
					elevatorInfoPd.put("num", "1");//修改为1台梯1行数据
					elevatorInfoPd.put("total","0");
					elevatorInfoPd.put("flag", "1");//默认标准梯型,报价时添加非标描述则改为2
					elevatorInfoService.elevatorInfoAdd(elevatorInfoPd);
				}
			}
			//更新product_id
			itemService.updateElevatorDetailsProduct();
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
	}
	
	/**
	 *echarts报表 
	 */
	@RequestMapping(value="reportInfo")
	public ModelAndView reportInfo(){
		ModelAndView mv = new ModelAndView();
		try{
			mv.setViewName("system/item/report");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *放入json数据 
	 */
	@RequestMapping(value="setByType",produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Object setByType(){
		GsonOption option = new GsonOption();
		PageData pd = new PageData();
		try{
			Echarts chart = new Echarts();
			pd = this.getPageData();
			List<PageData> list = new ArrayList<PageData>();
			String type = pd.get("type").toString();
			String itemStatus = pd.get("itemStatus").toString();
			String year = pd.get("yearOption").toString();
			PageData dataPd = new PageData();
			dataPd.put("year", year);
			dataPd.put("item_status", itemStatus);
			String xAxisName = "";
			String yAxisName = "(Num)";
			if(type.equals("year")){
				list = itemService.itemYearNum(dataPd);
				xAxisName = "(年)";
			}else if(type.equals("month")){
				list = itemService.itemMonthNum(dataPd);
				xAxisName = "(月)";
			}else if(type.equals("quarter")){
				list = itemService.itemQuarterNum(dataPd);
				xAxisName = "(季)";
			}
			Map<String, String> legendMap = new HashMap<String, String>();
			legendMap.put("category", "date");
			legendMap.put("数量", "num");
			option = chart.setOption(list, legendMap);
			chart.setXAxisName(option, xAxisName);
			chart.setYAxisName(option, yAxisName);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		System.out.println(option.toString());
		return option.toString();
	}
	
	
	/**
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("项目id");
			titles.add("项目编号");
			titles.add("项目名");
			titles.add("安装地址");
			titles.add("最终用户");
			titles.add("用户编号");
			titles.add("销售类型");
			titles.add("订购单位");
			titles.add("订购单位联系人");
			titles.add("订购单位联系电话");
			titles.add("项目归属区域");
			titles.add("项目归属分公司");
			titles.add("是否跨区");
			titles.add("项目安装管辖分公司");
			titles.add("项目状态");
			titles.add("市场标志");
			titles.add("信息来源");
			titles.add("启用状态");
			titles.add("电梯信息");
			titles.add("项目启动时间");
			titles.add("预计完工时间");
			titles.add("预计设备使用时间");
			titles.add("预计签约时间");
			titles.add("设计院名称");
			titles.add("设计院地址");
			titles.add("设计院电话");
			titles.add("设计院传真");
			titles.add("项目设计");
			titles.add("项目设计联系电话");
			titles.add("项目总工");
			titles.add("项目总工联系电话");
			titles.add("技术特别要求");
			titles.add("报备人");
			titles.add("录入日期");
			titles.add("最后修改时间");
			titles.add("市场区分");
			titles.add("我司劣势");
			titles.add("合同可能");
			titles.add("项目总额");
			titles.add("项目负责人");
			titles.add("是否重点项目");
			titles.add("是否重大项目");
			titles.add("是否top10项目");
			titles.add("项目单位");
			titles.add("项目单位联系人");
			titles.add("项目单位联系电话");
			titles.add("项目联系人");
			titles.add("项目联系电话");
			titles.add("预计收取订金时间");
			titles.add("负责人职位");
			titles.add("项目地址");
			titles.add("负责人电话");
			titles.add("报备区域");
			titles.add("报备子公司");
			titles.add("报备分公司");
			titles.add("录入人");
			titles.add("最后修改人");
			titles.add("备注");
			titles.add("跨区台量");
			titles.add("合同类型");
			dataMap.put("titles", titles);
			
			/*List<PageData> itemList = itemService.findItemList();*/
			List<PageData> itemList = itemService.findItemToExcel();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("item_id"));
				vpd.put("var2", itemList.get(i).getString("item_no"));
				vpd.put("var3", itemList.get(i).getString("item_name"));
				vpd.put("var4", itemList.get(i).getString("item_install_address_excel"));
				vpd.put("var5", itemList.get(i).getString("end_user_excel"));
				vpd.put("var6", itemList.get(i).getString("customer_no"));
				String st = itemList.get(i).getString("sale_type");
				if(st.equals("1")){
					vpd.put("var7", "经销");
				}else if(st.equals("2")){
					vpd.put("var7", "直销");
				}else if(st.equals("3")){
					vpd.put("var7", "代销");
				}else{
					vpd.put("var7", "");
				}
				vpd.put("var8", itemList.get(i).getString("order_org_excel"));
				vpd.put("var9", itemList.get(i).getString("order_org_contact"));
				vpd.put("var10", itemList.get(i).getString("order_org_phone"));
				vpd.put("var11", itemList.get(i).getString("item_area_excel"));
				vpd.put("var12", itemList.get(i).getString("item_sub_branch_excel"));
				vpd.put("var13", itemList.get(i).getString("is_cross_region").equals("0")?"否":"是");
				vpd.put("var14", itemList.get(i).getString("item_install_sub_branch_excel"));
				String is = itemList.get(i).getString("item_status");
				if(is.equals("1")){
					vpd.put("var15", "信息");
				}else if(is.equals("2")){
					vpd.put("var15", "报价");
				}else if(is.equals("3")){
					vpd.put("var15", "投标");
				}else if(is.equals("4")){
					vpd.put("var15", "洽谈");
				}else if(is.equals("5")){
					vpd.put("var15", "合同");
				}else if(is.equals("6")){
					vpd.put("var15", "中标");
				}else if(is.equals("7")){
					vpd.put("var15", "失标");
				}else if(is.equals("8")){
					vpd.put("var15", "取消");
				}else if(is.equals("9")){
					vpd.put("var15", "生效");
				}else{
					vpd.put("var15", "");
				}
				vpd.put("var16", itemList.get(i).getString("market_flag"));
				vpd.put("var17", itemList.get(i).getString("mes_source"));
				vpd.put("var18", itemList.get(i).getString("enable_status").equals("0")?"禁用":"启用");
				vpd.put("var19", itemList.get(i).getString("elevator_info"));
				vpd.put("var20", itemList.get(i).getString("start_date"));
				vpd.put("var21", itemList.get(i).getString("plan_complete"));
				vpd.put("var22", itemList.get(i).getString("plan_comeinto"));
				vpd.put("var23", itemList.get(i).getString("plan_contract"));
				vpd.put("var24", itemList.get(i).getString("design_name"));
				vpd.put("var25", itemList.get(i).getString("design_address_excel"));
				vpd.put("var26", itemList.get(i).getString("design_phone"));
				vpd.put("var27", itemList.get(i).getString("design_fax"));
				vpd.put("var28", itemList.get(i).getString("item_design"));
				vpd.put("var29", itemList.get(i).getString("item_design_phone"));
				vpd.put("var30", itemList.get(i).getString("item_engineer"));
				vpd.put("var31", itemList.get(i).getString("item_engineer_phone"));
				vpd.put("var32", itemList.get(i).getString("special_require"));
				vpd.put("var33", itemList.get(i).getString("filing_man_excel"));
				vpd.put("var34", itemList.get(i).getString("input_date"));
				vpd.put("var35", itemList.get(i).getString("modified_date"));
				vpd.put("var36", itemList.get(i).getString("market_type"));
				vpd.put("var37", itemList.get(i).getString("self_inferiority"));
				vpd.put("var38", itemList.get(i).getString("agreement_possible"));
				vpd.put("var39", itemList.get(i).getString("item_total"));
				vpd.put("var40", itemList.get(i).getString("item_manager_excel"));
				String ia = itemList.get(i).getString("is_attention");
				String ii = itemList.get(i).getString("is_imporant");
				String it = itemList.get(i).getString("is_top");
				if(ia!=null&&!ia.equals("")){
					vpd.put("var41", ia.equals("0")?"否":"是");
				}else{
					vpd.put("var41", "");
				}
				if(ii!=null&&!ii.equals("")){
					vpd.put("var42", ii.equals("0")?"否":"是");
				}else{
					vpd.put("var42", "");
				}
				if(it!=null&&!it.equals("")){
					vpd.put("var43", it.equals("0")?"否":"是");
				}else{
					vpd.put("var43", "");
				}
				vpd.put("var44", itemList.get(i).getString("item_org"));
				vpd.put("var45", itemList.get(i).getString("item_org_contact"));
				vpd.put("var46", itemList.get(i).getString("item_org_phone"));
				vpd.put("var47", itemList.get(i).getString("item_contact"));
				vpd.put("var48", itemList.get(i).getString("item_contact_phone"));
				vpd.put("var49", itemList.get(i).getString("plan_deposit"));
				vpd.put("var50", itemList.get(i).getString("manager_duty_excel"));
				vpd.put("var51", itemList.get(i).getString("item_address_excel"));
				vpd.put("var52", itemList.get(i).getString("manager_phone"));
				vpd.put("var53", itemList.get(i).getString("filing_area_excel"));
				vpd.put("var54", itemList.get(i).getString("filing_sub_company_excel"));
				vpd.put("var55", itemList.get(i).getString("filing_branch_company_excel"));
				vpd.put("var56", itemList.get(i).getString("input_user_excel"));
				vpd.put("var57", itemList.get(i).getString("modified_by_excel"));
				vpd.put("var58", itemList.get(i).getString("remark"));
				vpd.put("var59", itemList.get(i).getString("cross_region_num"));
				String ct = itemList.get(i).getString("contract_type");
				if(ct.equals("1")){
					vpd.put("var60", "安装合同");
				}else if(ct.equals("2")){
					vpd.put("var60", "设备合同");
				}else if(ct.equals("3")){
					vpd.put("var60", "总包合同");
				}else{
					vpd.put("var60", "");
				}
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv, dataMap);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *导入Excel到数据库 
	 */
	@RequestMapping(value="importExcel")
	@ResponseBody
	public Object importExcel(@RequestParam(value = "file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				PageData pd = new PageData();
				//保存错误信息集合
    			List<PageData> allErrList = new ArrayList<PageData>();
    			//判断字段状态
    			Boolean flag;
    			//判断是否是所有行都有错误
    			Boolean allErr = true;
				for(int i = 0;i<listPd.size();i++){
        			List<PageData> errList = new ArrayList<PageData>();
					//放入主键
					pd.put("item_id", this.get32UUID());
					//放入编号
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		        	String item_no = "DN"+"I"+sdf.format(new Date()).toString()+((int)((Math.random()*9+1)*100000)+"");
		        	pd.put("item_no", item_no);
		        	String item_name = listPd.get(i).getString("var0");
		        	flag = itemService.checkExistIName(item_name);
		        	if(item_name.equals("")||item_name==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "项目名称不能为空!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else if(flag){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "项目名称重复!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("item_name", item_name);//项目名
    	        	}
		        	String sale_type = listPd.get(i).getString("var1");
		        	if(sale_type.equals("")||sale_type==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "销售类型不能为空!");
    	        		errPd.put("errCol", "2");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
    	        		if(sale_type.equals("经销")){
            	        	pd.put("sale_type", "1");
    	        		}else if(sale_type.equals("直销")){
            	        	pd.put("sale_type", "2");
    	        		}else if(sale_type.equals("代销")){
            	        	pd.put("sale_type", "3");
    	        		}else{
    	        			PageData errPd = new PageData();
        	        		errPd.put("errMsg", "销售类型填写错误!");
        	        		errPd.put("errCol", "2");
        	        		errPd.put("errRow", i+1);
        	        		errList.add(errPd);
    	        		}
    	        	}
		        	String contract_type = listPd.get(i).getString("var2");
		        	if(contract_type.equals("")||contract_type==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "合同类型不能为空!");
    	        		errPd.put("errCol", "3");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
    	        		if(contract_type.equals("安装合同")){
            	        	pd.put("contract_type", "1");
    	        		}else if(contract_type.equals("设备合同")){
            	        	pd.put("contract_type", "2");
    	        		}else if(contract_type.equals("总包合同")){
            	        	pd.put("contract_type", "3");
    	        		}else{
    	        			PageData errPd = new PageData();
        	        		errPd.put("errMsg", "合同类型填写错误!");
        	        		errPd.put("errCol", "3");
        	        		errPd.put("errRow", i+1);
        	        		errList.add(errPd);
    	        		}
    	        	}
		        	String end_user = listPd.get(i).getString("var3");
		        	flag = itemService.checkExistCName(end_user);
		        	if(end_user.equals("")||end_user==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户名称不能为空!");
    	        		errPd.put("errCol", "4");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else if(!flag){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户名称不存在!");
    	        		errPd.put("errCol", "4");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
    		        	pd.put("end_user", itemService.findEndUesrId(end_user));
    	        	}
		        	String order_org = listPd.get(i).getString("var4");
		        	if(order_org.equals("")||order_org==null){
		        		PageData errPd = new PageData();
    	        		errPd.put("errMsg", "订购单位不能为空!");
    	        		errPd.put("errCol", "5");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
		        	}else{
		        		if(sale_type.equals("经销")){
		        			flag = itemService.checkExistAName(order_org);
		        			if(!flag){
		        				PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "所填代理商不存在!");
		    	        		errPd.put("errCol", "5");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
		        			}else{
		    		        	pd.put("order_org", itemService.findAgentId(order_org));
		        			}
		        		}else if(sale_type.equals("直销")||sale_type.equals("代销")){
		        			flag = itemService.checkExistCName(order_org);
		        			if(!flag){
		        				PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "所填客户不存在!");
		    	        		errPd.put("errCol", "5");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
		        			}else{
		    		        	pd.put("order_org", itemService.findEndUesrId(order_org));
		        			}
		        		}
		        	}
		        	pd.put("order_org_contact", listPd.get(i).getString("var5"));
		        	pd.put("order_org_phone", listPd.get(i).getString("var6"));
		        	String item_manager = listPd.get(i).getString("var7");
		        	pd.put("item_manager", itemService.findUserId(item_manager));
		        	/*flag = itemService.checkExistCName(item_manager);
		        	if((!item_manager.equals(""))&&item_manager!=null){
		        		if(!flag){
		        			PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "客户不存在!");
	    	        		errPd.put("errCol", "8");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
		        		}else{
				        	pd.put("item_manager", item_manager);
		        		}
		        	}else{
	        			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "项目负责人不存在!");
    	        		errPd.put("errCol", "8");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
		        	}*/
		        	pd.put("start_date", listPd.get(i).getString("var8"));
		        	pd.put("market_flag", listPd.get(i).getString("var9"));
		        	pd.put("mes_source", listPd.get(i).getString("var10"));
		        	String item_status = listPd.get(i).getString("var11");
		        	if(item_status.equals("")||item_status==null){
		        		PageData errPd = new PageData();
    	        		errPd.put("errMsg", "项目状态不能为空!");
    	        		errPd.put("errCol", "12");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
		        	}else{
		        		if(item_status.equals("信息")){
		        			pd.put("item_status", "1");
		        		}else if(item_status.equals("报价")){
		        			pd.put("item_status", "2");
		        		}else if(item_status.equals("投标")){
		        			pd.put("item_status", "3");
		        		}else if(item_status.equals("洽谈")){
		        			pd.put("item_status", "4");
		        		}else if(item_status.equals("合同")){
		        			pd.put("item_status", "5");
		        		}else if(item_status.equals("中标")){
		        			pd.put("item_status", "6");
		        		}else if(item_status.equals("失标")){
		        			pd.put("item_status", "7");
		        		}else if(item_status.equals("取消")){
		        			pd.put("item_status", "8");
		        		}else if(item_status.equals("生效")){
		        			pd.put("item_status", "9");
		        		}else{
		        			PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "项目状态存在!");
	    	        		errPd.put("errCol", "12");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
		        		}
		        	}
		        	String item_area = listPd.get(i).getString("var12");
		        	if((!item_area.equals(""))&&item_area!=null){
			        	flag = itemService.checkExistDName(item_area);
		        		if(!flag){
		        			PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "该区域不存在!");
	    	        		errPd.put("errCol", "13");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
		        		}else{
				        	pd.put("item_area", itemService.findDepartmentId(item_area));
		        		}
		        	}else{
		        		PageData errPd = new PageData();
    	        		errPd.put("errMsg", "所属区域不能为空!");
    	        		errPd.put("errCol", "13");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
		        	}
		        	String item_sub_branch = listPd.get(i).getString("var13");
		        	if((!item_sub_branch.equals(""))&&item_sub_branch!=null){
			        	flag = itemService.checkExistDName(item_sub_branch);
		        		if(!flag){
		        			PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "该分子公司不存在!");
	    	        		errPd.put("errCol", "14");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
		        		}else{
				        	pd.put("item_sub_branch", itemService.findDepartmentId(item_sub_branch));
		        		}
		        	}else{
		        		PageData errPd = new PageData();
    	        		errPd.put("errMsg", "分子公司不能为空!");
    	        		errPd.put("errCol", "14");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
		        	}
		        	pd.put("is_cross_region", listPd.get(i).getString("var14").equals("是")?"1":"0");
		        	pd.put("remark", listPd.get(i).getString("var15"));
		        	pd.put("plan_complete", listPd.get(i).getString("var16"));
		        	pd.put("plan_comeinto", listPd.get(i).getString("var17"));
		        	pd.put("plan_contract", listPd.get(i).getString("var18"));
		        	pd.put("design_name", listPd.get(i).getString("var19"));
		        	pd.put("design_phone", listPd.get(i).getString("var20"));
		        	pd.put("design_fax", listPd.get(i).getString("var21"));
		        	pd.put("item_design", listPd.get(i).getString("var22"));
		        	pd.put("item_design_phone", listPd.get(i).getString("var23"));
		        	pd.put("item_engineer", listPd.get(i).getString("var24"));
		        	pd.put("item_engineer_phone", listPd.get(i).getString("var25"));
		        	pd.put("special_require", listPd.get(i).getString("var26"));
		        	/*pd.put("item_install_address", listPd.get(i).getString("var27"));
		        	pd.put("design_address", listPd.get(i).getString("var28"));*/
		        	
		        	//保存至数据库
		        	if(errList.size()==0){
    	        		allErr = false;
		        		itemService.saveItemImportExcel(pd);
		        	}else{
    	        		for(PageData dataPd : errList){
    	        			allErrList.add(dataPd);
    	        		}
    	        	}
				}
				if(allErrList.size()==0){
        			map.put("msg", "success");
    			}else{
    				if(allErr){
            			map.put("msg", "allErr");
    				}else{
    					map.put("msg", "error");
    				}
        			String errStr = "共出错"+allErrList.size()+"行\n";
        			for(PageData forPd : allErrList){
        				errStr += "错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol");
        			}
        			errStr += "总错误:"+allErrList.size();
        			map.put("errorUpload", errStr);
    			}
	    	}else{
	    		map.put("errorMsg", "上传失败");
	    	}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "系统错误，请稍后重试！");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
     *获取报表统计条件查询的年份列表 
     */
    @RequestMapping(value="findReportYearList")
    @ResponseBody
    public Object findReportYearList(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	List<String> yearList = new ArrayList<String>();
    	try{
    		int minYear = itemService.findMinYearItem();
    		int maxYear = Integer.parseInt(new SimpleDateFormat("yyyy").format(new Date()));
    		for(int i = minYear;i<=maxYear;i++){
    			yearList.add(i+"");
    		}
    		map.put("yearList", yearList);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *设置梯号 
     */
    @RequestMapping(value="setTh")
    public ModelAndView setTh(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = this.getPageData();
    	try{
    		int num = Integer.parseInt(pd.getString("num"));
    		String th = pd.getString("th");
    		List<String> thList = new ArrayList<String>();
    		if(th.lastIndexOf(",")>-1){
        		thList = Arrays.asList(th.split(","));
    		}
    		String htmlStr = "";
    		for(int i=0;i<num;i++){
    			htmlStr += "梯号:<input type=\"text\" name=\"eNo\" class=\"form-control\" ";
    			if(thList.size()>0){
    				htmlStr += "value=\""+thList.get(i)+"\"";
    			}
    			htmlStr += "><br>";
    		}
    		mv.addObject("htmlStr", htmlStr);
    		mv.addObject("rowIndex", pd.getString("rowIndex"));
    		mv.setViewName("system/item/setTh");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     * 获取权限
     *
     * @return
     */
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
    /* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
    /* ===============================用户================================== */

}
