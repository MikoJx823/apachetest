package com.project.servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * Servlet implementation class AdminCategoryServlet
 */
public class AdminCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(AdminCategoryServlet.class);
	
	private static final String ADD = "add";
	private static final String EDIT = "edit";
	private static final String SEARCH = "search";
	private static final String VIEW = "view";
	private static final String DELETE = "delete";
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/*response.setContentType("text/html");
		response.setHeader("Cache-Control", "no-cache");
		String actionType = request.getParameter("actionType");
		SmartUpload su = new SmartUpload();
		if (null == actionType){

			su.initialize(this.getServletConfig(), request, response);
			try{
				su.upload();
			}catch (Exception e){
				log.info(e);
			}

			actionType = su.getRequest().getParameter("actionType");
		}
		log.info("actionType:" + actionType);

		if(ADD.equals(actionType)){
			add(request, response, su);
		}else if(EDIT.equals(actionType)){
			edit(request, response, su);
		}else if(DELETE.equals(actionType)) {
			delete(request, response);
		}else if(SEARCH.equals(actionType)){
			search(request, response);
		}
		
	}
	
	private void delete(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "categoryIdx.jsp";
		String errorMsg = "";
		try{
			String itemName = "";
			AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
			String id = StringUtil.filter(request.getParameter("id"), StaticValueUtil.DEFAULT_VALUE);

			CategoryBean bean = CategoryService.getInstance().getBeanById(StringUtil.strToInt(id));
			
			if(bean != null) {
				bean.setStatus(StaticValueUtil.Delete);
				bean.setModifiedBy(loginUser.getLoginId());
				if(CategoryService.getInstance().delete(bean) != null){
					errorMsg = "Delete category ["+StringUtil.delHTMLTag(itemName)+"] success.";
				}
				else{
					errorMsg = "Delete category ["+StringUtil.delHTMLTag(itemName)+"] fail.";
				}
			}else {
				errorMsg = "Delete category ["+StringUtil.delHTMLTag(itemName)+"] fail.";
			}

			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			
			search(request, response);
			
		}
		catch (Exception e)
		{
			log.error(e);
		}
	}
	
	private void add(HttpServletRequest req, HttpServletResponse resp, SmartUpload su) {
		String resultUrl = "categoryAdd.jsp";
		String errorMsg = "";
		
		//if (!req.getSession().getAttribute(SessionName.token).equals(req.getParameter(SessionName.token)))
		//	return ;
		
		
		try
		{	
			su.setMaxFileSize(10000);
			su.setTotalMaxFileSize(20000);
			//su.setAllowedFilesList("jpg,gif,JPG,GIF,jpeg,PNG,png");
			su.setAllowedFilesList("jpg,JPG,jpeg,PNG,png");
			
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute("loginUser");

			String name = StringUtils.trimToEmpty(su.getRequest().getParameter("eName"));
			String desc = StringUtils.trimToEmpty(su.getRequest().getParameter("eDesc")==null?"":su.getRequest().getParameter("eDesc"));
			int isparent = StringUtil.strToInt(su.getRequest().getParameter("isparent"));
			int parentid = StringUtil.strToInt(su.getRequest().getParameter("parentid"));
			int seq = StringUtil.strToInt(StringUtil.filter(su.getRequest().getParameter("seq")));
			int status = StringUtil.trimToInt(StringUtil.trimToStr(su.getRequest().getParameter("status"),(StaticValueUtil.Inactive + "")));
			
			CategoryBean category = new CategoryBean();
			if(isparent == StaticValueUtil.STATUS_ENABLE) {
				category.setParentId(StaticValueUtil.PARENT_CAT);
			}else {
				category.setParentId(parentid);
			}
			category.setName(name);
			category.setDesc(desc);
			category.setSeq(seq);
			category.setParentId(parentid);
			category.setStatus(status);
			category.setCreatedBy(loginUser.getLoginId());
			
			errorMsg = this.checkInfo(category);

			
			if ("".equals(errorMsg)){
				if(CategoryService.getInstance().insert(category) == null){
					errorMsg = "Add category [" + category.getName() + " ] fail.";
					resultUrl = "categoryAdd.jsp";
					req.setAttribute(SessionName.beanInfo, category);
				}else{
					errorMsg = "Add category [ " + category.getName() + " ] success.";
					resultUrl = "categoryView.jsp?id="+category.getId();
				}
			}else{
				resultUrl = "categoryAdd.jsp";
				req.setAttribute(SessionName.beanInfo, category);
			}
			
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			req.getSession().setAttribute("msgAlertBean", msgAlertBean);
			req.getRequestDispatcher(resultUrl).forward(req, resp);
			//resp.sendRedirect(resultUrl);

		}
		catch (Exception e)
		{
			log.info(e);
		}
		
	}
	
	private void edit(HttpServletRequest req,HttpServletResponse resp, SmartUpload su) {
		// TODO Auto-generated method stub
		
		//if (!req.getSession().getAttribute(SessionName.token).equals(req.getParameter(SessionName.token)))
		//	return ;
		
		//String resultUrl = "categoryUpdate.jsp?id="+req.getParameter("id");
		String resultUrl = "categoryView.jsp?id=";
		String errorMsg = "";
		
		
		try
		{
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute("loginUser");
			
			//su.setMaxFileSize(10000);
			//su.setTotalMaxFileSize(20000);
			//su.setAllowedFilesList("jpg,JPG,jpeg,PNG,png");
					
			int id = StringUtil.strToInt(StringUtils.trimToEmpty(su.getRequest().getParameter("id")));
			String name = StringUtils.trimToEmpty(su.getRequest().getParameter("name"));
			String desc = StringUtil.filter(su.getRequest().getParameter("desc"));
			//int isparent = StringUtil.strToInt(su.getRequest().getParameter("isparent"));
			int parentid = StringUtil.strToInt(su.getRequest().getParameter("parentid"));
			int seq = StringUtil.strToInt(StringUtil.filter(su.getRequest().getParameter("seq")));
			int status = StringUtil.trimToInt(StringUtil.trimToStr(su.getRequest().getParameter("status"),(StaticValueUtil.Inactive + "")));
			
			CategoryBean category = CategoryService.getInstance().getBeanById(id);
			
			if(category == null) {
				errorMsg = "Update Category [" + name + "] fail.";
				req.getSession().setAttribute("category", category);

				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				search(req,resp);
				//resp.sendRedirect(resultUrl);
				return;
			}
			
			if(category.getParentId() == StaticValueUtil.STATUS_DISABLE){
				category.setParentId(parentid);
			}
			category.setName(name);
			category.setDesc(desc);
			category.setSeq(seq);
			category.setStatus(status);
			category.setModifiedBy(loginUser.getLoginId());

			errorMsg = this.checkInfo(category);
	
			if ("".equals(errorMsg)){
				if(CategoryService.getInstance().update(category)!=null){
					errorMsg = "Update Category ["+StringUtil.delHTMLTag(category.getName())+"] success.";
					resultUrl = "categoryView.jsp?id="+category.getId();
				}else{
					errorMsg = "Update Category ["+StringUtil.delHTMLTag(category.getName())+"] fail.";
					req.setAttribute(SessionName.beanInfo, category);
					resultUrl = "categoryUpdate.jsp?id="+category.getId();
					//resultUrl = "categoryView.jsp?id="+category.getId();
				}		
			}else{	
				resultUrl = "categoryUpdate.jsp?id="+category.getId();
				req.setAttribute(SessionName.beanInfo, category);
			}
			
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			req.getSession().setAttribute("msgAlertBean", msgAlertBean);
			req.getRequestDispatcher(resultUrl).forward(req, resp);
				
			//resp.sendRedirect(resultUrl);
			
		}catch (Exception e){
			log.info(e);
			e.getStackTrace();
		}
		
	}
	
	private void search(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		String resultUrl = "categoryIdx.jsp";
		
		try
		{
			String from = StringUtil.trimToEmpty(req.getParameter(SessionName.from));
			int pageIdx = StringUtil.trimToInt(req.getParameter(SessionName.pageIdx));
						
			String name = new String(StringUtils.trimToEmpty(req.getParameter(SessionName.searchName)).getBytes("ISO8859-1"), "utf-8");
			String parent = StringUtils.trimToEmpty(req.getParameter(SessionName.searchParent));
			String status = StringUtils.trimToEmpty(req.getParameter(SessionName.searchStatus));

			if (SessionName.fromMenu.equals(from)){
				req.getSession().removeAttribute(SessionName.searchName);
				req.getSession().removeAttribute(SessionName.searchParent);
				req.getSession().removeAttribute(SessionName.searchStatus);
				req.getSession().removeAttribute(SessionName.pageIdx);
			}	
			else if (SessionName.fromSearch.equals(from)){
				req.getSession().setAttribute(SessionName.searchName, name);
				req.getSession().setAttribute(SessionName.searchParent, parent);
				req.getSession().setAttribute(SessionName.searchStatus, status);
				req.getSession().setAttribute(SessionName.pageIdx, "0");
			}
			else{				
				name = StringUtil.trimToEmpty(req.getSession().getAttribute(SessionName.searchName));
				status = StringUtil.trimToEmpty(req.getSession().getAttribute(SessionName.searchStatus));
				parent = StringUtil.trimToEmpty(req.getSession().getAttribute(SessionName.searchParent));
				
				if (pageIdx == 0)
					pageIdx = StringUtil.strToInt((String) req.getSession().getAttribute(SessionName.pageIdx));

			}
			
			if (pageIdx == 0)
				pageIdx = 1;
	
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);
			
			CategoryService categoryService = CategoryService.getInstance();
			
			String sqlWhere = "where 1=1 ";
		
			if (!"".equals(name)){
				sqlWhere += " and name like '%" + name + "%' ";
			}
			if(!"".equals(parent)){
				sqlWhere += " and parentid = " + parent ;
			}
			if (!"".equals(status)){
				sqlWhere += " and status = " + status ;
			}
			
			sqlWhere += " order by id desc";
			
			List<CategoryBean> categoryList = categoryService.getListBySqlwhereWithPage(sqlWhere, pageIdx);
			
			int totalPages = categoryService.getTotalPages(pageIdx, sqlWhere);
			
			req.setAttribute(SessionName.beanList, categoryList);
			req.setAttribute(SessionName.pageIdx, pageIdx);
			req.setAttribute(SessionName.totalPages, totalPages);
			
			req.getRequestDispatcher(resultUrl).forward(req, resp);
		}
		catch (Exception e)
		{
			log.error(e);
		}
		
	}
	
	private String checkInfo(CategoryBean bean){
		String result = "";
		
		if("".equals(bean.getName())){
			result += "Name is required <br>";
		}
		
		if(bean.getParentId() < StaticValueUtil.PARENT_CAT || bean.getParentId() == StaticValueUtil.DEFAULT_VALUE){
			result += "Incorrent parent id <br>";	
		}
		
		if(bean.getSeq() < StaticValueUtil.DEFAULT_VALUE) {
			result += "Incorrect sequence <br>";
		}
		
		if(bean.getStatus() != StaticValueUtil.Active && bean.getStatus() != StaticValueUtil.Inactive){
			result += "Invalid status <br>";
		}
		
		return result;*/
	}
}