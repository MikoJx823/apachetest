package com.project.pulldown;

import com.project.util.StaticValueUtil;

public class CategoryTagPulldown
{
	public static String[] text = { "Pre-Makeup", "Concealer & Foundation", 
									"Eye Makeup", "Lip Makeup", "3D",
									"Makeup Seting", "Makeup Tools"};

	public static int[] value = { StaticValueUtil.TAG_FACE, StaticValueUtil.TAG_EYE, StaticValueUtil.TAG_CHEEKS, 
								  StaticValueUtil.TAG_LIPS, StaticValueUtil.TAG_TOOLS, StaticValueUtil.TAG_3D,
								  StaticValueUtil.TAG_MAKEUPSETTING
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
