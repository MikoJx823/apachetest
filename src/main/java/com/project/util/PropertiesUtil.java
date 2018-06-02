package com.project.util;

import java.util.ResourceBundle;

import org.apache.log4j.Logger;

public class PropertiesUtil {
	
private static Logger log = Logger.getLogger(PropertiesUtil.class);
	
	public static ResourceBundle prop = ResourceBundle.getBundle("system");
	
	public final static String MAILUSERTITLE =prop.getString("mailUserTitle"); 
	public final static String MAILPATH =prop.getString("mailPath"); 
	public final static String MAILHOST =prop.getString("mailHost"); 
	public final static String MAILFROM =prop.getString("mailFrom"); 
	public final static String MAILUSER =prop.getString("mailUser"); 
	public final static String MAILPASS =prop.getString("mailPass"); 
	public final static String MAILBCC =prop.getString("mailBcc"); 
	public final static String OFFLINEPATH =prop.getString("offlinePath"); 
	
	public static String getProperty(String key)
	{
		return prop.getString(key);
	}
	
	public static String getString(String bundle, String key) {
		String value = "";
		try {
			value = ResourceBundle.getBundle(bundle).getString(key);
			value = new String(value.getBytes("ISO-8859-1"),"UTF-8");
			return value;
		} catch (Exception e) {
			log.error("PropertiesUtil: Cannot get resource bundle: " + e.getMessage());
			return "";
		}
	}
}