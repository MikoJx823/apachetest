<%@page import="com.project.pulldown.*"%>
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
	//AdminService.getInstance().checkLogin(request, response);
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.Product, AdminFunction.Add);	

	Date nowDate = new Date();

	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
    
    List<IndexInfoBean> latestProductList = IndexService.getInstance().getListBySqlwhere(" where status != " + StaticValueUtil.Delete + " and type = " + StaticValueUtil.INDEX_LATEST);
    List<IndexInfoBean> topRatedList = IndexService.getInstance().getListBySqlwhere(" where status != " + StaticValueUtil.Delete + " and type = " + StaticValueUtil.INDEX_TOP_RATED);
	
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

	<jsp:include page="../main/leftMenu.jsp"><jsp:param value="product" name="pageIdx"/> </jsp:include> 
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
<div class="panel-heading"><big>Product Management</big> </div>
<jsp:include page="../main/msgAlert.jsp"></jsp:include>
<form role="form" id="productForm" action="AdminIndexServlet" method="post">
<input type="hidden" name="actionType" id="actionType" value="add">	  
  <div class="panel-body">
     
      <div class="uppertab">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
   	 <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../product/AdminProductServlet?actionType=search&from=menu">Product Search</a></li>
    <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="productAdd.jsp">Add Product</a></li>
     <%} %>
    <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" class="active"><a href="../product/indexIdx.jsp">Add To Index</a></li>
    <%} %>
  </ul>

  <!-- Tab panes -->
<div class="bg-light-primary pd-15">

    <div class="row">
       
      <div class="col-xs-8">
          <div class="form-group">
            <label>Product</label>
            <select class="form-control" name="pid">
            <%=ProductService.getInstance().getProductNamePulldown(0) %>
            </select>
          </div>
      </div><!--col-xs-8-->
      
      <div class="col-xs-8">
      <div class="form-group">
        <label>Index Display Type</label>
        <select name="type" class="form-control">
        <%=IndexTypePulldown.select(0) %>
        </select>
      </div>
     </div>
     
      </div><!--row end-->

        <div class="row">
              
	        <div class="col-xs-8"></div>
        	<div class="col-xs-8"></div>
        
	       	<div class="col-xs-8 text-right">    
	       		<button onclick="add()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Add</button>
	       	</div>
       
      </div><!--row end-->
    
</div><!--.bg-light-primary-->

</div><!--.uppertab-->

<hr>
<!--result-->

<h4 class="text-primary">Index List</h4>

<%if ((latestProductList != null && latestProductList.size() > 0  ) || 
		(topRatedList != null && topRatedList.size() > 0)) { %>
<div class="row">
<div class="col-xs-8">
	<div class="form-group">
        <label>Index Display Type</label>
        <select class="form-control" id="selectType" onchange="onTypeChange()">
        <%=IndexTypePulldown.select(0) %>
        </select>
 	</div>
</div>
</div>

<div id="latestProduct-container" class="hidden">
<div class="table-responsive">
<table class="table table-condensed table-striped table-hover mb-5">
<thead class="bg-black">
<tr>
<th width="45%">Name</th>
<th width="20%">Type</th>
<th width="15%">Action</th>
</tr></thead>
<tbody>


<%
	if(latestProductList != null && latestProductList.size() > 0) {
	for(IndexInfoBean bean: latestProductList){ 
		 ProductBean product = ProductService.getInstance().getProductById(bean.getPid());
	     
	     String name = "";
	     
	     if(product != null) name = StringUtil.filter(product.getName());
%>  
    <tr>
        <td class="tbl-center"><%=name%></td>
        <td class="tbl-center"><%=IndexTypePulldown.getText(bean.getType())%></td>
        <td class="tbl-center">
        <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
        	 <a  onclick="return confirm('Are you sure to delete <%=name%>?')" href="AdminIndexServlet?actionType=delete&id=<%=bean.getId() %>" class="btn btn-sm btn-danger"><span class="fa fa-remove"></span> Delete</a>
        <%}%>
		</td>
    </tr>
<%} }%>    

    
</tbody>
</table>
</div>
</div>

<div id="topRated-container" class="hidden">
<div class="table-responsive">
<table class="table table-condensed table-striped table-hover mb-5">
<thead class="bg-black">
<tr>
<th width="45%">Name</th>
<th width="20%">Type</th>
<th width="15%">Action</th>
</tr></thead>
<tbody>


<%
	if(topRatedList != null && topRatedList.size() > 0) {
	for(IndexInfoBean bean: topRatedList){ 
		 ProductBean product = ProductService.getInstance().getProductById(bean.getPid());
	     
	     String name = "";
	     
	     if(product != null) name = StringUtil.filter(product.getName());
%>  
    <tr>
        <td class="tbl-center"><%=name%></td>
        <td class="tbl-center"><%=IndexTypePulldown.getText(bean.getType())%></td>
        <td class="tbl-center">
        <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
        	 <a  onclick="return confirm('Are you sure to delete <%=name%>?')" href="AdminIndexServlet?actionType=delete&id=<%=bean.getId() %>" class="btn btn-sm btn-danger"><span class="fa fa-remove"></span> Delete</a>
        <%} %>
		</td>
    </tr>
<%} }%>    

    
</tbody>
</table>
</div>
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

function add(){
	 $("#actionType").val("add");
	 $("#productForm").submit();
}

function onTypeChange(){
	var selectType = $("#selectType").val();
	
	if(selectType == <%=StaticValueUtil.INDEX_LATEST %>){
		$("#latestProduct-container").removeClass("hidden");
		$("#topRated-container").addClass("hidden");
	}else if (selectType == <%=StaticValueUtil.INDEX_TOP_RATED%>){
		$("#latestProduct-container").addClass("hidden");
		$("#topRated-container").removeClass("hidden");
	}else{
		$("#latestProduct-container").addClass("hidden");
		$("#topRated-container").addClass("hidden");
	}

	

}

</script>
</body>
</html>
