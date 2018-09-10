package com.project.servlet.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.AdminInfoBean;
import com.project.bean.IndexInfoBean;
import com.project.bean.MsgAlertBean;
import com.project.service.AdminService;
import com.project.service.IndexService;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class AdminIndexServlet
 */
public class AdminIndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(AdminIndexServlet.class);
	  
	private static final String ADD = "add";
	private static final String DELETE = "delete";
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		response.setHeader("Cache-Control", "no-cache");
		String actionType = request.getParameter("actionType");
		
		AdminService.getInstance().checkLogin(request, response);
		
		log.info("actionType:" + actionType);
		
		if(actionType.equals(ADD)){
			add(request, response);
		}else if(actionType.equals(DELETE)){
			delete(request, response);
		}
		return; 
	}

	private void delete(HttpServletRequest request, HttpServletResponse response){
		
		log.info("DELETE ");
		String resultUrl = "indexIdx.jsp";
		String errorMsg = "";
		try{
			String itemName = "";
			AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
			String id = StringUtil.filter(request.getParameter("id"), StaticValueUtil.DEFAULT_VALUE);

			IndexInfoBean bean = IndexService.getInstance().getBeanById(StringUtil.strToInt(id));
			
			if(bean != null) {
				bean.setStatus(StaticValueUtil.Delete);
				bean.setModifiedBy(loginUser.getLoginId());
				if(IndexService.getInstance().update(bean) != null){
					//DELETE FILE HERE;
					errorMsg = "Delete index item success.";
				}
				else{
					errorMsg = "Delete index item fail.";
				}
			}else {
				errorMsg = "Delete index item fail.";
			}

			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			request.getRequestDispatcher(resultUrl).forward(request, response);
			
		}catch (Exception e){
			log.error(e);
		}
	}
	
	private void add(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "indexIdx.jsp";
		String errorMsg = "";
		
		log.info("ADD INSIDE ");
		try{
			
			AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
			
			int pid = StringUtil.strToInt(request.getParameter("pid"));
			int type = StringUtil.strToInt(request.getParameter("type"));
			
			IndexInfoBean bean = new IndexInfoBean();
			bean.setPid(pid);
			bean.setType(type);
			bean.setStatus(StaticValueUtil.Active);
			bean.setCreatedBy(loginUser.getLoginId());
			
			log.info("pid  " + pid);
			
			errorMsg += this.checkInfo(bean);
			
			if ("".equals(errorMsg)){
				//STORE BEAN 
				if(IndexService.getInstance().insert(bean) != null){
					errorMsg = "Add Index success.";						
				}else{
					errorMsg = "Add Index failed.";
				}
				log.info("errorMsg: " +errorMsg);
				log.info("resultUrl: " +resultUrl);
			}

			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			request.setAttribute(SessionName.beanInfo, bean);
			request.getRequestDispatcher(resultUrl).forward(request, response);

		}
		catch (Exception e)
		{
			log.error(e);
			e.printStackTrace();
		}
		
	}
	
	private String checkInfo(IndexInfoBean bean){
		String errorMsg = "";
		
		if(bean.getPid() <= 0){
			errorMsg += "Product is required. <br>";
		}else {
			List<IndexInfoBean> index = IndexService.getInstance().getListBySqlwhere(" where status != " + StaticValueUtil.Delete + " and pid = " + bean.getPid() + " and type = " + bean.getType());
			if(index != null && index.size() > 0) {
				errorMsg += "Existed product. <br>";
			}
		}
		
		if(bean.getType() != StaticValueUtil.INDEX_LATEST && bean.getType() != StaticValueUtil.INDEX_TOP_RATED){
			errorMsg += "Incorrect index display type. <br>";
		}
		
		return errorMsg;
	}
}
