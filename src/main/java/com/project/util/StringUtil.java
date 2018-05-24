package com.project.util;

import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import sun.misc.BASE64Encoder;

public class StringUtil {
	private static Logger log = Logger.getLogger(StringUtil.class);
	public static String formatPrice(Double price)
	{
		String returnStr = "0";
		try
		{
			String pattern = "#,###,###.##";
			NumberFormat format = new DecimalFormat(pattern);
			returnStr = format.format(price);
		}
		catch (Exception e)
		{
		}
		
		return returnStr;
	}
	
	public static String formatReceiptPrice(Double price)
	{
		String returnStr = "0";
		try
		{
			String pattern = "#,###,###.00";
			NumberFormat format = new DecimalFormat(pattern);
			returnStr = format.format(price);
		}
		catch (Exception e)
		{
		}
		
		return returnStr;
	}
	
	//Display
	public static String formatIndexPrice(Double price)
	{
		String returnStr = "0";
		try
		{
			String pattern = "#,###,###";
			NumberFormat format = new DecimalFormat(pattern);
			returnStr = format.format(price);
		}
		catch (Exception e)
		{
		}
		
		return returnStr;
	}
	
	//Normal 
	public static String formatIndexPrice2(Double price)
	{
		String returnStr = "0";
		try
		{
			String pattern = "#######";
			NumberFormat format = new DecimalFormat(pattern);
			returnStr = format.format(price);
		}
		catch (Exception e)
		{
		}
		
		return returnStr;
	}

	public static String formatCurrencyPrice(Double price)
	{
		String returnStr = "0";
		try
		{
			String pattern = "#,###,###.##";
			NumberFormat format = new DecimalFormat(pattern);
			returnStr = format.format(price);//"HKD "+format.format(price);
		}
		catch (Exception e)
		{
		}
		
		return returnStr;
	}
	
	public static String formatFrontCurrencyPrice(Double price)
	{
		String returnStr = "0";
		try
		{
			String pattern = "#,###,###.##";
			NumberFormat format = new DecimalFormat(pattern);
			returnStr = "MYR "+format.format(price);
		}
		catch (Exception e)
		{
		}
		
		return returnStr;
	}
	
	public static int strToInt(String str)
	{
		int returnVal = 0;
		try
		{
			returnVal = Integer.valueOf(str);
		}
		catch (Exception e)
		{
			returnVal = 0;
		}
		return returnVal;
	}

	public static double strToDouble(String str)
	{
		str = str.replace( ",", "");  
		double returnVal = 0.0;
		try
		{
			returnVal = Double.valueOf(str);
		}
		catch (Exception e)
		{
			returnVal = 0;
		}
		return returnVal;
	}


	public static String delHTMLTag(String htmlStr)
	{
		String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; 
		String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; 
		String regEx_html = "<[^>]+>"; 
		String regEx_space = "\\s{2,}|\t|\r|\n";
		//String regEx_space = "\\t|\r|\n";

		Pattern p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
		Matcher m_script = p_script.matcher(htmlStr);
		htmlStr = m_script.replaceAll(" "); 

		Pattern p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
		Matcher m_style = p_style.matcher(htmlStr);
		htmlStr = m_style.replaceAll(" "); 

		Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
		Matcher m_html = p_html.matcher(htmlStr);
		htmlStr = m_html.replaceAll(" "); 

		Pattern p_space = Pattern.compile(regEx_space, Pattern.CASE_INSENSITIVE);
		Matcher m_space = p_space.matcher(htmlStr);
		htmlStr = m_space.replaceAll(" "); 
		htmlStr = unblockXss(htmlStr);
		return htmlStr.trim(); 
	}
	
	public static String blockXss(String in)
	{		
		if (in==null)
			return null;

		String out = in;
		out = out.replaceAll("&", "&amp;");
		out = out.replaceAll("<", "&lt;");
		out = out.replaceAll(">", "&gt;");		
		out = out.replaceAll("\"", "&quot;");
		out = out.replaceAll("'", "&#x27;");
		out = out.replaceAll("/", "&#x2F;");		 
		return out;
	}
    
