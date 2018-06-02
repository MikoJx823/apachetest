package com.project.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.CategoryBean;
import com.project.bean.ProductBean;
import com.project.service.CategoryService;
import com.project.service.ProductService;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class ProductListServlet
 */
public class ProductListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static Logger log = Logger.getLogger(ProductListServlet.class);
	private static final String search = "search";
	

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String actionType = request.getParameter("actionType");
			
		log.info("actionType : " + actionType);	
		search(request, response);
		
		return;
	}
	
	private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");

		String resultUrl = "cart/products.jsp";
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
			//CategoryService categoryService = CategoryService.getInstance();
			
			String sqlWhere = " where status = " + StaticValueUtil.Active + " and displaystart < now() and displayend > now() ";
			
			//if(!"".equals(categoryId)) {
			CategoryBean category = CategoryService.getInstance().getBeanById(StringUtil.strToInt(categoryId));
				
			if(category != null) {
				if(category.getParentId() == StaticValueUtil.PARENT_CAT) {
					sqlWhere += " and categoryid in (Select id from category where parentid = " + categoryId+ " or id = " + categoryId +")";
				}else {
					sqlWhere += " and categoryid in (" + categoryId + ")";
				}
			}
			//}
			
			if(!"".equals(search)) {
				sqlWhere += " and name like '%" + search +"%' "; 
			}
			
			sqlWhere += " order by name"  ;

			//GENERATE CATEGORY LIST FOR FILTER  
			/*List<CategoryBean> categories = CategoryService.getInstance().getListBySqlwhere(" where status = " + StaticValueUtil.Active + " order by parentid");
			Map<Integer, String> categoryMap = new HashMap<Integer,String>();
			for(CategoryBean category : categories ) {
				if(category.getParentId() == StaticValueUtil.PARENT_CAT) {
					String categoryInStr = category.getId() + ",";
					for(CategoryBean cat: categories) {
						if(cat.getParentId() == category.getId()) {
							categoryInStr += category.getId() + ",";
						}
					}
					
					if(categoryInStr.endsWith(",")) {
						categoryInStr = categoryInStr.substring(0, categoryInStr.length() - 1);
					}
					
					int count = ProductService.getInstance().getCountActiveProdByCategory(categoryInStr);
					
					categoryMap.put(category.getId(), category.getId() + " | " + StringUtil.filter(category.getName()) + " | " + count );
				}
			}*/
			
			
			List<ProductBean> products = service.getProductFrontBySqlWhereWithPage(sqlWhere, pageIdx);
			itemCount = service.getTotalItems(sqlWhere);//.getProductBySqlwhere(sqlWhere).size();
			int totalPages = service.getFrontTotalPages(pageIdx, sqlWhere);
		
			request.setAttribute(SessionName.products, products);
			request.setAttribute(SessionName.pageIdx, pageIdx);
			request.setAttribute(SessionName.totalPages, totalPages);
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