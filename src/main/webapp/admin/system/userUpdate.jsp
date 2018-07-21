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
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.System, AdminFunction.Edit);	

    String aid = request.getParameter("aid");
    
    AdminInfoBean admin = AdminService.getInstance().getAdminInfoBeanByAid(Integer.valueOf(aid)); 
    
    List<GroupInfoBean> list = AdminService.getInstance().getGroupList();
    
    AdminInfoBean userUpdateBean = (AdminInfoBean)request.getAttribute("userInfoBean");
    
    if(userUpdateBean != null){
    	admin = userUpdateBean;
    }
    
    //List<BranceBean> branceList = AdminService.getInstance().getBranceList();
    
    String basePath = StringUtil.getHostAddress() + "admin/";
%>

<!DOCTYPE html>
<html>
 	<jsp:include page="../main/adminHeader.jsp"></jsp:include>

  <body>
  <form action="UserServlet" name="updateForm" method="post" >
  <input type="hidden" name="actionType" value="userUpdate">
  <input type="hidden" name="aid" value="<%=admin.getAid() %>"/>
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
  
  <div class="panel-heading"><big>Edit User</big></div>
  <jsp:include page="../main/msgAlert.jsp"></jsp:include>
   
  <div class="panel-body">
  
   <h5 class="text-primary">User Information</h5>

<div class="row">        
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>Login ID</label>
                    <p class="form-control-static"><%=admin.getLoginId() %></p>
                    <input type="hidden" name="loginId" value="<%=admin.getLoginId() %>" />
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                 
                 <div class="col-xs-8">
               	  <div class="form-group">
                    <label>Staff Name</label>                    
                    <input class="form-control" name="name"  value="<%=admin.getName() %>">
                    <!-- 
                    <input type="hidden" name="name" value="<%=admin.getName() %>" />
                     -->
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                 
                 
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>Email</label>
                     <input class="form-control" name="email"  value="<%=admin.getEmail() %>">
                     <!-- 
                    <input type="hidden" name="email" value="<%=admin.getEmail() %>" />
                     -->
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                 
                 
                  
          </div><!--row ended-->
         <div class="row">
               <div class="col-xs-8">
                	<div class="form-group">
                    <label>User Group</label>
                   <select class="form-control" id="gid" name="gid">
	         	    <%for(GroupInfoBean bean:list) {%>
		           <option value="<%=bean.getGid()%>" <%if(admin.getGid()==bean.getGid()){ %> selected="selected" <%} %> ><%=bean.getGroupName()%></option>
		           <%}%>
		      </select>
          			</div><!--form-group-->
               </div><!--col-xs-8-->
               
               
               <div class="col-xs-8">
                	<div class="form-group">
                    <label>Status</label>
                   <select class="form-control" id="status" name="status">
                   <%=UserStatus.select(Integer.valueOf(admin.getStatus()), false)%>
                   </select>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
          </div><!--row ended-->
    
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
  <a class="btn btn-primary loginbtn hvr-float-shadow" href="javascript:formSubmit();">Submit</a>
  <a class="btn btn-cancel loginbtn hvr-float-shadow" href="javascript:onBack()">Back</a>
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

	function formSubmit(){		
		document.updateForm.submit();
	}
    
	function onBack(){
		window.location="../system/UserServlet?actionType=getUserList&from=menu";
	}
    
    </script> 
  </body>
</html>

