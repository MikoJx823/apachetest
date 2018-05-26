package com.project.pulldown;

import com.project.util.StaticValueUtil;

public class MemberPulldown {
	
	//public static String[] textZh = { "", ""};
	//public static String[] textEng = { "Email","No"};
	
	public static String[] name = {"PENDING", "ACTIVE", "REGISTERED", "DELETED",
								   "SUSPENDED", "LOCKED"};
	
	public static int[] value = { StaticValueUtil.Pending, StaticValueUtil.Active, 
								  StaticValueUtil.Registered, StaticValueUtil.Delete,
								  StaticValueUtil.Suspend, StaticValueUtil.Locked};

	public static String getText(int initValue)
	{
		/*String[] text = textZh;
		if ("E".equalsIgnoreCase(lang))
		{
			text = textEng;
		}
		for (int i = 0; i < value.length; i++)
		{
			if (value[i] == initValue)
			{
				return text[i];
			}
		}*/
		
		for(int i = 0; i < value.length ; i++) {
			if(value[i] == initValue){
				return name[i];
			}
		}
		return "";
	}
	
	public static String getPulldown(int initValue){
		String result = "";
		
		result += "<option value=''>" + "---" + "</option>\n";
		for (int i = 0; i < value.length; i++){
			
			if(value[i] == initValue){
				result += "<option value='" + value[i] + "' selected>" + name[i] + "</option>";
			}else{
				result += "<option value='" + value[i] + "'>" + name[i] + "</option>\n";
			}
		}

		return result;
	}
	
}
