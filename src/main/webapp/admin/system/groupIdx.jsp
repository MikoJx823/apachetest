﻿<%@ page language="java" import="java.util.*,com.project.bean.*,com.project.service.AdminService,org.apache.commons.lang.StringUtils,com.project.pulldown.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.project.util.*"%>
<%@page import="java.io.PrintWriter" %>
<%@ page contentType="text/html; charset=utf-8"%>

<%
	AdminService.getInstance().checkLogin(request, response);

	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.System, AdminFunction.View);

	List<GroupInfoBean> groupList = AdminService.getInstance().getGroupList();
	
	AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	
	String basePath = StringUtil.getHostAddress() + "admin/";
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>
 
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
<form action="GroupServlet" method="post"  id="delForm" name="delForm">   
<input type="hidden" id="actionType" name="actionType" value="groupDel">
<input type="hidden" id="gid" name="gid">
      <div class="uppertab">
      
      <jsp:include page="../menu/systemMenu.jsp"><jsp:param value="groupMenu" name="target"/> </jsp:include> 
      
  <!-- Nav tabs -->
  <!--  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
    <li role="presentation"><a href="UserServlet?actionType=getUserList">User Maintenance</a></li>
    <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>  
    <li role="presentation"><a href="userAdd.jsp">Add New User</a></li>
    <li role="presentation"><a href="groupAdd.jsp">Add User Access Group</a></li>
    <%} %>
    <li role="presentation" class="active"><a href="groupIdx.jsp">User Access Group</a></li>
   
  </ul> -->

  <!-- Tab panes -->
<div class="bg-light-primary pd-15">
 
        <h4 class="text-primary">Group List</h4>
       <div class="row">
       
          <div class="col-xs-24">
         <!--result-->
            <table class="table table-condensed table-striped table-hover">
              <thead class="bg-black"><tr>
             	<th width="25%">User Group</th> 
                <th width="65%">Description </th>   
                <th width="10%" class="tbl-center">Action</th>
             </tr></thead>
          <tbody>

          <%for(GroupInfoBean bean:groupList){ %>

           <tr>
	         <td  class="tbl-center"><%=bean.getGroupName() %></td>
	         <td  class="tbl-center"><%=StringUtils.trimToEmpty(bean.getDescription()) %></td>
	         <td  class="tbl-center">
	         <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
	            <a href="groupView.jsp?gid=<%=bean.getGid() %>" class="btn btn-xs btn-cancel">View</a>
	            <%} %>
	            <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.System, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
	         	<a href="groupUpdate.jsp?gid=<%=bean.getGid()%>"  class="btn btn-xs btn-primary" >Edit</a>
	         <%} %>

			  </td>
	        </tr>
         <%} %>
    
     </tbody>
  </table>
<!--result table-->
       </div><!--col-xs-24-->

       </div>
    
</div><!--.bg-light-primary-->

</div>
</form>         
 
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
  	
	  function deleteGroup(gid){
     		var msg = "Do you confirm to delete this group ?";
	     	if(confirm(msg)) {
				 $("#actionType").val("groupDel");
				 $("#gid").val(gid);
			//	  alert($("#gid").val());
					 $("#delForm").submit();
		 	}
 		}

	</script>
  </body>

</html>