    public static String unblockXss(String in)
	{		
		if (in==null)
			return null;

		String out = in;
		out = out.replaceAll("&#60;br&#62;", "\r\n");
		out = out.replaceAll("&lt;", "<");
		out = out.replaceAll("&gt;", ">");
		out = out.replaceAll("&#x27;", "'");
		out = out.replaceAll("&#x2F;", "/");	
		out = out.replaceAll("&#x2f;", "/");
		out = out.replaceAll("&quot;","\"");
		out = out.replaceAll("&amp;", "&");
		//out = out.replaceAll(" ", "+"); //+   %2b
		return out;
	}
    
    public static String unblockXssASC(String in){
    	String out = in;
		out = out.replaceAll("&#60;br&#62;", "\r\n");
		out = out.replaceAll("&lt;", "<");
		out = out.replaceAll("&gt;", ">");
		out = out.replaceAll("&#x27;", "'");
		out = out.replaceAll("&#x2F;", "/");	
		out = out.replaceAll("&#x2f;", "/");
		out = out.replaceAll("&quot;","\"");
		out = out.replaceAll("&amp;", "&");
		out = out.replaceAll(" ", "+"); //+   %2b
		return out;
    }
    
    public static String getPagingString(int pageSide,int pageIdx,int totalPages,String url)
    {
    	String result = "<ul class=\"pagination pagination-sm mt-5\">";

    	if (pageIdx == 1)
    	{

    		result += "<li><a  aria-label=\"Previous\"><span aria-hidden=\"true\">&laquo;</span></a></li>";
    	}
    	else
    	{ 
    		result += "<li> <a href=\""+url+"0\" aria-label=\"Previous\"><span aria-hidden=\"true\">&laquo;</span></a></li>";
    	} 
    	
    	if (pageIdx > pageSide)
    	{
    		int startNum = pageIdx - pageSide;
    		for (int i = startNum; i <= pageIdx - 1; i++)
    		{
    			result += "<li><a href=\""+url+i+"\">"+i+"</a></li>";
    		}
    	}
    	else
    	{
    		for (int j = 1; j < pageIdx; j++)
    		{
    			result += "<li><a href=\""+url+j+"\">"+j+"</a></li>";
    		}
    	}
    	result += "<li class=\"active\"><a >"+pageIdx +"</a></li>";

    	if ((totalPages - pageIdx) > pageSide)
    	{
    		for (int i = pageIdx + 1; i < pageIdx + pageSide; i++)
    		{
    			result += "<li><a href=\""+url+i+"\">"+i+"</a></li>";
    		}
    	}
    	else
    	{
    		for (int j = pageIdx + 1; j < totalPages + 1; j++)
    		{
 
    			result += "<li><a href=\""+url+j+"\">"+j+"</a></li>";
    
    		}
    	}

    	if (pageIdx == totalPages)
    	{

    		result += "<li><a  aria-label=\"Previous\"><span aria-hidden=\"true\">&raquo;</span></a></li>";

    	}
    	else
    	{

    		result += "<li><a href=\""+url+totalPages+"\"aria-label=\"Previous\"><span aria-hidden=\"true\">&raquo;</span></a></li>";

    	}
   
    	result +="</ul>";
    	return result;
    	
    }
    
