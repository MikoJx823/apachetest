package com.project.pulldown;

import com.project.util.StringUtil;

public class OrderStatusPulldown{

	public static final String PENDING = "P";		// set after payment is sent to paygate
	public static final String ACCEPTED= "S";	// set after datafeed return success
	public static final String REJECTED= "R";	// set after datafeed return fail
	public static final String DELETED = "D"; //Deleted Item 
	public static final String CANCELLED = "C";
	
	public static String[] texts = {"Pending", "Success", "Reject", "Cancel", "Delete"};

	public static String[] values = {PENDING, ACCEPTED, REJECTED, CANCELLED, DELETED};
	
	public static String getName(String in){
		
		for(int i = 0; i < values.length; i++ ){
			if(in.equals(values[i])){
				return texts[i];
			}
		}
		
		return "";
	}

	// for order item
	public static final int NOTSOLD = 1;	
	public static final int SOLD = 2;	

	public static String getSearchPulldown(String in){
		String result = "";
		
		if("".equals(in)){
			result += "<option value='' selected>" + "All" + "</option>\n";
		}else {
			result += "<option value=''>" + "All" + "</option>\n";
		}
		
		for(int i = 0; i < values.length ; i ++) {
			if(in.equals(values[i])){
				result += "<option value='"+ values[i] +"' selected >" + texts[i] + "</option>\n";
			}else {
				result += "<option value='"+ values[i] +"'>" + texts[i] + "</option>\n";
			}
		}

		return result;
	}
	
	public static String getPulldown(String in){
		String result = "";
		
		for(int i = 0; i < values.length - 1; i ++) {
			if(in.equals(values[i])){
				result += "<option value='"+ values[i] +"' selected >" + texts[i] + "</option>\n";
			}else {
				result += "<option value='"+ values[i] +"'>" + texts[i] + "</option>\n";
			}
		}

		return result;
	}
	
	public static String select(String initValue, Boolean hasBlank){
		String plsText = "ALL";
		String statment = "";
		if (hasBlank)
		{
			statment += "<option value=\"\" >"+plsText+"</option>";
		}
		for (int i = 0; i < values.length; i++)
		{
			if (values[i].equals(initValue))
			{
				statment += "<option value=\"" + values[i] + "\" selected>" + texts[i] + "</option>";
			} else
			{
				statment += "<option value=\"" + values[i] + "\">" + texts[i] + "</option>";
			}
		}
		return statment;
	}
}
