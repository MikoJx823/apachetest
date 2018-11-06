package com.project.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.MemberInfoBean;
import com.project.service.MemberService;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class MemberLoginServlet
 */

public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Logger log = Logger.getLogger(MemberLoginServlet.class);
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
 	    response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    response.setHeader("Cache-Control", "no-cache");
 	    
		String errorMsg = "";
    	String loginId = StringUtil.filter(request.getParameter("loginId"));
		String password = StringUtil.filter(request.getParameter("password"));
		
		if("".equals(loginId)){
			errorMsg += "Invalid Login Id \\n";
		}
		
		if("".equals(password)){
			errorMsg += "Invalid Password \\n";
		}
		
		if(!"".equals(errorMsg)){
			JSONObject jsonObject = new JSONObject();
			jsonObject.put(SessionName.errorMsg, errorMsg);
		 	jsonObject.put(SessionName.successCode, StaticValueUtil.STATUS_NO);
		 		
		 	PrintWriter out = response.getWriter();
		 	out.print(jsonObject);		
		 	return;
		}

		MemberInfoBean member = MemberService.getInstance().getBeanByIdPassword(loginId, password);
		
		if(member == null){
	    	errorMsg = "Invalid username or password" ;
	    	
			JSONObject jsonObject = new JSONObject();
			jsonObject.put(SessionName.errorMsg, errorMsg);
		 	jsonObject.put(SessionName.successCode, StaticValueUtil.STATUS_NO);
		 		
		 	PrintWriter out = response.getWriter();
		 	out.print(jsonObject);		
		 	return;
		}
		
		if(member.getStatus() != StaticValueUtil.Active) {
			errorMsg = "Account was deactivated. Please contact us to reactive account. ";
			
			JSONObject jsonObject = new JSONObject();
			jsonObject.put(SessionName.errorMsg, errorMsg);
		 	jsonObject.put(SessionName.successCode, StaticValueUtil.STATUS_NO);
		 		
		 	PrintWriter out = response.getWriter();
		 	out.print(jsonObject);		
		 	return;
		}
        
		request.getSession().setAttribute(SessionName.loginMember, member);
		
		log.info("***************************************************************");
		log.info("Member - [" + StringUtil.filter(member.getEmail()) + "] login at " + new Date() );
		log.info("***************************************************************");
        
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(SessionName.successCode, StaticValueUtil.STATUS_YES);
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
	  	
		return;
	}
}