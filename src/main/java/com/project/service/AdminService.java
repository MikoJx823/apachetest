package com.project.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.AdminFunction;
import com.project.bean.AdminGroupFunction;
import com.project.bean.AdminInfoBean;
import com.project.bean.GroupInfoBean;
import com.project.bean.RightsInfoBean;
import com.project.dao.AdminDao;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

public class AdminService
{
	Logger log = Logger.getLogger(AdminService.class);

	private static AdminService instance = null;
	private AdminDao adminDao;

	public static synchronized AdminService getInstance()
	{
		if (instance == null)
			instance = new AdminService();
		return instance;
	}
	private AdminService()
	{
		adminDao = AdminDao.getInstance();
	}
	public List<AdminInfoBean> getAdminInfoBeanListBySqlwhere(String sqlWhere)
	{
		return adminDao.getAdminInfoBeanListBySqlwhere(sqlWhere);
	}
	
	public List<AdminInfoBean> getListBySqlwhereWithPage(String sqlWhere, int pageIdx)
	{
		return adminDao.getListBySqlwhereWithPage(sqlWhere, pageIdx);
	}

	public AdminInfoBean getAdminInfoBeanByLoginId(String loginId)
	{
		String sqlWhere = " where loginId='"+loginId+"' and status = " + StaticValueUtil.Active ;
		List<AdminInfoBean> list = adminDao.getAdminInfoBeanListBySqlwhere(sqlWhere);
		if(list.size()==1)
		{
			return list.get(0);
		}
		else
			return null;
	}
	public AdminInfoBean getAdminInfoBeanByAid(int aid)
	{
		String sqlWhere = " where aid="+aid+"";
		List<AdminInfoBean> list = adminDao.getAdminInfoBeanListBySqlwhere(sqlWhere);
		if(list.size()==1)
		{
			return list.get(0);
		}
		else
			return null;
	}
	
	public AdminInfoBean checkExistLoginId(AdminInfoBean bean)
	{
		String sqlWhere = " where aid !="+bean.getAid()+" and loginId='"+bean.getLoginId()+"'";
		if(bean.getAid()==null)
		{
			sqlWhere = " where loginId='"+bean.getLoginId()+"'";
		}
		List<AdminInfoBean> list = adminDao.getAdminInfoBeanListBySqlwhere(sqlWhere);
		if(list.size()>0)
		{
			return list.get(0);
		}
		else
			return null;
	}
	
	public AdminInfoBean checkExistUserName(AdminInfoBean bean)
	{
		String sqlWhere = " where aid !="+bean.getAid()+" and name='"+bean.getName()+"'";
		if(bean.getAid()==null)
		{
			sqlWhere = " where name='"+bean.getName()+"'";
		}
		List<AdminInfoBean> list = adminDao.getAdminInfoBeanListBySqlwhere(sqlWhere);
		if(list.size()>0)
		{
			return list.get(0);
		}
		else
			return null;
	}
	
	public AdminInfoBean checkExistUserEmail(AdminInfoBean bean)
	{
		String sqlWhere = " where aid !="+bean.getAid()+" and email='"+bean.getEmail()+"'";
		if(bean.getAid()==null)
		{
			sqlWhere =  " where email='"+bean.getEmail()+"'";
		}
		List<AdminInfoBean> list = adminDao.getAdminInfoBeanListBySqlwhere(sqlWhere);
		if(list.size()>0)
		{
			return list.get(0);
		}
		else
			return null;
	}
	
	public AdminInfoBean updateAdminInfoBean(AdminInfoBean admin)
	{
		return adminDao.updateAdminInfoBean(admin);
	}
	
	/*
	public List<String> getGroupRightsList(int gid)
	{
		return adminDao.getGroupRightsList(gid);
	}
	*/
	public List<GroupInfoBean> getGroupList()
	{
		return adminDao.getGroupListBySqlwhere(" where 1=1");
	}
	
	public GroupInfoBean getGroup(int gid)
	{
		List<GroupInfoBean> groupList =  adminDao.getGroupListBySqlwhere(" where gid = "+gid);
		if(groupList.size()==1)
			return groupList.get(0);
		return null;
	}
	public Boolean hasExistGroup(GroupInfoBean group)
	{	
		String sqlWhere = " where groupName='" + group.getGroupName() + "'";
		if(group.getGid() != null) {
			sqlWhere += " and gid != " + group.getGid();
		}	
		
		List<GroupInfoBean> groupList =  adminDao.getGroupListBySqlwhere(sqlWhere);
				//" where gid != "+group.getGid() + " and groupName='"+group.getGroupName()+"'");
		if(groupList.size()==0)
			return false;
		return true;
	}
	public List<RightsInfoBean> getRightsList()
	{
		return adminDao.getRightsListBySqlwhere(" where 1=1");
	}
	public List<RightsInfoBean> getRightsListBySqlwhere(String sqlWhere)
	{
		return adminDao.getRightsListBySqlwhere(sqlWhere);
	}
	/*
	public GroupInfoBean insertGroupInfoBean(GroupInfoBean groupBean,List<RightsInfoBean> rightsList)
	{
		return adminDao.insertGroupInfoBean(groupBean, rightsList);
	}
	*/
	
