 <%@page import="org.apache.commons.lang.StringUtils,com.project.service.*,com.project.bean.*, com.project.util.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String pageIdx =StringUtils.trimToEmpty( (String)request.getParameter("pageIdx"));
	
	if("".equals(pageIdx)){
		pageIdx = "profile";
	}
	
	AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	String basePath = StringUtil.getHostAddress() + "admin/"; 
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Admin</title>
   
    <meta name="viewport" content="width=device-width">

</head>

<body>
   
        
    <!--left Menu area-->
    <div class="col-xs-5">
    	<ul class="nav nav-sidebar main-side">
    	    <li  id="profile" class="" ><a href="<%=basePath%>system/myProfile.jsp">My Profile</a></li>
    	     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
            	<li id="product" class="" ><a href="<%=basePath%>product/AdminProductServlet?actionType=search&from=menu">Product Management </a></li>
           	 <%} %>
              		 
             <%//if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
            <!--  <li  id="category" class="" ><a href="<%=basePath%>category/AdminCategoryServlet?actionType=search&from=menu">Category Management</a></li>-->
             <%//} %>
             
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Order, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
            <li id="order" class=""><a href="<%=basePath%>order/AdminOrderServlet?actionType=search&from=menu" >Order Management</a></li>
             <%} %>
             
            <%/*if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportOrder), AdminFunction.haveRight, adminGroupFunctions) || 
            		AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPayment), AdminFunction.haveRight, adminGroupFunctions) 
            	)
            {%>
            <li id="report" class=""><a href="<%=basePath%>report/reportIdx.jsp" >Report</a></li>
             <%}*/ %>
             
             <%/*if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Recommend, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
            <li id="settings" class=""><a href="<%=basePath%>recommend/AdminRecommendServlet?actionType=search&from=menu" >Settings</a></li>
            <%}else if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.WhatsHot, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
            <li id="settings" class=""><a href="<%=basePath%>whatshot/AdminWhatsHotServlet?actionType=getSearchList&from=menu" >Settings</a></li>
            <%}else if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Index, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
            <li id="settings" class=""><a href="<%=basePath%>index/AdminIndexServlet?actionType=getSearchList&from=menu" >Settings</a></li>
            <%} */%>
            
            <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
            <li id="system" class=""><a href="<%=basePath%>system/UserServlet?actionType=getUserList" >User Management</a></li>
           <%} %>
          </ul>
    
    </div>
    <!--Left ended col-xs-5-->


</body>
<script type="text/javascript">
$(document).ready(function(){
	  $("#<%=pageIdx%>").addClass("active");
	});
	
/*function onMenuClick(menu){
	
	var target = "";
	if(menu == 'survey'){
		target = "survey.do";
	}
	
	var form = document.createElement("form");
	var element1 = document.createElement("input"); 
	var element2 = document.createElement("input");
	    
	form.method = "POST";
	form.action = "<%=basePath%>" + target;   

	element1.value="menu";
	element1.name="from";
	element1.className="hidden";
	form.appendChild(element1);  

	element2.value="getSearchList";
	element2.name="actionType";
	element2.className="hidden";
	form.appendChild(element2);
	
	document.body.appendChild(form);
	form.submit();
	
}*/

</script>
</html>
