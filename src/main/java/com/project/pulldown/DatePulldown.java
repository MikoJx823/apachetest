package com.project.pulldown;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

public class DatePulldown
{

	public static String getDDPulldown(Integer DD)
	{
		String result = "";
		String data = "";
		result += "<option value=''>" + "---" + "</option>\n";
		for (int i = 1; i <= 31; i++)
		{
			if (i < 10)
			{
				data = "0" + i;
			}
			else
			{
				data = String.valueOf(i);
			}
			if (DD != null && i == DD)
			{
				result += "<option value='" + data + "' selected>" + data + "</option>\n";
			}
			else
			{
				result += "<option value='" + data + "'>" + data + "</option>\n";
			}
		}
		return result;
	}

	public static String getMMPulldown(Integer MM)
	{
		String result = "";
		String data = "";
		result += "<option value=''>" + "---" + "</option>\n";
		for (int i = 1; i <= 12; i++)
		{
			if (i < 10)
			{
				data = "0" + i;
			}
			else
			{
				data = String.valueOf(i);
			}
			if (MM != null && i == MM)
			{
				result += "<option value='" + data + "' selected>" + data + "</option>\n";
			}
			else
			{
				result += "<option value='" + data + "'>" + data + "</option>\n";
			}
		}
		return result;
	}

	public static String getYYYYPulldown(Integer YYYY)
	{
		String result = "";
		int startYear = new Date().getYear() + 1900 - 1;
		int maxYear = new Date().getYear() + 1900+2;
		result += "<option value=''>" + "---" + "</option>\n";
		for (int i = startYear; i <= maxYear; i++)
		{
			if (YYYY != null && i == YYYY)
			{
				result += "<option value='" + i + "' selected>" + i + "</option>\n";
			}
			else
			{
				result += "<option value='" + i + "'>" + i + "</option>\n";
			}
		}
		return result;
	}

	public static String getHHPulldown(Integer HH)
	{
		String result = "";
		String data = "";
		result += "<option value=''>" + "---" + "</option>\n";
		for (int i = 0; i < 24; i++)
		{
			if (i < 10)
			{
				data = "0" + i;
			}
			else
			{
				data = String.valueOf(i);
			}
			if (HH != null && i == HH)
			{
				result += "<option value='" + data + "' selected>" + data + "</option>\n";
			}
			else
			{
				result += "<option value='" + data + "'>" + data + "</option>\n";
			}
		}
		return result;
	}

	public static String getSSPulldown(Integer SS)
	{
		String result = "";
		String data = "";
		result += "<option value=''>" + "---" + "</option>\n";
		for (int i = 0; i < 60; i++)
		{
			if (i < 10)
			{
				data = "0" + i;
			}
			else
			{
				data = String.valueOf(i);
			}
			if (SS != null && i == SS)
			{
				result += "<option value='" + data + "' selected>" + data + "</option>\n";
			}
			else
			{
				result += "<option value='" + data + "'>" + data + "</option>\n";
			}
		}
		return result;
	}
}
