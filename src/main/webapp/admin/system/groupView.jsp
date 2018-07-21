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
	AdminService.performBlockAccess(request, response, AdminFunction.System, AdminFunction.View);

    int gid = StringUtil.strToInt(StringUtils.trimToEmpty(request.getParameter("gid")));
	GroupInfoBean groupInfoBean = AdminService.getInstance().getGroup(Integer.valueOf(gid));
	
	if(groupInfoBean == null)
	{
		groupInfoBean = new GroupInfoBean();
	}

    List<AdminGroupFunction> functionList = AdminService.getInstance().listAdminGroupFunctionByAGID(groupInfoBean.getGid());
	Map<Integer,String> functionMap = new HashMap<Integer,String>();
	for(AdminGroupFunction function:functionList)
	{
		functionMap.put(function.getFid(), function.getAccessRight());
	}
	
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
   <div class="panel-heading"><big>View User Access Group</big></div>
   <jsp:include page="../main/msgAlert.jsp"></jsp:include>  
   
  <div class="panel-body">
  <h5 class="text-primary">User Access Group Information</h5>
<form action="GroupServlet" method="post" name="updateForm">   
  <input type="hidden" name="actionType" value="groupUpdate">
  <input type="hidden" name="gid" value="<%=gid%>">
  
    
       <div class="row">
        
        <div class="col-xs-8">
          <div class="form-group">
            <label>Group Name *</label>
            <p class="form-control-static"><%=StringUtils.trimToEmpty(groupInfoBean.getGroupName()) %></p>
          </div>
      </div><!--col-xs-8-->
       </div><!--row end-->
       
       <div class="row">
        <div class="col-xs-8">
        <div class="form-group">
        <label>Desc </label>
            <p class="form-control-static"><%=StringUtils.trimToEmpty(groupInfoBean.getDescription()) %></p>
       </div>
       </div><!--col-xs-8-->
       </div>
       
       <div class="row">
       <div class="col-xs-24">
       <div class="form-group">
        <label>User Group Function</label>
            <table class="table table-hover table-condensed" >
	         	  <%
	              String [] modules = AdminFunction.getAllModules();
	                    for(int i=1;i<modules.length;i++){
	              %>
	             <tr>
                    <td class="tbl-center"><strong><%=modules[i] %></strong></td>
                 <td>
            	<%
	               String[] functions = AdminFunction.getAllFunctions(modules[i]);
	                     for(int t=1;t<functions.length;t++){
		                 String accessRight="" ;
		                 if(functionMap != null && functionMap.size() > 0) {
				         accessRight = (String)functionMap.get(AdminFunction.getFunctionId(modules[i],functions[t]));
		         	}
	           %>
	  		<label class="checkbox-inline"><input type="checkbox" name="sys_<%=AdminFunction.getFunctionId(modules[i],functions[t]) %>" value="Y" <%="Y".equals(accessRight)?"checked":"" %> disabled=disabled><%=functions[t] %></label>
	         <%}%>
		    </td>
	         </tr>
        	<%}%>
	         	</table>
      </div>
       </div><!--col-xs-8-->
       </div>

</form>         
 
    
  </div><!--panel body ended--> 
  
  <div class="panel-footer text-right"> 
       <!--      
       <a href="javascript:history.go(-1)" class="btn btn-cancel loginbtn hvr-float-shadow">Back</a> -->
       <a href="groupIdx.jsp" class="btn btn-cancel loginbtn hvr-float-shadow">Back</a>
       </div>
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

        var groupName = document.getElementById("groupName");        
      
        var pass = true;

	if ( groupName.value == '' )
	{
		alert("Please input Group Name");
                pass = false;
                return;
	}
			
	return pass;
   
}

    </script>
  </body>

</html>


