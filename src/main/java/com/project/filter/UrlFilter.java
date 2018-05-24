package com.project.filter;


import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.project.bean.AdminInfoBean;
import com.project.util.PropertiesUtil;

/**
 * Servlet Filter implementation class UrlFilter
 */

public class UrlFilter implements Filter {
	Logger log = Logger.getLogger(UrlFilter.class);
	 public void init(FilterConfig config) throws ServletException {
		 //
	 }

	 public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {
	        
		 HttpServletRequest request = (HttpServletRequest) req;
		 HttpServletResponse response = (HttpServletResponse) res;
		 HttpSession session = request.getSession();   
	     
		 String requestURI = request.getRequestURI();
	     String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	     AdminInfoBean loginUser = (AdminInfoBean) session.getAttribute("loginUser");
	     log.info("FILTER " + requestURI); 
	        
	     /*if (requestURI.startsWith("/" + PropertiesUtil.getProperty("virtualHost.admin"))) {
	        if(loginUser != null){
	        	//String newURI = PropertiesUtil.getProperty("virtualHost.admin") + "LoginServlet";
	        	
	        	String toReplace = requestURI.substring(PropertiesUtil.getProperty("virtualHost.admin").length() + 1 , requestURI.length());
	            
	        	log.info("to replace " + toReplace);
	        	String newURI = requestURI.replace(toReplace, "Test");
	        	log.info("new URI " + newURI);
	            
	        	
	        	req.getRequestDispatcher(newURI).forward(req, res);
	            return;
	        }else{
	        	chain.doFilter(req, res);
	        }
	     }else{
	    	 chain.doFilter(req, res);
	     }*/
		 chain.doFilter(req, res);   
	     return;
	}

	public void destroy() {
	//
	}

}
