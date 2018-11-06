<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.pulldown.DatePulldown"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@page import="java.io.PrintWriter" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%

	AdminInfoBean loginUser = (AdminInfoBean) request.getSession().getAttribute(SessionName.loginAdmin);
	String url = request.getRequestURL().toString();
	
	if (loginUser == null&& !url.contains("/LoginServlet") && !url.contains("login.jsp")&& !url.contains("/css/") && !url.contains("/images/") && !url.contains("/layer/")
			&& !url.contains("/js/") && !url.endsWith("/admin/"))
	{
		
			PrintWriter pw = response.getWriter();
			pw.println("<script type='text/javascript'>alert('Your session has been timed out.')</script> <script type='text/javascript'>window.location.href='" + StringUtil.getHostAddress()// request.getContextPath()
					+ "admin/'</script> ");
			pw.flush();
			return;
	}

	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	String basePath = StringUtil.getHostAddress() + "admin/";
%>
<!DOCTYPE html>
<html>
  <jsp:include page="../main/adminHeader.jsp"></jsp:include>
  <body>
  <form action="UserServlet" name="updateForm" method="post" >
 
 <jsp:include page="../main/topNav.jsp"></jsp:include>
<!-- header menu ended-->
    <section class="container">
    
    <!--main-row-->
    <div class="row">
    
    <!--left Menu area-->
   <jsp:include page="../main/leftMenu.jsp"><jsp:param value="order" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>Order Management</big></div>
  
  <div class="panel-body">

   <h4 class="text-primary">Resend Order Email</h4>
  <jsp:include page="../main/msgAlert.jsp"></jsp:include>
   
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
  <a class="btn btn-primary btn-cancel" href="../order/AdminOrderServlet?actionType=getSearchList&from=menu">Back</a>
  
  </div>
	</div>
    
    </div><!--right main content col-xs-19 ended-->
    
    </div><!--main row-->
    </section><!-- /section.container -->
</form>  
  </body>
</html>

