package com.project.servlet.admin;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.AdminInfoBean;
import com.project.bean.MsgAlertBean;
import com.project.service.AdminService;
import com.project.util.MailUtil;
import com.project.util.RandomNumber;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class UserServlet
 */
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(UserServlet.class);

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		resp.setContentType("text/html");
	//	resp.setCharacterEncoding("UTF-8");
		resp.setHeader("Cache-Control", "no-cache");

		AdminService.getInstance().checkLogin(req, resp);
		
		String actionType = req.getParameter("actionType");
		log.info("actionType:" + actionType);

		if ("userAdd".equals(actionType))
		{
			userAdd(req, resp);
		}
		else if ("userDel".equals(actionType))
		{
			userDel(req, resp);
		}
		else if ("userUpdate".equals(actionType)){
			userUpdate(req, resp);
		}else if("getUserList".equals(actionType)){
			getUserList(req, resp);
		}else if("userPasswordUpdate".equals(actionType)){
			userPasswordUpdate(req, resp);
		}else if("resetPwd".equals(actionType)){
			resetPwd(req, resp);
		}
	}

	private void resetPwd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// TODO Auto-generated method stub
		
		String errorMsg = "";
		String resultUrl = "pwdResetSuccess.jsp";
		int aid = StringUtil.strToInt(req.getParameter("aid"));
		AdminInfoBean admin = AdminService.getInstance().getAdminInfoBeanByAid(aid);
		
		String defaultPass = RandomNumber.genRandomNum(8);
		admin.setPassword(StringUtil.encryptString(defaultPass));
		
		admin = AdminService.getInstance().updateAdminInfoBean(admin);
		
		if(admin==null)
		{
			errorMsg = "Update user fail.";
		}
		else
		{	
			admin.setPassword(defaultPass);
			MailUtil.getInstance().sendUserResetPwd(admin);
			
			errorMsg = "Reset Admin User [ " + admin.getLoginId() + " ] password success, please tell user check the email.";
		}
		
		MsgAlertBean msgAlertBean = new MsgAlertBean();
		msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
		msgAlertBean.setMsg(errorMsg);
		msgAlertBean.setFocusId("msgAlert");
		req.getSession().setAttribute("msgAlertBean", msgAlertBean);
	
	     resp.sendRedirect(resultUrl);

		
	}

	private void userPasswordUpdate(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String errorMsg = "";
		String resultPage = "passwordUpdate.jsp";
		AdminInfoBean loginAdmin = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);

	
		String oldPassword = StringUtil.filter(req.getParameter("curPwd"));
		String newPassword = StringUtil.filter(req.getParameter("newPwd"));
		String rePassword = StringUtil.filter(req.getParameter("rePwd"));
		
		int aid = StringUtil.strToInt(req.getParameter("aid"));

		AdminInfoBean admin = AdminService.getInstance().getAdminInfoBeanByAid(aid);

		if (aid != loginAdmin.getAid() || admin == null)
		{
			errorMsg = "Record not found.";
			resultPage = "myProfile.jsp";
		}
		else if (!StringUtil.encryptString(oldPassword).equals(admin.getPassword()))
		{
			errorMsg = "The entered old password is incorrect.<br>";
			resultPage = "passwordUpdate.jsp";
		}
		else if (!(newPassword.equals(rePassword))){
			errorMsg = "The confirm password is does not match.<br>";
			resultPage = "passwordUpdate.jsp";
		}
		else
		{			
			admin.setPassword(StringUtil.encryptString(newPassword));
			
			admin.setUpdatedDate(new Date());
	
			
			if ("".equals(errorMsg))
			{
				admin =AdminService.getInstance().updateAdminInfoBean(admin);
				if (admin == null)
				{
					errorMsg = "System error.";
					resultPage = "passwordUpdate.jsp";
				}
				else
				{
					errorMsg = "Update successfully.";
					resultPage = "myProfile.jsp";
				}
			}
		}

		MsgAlertBean msgAlertBean = new MsgAlertBean();
		msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
		msgAlertBean.setMsg(errorMsg);
		msgAlertBean.setFocusId("msgAlert");
		req.getSession().setAttribute("msgAlertBean", msgAlertBean);
		req.getRequestDispatcher(resultPage).forward(req, resp);
		
		
	}
	
	private void getUserList(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		String resultUrl = "systemIndex.jsp";
		String sqlWhere = "";
		String from = StringUtil.filter(req.getParameter("from")).equals("")? "menu" : StringUtil.filter(req.getParameter("from"));
		int pageIdx = StringUtil.trimToInt(req.getParameter("pageIdx"));
		String loginId = StringUtil.filter(req.getParameter("loginId"));
		String loginName = StringUtil.filter(req.getParameter("loginName"));
		String gid = StringUtil.filter(req.getParameter("gid"));
		String status = StringUtil.filter(req.getParameter("status"));
						 
		try
		{	
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);
			sqlWhere = " where 1=1 ";
			
			if(from.equals("menu")){
				req.getSession().removeAttribute("loginName");
				req.getSession().removeAttribute("loginId");
				req.getSession().removeAttribute("gid");
				req.getSession().removeAttribute("status");
				
			}else if(from.equals("search")) {
				req.getSession().setAttribute("loginName", loginName);
				req.getSession().setAttribute("loginId",loginId);
				req.getSession().setAttribute("gid",gid);
				req.getSession().setAttribute("status", status);
				req.getSession().setAttribute("pageIdx", "0");
			}else {
				loginName = StringUtil.filter((String)req.getSession().getAttribute("loginName"));
				loginId = StringUtil.filter((String)req.getSession().getAttribute("loginId"));
				gid = StringUtil.filter((String)req.getSession().getAttribute("gid"));
				status = StringUtil.filter((String)req.getSession().getAttribute("status"));
			}
			
			if (pageIdx == 0)
				pageIdx = 1;
			
			if(!("".equals(loginId))) {
				sqlWhere += " and loginId like '%" + loginId + "%'" ;
			}
			
			if(!("".equals(loginName))) {
				sqlWhere += " and name like '%" + loginName + "%'";
			}
			
			if(!("".equals(gid))) {
				sqlWhere += " and gid = '" + gid + "'";
			}
			
			if(!"".equals(status)){
				sqlWhere += " and status = " + status;
			}else {
				sqlWhere += " and status != " + StaticValueUtil.Delete;
			}
			
			/*if(!("0".equals(status)) && !("".equals(status))) {
				sqlWhere += " status = " + status ;
			}else {
				sqlWhere += " status != " + StaticValueUtil.Delete;
			}*/
			
			//List<AdminInfoBean> userlist = AdminService.getInstance().getAdminInfoBeanListBySqlwhere(sqlWhere);
			List<AdminInfoBean> userlist = AdminService.getInstance().getListBySqlwhereWithPage(sqlWhere, pageIdx);

			int totalPages = AdminService.getInstance().getUserTotalPages(pageIdx, sqlWhere);
			
			req.setAttribute("userlist", userlist);
			req.setAttribute("pageIdx", pageIdx);
			req.setAttribute("totalPages", totalPages);
			
			req.getRequestDispatcher(resultUrl).forward(req, resp);
		}
		catch (Exception e)
		{
			log.error(e);
		}
	}

	private void userUpdate(HttpServletRequest req, HttpServletResponse resp)
	{
		String resultUrl = "userUpdate.jsp";
		String errorMsg = "";
		try
		{
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);
			
			String aid = StringUtil.filter(req.getParameter("aid"));
			String name = StringUtil.filter(req.getParameter("name")==null?"":req.getParameter("name"));
			String loginId = StringUtil.filter(req.getParameter("loginId")==null?"":req.getParameter("loginId"));
			String email = StringUtil.filter(req.getParameter("email")==null?"":req.getParameter("email"));
			String gid = StringUtil.filter(req.getParameter("gid")==null?"":req.getParameter("gid"));
			//String bid = StringUtils.trimToEmpty(req.getParameter("bid")==null?"":req.getParameter("bid"));
			String status = StringUtil.filter(req.getParameter("status")==null?"":req.getParameter("status"));
			
			AdminInfoBean adminInfoBean = AdminService.getInstance().getAdminInfoBeanByAid(Integer.valueOf(aid));
			
			if(adminInfoBean == null){
				adminInfoBean = new AdminInfoBean();
				errorMsg = "Invalid User <br>";
			}
			
			adminInfoBean.setAid(Integer.valueOf(aid));
			adminInfoBean.setName(name);
			adminInfoBean.setLoginId(loginId);
			adminInfoBean.setEmail(email);
			adminInfoBean.setGid(Integer.valueOf(gid));
			//adminInfoBean.setBid(Integer.valueOf(bid));
			adminInfoBean.setStatus(status);			
			adminInfoBean.setUpdatedBy(loginUser.getAid()+"");
			adminInfoBean.setUpdatedDate(new Date());
			
			if("".equals(errorMsg))
				errorMsg = this.checkUserInfo(adminInfoBean);
			
			if ("".equals(errorMsg)){
				adminInfoBean = AdminService.getInstance().updateAdminInfoBean(adminInfoBean);
				
				if(adminInfoBean==null)
				{
					errorMsg = "Update user fail.";
				}
				else
				{
					errorMsg = "Update Admin User [ " + name + " ] success.";
				}
				
				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				resultUrl = "userView.jsp?aid="+aid;
			}
			else
			{
				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				req.setAttribute("userInfoBean", adminInfoBean);
				// has errorMsg
				resultUrl = "userUpdate.jsp?aid="+aid;
			}
			
			req.getRequestDispatcher(resultUrl).forward(req, resp);
			//resp.sendRedirect(resultUrl);

		}
		catch (Exception e)
		{
			log.info(e);
			e.printStackTrace();
		}
	}
	
	private void userDel(HttpServletRequest req, HttpServletResponse resp)
	{
		String resultUrl = "userIdx.jsp";
		String errorMsg = "";
		try
		{
			String aid = StringUtil.filter(req.getParameter("aid"), "0");

			if(AdminService.getInstance().delAdminInfoByAid(Integer.valueOf(aid)))
			{
				errorMsg = "Delete admin user success.";
			}
			else
			{
				errorMsg = "Delete admin user fail.";
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
	
	private void userAdd(HttpServletRequest req, HttpServletResponse resp)
	{
		String resultUrl = "systemIndex.jsp";
		String errorMsg = "";
		try
		{
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);
			
			String loginId = StringUtil.filter(req.getParameter("loginId"));
			String loginName = StringUtil.filter(req.getParameter("loginName"));
			String password = StringUtil.filter(req.getParameter("password"));
			String email = StringUtil.filter(req.getParameter("email"));
			String gid =  StringUtil.filter(req.getParameter("gid"),"0");
			String bid = StringUtil.filter(req.getParameter("bid"),"0");
			
			AdminInfoBean adminInfoBean = new AdminInfoBean();
			adminInfoBean.setLoginId(loginId);
			adminInfoBean.setName(loginName);
			adminInfoBean.setPassword(StringUtil.encryptString(password));
			adminInfoBean.setEmail(email);
			adminInfoBean.setGid(Integer.valueOf(gid));
			adminInfoBean.setBid(Integer.valueOf(bid));
			adminInfoBean.setStatus(StaticValueUtil.Active+"");
			adminInfoBean.setCreatedBy(loginUser.getAid()+"");
			adminInfoBean.setUpdatedBy(loginUser.getAid()+"");
			
			errorMsg = this.checkUserInfo(adminInfoBean);
			
			if ("".equals(errorMsg))
			{
				adminInfoBean = AdminService.getInstance().insertAdminInfoBean(adminInfoBean);
				
				if(adminInfoBean==null)
				{
					errorMsg = "Add admin user fail.";
				}
				else
				{
					errorMsg = "Add Admin User [ " + loginName + " ] success.";
				}
				
				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				resultUrl = "userView.jsp?aid="+adminInfoBean.getAid();
			}
			else
			{
				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				req.setAttribute("userInfoBean", adminInfoBean);
				// has errorMsg
				resultUrl = "userAdd.jsp";
			}
			
			req.getRequestDispatcher(resultUrl).forward(req, resp);
			//resp.sendRedirect(resultUrl);

		}
		catch (Exception e)
		{
			log.info(e);
		}
	}
	
	private String checkUserInfo(AdminInfoBean adminInfoBean)
	{
		String result = "";
		if("".equals(adminInfoBean.getName()))
		{
			result +="Please input name."+"<br>";
		}
		if("".equals(adminInfoBean.getLoginId()))
		{
			result +="Please input login."+"<br>";
		}
		if("".equals(adminInfoBean.getPassword()))
		{
			result +="Please input password."+"<br>";
		}
		if("".equals(adminInfoBean.getEmail()))
		{
			result +="Please input email."+"<br>";
		}
		else
		{
			Pattern pattern = Pattern.compile("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$");

			Matcher matcher = pattern.matcher(adminInfoBean.getEmail());
			if (!matcher.matches())
			{
				result +="Please input a valid email."+"<br>";
			}
		}
		
		
		
			AdminInfoBean existBean = AdminService.getInstance().checkExistUserName(adminInfoBean);
			if(existBean!=null)
			{
				result +="Exist user name."+"<br>";
			}
			
			existBean = AdminService.getInstance().checkExistLoginId(adminInfoBean);
			if(existBean!=null)
			{
				result +="Exist user login ID."+"<br>";
			}
			existBean = AdminService.getInstance().checkExistUserEmail(adminInfoBean);
			if(existBean!=null)
			{
				result +="Exist user email."+"<br>";
			}

		
		return result;
	}
}