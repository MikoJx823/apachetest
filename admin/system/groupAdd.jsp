﻿<%@ page language="java" import="java.util.*,com.project.bean.*,com.project.service.AdminService,org.apache.commons.lang.StringUtils,com.project.pulldown.*" contentType="text/html; charset=utf-8"%>
<%@page import="com.project.util.*"%>
<%@ page contentType="text/html; charset=utf-8"%>

<%
	
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.System, AdminFunction.Add);

    List<GroupInfoBean> groupList = AdminService.getInstance().getGroupList();
	
	GroupInfoBean adminGroup = (GroupInfoBean)request.getAttribute("adminGroup");
	if(adminGroup == null)
	{
		adminGroup = new GroupInfoBean();
	}
	
	List<AdminGroupFunction> functionList = (List<AdminGroupFunction>)request.getAttribute("adminFunctions") == null ? new ArrayList<AdminGroupFunction>() : (List<AdminGroupFunction>)request.getAttribute("adminFunctions") ;
	Map<Integer,String> functionMap = new HashMap<Integer,String>();
	for(AdminGroupFunction function:functionList)
	{
		functionMap.put(function.getFid(), function.getAccessRight());
	}
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>

  <body>
  	<form action="GroupServlet" method="post" name="addForm">   
	<input type="hidden" name="actionType" value="groupAdd">
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
      
      <jsp:include page="../menu/systemMenu.jsp"><jsp:param value="groupAdd" name="target"/> </jsp:include> 
  <!-- Nav tabs -->
  <!--  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
    <li role="presentation"><a href="UserServlet?actionType=getUserList">User Maintenance</a></li>
    <li role="presentation"><a href="userAdd.jsp">Add New User</a></li>
    <li role="presentation" class="active"><a href="groupAdd.jsp">Add User Access Group</a></li>
    <li role="presentation"><a href="groupIdx.jsp">User Access Group</a></li>
  </ul> -->

  <!-- Tab panes -->
	<div class="panel-body">
      <h5 class="text-primary">User Access Group Information</h5>
       <div class="row">
        
        <div class="col-xs-8">
          <div class="form-group">
            <label>Group Name *</label>
            <input class="form-control" id="groupName" name="groupName" value="<%=StringUtil.filter(adminGroup.getGroupName()) %>" autocomplete="off">
          </div>
      </div><!--col-xs-8-->
       </div><!--row end-->
       
       <div class="row">
        <div class="col-xs-8">
        <div class="form-group">
        <label>Desc </label>
            <textarea class="form-control" id="description" name="description" autocomplete="off" ><%=StringUtil.filter(adminGroup.getDescription()) %></textarea>
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
	  		<label class="checkbox-inline"><input type="checkbox" name="sys_<%=AdminFunction.getFunctionId(modules[i],functions[t]) %>" value="Y" <%="Y".equals(accessRight)?"checked":"" %> <%=functions[t].equals(AdminFunction.None)?"disabled=disabled":"" %>><%=functions[t] %></label>
	         <%}%>
		    </td>
	         </tr>
        	<%}%>
	         	</table>
            	<!--  <table class="table table-hover table-condensed" >
	         	    <%
	                /*String [] modules = AdminFunction.getAllModules();
	                for(int i=1;i<modules.length;i++){
	               %>
	         	<tr>
        <td class="tbl-center"><strong><%=modules[i] %></strong></td>
           <td>
    	    <%
	         String[] functions = AdminFunction.getAllFunctions(modules[i]);
	         for(int t=1;t<functions.length;t++){
	         %>
	  		 <label class="checkbox-inline"><input type="checkbox" name="sys_<%=AdminFunction.getFunctionId(modules[i],functions[t]) %>" value="Y" <%=functions[t].equals(AdminFunction.None)?"disabled=disabled":"" %>><%=functions[t] %></label>
	     <%}%>
		</td>
	           </tr>
	         	<%}*/ %>
	         	</table> -->
	         	
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
		document.addForm.submit();
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


