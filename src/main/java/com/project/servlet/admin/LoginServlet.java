package com.project.servlet.admin;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.AdminGroupFunction;
import com.project.bean.AdminInfoBean;
import com.project.service.AdminService;
import com.project.util.SessionName;
import com.project.util.StringUtil;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet{

	private static Logger log = Logger.getLogger(LoginServlet.class);

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		resp.setContentType("text/html");
	//	resp.setCharacterEncoding("UTF-8");
		resp.setHeader("Cache-Control", "no-cache");
		
		AdminService.getInstance().checkLogin(req, resp);
		
		String actionType = StringUtil.filter(req.getParameter("actionType"));
		log.info("actionType:" + actionType);
		log.info("");
		if ("login".equals(actionType))
		{
			login(req, resp);
		}
		else if ("logout".equals(actionType))
		{
			logout(req, resp);
		}
		else if ("".equals(actionType))
		{
			req.getRequestDispatcher("login.jsp").forward(req, resp);
			return;
		}

	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		String validInfo = "";

		String loginId = StringUtil.filter(req.getParameter("loginId"));
		String password = StringUtil.filter(req.getParameter("password"));
		
		AdminInfoBean adminInfoBean = null;
		Date lastLoginTime = null;
		
		if ("".equals(loginId)){
			validInfo = "Please input loginId.<br/>";
		}
		else if ("".equals(password)){
			validInfo = "Please input password.<br/>";
		}
		else {
			adminInfoBean = AdminService.getInstance().getAdminInfoBeanByLoginId(loginId);
			if (adminInfoBean != null)
			{
				lastLoginTime = adminInfoBean.getLastLoginDate()==null?new Date():adminInfoBean.getLastLoginDate();
				
			    if (StringUtil.encryptString(password).equals(adminInfoBean.getPassword()))
				{
					adminInfoBean.setLastLoginDate(new Date());
					try
					{
						AdminService.getInstance().updateAdminInfoBean(adminInfoBean);
						List<AdminGroupFunction> adminGroupFunction = AdminService.getInstance().listAdminGroupFunctionByAGID(adminInfoBean.getGid());
						adminInfoBean.setAdminGroupFunction(adminGroupFunction);

						
					}catch (Exception e){
						log.info(e);
					}
				}else{
					validInfo = "Incorrect password, please try again.";
				}
			}
			else
			{
				validInfo = "Invalid user.<br/>";
			}

		}
		if("".equals(validInfo)){
			req.getSession().setAttribute(SessionName.loginAdmin, adminInfoBean);
			req.getSession().setAttribute("lastLoginTime", lastLoginTime);
			resp.sendRedirect("system/myProfile.jsp");
		}else{
			req.setAttribute("validInfo", validInfo);
			req.getRequestDispatcher("login.jsp").forward(req, resp);
		}
	}

	private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException
	{
		req.getSession().removeAttribute(SessionName.loginAdmin);
		req.getSession().removeAttribute("rightsList");
		resp.sendRedirect("LoginServlet");
	}

}