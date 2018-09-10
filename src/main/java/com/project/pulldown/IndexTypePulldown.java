package com.project.pulldown;

import com.project.util.StaticValueUtil;

public class IndexTypePulldown {

	public static String[] name = {"Latest Product", "Top Rated"};
	
	public static int[] value = { StaticValueUtil.INDEX_LATEST, StaticValueUtil.INDEX_TOP_RATED};
	
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
