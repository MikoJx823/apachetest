package com.project.pulldown;

public class TitlePulldown
{
	public static String[] textEng = {"Mr","Ms"};
	public static String[] value = {"Mr","Ms"};

	public static String getText(String val, String lang){

		for(int i = 0; i < value.length ; i++) {
			//String lang = I18nUtil.getLangHtml(request).equals("en")?"E":"C";  
			if(val.startsWith(value[i])){
				return textEng[i];
			}
		}
		
		return "";
	}
	
	public static String pulldown(String val){
		String result = "";
		
		for(int i = 0; i < value.length ; i++) {
			
			if(val.equals(value[i]) && !value.equals("")){
				result += "<option value=\""+ value[i] + "\" selected >" + textEng[i] + "</option>";
			}else {
				result += "<option value=\""+ value[i] + "\">" + textEng[i] + "</option>";
			}
			
		}
		return result;
	}
}
