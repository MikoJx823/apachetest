<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.pulldown.DatePulldown"%>
<%@page import="com.project.util.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
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
   String aid = request.getParameter("aid");
	String basePath = StringUtil.getHostAddress() + "admin/";
%>

<!DOCTYPE html>
<html>
 <jsp:include page="../main/adminHeader.jsp"></jsp:include>
    
  <body>
  <form action="UserServlet" name="updateForm" method="post" >
  <input type="hidden" name="actionType" value="userPasswordReset">
  <input type="hidden" name="aid" value="<%=aid %>">
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
  
  <div class="panel-heading"><big>User Management</big></div>
  
  <div class="panel-body">

   <h4 class="text-primary">Reset User Password</h4>
   <h5>  	
     Please provide a 6-15 alphanumeric password: 
   </h5>
   
   <div class="row">        
          <div class="col-xs-8">
              <div class="form-group">
              <label>Current Password *</label>
              <input class="form-control" type="password" id="curPwd" name="curPwd" autocomplete="off" >
          	 </div><!--form-group-->
         </div><!--col-xs-8-->
   
   </div><!--row ended-->
   <div class="row">        
          <div class="col-xs-8">
              <div class="form-group">
              <label>New Password  *</label>
              <input class="form-control" type="password" id="newPwd" name="newPwd" autocomplete="off" >
          	 </div><!--form-group-->
         </div><!--col-xs-8-->
   
   </div><!--row ended-->
      <div class="row">        
          <div class="col-xs-8">
              <div class="form-group">
              <label>Re-Confirm Password *</label>
              <input class="form-control" type="password" id="rePwd" name="rePwd" autocomplete="off" >
          	 </div><!--form-group-->
         </div><!--col-xs-8-->
   
   </div><!--row ended-->

    
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
  <a class="btn btn-primary loginbtn hvr-float-shadow" href="javascript:formSubmit();">Reset</a>
  <a class="btn btn-primary btn-cancel loginbtn hvr-float-shadow" href="javascript:history.go(-1)">Back</a>
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
function isFloat (s)

{   var i;
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
function isInteger(s)
{   var i;
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
function isAlphabetic(val)
{
        if (val.match(/^[a-zA-Z]+$/))
        {
                return true;
        }
        else
        {
                return false;
        }
}


function formSubmit()
{		

	if (checkDataField()){
		document.updateForm.submit();
		}
 
}
   

    function checkDataField(){

        var curPwd = document.getElementById("curPwd");        
        var newPwd = document.getElementById("newPwd");
        var rePwd = document.getElementById("rePwd");
     
        var pass = true;

	if ( curPwd.value == '' )
	{
		alert("Current Password must be input");
                pass = false;
                return;
	}
			
	if ( newPwd.value == '' )
	{
		alert("New Password must be input");
                pass = false;
                return;
	}
	
	
	if ( rePwd.value == '' )
	{
		alert("Re-Confirm Password must be input");
                pass = false;
                return;
	}
    // check for length of password
        if ( newPwd.value.length < 6 || newPwd.value.length > 15 )
        {
                alert("New password must be 6-15 alphanumeric characters");
                pass = false;
                return;
        }

        // check for format of password: must be alphaNumeric
        var i = 0;
        for (i=0; i<newPwd.value.length; i++)
        {
                var c = newPwd.value.charAt(i);
                if ( !isInteger(c) && !isAlphabetic(c) )
                {
                        alert("New password must be alphanumeric");
                        pass = false;
                        return;
                }
        }

        if ( isInteger(newPwd.value) || isAlphabetic(newPwd.value) )
        {
                alert("New password must consist both alphabet and number");
                pass = false;
                return;
        }

        if ( curPwd.value == newPwd.value )
        {
                alert("Current and new password must not be equal");
                pass = false;
                return;
        }

        if ( rePwd.value != newPwd.value )
        {
                alert("New and confirm password must be equal");
                pass = false;
                return;
        }
				
	return pass;
   
}
    
    
    </script>
  </body>
</html>

