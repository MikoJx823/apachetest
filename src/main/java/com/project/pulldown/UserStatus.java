package com.project.pulldown;

import com.project.util.StaticValueUtil;

public class UserStatus {
	
	public static String[] text = { "Active", "Inactive"};

	public static int[] value = { StaticValueUtil.Active, StaticValueUtil.Suspend};

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
	public static String select(int initValue, Boolean hasBlank)
	{
		String plsText = "ALL";
		String statment = "";
		if (hasBlank)
		{

			statment += "<option selected  value=\"\" >"+plsText+"</option>";
		}
		for (int i = 0; i < value.length; i++)
		{
			if (value[i]==initValue)
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
