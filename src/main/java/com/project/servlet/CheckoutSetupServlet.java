package com.project.servlet;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.OrderItemBean;
import com.project.util.SessionName;

/**
 * Servlet implementation class CheckoutSetupServlet
 */
public class CheckoutSetupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(CheckoutSetupServlet.class);
	
	@Override
	protected void service(HttpServletRequest request,  HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html"); 
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		
		String resultUrl = "cart/checkout.jsp";
		//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
		
		HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap) == null ? 
				new HashMap<String, OrderItemBean>() : (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap);
				
		if (cartMap== null || cartMap.isEmpty()){
			resultUrl = "cart/cartsummary.jsp";
		}
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
		requestDispatcher.forward(request, response);
		//response.sendRedirect(basePath + resultUrl);
		return;

	}
}
