package com.project.pulldown;

import com.project.util.StaticValueUtil;


public class UserTypePulldown
{
	public static String[] text = { "Guest", "Member" };

	public static int[] value = { StaticValueUtil.USER_GUEST, StaticValueUtil.USER_MEMBER};

	public static String getText(int initValue)
	{
		for (int i = 0; i < value.length; i++)
		{
			if (value[i]==initValue)
			{
				return text[i];
			}
		}
		return "";
	}
	
	public static String select(String initValue){
		
		String statment = "<option value=\"\" >"+ StaticValueUtil.DEFAULT_ALL +"</option>";
		
		for (int i = 0; i < value.length; i++)
		{
			if (String.valueOf(value[i]).equals(initValue))
			{
				statment += "<option value=\"" + value[i] + "\" selected>" + text[i] + "</option>";
			} else
			{
				statment += "<option value=\"" + value[i] + "\">" + text[i] + "</option>";
			}
		}
		return statment;
	}
}
