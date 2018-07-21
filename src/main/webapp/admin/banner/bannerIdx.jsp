<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.util.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	AdminService.getInstance().checkLogin(request, response);	

	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.Banner, AdminFunction.View);
	
	AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute(SessionName.loginAdmin);
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	
    List<BannerInfoBean> list = (List<BannerInfoBean>)request.getAttribute("bannerList") == null ? new ArrayList<BannerInfoBean>() : (List<BannerInfoBean>)request.getAttribute("bannerList");
 
	String name = StringUtil.filter((String)request.getSession().getAttribute("name"));
	String status = StringUtil.filter((String)request.getSession().getAttribute("status"));
	String position = StringUtil.filter((String) request.getSession().getAttribute("position"));
	
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
    
	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
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

	<jsp:include page="../main/leftMenu.jsp"><jsp:param value="settings" name="pageIdx"/> </jsp:include> 
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
<div class="panel-heading"><big>Banner Management</big> </div>
<jsp:include page="../main/msgAlert.jsp"></jsp:include>
<form role="form" action="AdminBannerServlet" method="post">
<input type="hidden" name="from" value="search">
<input type="hidden" name="actionType" value="search">	  
  <div class="panel-body">
     
      <div class="uppertab">
		
	  <jsp:include page="../menu/bannerMenu.jsp"><jsp:param value="bannerMenu" name="target"/> </jsp:include> 
	
  <!-- Tab panes -->
<div class="bg-light-primary pd-15">

	<div class="row">
       
    	<div class="col-xs-8">
        	<div class="form-group">
            	<label>Name</label>
            	<input class="form-control" name="name" autocomplete="off" value="<%=name%>">
          	</div>
      	</div><!--col-xs-8-->

    	<div class="col-xs-8">
       		<div class="form-group">
           		<label>Position</label>
             	<select name="platform" class="form-control">
					<%=BannerPositionPulldown.searchPulldown(position) %>
      		 	</select>
         	</div>
       	</div><!--col-xs-8--> 
       	
       	<div class="col-xs-8">
       		<div class="form-group">
           		<label>Status</label>
             	<select name="status" class="form-control">
        			<%=GenericStatusPulldown.getPulldownForSearch(status) %> 
      		 	</select>
         	</div>
       	</div><!--col-xs-8--> 
	</div><!--row end-->

    <div class="row">
		<div class="col-xs-8"></div>
        <div class="col-xs-8"></div>
        
	    <div class="col-xs-8 text-right">    
	    	<button type="submit" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Search</button>
	    </div>
    </div><!--row end-->
</div><!--.bg-light-primary-->

</div><!--.uppertab-->

<hr>
<!--result-->

<h4 class="text-primary">Banner List</h4>

<%if (list.size() > 0 ) { %> 

<table class="table table-condensed table-striped table-hover mb-5">
<thead class="bg-black">
<tr>
<th width="67%">Name</th>
<th width="10%">Position</th>
<th width="6%">Sequence</th>
<th width="7%">Status</th>
<th width="10%">Action</th>
</tr></thead>
<tbody>

<%
	for(BannerInfoBean bean: list){ 
		
%>  
    <tr>
    	<td class="tbl-center"><%=StringUtil.filter(bean.getName())%></td>
    	<td class="tbl-center"><%=BannerPositionPulldown.getText(bean.getPosition())%></td>
    	<td class="tbl-center"><%=bean.getSeq()%></td>
        <td class="tbl-center"><%=GenericStatusPulldown.getText(bean.getStatus())%></td>
        <td class="tbl-center">
        <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Banner, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
        <a href="bannerView.jsp?id=<%=bean.getId() %>" class="btn btn-xs btn-cancel">View</a>
        <%} %>
        <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Banner, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
        <a href="bannerEdit.jsp?id=<%=bean.getId() %>" class="btn btn-xs btn-primary">Edit</a>
        <%} %>
        </td>
    </tr>
<%} %>    
    
</tbody>
</table>

<div class="row text-center">
<%=StringUtil.getPagingString(5, pageIdx, totalPages, "AdminBannerServlet?actionType=search&pageIdx=") %>

  </div>
<!--result table-->

<%}else { %>
	 No records found !

<%} %>
  </div><!--panel body ended-->
 </form> 

	</div><!-- main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    </div>
  
    </section><!-- /section.container -->
  
<script type="text/javascript">
$(function () { $('.tooltip-show').tooltip('show');});
</script>
</body>
</html>