	public GroupInfoBean addAdminGroup(GroupInfoBean adminGroup, List<AdminGroupFunction> adminFunctionList)
	{
		return adminDao.addAdminGroup(adminGroup, adminFunctionList);
	}
/*	
	public GroupInfoBean updateGroupInfoBean(GroupInfoBean groupBean,List<RightsInfoBean> rightsList)
	{
		return adminDao.updateGroupInfoBean(groupBean, rightsList);
	}
	*/
	
	
	public AdminInfoBean insertAdminInfoBean(AdminInfoBean bean)
	{
		return  adminDao.insertAdminInfoBean(bean);
	}
	
	public boolean delGroupInfoByGid(int gid)
	{
		return adminDao.delGroupInfoByGid(gid);
	}
	public boolean delAdminInfoByAid(int aid)
	{
		return adminDao.delAdminInfoByAid(aid);
	}
	public boolean delAdminInfoByGid(int gid)
	{
		return adminDao.delAdminInfoByGid(gid);
	}
	public boolean delBranceByBid(int bid)
	{
		return adminDao.delBranceByBid(bid);
	}
	public int getAdminQtyByGid(int gid)
	{
		return adminDao.getAdminQtyByGid(gid);
	}
	
	public List<AdminGroupFunction> listAdminGroupFunctionByAGID(int agid)
	{
		return adminDao.listAdminGroupFunctionByAGID(agid);
	}
	
	public static boolean hasAccessRights(int function,String rights,List<AdminGroupFunction> adminGroupFunctions)
	{
		boolean result = false;
		for(AdminGroupFunction adminGroupFunction:adminGroupFunctions)
		{
			if(adminGroupFunction.getFid()==function && adminGroupFunction.getAccessRight().equalsIgnoreCase(rights))//Integer.valueOf(adminGroupFunction.getAccessRight())>=Integer.valueOf(rights)
			{
				result = true;
				break;
			}
		}
		return result;
		
	}
	
	public GroupInfoBean updateAdminGroup(GroupInfoBean adminGroup, List<AdminGroupFunction> adminFunctionList){
		
		return adminDao.updateAdminGroup(adminGroup, adminFunctionList);
	}
	
	public int getUserTotalPages(int pageIdx, String sqlWhere){
		return adminDao.getUserTotalPages(pageIdx, sqlWhere);
	}
	
	public static void performBlockAccess(HttpServletRequest request, HttpServletResponse response, String mainMenu, String subMenu ) throws ServletException, IOException{
		AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
		
		List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
		
		if(!AdminService.hasAccessRights(AdminFunction.getFunctionId(mainMenu, subMenu), AdminFunction.haveRight, adminGroupFunctions)) {
			request.getRequestDispatcher("../system/myProfile.jsp").forward(request, response);
		} 
		
	}
	
	public String getGroupSearch(String inputValue){
		
		String result = "<option value=\"\">ALL</option>";
		List<GroupInfoBean> list = adminDao.getGroupListBySqlwhere(" where status != " + StaticValueUtil.Delete );
		
		for(GroupInfoBean bean : list){
			if(inputValue.equals(String.valueOf(bean.getGid()))) {
				result += "<option value=\"" + bean.getGid() + "\" selected>" + StringUtil.filter(bean.getGroupName()) + "</option>";
			}else {
				result += "<option value=\"" + bean.getGid() + "\" >" + StringUtil.filter(bean.getGroupName()) + "</option>";
			}
		}
		
		return result;
	}
	
	public void checkLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AdminInfoBean loginUser = (AdminInfoBean) request.getSession().getAttribute(SessionName.loginAdmin);
		String url = request.getRequestURL().toString();
		
		if (loginUser == null&& !url.contains("/LoginServlet") && !url.contains("login.jsp")&& !url.contains("/css/") && !url.contains("/images/") && !url.contains("/layer/")
				&& !url.contains("/js/") && !url.endsWith("/admin/"))
		{
			
				PrintWriter pw = response.getWriter();
				pw.println("<script type='text/javascript'>alert('Your session has been timed out.')</script> <script type='text/javascript'>window.top.location='" + request.getContextPath()
						+ "/admin/'</script> ");
				pw.flush();

				return;
		}
	}
	
	public static void checkLogin1(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AdminInfoBean loginUser = (AdminInfoBean) request.getSession().getAttribute(SessionName.loginAdmin);
		String url = request.getRequestURL().toString();
		String basePath = StringUtil.getHostAddress();
		if (loginUser == null&& !url.contains("/LoginServlet") && !url.contains("login.jsp")&& !url.contains("/css/") && !url.contains("/images/") && !url.contains("/layer/")
				&& !url.contains("/js/") && !url.endsWith("/admin/"))
		{
			
				PrintWriter pw = response.getWriter();
				pw.println("<script type='text/javascript'>alert('Your session has been timed out.')</script> <script type='text/javascript'>window.location.href='" + basePath// request.getContextPath()
						+ "admin/'</script> ");
				pw.flush();
				return;
		}
	}
}
