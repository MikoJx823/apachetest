<%@page import="com.project.pulldown.OrderStatusPulldown"%>
<%@page import="com.project.pulldown.DatePulldown"%>
<%@page import="com.project.util.DateUtil"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.System, AdminFunction.View);

    String aid = request.getParameter("aid");
    
    AdminInfoBean admin = AdminService.getInstance().getAdminInfoBeanByAid(Integer.valueOf(aid)); 
    
    GroupInfoBean group = AdminService.getInstance().getGroup(admin.getGid());
	
    String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	
 %>
<!DOCTYPE html>
<html>
  <jsp:include page="../main/adminHeader.jsp"></jsp:include>
  
  <body>
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
  
  <div class="panel-heading"><big>View User</big></div>
  <jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <div class="panel-body">

<h5 class="text-primary">User information</h5>
<div class="row">            
            <div class="col-xs-8">
               	  <div class="form-group">
                    <label>Login ID</label>
                    <p class="form-control-static"><%=admin.getLoginId() %></p>
          			</div><!--form-group-->
              </div><!--col-xs-8-->
                 
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>Staff Name</label>
                    <p class="form-control-static"><%=admin.getName() %></p>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                 
                  <div class="col-xs-8">
                	<div class="form-group">
                    <label>Email</label>
                   <p class="form-control-static"><%=admin.getEmail() %></p>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
</div><!--row ended-->

<div class="row pt-15">            
            <div class="col-xs-8">
               	  <div class="form-group">
                    <label>Admin Group</label>
                    <p class="form-control-static"><%=group.getGroupName() %></p>
          			</div><!--form-group-->
              </div><!--col-xs-8-->
                 
                  <div class="col-xs-8">
                	<div class="form-group">
                    <label>Status</label>
                   <p class="form-control-static"><%=admin.getStatus().equals("1")?"Active":"Inactive" %></p>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
</div><!--row ended-->
         
        

    
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
  <a class="btn btn-cancel loginbtn hvr-float-shadow" href="../system/UserServlet?actionType=getUserList">Back</a>
  <!--  <a class="btn btn-primary btn-cancel" href="javascript:history.go(-1)">Back</a> -->
  
  </div>
	</div>
    
    </div><!--right main content col-xs-19 ended-->
    
    </div><!--main row-->
    </section><!-- /section.container -->
  
  </body>
</html>


