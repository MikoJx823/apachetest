package com.project.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;

public class DateUtil
{
	private static Logger log = Logger.getLogger(DateUtil.class);
	public static SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
	public static SimpleDateFormat datetimeFormatter_M = new SimpleDateFormat("M/yyyy");
	public static SimpleDateFormat datetimeFormatter_mm = new SimpleDateFormat("dd/MM/yyyy HH:mm");
	public static SimpleDateFormat datetimeFormatter_ss = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	
	public static SimpleDateFormat dateFormatterSql = new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat dateFormatterSql_mm = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public static SimpleDateFormat dateFormatterSql_ss = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public static Timestamp stringToTimestamp(String dateStr, SimpleDateFormat dateFormatter)
	{
		if (dateStr == null || "".equals(dateStr.trim()))
			return null;
		else
		{

			try
			{
				return dateToTimestamp(dateFormatter.parse(dateStr));
			}
			catch (ParseException e)
			{
				return null;
			}
		}

	}

	public static Date stringToDate(String dateStr)
	{
		if (dateStr == null || "".equals(dateStr.trim()))
			return null;
		else
		{

			try
			{
				return DateUtils.parseDate(dateStr, new String[] { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "dd/MM/yyyy", "dd/MM/yyyy HH:mm:ss", "dd/MM/yyyy HH:mm", "MM/yyyy",
						"mm/yyyy" });
			}
			catch (ParseException e)
			{
				return null;
			}
		}

	}

	public static Timestamp dateToTimestamp(Date date)
	{
		if (date == null)
			return null;
		else
		{
			Timestamp ts = new Timestamp(date.getTime());
			return ts;
		}
	}

	public static Date timestampToDate(Timestamp tt)
	{
		if (tt == null)
			return null;
		return new Date(tt.getTime());
	}

	public static String formatDate(Date in)
	{
		String result = "";
		if (in != null)
		{
			result = dateFormatter.format(in);
		}
		return result;
	}

	public static String formatDateSql(Date in)
	{
		String result = "";
		if (in != null)
		{
			result = dateFormatterSql.format(in);
		}
		return result;
	}

	public static String formatDate(Timestamp in)
	{
		String result = "";
		if (in != null)
		{
			result = dateFormatter.format(in);
		}
		return result;
	}

	public static String formatDatetime_ss(Date in)
	{
		String result = "";
		if (in != null)
		{
			result = datetimeFormatter_ss.format(in);
		}
		return result;
	}

	public static String formatDatetime_ss(Timestamp in)
	{
		String result = "";
		if (in != null)
		{
			result = datetimeFormatter_ss.format(in);
		}
		return result;
	}

	public static String formatDatetime_mm(Date in)
	{
		String result = "";
		if (in != null)
		{
			result = datetimeFormatter_mm.format(in);
		}
		return result;
	}
	
	public static String formatDatetime_M(Date in)
	{
		String result = "";
		if (in != null)
		{
			result = datetimeFormatter_M.format(in);
		}
		return result;
	}

	public static String formatDatetime_mm(Timestamp in)
	{
		String result = "";
		if (in != null)
		{
			result = datetimeFormatter_mm.format(in);
		}
		return result;
	}

	public static boolean isSameDay(Date day1, Date day2)
	{
		String ds1 = formatDate(day1);
		String ds2 = formatDate(day2);
		if (ds1.equals(ds2))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	/*public static String formatAPIDate(String in){
		
		String result = "";
		
	    DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	    Date startDate = null;
	    try {
	        startDate = df.parse(in);
	        String newDateString = df.format(startDate);
	        System.out.println(newDateString);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
		
	    if(startDate != null){
	    	result = formatDate(startDate);
	    }
		
	    return result; 
	}
	
	public static Date getAPIDate(String in){
		
	    DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	    Date startDate = null;
	    try {
	        startDate = df.parse(in);
	        String newDateString = df.format(startDate);
	        System.out.println(newDateString);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
		
	    return startDate; 
	}*/
}
