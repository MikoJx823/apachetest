<%@page import="com.asiapay.clp.bean.*"%>
<%@page import="com.asiapay.clp.service.*"%>
<%@page import="com.asiapay.clp.util.*"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%	

	AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	
	if(!(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportOrder), AdminFunction.haveRight, adminGroupFunctions) ||
			AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPayment), AdminFunction.haveRight, adminGroupFunctions) || 
			AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPrintHouse), AdminFunction.haveRight, adminGroupFunctions) ||
			AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportERedeem), AdminFunction.haveRight, adminGroupFunctions) ||
			AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportSurvey), AdminFunction.haveRight, adminGroupFunctions) ||
			AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPageView), AdminFunction.haveRight, adminGroupFunctions) ||
			AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportLoginMethod), AdminFunction.haveRight, adminGroupFunctions) ||
			AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPurchasedProduct), AdminFunction.haveRight, adminGroupFunctions) ||
			AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportCartTrack), AdminFunction.haveRight, adminGroupFunctions)) 
	) {
		request.getRequestDispatcher("../system/myProfile.jsp").forward(request, response);
	}

	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	
%>
<!doctype html>
<html>

<jsp:include page="../main/adminHeader.jsp"></jsp:include>

<body>
      <jsp:include page="../main/topNav.jsp"></jsp:include>
 
<!-- header menu ended-->

    <section class="container">
    
    <!--main-row-->
    <div class="row">

 
    <!--left Menu area-->
    <jsp:include page="../main/leftMenu.jsp"><jsp:param value="report" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>Report Management</big></div>
  	<jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <div class="panel-body">
            <table class="table table-hover table-condensed">
            <tbody>
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportOrder), AdminFunction.haveRight, adminGroupFunctions)) {%>
            	<tr><td class="tbl-title"><a href="orderReport.jsp">Order Report</a></td></tr>
             <%} %>
             
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPayment), AdminFunction.haveRight, adminGroupFunctions)) {%>
             <tr><td class="tbl-title"><a href="paymentReport.jsp">Online Payment Report </a></td></tr>
             <%} %>
             
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPrintHouse), AdminFunction.haveRight, adminGroupFunctions)) {%>	
             <tr><td class="tbl-title"><a href="ecoRewardPrintReport.jsp">Eco Reward Print Report</a></td></tr>
             <%} %>
             
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportERedeem), AdminFunction.haveRight, adminGroupFunctions)) {%>
             <tr><td class="tbl-title"><a href="ecoRewardERedeemReport.jsp" >Eco Reward ERedeem Report</a></td></tr>
             <%} %>
             
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportSurvey), AdminFunction.haveRight, adminGroupFunctions)) {%>
             <tr><td class="tbl-title"><a href="surveyReport.jsp" >Survey Report</a></td></tr>
             <%} %>
                
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPageView), AdminFunction.haveRight, adminGroupFunctions)) {%>
             <tr><td class="tbl-title"><a href="pageViewReport.jsp" >Page View Report</a></td></tr>
             <%} %>
             
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportLoginMethod), AdminFunction.haveRight, adminGroupFunctions)) {%>
             <tr><td class="tbl-title"><a href="loginMethodReport.jsp" >Login Method Report</a></td></tr>
             <%} %>
             
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportPurchasedProduct), AdminFunction.haveRight, adminGroupFunctions)) {%>
             <tr><td class="tbl-title"><a href="purchasedProductReport.jsp" >Purchased Product Report</a></td></tr>
             <%} %>
             
             <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Report, AdminFunction.ReportCartTrack), AdminFunction.haveRight, adminGroupFunctions)) {%>
             <tr><td class="tbl-title"><a href="cartReport.jsp" >Cart Track Report</a></td></tr>
             <%} %>
            </tbody>
             
            </tbody>
            
            </table>
            
  </div><!--panel body ended-->
  
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    </div>
  
    </section><!-- /section.container -->
  
  </body>
</html>
