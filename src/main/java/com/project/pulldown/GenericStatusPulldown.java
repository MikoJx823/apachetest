package com.project.pulldown;

import java.util.List;

import com.project.bean.CategoryBean;
import com.project.service.CategoryService;
import com.project.util.StaticValueUtil;

public class GenericStatusPulldown {
	public static String[] name = {"Active", "Inactive"};
	public static String[] enableName = {"Y", "N"};
	
	public static int[] value = {StaticValueUtil.Active, StaticValueUtil.Inactive};
	public static int[] enableValue = {StaticValueUtil.PRODUCT_ENABLE, StaticValueUtil.PRODUCT_DISABLE};
	
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

	public static String getPulldown(int initValue){
		String result = "";
		
		result += "<option value=''>" + "--- Please Select --- " + "</option>\n";
		
		for(int i = 0; i <value.length; i ++) {
			if(initValue == value[i]) {
				result += "<option value='" + value[i] + "' selected>" + name[i] + "</option>\n";
			}else {
				result += "<option value='" + value[i] + "'>" + name[i] + "</option>\n";
			}
			
		}
		return result;
	}
	
	public static String getPulldownForSearch(String val){
		String result = "";
		
		result += "<option value=''>" + "ALL" + "</option>\n";
		
		for(int i = 0; i <value.length; i ++) {
			
			if(val.equals(String.valueOf(value[i]))){
				result += "<option value='" + value[i] + "' selected>" + name[i] + "</option>\n";
			}else {
				result += "<option value='" + value[i] + "'>" + name[i] + "</option>\n";
			}
			
		}
		return result;
	}
	
	
	public static String getEnableText(int initValue){
		for(int i = 0; i < enableValue.length ; i++) {
			if(enableValue[i] == initValue){
				return enableName[i];
			}
		}
		return "";
	}
	
	public static String getEnableTextByLanguage(int initValue, String lang){
		for(int i = 0; i < enableValue.length ; i++) {
			if(enableValue[i] == initValue){
				return enableName[i];
			}
		}
		return "";
	}

	public static String getEnablePulldown(int initValue){
		String result = "";
		
		result += "<option value=''>" + "--- Please Select --- " + "</option>\n";
		
		for(int i = 0; i <enableValue.length; i ++) {
			if(initValue == value[i]) {
				result += "<option value='" + enableValue[i] + "' selected>" + enableName[i] + "</option>\n";
			}else {
				result += "<option value='" + enableValue[i] + "'>" + enableName[i] + "</option>\n";
			}
			
		}
		return result;
	}
	
	public static String getEnablePulldownForSearch(String val){
		String result = "";
		
		result += "<option value=''>" + "ALL" + "</option>\n";
		
		for(int i = 0; i <enableValue.length; i ++) {
			
			if(val.equals(String.valueOf(value[i]))){
				result += "<option value='" + enableValue[i] + "' selected>" + enableName[i] + "</option>\n";
			}else {
				result += "<option value='" + enableValue[i] + "'>" + enableName[i] + "</option>\n";
			}
			
		}
		return result;
	}
}
