package com.project.servlet.admin;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.AdminGroupFunction;
import com.project.bean.AdminInfoBean;
import com.project.bean.GroupInfoBean;
import com.project.bean.MsgAlertBean;
import com.project.dao.AdminDao;
import com.project.dao.ConectionFactory;
import com.project.service.AdminService;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class GroupServlet
 */
public class GroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(GroupServlet.class);

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		resp.setContentType("text/html");
	//	resp.setCharacterEncoding("UTF-8");
		resp.setHeader("Cache-Control", "no-cache");
		
		AdminService.getInstance().checkLogin(req, resp);
		
		String actionType = req.getParameter("actionType");
		log.info("actionType:" + actionType);

		if ("groupAdd".equals(actionType))
		{
			groupAdd(req, resp);
		}
		else if ("groupDel".equals(actionType))
		{
			groupDel(req, resp);
		}
		else if ("groupUpdate".equals(actionType))
		{
			groupUpdate(req, resp);
		}
	}
	private void groupDel(HttpServletRequest req, HttpServletResponse resp)
	{
		String resultUrl = "groupIdx.jsp";
		String errorMsg = "";
		Connection conn = null;
		try
		{
			conn = ConectionFactory.getConnection();
			String gid = StringUtil.filter(req.getParameter("gid"), "0");
			System.out.println("AAAAAAAAAAAAAAA:"+gid);
			
			if(AdminService.getInstance().delGroupInfoByGid(Integer.valueOf(gid)))
			{
				AdminService.getInstance().delAdminInfoByGid(Integer.valueOf(gid));
				AdminDao.deleteAdminGroupFunctionByAgid(Integer.valueOf(gid), conn);
				errorMsg = "Delete Group success.";
			}
			else
			{
				errorMsg = "Delete Group fail.";
			}
			
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			req.getSession().setAttribute("msgAlertBean", msgAlertBean);
			
			resp.sendRedirect(resultUrl);
			
		}
		catch (Exception e)
		{
			log.error(e);
		}
	}
	
	private void groupAdd(HttpServletRequest req, HttpServletResponse resp)
	{
		String resultUrl = "groupAdd.jsp";
		String errorMsg = "";
		try
		{		
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);
			
			String groupName = StringUtil.filter(req.getParameter("groupName"));
			String description = StringUtil.filter(req.getParameter("description"));
			
			Date nowDate = new Date();
			GroupInfoBean adminGroup = new GroupInfoBean();
			adminGroup.setGroupName(groupName);
			adminGroup.setDescription(description);
			adminGroup.setCreatedBy(loginUser.getLoginId());
			adminGroup.setCreatedDate(nowDate);
			
			List adminFunctionList = new ArrayList<AdminGroupFunction>();
			
			Enumeration<?> functions = req.getParameterNames(); 
			while (functions.hasMoreElements()) {
				String functionname = (String)(functions.nextElement());
				
				if (functionname.startsWith("sys")) {
					String accessRight = req.getParameter(functionname)==null?"N":req.getParameter(functionname);
					int functionId=Integer.parseInt(functionname.substring(functionname.lastIndexOf("_")+1));
					AdminGroupFunction adminGroupFunction=new AdminGroupFunction();
					adminGroupFunction.setFid(functionId);
					adminGroupFunction.setAccessRight(accessRight);
					adminGroupFunction.setCreatedBy(loginUser.getLoginId());
					adminGroupFunction.setCreatedDate(nowDate);
					adminFunctionList.add(adminGroupFunction);
				}
			}
			
			errorMsg = this.checkUserInfo(adminGroup);
			
			if ("".equals(errorMsg))
			{
				adminGroup = AdminService.getInstance().addAdminGroup(adminGroup, adminFunctionList);
				log.info("here ");
				if (adminGroup == null)//adminGroup.getGid() == 0)
				{
					errorMsg = "System error.";
				}
				else
				{
					log.info("added");
					errorMsg = "Add user group successfully.";
					resultUrl = "groupView.jsp?gid=" + adminGroup.getGid();
				}
			}else {
				resultUrl = "groupAdd.jsp";
				
			}
			req.setAttribute("adminGroup", adminGroup);
			req.setAttribute("adminFunctions", adminFunctionList);
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			req.getSession().setAttribute("msgAlertBean", msgAlertBean);
			req.getRequestDispatcher(resultUrl).forward(req, resp);
			
		}
		catch (Exception e)
		{
			log.info(e);
		}
	}
	
	private void groupUpdate(HttpServletRequest req, HttpServletResponse resp)
	{
		String resultUrl = "groupUpdate.jsp";
		String errorMsg = "";
		try
		{
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);
			
			String gid = StringUtil.filter(req.getParameter("gid"));
			String groupName = StringUtil.filter(req.getParameter("groupName"));
			String description = StringUtil.filter(req.getParameter("description"));
			/*
			String[] rightsIdArray = req.getParameterValues("rightsId");
			String ridStr = "";
			if (rightsIdArray != null)
			{
				for (int i = 0; i < rightsIdArray.length; i++)
				{
					ridStr += rightsIdArray[i] + ",";
				}
				if (ridStr.length() > 1)
				{
					ridStr = ridStr.substring(0, ridStr.length() - 1);
				}
			}
			String sqlWhere = " where rid in(" + ridStr + ")";
			
			List<RightsInfoBean> rightsList = AdminService.getInstance().getRightsListBySqlwhere(sqlWhere);
			*/
			GroupInfoBean groupBean = AdminService.getInstance().getGroup(Integer.valueOf(gid));
			
			Date nowDate = new Date();
			groupBean.setGroupName(groupName);
			groupBean.setDescription(description);
			groupBean.setModifiedBy(loginUser.getLoginId());
			groupBean.setModifiedDate(nowDate);

			List adminFunctionList = new ArrayList<AdminGroupFunction>();
			
			Enumeration<?> functions = req.getParameterNames(); 
			while (functions.hasMoreElements()) {
				String functionname = (String)(functions.nextElement());
				
				if (functionname.startsWith("sys")) {
					String accessRight = req.getParameter(functionname)==null?"N":req.getParameter(functionname);
					int functionId=Integer.parseInt(functionname.substring(functionname.lastIndexOf("_")+1));
					AdminGroupFunction adminGroupFunction=new AdminGroupFunction();
					adminGroupFunction.setFid(functionId);
					adminGroupFunction.setAccessRight(accessRight);
					adminGroupFunction.setCreatedBy(loginUser.getLoginId());
					adminGroupFunction.setCreatedDate(nowDate);
					adminFunctionList.add(adminGroupFunction);
				}
			}
			
			errorMsg = this.checkUserInfo(groupBean);
			
			if ("".equals(errorMsg))
			{
		
				groupBean = AdminService.getInstance().updateAdminGroup(groupBean, adminFunctionList);
				
				if(groupBean==null)
				{
					errorMsg = "Update fail.";
				}
				else
				{
					errorMsg = "Update group success.";
				}
				
				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				resultUrl = "groupView.jsp?gid="+gid;
			}
			else
			{
				req.setAttribute("groupInfoBean", groupBean);
				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				// has errorMsg
				resultUrl = "groupUpdate.jsp?gid="+gid;
			}
			
			req.getRequestDispatcher(resultUrl).forward(req, resp);
			//resp.sendRedirect(resultUrl);
			
		}
		catch (Exception e)
		{
			log.info(e);
		}
	}
	
	private String checkUserInfo(GroupInfoBean bean)
	{
		String result = "";
		if ("".equals(bean.getGroupName()) || bean.getGroupName().length() > 80)
		{
			result = "Incorrect input group name. <br>";
		}
		
		if(AdminService.getInstance().hasExistGroup(bean))
		{
			result += "Group name existed. <br>";
		}
		
		return result;
	}
}
