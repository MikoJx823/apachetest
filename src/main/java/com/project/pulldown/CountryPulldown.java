package com.project.pulldown;

import com.project.util.StringUtil;

public class CountryPulldown {
	//https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
	public static String[] name = {
									"Indonesia", "Malaysia", "Philippines", 
									"Singapore", "Thailand", "Viet Nam"
								  };
	
	public static String[] value = { 
									"RI", "MY", "RP", 
								    "SG", "TH", "VN"
								   };
	
	public static String getText(String initValue){
		for(int i = 0; i < value.length ; i++) {
			if(value[i].equals(initValue)){
				return name[i];
			}
		}
		return "";
	}
	
	public static String frontSelect(String initValue){
		String result = "";
		
		result += "<option value=''>" + "--- Please Select --- " + "</option>\n";
		
		for(int i = 0 ; i < value.length; i++){	
			
			if(value[i].equals(initValue) || (StringUtil.filter(initValue).equals("") && value[i].equals("MY")) ){
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
