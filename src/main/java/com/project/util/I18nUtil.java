package com.project.util;

import java.text.MessageFormat;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

public class I18nUtil
{
	public static final String ENG = "en";
	public static final String TC = "zh";
	
	public static final String Lang_EN = "E";
	public static final String Lang_TC = "C";
	
	public static final Locale HKLocale = Locale.TRADITIONAL_CHINESE;
	public static final Locale USLocale = Locale.US;
	
	public static final ResourceBundle rbHK = ResourceBundle.getBundle("message", HKLocale);
	public static final ResourceBundle rbUS = ResourceBundle.getBundle("message", USLocale);

	public static void setLang(HttpServletRequest req)
	{
		String requestlang = StringUtils.trimToEmpty(req.getParameter("lang"));
		String sessionlang = StringUtils.trimToEmpty((String)req.getSession().getAttribute("lang"));
		requestlang = "".equals(requestlang)?sessionlang:requestlang;
		requestlang = "".equals(requestlang)?"E":requestlang;
		req.getSession().setAttribute("lang", requestlang);
	}
	
	public static void setLang(HttpServletRequest req, String lang){
		
		String requestlang = "".equals(lang)?"E":lang;
		
		req.getSession().setAttribute("lang", requestlang);
	}

	public static String getCssFolderName(HttpServletRequest req)
	{
		String lang = getLang(req);
		return lang;
	}
	public static String getLang(HttpServletRequest req)
	{
		String sessionlang = StringUtils.trimToEmpty((String)req.getSession().getAttribute("lang"));
		return sessionlang;
	}
	public static String getLangHtml(HttpServletRequest req)
	{
		String sessionlang = StringUtils.trimToEmpty((String)req.getSession().getAttribute("lang"));
		if("C".equalsIgnoreCase(sessionlang))
			return "zh";
		else 
			return "en";
	}
	public static String getLangBundle(HttpServletRequest req)
	{
		String sessionlang = StringUtils.trimToEmpty((String)req.getSession().getAttribute("lang"));
		if("C".equalsIgnoreCase(sessionlang))
			return "zh_TW";
		else 
			return "en_US";
	}
	
	public static boolean isEng(HttpServletRequest req){
		String sessionlang = StringUtils.trimToEmpty((String)req.getSession().getAttribute("lang"));
		if ("C".equalsIgnoreCase(sessionlang)){
			return false;
		}
		return true;
	}

	public static String getString(String str, String lang){
		if ("C".equalsIgnoreCase(lang)){
			return rbHK.getString(str);
		} else{
			return rbUS.getString(str);
		}
	}

	public static String getString(String str, Object[] array, String lang)
	{
		String message = getString(str, lang);
		return MessageFormat.format(message, array);
	}

}
