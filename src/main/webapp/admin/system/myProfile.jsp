<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@page import="com.project.util.*"%>
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
	AdminInfoBean admin = (AdminInfoBean)session.getAttribute(SessionName.loginAdmin);
	
	if(admin == null)
	{
		admin = new AdminInfoBean();
	}
	GroupInfoBean adminGroup = AdminService.getInstance().getGroup(admin.getGid());
	
	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	String basePath = StringUtil.getHostAddress() + "admin/"; 
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
    <jsp:include page="../main/leftMenu.jsp"><jsp:param value="profile" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>User Management</big></div>
  	<jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <div class="panel-body">
     
            <h5 class="text-primary">My Profile</h5>
            <table class="table table-hover table-condensed">
            <tbody>
             <tr>
            	<td class="tbl-title">Login ID</td>
                <td class="tbl-content"><%=admin.getLoginId() %></td>
                
                <td class="tbl-title">Name</td>
                <td class="tbl-content"><%=admin.getName() %></td>

            </tr>
            
              <tr>
            	<td class="tbl-title">Email</td>
                <td class="tbl-content"><%=admin.getEmail() %></td>
                
                <td class="tbl-title">Group</td>
                <td class="tbl-content"><%=adminGroup.getGroupName() %></td>

            </tr>
                 
            </tbody>
            
            </table>
            
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
  <a href="passwordUpdate.jsp?aid=<%=admin.getAid() %>" class="btn btn-primary loginbtn hvr-float-shadow">Update Password</a>
  </div><!--panel-footer-->
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    </div>
  
    </section><!-- /section.container -->
  
  </body>
</html>
