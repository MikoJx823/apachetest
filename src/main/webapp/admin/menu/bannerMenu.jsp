<%@page import="org.apache.commons.lang.StringUtils,com.project.service.*,com.project.bean.*, com.project.util.StringUtil, com.project.util.SessionName"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String target =StringUtils.trimToEmpty( (String)request.getParameter("target"));
	
	if("".equals(target)){
		target = "recommendMenu";
	}
	
	AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	String basePath = StringUtil.getHostAddress() + "admin/";
	
%>
    <ul class="nav nav-tabs nav-tabs-main" role="tablist">
   		<li role="presentation" id="bannerMenu" class=""><a href="../banner/AdminBannerServlet?actionType=getSearchList&from=menu">Banner Search </a></li>
  		<li role="presentation" id="bannerAdd" class=""><a href="../banner/bannerAdd.jsp">Add Banner </a></li>
  </ul>
       
<script type="text/javascript">
$(document).ready(function(){
	$("#<%=target%>").addClass("active");
});

</script>

