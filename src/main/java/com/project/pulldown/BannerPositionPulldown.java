package com.project.pulldown;

import com.project.util.StaticValueUtil;

public class BannerPositionPulldown {

	public static String[] name = {"Index Main", "Sub Banner Left", "Sub Banner Right 1", 
								   "Sub Banner Right 2", "Sub Banner Right Bottom"};
	
	public static int[] value = { StaticValueUtil.BANNER_INDEX_MAIN, StaticValueUtil.BANNER_INDEX_SUB_L, 
								  StaticValueUtil.BANNER_INDEX_SUB_R_1, StaticValueUtil.BANNER_INDEX_SUB_R_2, 
								  StaticValueUtil.BANNER_INDEX_SUB_R_B};
	
	public static String getText(int initValue){
		for(int i = 0; i < value.length ; i++) {
			if(value[i] == initValue){
				return name[i];
			}
		}
		return "";
	}
	
	public static String getTextByLanguage(int initValue, String lang){
		for(int i = 0; i < value.length ; i++) {
			if(value[i] == initValue){
				return name[i];
			}
		}
		return "";
	}

	public static String select(int initValue){
		String result = "";
		
		result += "<option value=''>" + "--- Please Select --- " + "</option>\n";
		
		for(int i = 0 ; i < value.length; i++){	
			if(initValue == value[i]) {
				result += "<option value='" + value[i] + "' selected >" + name[i] + "</option>\n";  
			}else{
				result += "<option value='" + value[i] + "'>" + name[i] + "</option>\n";  
			}
		}
		return result;
	}
	
	public static String searchPulldown(String initValue){
		String result = "";
		
		result += "<option value=''>ALL</option>\n";
		
		for(int i = 0 ; i < value.length; i++){	
			if(initValue.equals(String.valueOf(value[i]))) {
				result += "<option value='" + value[i] + "' selected >" + name[i] + "</option>\n";  
			}else{
				result += "<option value='" + value[i] + "'>" + name[i] + "</option>\n";  
			}
		}
		return result;
	}
	
	
}
