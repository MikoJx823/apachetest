﻿<%@ page language="java" import="java.util.*,com.project.bean.*,com.project.service.AdminService,org.apache.commons.lang.StringUtils,com.project.pulldown.*" contentType="text/html; charset=utf-8"%>
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
	AdminService.performBlockAccess(request, response, AdminFunction.System, AdminFunction.Add);

	List<GroupInfoBean> groupList = AdminService.getInstance().getGroupList();
	
	List<AdminInfoBean> userlist = (List<AdminInfoBean>)request.getAttribute("userlist");
	
	//AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
	
	AdminInfoBean userUpdateBean = (AdminInfoBean)request.getAttribute("userInfoBean");
	AdminInfoBean admin = new AdminInfoBean();
	
    if(userUpdateBean != null){
    	admin = userUpdateBean;
    }
	
    String basePath = StringUtil.getHostAddress() + "admin/";

%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>

  <body>
  <form action="UserServlet" method="post" name="addForm">   
	<input type="hidden" name="actionType" value="userAdd">

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
  <jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <div class="panel-body">
      

      <div class="uppertab">
      
      <jsp:include page="../menu/systemMenu.jsp"><jsp:param value="userAdd" name="target"/> </jsp:include> 
  <!-- Nav tabs -->
  <!--  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
    <li role="presentation"><a href="UserServlet?actionType=getUserList">User Maintenance</a></li>
    <li role="presentation" class="active"><a href="userAdd.jsp">Add New User</a></li>
    <li role="presentation"><a href="groupAdd.jsp">Add User Access Group</a></li>
    <li role="presentation"><a href="groupIdx.jsp">User Access Group</a></li>
   
  </ul> -->

  <!-- Tab panes -->
 <div class="panel-body">
      <h5 class="text-primary">User Information</h5>
       <div class="row">
        
        <div class="col-xs-8">
          <div class="form-group">
            <label>Login ID *</label>
            <input class="form-control" id="loginId" name="loginId" value="<%=StringUtil.filter(admin.getLoginId()) %>" autocomplete="off">
          </div>
      </div><!--col-xs-8-->
      
      <div class="col-xs-8">
      <div class="form-group">
        <label>Staff Name *</label>
            <input class="form-control" id="loginName" name="loginName" value="<%=StringUtil.filter(admin.getName()) %>" autocomplete="off" >
      </div>
       </div><!--col-xs-8-->
		
		<div class="col-xs-8">
      <div class="form-group">
        <label>Email *</label>
            <input class="form-control" id="email" name="email" value="<%=StringUtil.filter(admin.getEmail()) %>" autocomplete="off" >
      </div>
       </div><!--col-xs-8--> 
       
       </div><!--row end-->
       
    <div class="row">
      <div class="col-xs-8">
      <div class="form-group">
        <label>Login Password *</label>
            <input class="form-control" id="password" type="password" name="password"  autocomplete="off" >
      </div>
       </div><!--col-xs-8--> 
       
        <div class="col-xs-8">
       <div class="form-group">
        <label>User Group</label>
            <select class="form-control" name="gid">
             <%for(GroupInfoBean bean:groupList) {%>
		         <option value="<%=bean.getGid()%>"><%=bean.getGroupName()%></option>
		         <%}%>
            </select>
      </div>
       </div><!--col-xs-8-->
       </div>

    
</div><!--.bg-light-primary-->

</div>
          
  </div><!--panel body ended--> 
  
       <div class="panel-footer text-right">
       <a href="javascript:formSubmit();" class="btn btn-primary loginbtn hvr-float-shadow ">Submit</a>
       </div>
       
	</div>   
    </div><!--right main content col-xs-19 ended-->
    
    </div><!--main row-->
    </section><!-- /section.container -->
    </form> 
  	<script type="text/javascript">
  	function MM_findObj(n, d) { //v4.0

	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && document.getElementById) x=document.getElementById(n); return x;
	}
	//To check if the input field is all numbers
	function isFloat (s){   
		var i;
	    var decimalPointDelimiter = "."
	    var seenDecimalPoint = false;
	
	    //if ((s == null) || (s.length == 0)) 
	    //   if (isFloat.arguments.length == 1) return defaultEmptyOK;
	    //   else return (isFloat.arguments[1] == true);
	    if (s == decimalPointDelimiter) return false;
	    
	    // Search through string's characters one by one
	    // until we find a non-numeric character.
	    // When we do, return false; if we don't, return true.
	    for (i = 0; i < s.length; i++)
	    {   
	        // Check that current character is number.
	        var c = s.charAt(i);
	        
	        if ((c == decimalPointDelimiter) && !seenDecimalPoint) seenDecimalPoint = true;
	        else if (!((c >= "0") && (c <= "9"))) return false;
	    }
	    // All characters are numbers.
	    return true;
	}

	// check to see if input is numeric
	function isInteger(s){   
		var i;
	    for (i = 0; i < s.length; i++)
	    {
	        // Check that current character is number.
	        var c = s.charAt(i);
	        if (((c < "0") || (c > "9"))) return false;
	    }
	
	    // All characters are numbers.
	    return true;
	}

	// check to see if input is alphabetic
	function isAlphabetic(val){
        if (val.match(/^[a-zA-Z]+$/))
        {
                return true;
        }
        else
        {
                return false;
        }
	}

	function formSubmit(){		
		if (checkDataField()){
			document.addForm.submit();
			}
	}
   

    function checkDataField(){
	
	        var loginId = document.getElementById("loginId");        
	        var loginName = document.getElementById("loginName");
	        var password = document.getElementById("password");
	        var email = document.getElementById("email");
	     
	        var pass = true;
	
		if ( loginId.value == '' )
		{
			alert("Please input Login ID");
	                pass = false;
	                return;
		}
				
		if ( loginName.value == '' )
		{
			alert("Please input Staff Name");
	                pass = false;
	                return;
		}
		
		if ( password.value == '' )
		{
			alert("Please input Password");
	                pass = false;
	                return;
		}
		
		    // check for length of password
	        if ( password.value.length < 6 || password.value.length > 15 )
	        {
	                alert("Password must be 6-15 alphanumeric characters");
	                pass = false;
	                return;
	        }
	
	        // check for format of password: must be alphaNumeric
	        var i = 0;
	        for (i=0; i<password.value.length; i++)
	        {
	                var c = password.value.charAt(i);
	                if ( !isInteger(c) && !isAlphabetic(c) )
	                {
	                        alert("Password must be alphanumeric");
	                        pass = false;
	                        return;
	                }
	        }
	
	        if ( isInteger(password.value) || isAlphabetic(password.value) )
	        {
	                alert("Password must consist both alphabet and number");
	                pass = false;
	                return;
	        }
		
		
		if ( email.value == '' )
		{
			alert("Please input Email");
	                pass = false;
	                return;
		}
	    if ( email.value != '' && email.value.indexOf('@') <0 )
		{
			alert("Invalid Email");
	                pass = false;
	                return;
		}
					
		return pass;
	}
    
    </script>
  </body>

</html>


