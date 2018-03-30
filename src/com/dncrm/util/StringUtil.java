package com.dncrm.util;

import javax.servlet.http.HttpServletRequest;

/**
 * 字符串相关方法
 */
public class StringUtil extends org.apache.commons.lang3.StringUtils{

    /**
     * 将以逗号分隔的字符串转换成字符串数组
     *
     * @param valStr
     * @return String[]
     */
    public static String[] StrList(String valStr) {
        int i = 0;
        String TempStr = valStr;
        String[] returnStr = new String[valStr.length() + 1 - TempStr.replace(",", "").length()];
        valStr = valStr + ",";
        while (valStr.indexOf(',') > 0) {
            returnStr[i] = valStr.substring(0, valStr.indexOf(','));
            valStr = valStr.substring(valStr.indexOf(',') + 1, valStr.length());

            i++;
        }
        return returnStr;
    }
    
    /**
	 * 获得用户远程地址
	 */
    public static String getRemoteAddr(HttpServletRequest request){
    	String remoteAddr = request.getHeader("X-Real-IP");
    	if (isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("X-Forwarded-For");
        }else if (isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("Proxy-Client-IP");
        }else if (isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("WL-Proxy-Client-IP");
        }
    	return remoteAddr!=null ? remoteAddr : request.getRemoteAddr();
    }
}
