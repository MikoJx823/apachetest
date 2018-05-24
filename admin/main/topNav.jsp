<%@page import="com.project.util.DateUtil,com.project.util.*"%>
<%@page import="com.project.bean.AdminInfoBean"%>
<%@page import="com.project.service.AdminService"%>
<%@page import="com.project.bean.GroupInfoBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%

	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");

	AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	
	
	GroupInfoBean groupInfo = AdminService.getInstance().getGroup(loginUser.getGid());

	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	
	
%>



       <nav class="navbar header">	
      <div class="container">
      
        <div class="navbar-header">
          <img src="<%=basePath %>images/logo.png" class="brand">
         </div>
         
             <div class="navbar-form navbar-right">
            
                <a class="btn btn-cancel" href="javascript:logout()">Logout</a>
              </div><!--navbar--right-->
              
              <div class="navbar-right loginname tbl wd-at">
          <div class="tbl-cell tbl-center pr-15">
            <small>You are login as:</small><br>
            <big><%=loginUser.getLoginId() %></big>
         </div>
         
         <div class="tbl-cell tbl-center pl-15">
            <small>User Group</small><br>
            <big><%=groupInfo.getGroupName() %></big>
         </div>
           </div> <!--navbar--right-->
  
       
      </div><!--container-->
    </nav>
<!-- header menu ended-->

<script type="text/javascript">
function logout()
{
	if (confirm('Confirm logout ?')) {
	
	   window.location.href='<%=basePath %>LoginServlet?actionType=logout';
	
	}
}
</script>
