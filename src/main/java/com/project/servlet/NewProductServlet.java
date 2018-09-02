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
 * Servlet implementation class NewProductServlet
 */
public class NewProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger log = Logger.getLogger(ProductListServlet.class);
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");

		String resultUrl = "cart/new.jsp";
		int itemCount = 0;
		
		try{
			String from = StringUtil.filter(request.getParameter(SessionName.from));
			int pageIdx = StringUtil.trimToInt(request.getParameter(SessionName.pageIdx));
			String search = StringUtil.filter(request.getParameter("search"));
			String categoryId = StringUtil.filter(request.getParameter("categoryid"), StaticValueUtil.CAT_MAKEUP);
			
			if ("menu".equals(from)){
				//request.getSession().removeAttribute("parentId");
				request.getSession().removeAttribute("categoryid");
				request.getSession().removeAttribute(SessionName.pageIdx);
			}	
			/*else if ("search".equals(from)){
				request.getSession().setAttribute("parentId", cParentId);
				request.getSession().setAttribute("categoryId", categoryId);
				request.getSession().setAttribute(SessionName.pageIdx, "0");
			}*/
			else{		
				if (pageIdx == 0)
					pageIdx = StringUtil.strToInt((String) request.getSession().getAttribute(SessionName.pageIdx));

			}
			
			if (pageIdx == 0)
				pageIdx = 1;

			ProductService service = ProductService.getInstance();
			String ids = service.getProductIdsForNew();
			List<ProductBean> products = new ArrayList<ProductBean>();
			
			if(!"".equals(ids)) products = service.getProductBySqlwhere(" where id in (" + ids + ") order by name");
			//itemCount = service.getTotalItems(sqlWhere);//.getProductBySqlwhere(sqlWhere).size();
			//int totalPages = service.getFrontTotalPages(pageIdx, sqlWhere);
		
			request.setAttribute("new", products);
			request.setAttribute(SessionName.pageIdx, pageIdx);
			//request.setAttribute(SessionName.totalPages, totalPages);
			request.setAttribute("categoryId", categoryId);
			request.setAttribute("search", search);
			//request.setAttribute("categorymap", categoryMap);
			request.setAttribute(SessionName.itemCount, itemCount);

			request.getRequestDispatcher(resultUrl).forward(request, response);
			return;
		}catch (Exception e)
		{
			log.error(e);
		}
	}

}
