package com.project.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.ProductBean;
import com.project.service.ProductService;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class SearchServlet
 */
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
private static Logger log = Logger.getLogger(SearchServlet.class);
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");

		String resultUrl = "cart/search.jsp";
		int itemCount = 0;
		
		try{
			int pageIdx = StringUtil.trimToInt(request.getParameter(SessionName.pageIdx));
			String key = StringUtil.filter(request.getParameter("key"));
			
			if (pageIdx == 0)
				pageIdx = 1;

			ProductService service = ProductService.getInstance();
			
			String sqlWhere = " where status = " + StaticValueUtil.Active + 
							 // " and displaystart < now() and displayend > now()" + 
							  " and name like '%" + key + "%' order by name";
			
			List<ProductBean> products = new ArrayList<ProductBean>();
			int totalPages = 0;
			
			if(!"".equals(key)) {	
				products = service.getFrontSearchBySqlWhereWithPage(sqlWhere, pageIdx);
				itemCount = service.getTotalItems(sqlWhere);//.getProductBySqlwhere(sqlWhere).size();
				totalPages = service.getFrontTotalPages(pageIdx, sqlWhere);
			}
		
			request.setAttribute(SessionName.products, products);
			request.setAttribute(SessionName.pageIdx, pageIdx);
			request.setAttribute(SessionName.totalPages, totalPages);
			request.setAttribute("key", key);
			request.setAttribute(SessionName.itemCount, itemCount);

			request.getRequestDispatcher(resultUrl).forward(request, response);
			return;
		}catch (Exception e)
		{
			log.error(e);
		}
	}
}