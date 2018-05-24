<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.pulldown.DatePulldown"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
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
   <jsp:include page="../main/leftMenu.jsp"><jsp:param value="system" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>Reset Password</big></div>
  
  <div class="panel-body">

   <h4 class="text-primary">Reset Status</h4>
  <jsp:include page="../main/msgAlert.jsp"></jsp:include>
   
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
  <!--   <a class="btn btn-primary btn-cancel" href="javascript:history.go(-2)">Back</a> -->
  <a class="btn btn-primary btn-cancel loginbtn hvr-float-shadow" href="../system/UserServlet?actionType=getUserList">Back</a>
  
  </div>
	</div>
    
    </div><!--right main content col-xs-19 ended-->
    
    </div><!--main row-->
    </section><!-- /section.container -->
</form>  
  </body>
</html>