    public static String getFrontPagingString (int pageSide,int pageIdx,int totalPages,String url){
    	String result = "<nav aria-label=\"Page navigation\" class=\" text-center\">" +
    					"	<ul class=\"pagination\">";
    	
    	//Set up for Start (LEFT SIDE)
    	if (pageIdx == 1){
    		result += "<li> "+ 
    				  "	<a href=\"#\" aria-label=\"Previous\">"+ 
    				  "		<span aria-hidden=\"true\"><em class=\"fa fa-chevron-left\"></em></span>"+ 
    				  "	</a>" +
    				  "</li>";
    	}else{ 
    		result += "<li> "
    				+ "	<a href=\""+url+"0\" aria-label=\"Previous\">"
    				+ "		<span aria-hidden=\"true\"><em class=\"fa fa-chevron-left\"></em></span>"
    				+ "	</a>"
    				+ "</li>";
    	} 
    	
    	if (pageIdx > pageSide){
    		int startNum = pageIdx - pageSide;
    		for (int i = startNum; i <= pageIdx - 1; i++)
    		{
    			result += "<li><a href=\""+url+i+"\">"+i+"</a></li>";
    		}
    	}else{
    		for (int j = 1; j < pageIdx; j++)
    		{
    			result += "<li><a href=\""+url+j+"\">"+j+"</a></li>";
    		}
    	}
    	
    	result += "<li class=\"active\"><a >"+pageIdx +"</a></li>";

    	
    	if ((totalPages - pageIdx) > pageSide){
    		for (int i = pageIdx + 1; i < pageIdx + pageSide; i++){
    			result += "<li><a href=\""+url+i+"\">"+i+"</a></li>";
    		}
    	}
    	else{
    		for (int j = pageIdx + 1; j < totalPages + 1; j++){
    			result += "<li><a href=\""+url+j+"\">"+j+"</a></li>";
    		}
    	}

    	//Set up for END (RIGHT SIDE) 
    	if (pageIdx == totalPages){
    		result += "<li><a  aria-label=\"Previous\"><span aria-hidden=\"true\"><em class=\"fa fa-chevron-right\"></em></span></a></li>";
    	}
    	else{
    		result += "<li><a href=\""+url+totalPages+"\"aria-label=\"Previous\"><span aria-hidden=\"true\"><em class=\"fa fa-chevron-right\"></em></span></a></li>";
    	}
   
    	result +="</ul>";
    	return result;
    }
    
	public static int trimToInt(Object object){
		int result = 0;
		try
		{
			result = Integer.valueOf((String)object);
		}
		catch (Exception e)
		{
		}
		if(result == 0)
		{
			try
			{
				result = (Integer)object;
			}
			catch (Exception e)
			{
			}
		}

		return result;
	}

	private static final String charset = "0123456789abcdefghijklmnopqrstuvwxyz";

	public static String randomString(int length) {
		Random rand = new Random(System.currentTimeMillis());
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i <= length; i++) {
			int pos = rand.nextInt(charset.length());
			sb.append(charset.charAt(pos));
		}
		return sb.toString();
	}
	
	public static synchronized String encryptString(String in) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(in.getBytes("UTF-8"));
			byte digest[] = md.digest();
			return (new BASE64Encoder()).encode(digest);
		} catch (Exception e) {
			log.error(in, e);
			return null;
		}
	}
	
	public static String filter(String in) {
		return filter(in, "");
	}
	
	public static String filter(String in, Object replacement) {
		String out = "";
		if (in != null && !"".equals(in.trim())
				&& !"null".equalsIgnoreCase(in.trim())) {
			out = in.trim();
		} else {
			out = String.valueOf(replacement);
		}
		return out;
	}
	
	public static String getBasePath() {
		
		String enviroment = StringUtil.filter(PropertiesUtil.getProperty("enviroment"));
		if(enviroment.equals(StaticValueUtil.ENV_PROD)) {
			return StringUtil.filter(PropertiesUtil.getProperty("basePath.prod"));
		}else if(enviroment.equals(StaticValueUtil.ENV_UAT)) {
			return StringUtil.filter(PropertiesUtil.getProperty("basePath.uat"));
		}else {
			return StringUtil.filter(PropertiesUtil.getProperty("basePath.local"));
		}
	}
	
	public static String getHostAddress() {
		String enviroment = StringUtil.filter(PropertiesUtil.getProperty("enviroment"));
		if(enviroment.equals(StaticValueUtil.ENV_PROD)) {
			return StringUtil.filter(PropertiesUtil.getProperty("hostAddr.prod"));
		}else if(enviroment.equals(StaticValueUtil.ENV_UAT)) {
			return StringUtil.filter(PropertiesUtil.getProperty("hostAddr.uat"));
		}else {
			return StringUtil.filter(PropertiesUtil.getProperty("hostAddr.local"));
		}
	}
	
}