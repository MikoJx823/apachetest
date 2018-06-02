package com.project.pulldown;

public class MYStatePulldown {
	public static String[] name = {
									 "Johor","Kedah","Kelantan","Melaka",
									 "Negeri Sembilan","Pahang","Penang","Perak",
									 "Perlis","Sabah","Sarawak","Selangor",
									 "Terengganu","WP Kuala Lumpur","WP Labuan","WP Putrajaya"
								  };
	
	public static String getText(String initValue){
		for(int i = 0; i < name.length ; i++) {
			if(name[i].equals(initValue)){
				return name[i];
			}
		}
		return "";
	}
	
	public static String frontSelect(String initValue){
		String result = "";
		
		result += "<option value=\'\'>" + "--- Please Select --- " + "</option>";
		
		for(int i = 0 ; i < name.length; i++){	
			if(name[i].equals(initValue)){
				result += "<option value=\'" + name[i] + "\' selected >" + name[i] + "</option>";  
			}else{
				result += "<option value=\'" + name[i] + "\'>" + name[i] + "</option>";  
			}
		}
		return result;
	}

	public static String searchPulldown(String initValue){
		String result = "";
		
		result += "<option value=''>ALL</option>\n";
		
		for(int i = 0 ; i < name.length; i++){	
			if(initValue.equals(String.valueOf(name[i]))) {
				result += "<option value='" + name[i] + "' selected >" + name[i] + "</option>\n";  
			}else{
				result += "<option value='" + name[i] + "'>" + name[i] + "</option>\n";  
			}
		}
		return result;
	}
	
	
}
