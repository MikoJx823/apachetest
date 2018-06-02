package com.project.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.project.util.I18nUtil;
import com.project.util.SessionName;
import com.project.util.StringUtil;

public class I18nFilter implements Filter
{	
	private static Logger log = Logger.getLogger(I18nFilter.class);

	public void init(FilterConfig filterConfig) throws ServletException
	{
		
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain chain) throws IOException, ServletException
	{	
		
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		HttpSession session = request.getSession();
		
		String currentLang = I18nUtil.getLang(request);
		
		Cookie[] cookies = request.getCookies();

		String lang = "";
		
		
		if(cookies != null){
			
			for(int i = 0; i < cookies.length; i++) { 
	            Cookie cookie1 = cookies[i];
	            if (cookie1.getName().equals(SessionName.cookieLang)) {
	            	lang = StringUtil.filter(cookie1.getValue());
	            }
	            //log.info(cookie1.getName() + " : " + cookie1.getValue() );
	        } 
		}
		
		if(!"".equals(lang)){
			if(!currentLang.equals(lang)){
				I18nUtil.setLang(request, lang);
			}
		}
		
		//I18nUtil.setLang(request);
		chain.doFilter(request, response);
	}

	public void destroy()
	{
		
	}


}
