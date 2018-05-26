package com.project.pulldown;

import javax.servlet.http.HttpServletRequest;

import com.project.util.StaticValueUtil;


public class CategoryTagPulldown
{
	public static String[] text = { "Face", "Eyes", "Cheeks", "Lips", "Tools"};

	public static int[] value = { StaticValueUtil.TAG_FACE, StaticValueUtil.TAG_EYE, 
								  StaticValueUtil.TAG_CHEEKS, StaticValueUtil.TAG_LIPS, 
								  StaticValueUtil.TAG_TOOLS
								};

	public static String getText(int initValue){
		for (int i = 0; i < value.length; i++)
		{
			if (value[i]==initValue)
			{
				return text[i];
			}
		}
		return "";
	}
}
