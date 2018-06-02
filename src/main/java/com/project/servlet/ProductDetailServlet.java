package com.project.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.bean.ProductBean;
import com.project.service.ProductService;
import com.project.util.PropertiesUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class ProductDetailServlet
 */
public class ProductDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html"); 
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
	
		String resultUrl = "cart/product.jsp";
		//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
		String basePath = StringUtil.getHostAddress(); 
		
		String pid = StringUtil.filter(request.getParameter("id"));
		String parentId = StringUtil.filter(request.getParameter("parentid"));
		String categoryId = StringUtil.filter(request.getParameter("categoryid"));
		
		ProductBean product = ProductService.getInstance().getFrontBeanDetailById(StringUtil.strToInt(pid));
		//String sqlWhere = " where id = "+ pid +" and status = " + StaticValueUtil.Active + " and displayStartDate < now() and displayEndDate > now() ";
		//List<ProductBean> products = ProductService.getInstance().getProductBySqlwhere(sqlWhere);
		
		if(product == null) {
			resultUrl = "index.jsp";
			response.sendRedirect(basePath + resultUrl);
			return;
		}
		
		request.setAttribute("product", product);
		request.setAttribute("parentid", parentId);
		request.setAttribute("categoryid", categoryId);
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
		requestDispatcher.forward(request, response);
		return;
	}
}
