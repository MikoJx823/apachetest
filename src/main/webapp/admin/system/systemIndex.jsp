﻿<%@ page language="java" import="java.util.*,com.project.bean.*,com.project.service.AdminService,com.project.pulldown.*,com.project.util.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.project.util.*"%>
<%@page import="java.io.PrintWriter" %>
<%@ page contentType="text/html; charset=utf-8"%>
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
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.System, AdminFunction.View);

	List<GroupInfoBean> groupList = AdminService.getInstance().getGroupList();
	
	List<AdminInfoBean> userlist = (List<AdminInfoBean>)request.getAttribute("userlist");
	
	//AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	
	String basePath = StringUtil.getHostAddress() + "admin/";
	
	String name = StringUtil.filter((String)request.getSession().getAttribute("loginName"));
	String loginId = StringUtil.filter((String)request.getSession().getAttribute("loginId"));
	String gid = StringUtil.filter((String)request.getSession().getAttribute("gid"));
	int status = StringUtil.strToInt(StringUtil.filter((String)request.getSession().getAttribute("status")));
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>

  </head>

  <body>
     <jsp:include page="../main/topNav.jsp"></jsp:include>
    <section class="container">
    
    <!--main-row-->
    <div class="row">
    
    <!--left Menu area-->

  
    <jsp:include page="../main/leftMenu.jsp"><jsp:param value="system" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>User Management</big></div>
  
  <div class="panel-body">
      <fieldset>
<form action="UserServlet" method="post" name="userForm" id="userForm">   
<input type="hidden" name="actionType" id="actionType" value="resetPwd">
<input type="hidden" name="from" id="from" value="menu">
<input type="hidden" name="aid" id="aid" value="0"> 
      <div class="uppertab">
      
      <jsp:include page="../menu/systemMenu.jsp"><jsp:param value="userMenu" name="target"/> </jsp:include> 
      
  <!-- Nav tabs -->
  <!--  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
    <li role="presentation" class="active"><a href="UserServlet?actionType=getUserList" >User Maintenance</a></li>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>   
    <li role="presentation"><a href="userAdd.jsp">Add New User</a></li>
    <li role="presentation"><a href="groupAdd.jsp">Add User Access Group</a></li>
    <%} %>
     <li role="presentation"><a href="groupIdx.jsp">User Access Group</a></li>
  </ul> -->

  <!-- Tab panes -->
<div class="bg-light-primary pd-15">
      
       <div class="row">
        
        <div class="col-xs-8">
          <div class="form-group">
            <label>Login ID</label>
            <input class="form-control" name="loginId" value="<%=StringUtil.filter(loginId) %>" autocomplete="off">
          </div>
      </div><!--col-xs-8-->
      
      <div class="col-xs-8">
      <div class="form-group">
        <label>Staff Name</label>
            <input class="form-control" name="loginName" value="<%=StringUtil.filter(name) %>" autocomplete="off" >
      </div>
       </div><!--col-xs-8-->
       <div class="col-xs-8">
      <div class="form-group">
        <label>User Group</label>
            <select class="form-control" name="gid">
            	<%=AdminService.getInstance().getGroupSearch(gid) %>
            	 <!--  <option value="">ALL</option>
             <%for(GroupInfoBean bean:groupList) {%>
		         <option value="<%=bean.getGid()%>"><%=bean.getGroupName()%></option>
		         <%}%> -->
            </select>
      </div>
       </div><!--col-xs-6-->

       </div><!--row end-->
       
      <div class="row">
       	
       	<div class="col-xs-8">
      <div class="form-group">
        <label>Status</label>
            <select class="form-control" name="status">
 			<%=UserStatus.select(status,true) %>        
            </select>
      </div>
       </div><!--col-xs-8-->
       
       </div>
       
       <div class="row">
       <div class="col-xs-4 pull-right text-right">
       <a href="javascript:formSubmit('','search');" class="btn btn-primary loginbtn hvr-float-shadow ">Search</a></div>
      </div><!--row end-->
    
</div><!--.bg-light-primary-->

</div>

<hr>  
</form>
       
<%if(userlist !=null && userlist.size()>0){ %>
         <h4 class="text-primary">User List</h4>
           <!--upper tab ended-->
        <div class="row">
        
        <div class="col-xs-24">
         <!--result-->
<table class="table table-condensed table-striped table-hover">
<thead class="bg-black"><tr>
	<th width="15%">User Group</th> 
    <th width="15%">Login ID</th>
    <th width="15%">Staff Name</th>
    <th width="15%">Create Date</th>
    <th width="7%">Status</th>
    <th width="18%" class="text-center">Action</th>
    </tr></thead>
<tbody>

 <%for(AdminInfoBean bean:userlist){ %>  
  <%
    GroupInfoBean groupInfoBean = AdminService.getInstance().getGroup(Integer.valueOf(bean.getGid()));
   %>
  
    <tr>
    	<td class="tbl-center"><%=groupInfoBean.getGroupName() %></td>
        <td class="tbl-center"><%=bean.getLoginId() %></td>
        <td class="tbl-center"><%=bean.getName() %></td>
        <td class="tbl-center"><%=bean.getCreatedDate() %></td>
        <td class="tbl-center">
        <%if(bean.getStatus().equals(String.valueOf(StaticValueUtil.Suspend))){ %>
        	<span class="label label-danger"><%=UserStatus.getText(Integer.parseInt(bean.getStatus()))%> </span> 
        <%}else {%>
        	<span class="label label-success"><%=UserStatus.getText(Integer.parseInt(bean.getStatus()))%></span>  
        <%} %>
        </td>       
        <td class="text-center">     
        <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>   
          <a href="userView.jsp?aid=<%=bean.getAid() %>" class="btn btn-xs btn-cancel">View</a>
          <%} %>
          <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
          <a href="userUpdate.jsp?aid=<%=bean.getAid() %>" class="btn btn-xs btn-primary">Edit</a>         
          <%} %>
          <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.ResetPwd), AdminFunction.haveRight, adminGroupFunctions)) {%>
           
          <a href="javascript:formSubmit(<%=bean.getAid()%>,'');" class="btn btn-xs btn-warning">Reset Password</a>
           
          <%} %>
          <!-- 
          <a href="passwordUpdate.jsp" class="btn btn-xs btn-warning">Reset Password</a>
          -->
        </td>
    </tr>
    <%} %>
    
</tbody>
</table>
<!--result table-->

<div class="row text-center">
<%=StringUtil.getPagingString(5, pageIdx, totalPages, "UserServlet?actionType=getUserList&pageIdx=") %>
</div>

<%} else{%>
   No records found !
<%} %> 
       </div><!--col-xs-24-->
      </div><!--row end-->
   
    </fieldset>    
  </div><!--panel body ended--> 
	</div>   
    </div><!--right main content col-xs-19 ended-->
    
    </div><!--main row-->
    </section><!-- /section.container -->
  <script type="text/javascript">
    function MM_findObj(n, d) { //v4.0

  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}
 /*   
function formSubmit(){

       	MM_findObj("userForm").submit();
   
}
*/

	function formSubmit(aid, from)
	{	
		if(from == "search") {
			$("#actionType").val("getUserList");
			$("#from").val(from);
			$("#userForm").submit();
			
		}else {
			var r=confirm("Do you confirm to reset password for this user?");
	        if (r==true)
	        {
	         $("#aid").val(aid);
	         $("#userForm").submit();        
	        }
	        else
	        {
	          return;
	        }
		}
	}
    </script>
  </body>

</html>


