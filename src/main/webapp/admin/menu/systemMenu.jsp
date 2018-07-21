<%@page import="org.apache.commons.lang.StringUtils,com.project.service.*,com.project.bean.*, com.project.util.StringUtil, com.project.util.SessionName"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String target =StringUtils.trimToEmpty( (String)request.getParameter("target"));
	
	if("".equals(target)){
		target = "userMenu";
	}
	
	AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	String basePath = StringUtil.getHostAddress() + "admin/";
	
%>
   
  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
  <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    <li role="presentation" id="userMenu" class=""><a href="../system/UserServlet?actionType=getUserList">User Maintenance</a></li>
  <%} %>
  <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    <li role="presentation" id="userAdd" class=""><a href="../system/userAdd.jsp">Add New User</a></li>
  <%} %>
  <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    <li role="presentation" id="groupMenu" class=""><a href="../system/groupIdx.jsp">User Access Group</a></li>
  <%} %>
  <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    <li role="presentation" id="groupAdd" class=""><a href="../system/groupAdd.jsp">Add User Access Group</a></li>
  <%} %>
  </ul>
      
<script type="text/javascript">
$(document).ready(function(){
	$("#<%=target%>").addClass("active");
});

</script>

