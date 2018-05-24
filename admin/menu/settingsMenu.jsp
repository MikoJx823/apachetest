 <%@page import="org.apache.commons.lang.StringUtils,com.project.service.*,com.project.bean.*, com.project.util.PropertiesUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String target =StringUtils.trimToEmpty( (String)request.getParameter("target"));
	
	if("".equals(target)){
		target = "recommendMenu";
	}
	
	AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute("loginUser");
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	
%>
    <ul class="nav nav-tabs nav-tabs-main" role="tablist">
   	<%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Recommend, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" id="recommendMenu" class=""><a href="../recommend/AdminRecommendServlet?actionType=getSearchList&from=menu">Recommend Items Search</a></li>
    <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Recommend, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" id="recommendAdd" class=""><a href="../recommend/recommendAdd.jsp">Add Recommend Item</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.WhatsHot, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" id="hotMenu" class=""><a href="../whatshot/AdminWhatsHotServlet?actionType=getSearchList&from=menu">Hot Items Search</a></li>
   	 <%} %>
      <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.WhatsHot, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" id="hotAdd" class=""><a href="../whatshot/whatsHotAdd.jsp">Add Hot Item </a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Index, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" id="indexMenu" class=""><a href="../index/AdminIndexServlet?actionType=getSearchList&from=menu">Index Item Search</a></li>
   	 <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Index, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" id="indexAdd" class=""><a href="../index/indexAdd.jsp">Add Index Item </a></li>
     <%} %>
  </ul>
       
<script type="text/javascript">
$(document).ready(function(){
	$("#<%=target%>").addClass("active");
});

</script>

