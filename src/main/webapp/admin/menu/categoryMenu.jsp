<%@page import="org.apache.commons.lang.StringUtils,com.project.service.*,com.project.bean.*, com.project.util.StringUtil, com.project.util.SessionName"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String target =StringUtils.trimToEmpty( (String)request.getParameter("target"));
	
	if("".equals(target)){
		target = "searchMenu";
	}
	
	AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	String basePath = StringUtil.getHostAddress() + "admin/";
	
%>

   <ul class="nav nav-tabs nav-tabs-main" role="tablist">
    <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
     	<li role="presentation" id="searchMenu" class="" ><a href="<%=basePath %>category/AdminCategoryServlet?actionType=getSearchList&from=menu" >Category Search</a></li>
  	<%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" id="addMenu" class="" ><a href="<%=basePath %>category/categoryAdd.jsp">Add Category</a></li>
   	<%} %>
   	 
  </ul>
       
<script type="text/javascript">
$(document).ready(function(){
	$("#<%=target%>").addClass("active");
});
</script>

