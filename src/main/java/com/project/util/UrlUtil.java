package com.project.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSocketFactory;

import org.apache.log4j.Logger;


import net.sf.json.JSONObject;

public class UrlUtil{
	Logger log = Logger.getLogger(UrlUtil.class);
	
	private static String TruncateUrlPage(String strURL)
	{
		String strAllParam = null;
		String[] arrSplit = null;

		strURL = strURL.trim().toLowerCase();

		arrSplit = strURL.split("[?]");
		if (strURL.length() > 1)
		{
			if (arrSplit.length > 1)
			{
				if (arrSplit[1] != null)
				{
					strAllParam = arrSplit[1];
				}
			}
		}

		return strAllParam;
	}

	
	public static Map<String, String> URLRequest(String strUrlParam)
	{
		Map<String, String> mapRequest = new HashMap<String, String>();

		String[] arrSplit = null;

		arrSplit = strUrlParam.split("[&]");
		for (String strSplit : arrSplit)
		{
			String[] arrSplitEqual = null;
			arrSplitEqual = strSplit.split("[=]");

			
			if (arrSplitEqual.length > 1)
			{

				mapRequest.put(arrSplitEqual[0], arrSplitEqual[1]);

			}
			else
			{
				if (arrSplitEqual[0] != "")
				{
					
					mapRequest.put(arrSplitEqual[0], "");
				}
			}
		}
		return mapRequest;
	}

	
	private String accessAPI(String path){
    	//int result = -1;
    	String result = "";
		try {
	    	
	    	SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
	    	URL url = new URL(path);
	    	HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
	    	conn.setSSLSocketFactory(sslsocketfactory);
	    	conn.setRequestProperty ("X-Authorization", "f8156db9c059cee3a1e17ddb9f6108fa1939ef49");
	    	InputStream inputstream = conn.getInputStream();
	    	InputStreamReader inputstreamreader = new InputStreamReader(inputstream);
	    	BufferedReader bufferedreader = new BufferedReader(inputstreamreader);
	    	
	    	log.info("Response Code:"+conn.getResponseCode());
	    	log.info("URL:"+conn.getURL());
	    	 
	    	
	    	String string = null;
	    	String toJson = "";
	    	while ((string = bufferedreader.readLine()) != null) {
	    		toJson += string;
	    	    System.out.println("Received " + string);
	    	}
	    	try {
	    		//System.out.println("String "+toJson);
	    		JSONObject jsonObject = JSONObject.fromObject(toJson);
		    	//double object = jsonObject.optDouble("co2e");
		    	//result = (int) Math.ceil(object / 1.0);
			} catch (Exception e) {
				System.out.println("jsonObject Error");
			}
	    	
	    	conn.disconnect();
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	return result;
    }
}
