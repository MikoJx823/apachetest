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
	AdminService.performBlockAccess(request, response, AdminFunction.Product, AdminFunction.View);	

	Date nowDate = new Date();
	
    AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute(SessionName.loginAdmin);
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
    
    List<ProductBean> productList = (List<ProductBean>)request.getAttribute("productList");

	String productCode = StringUtil.filter((String)request.getSession().getAttribute("productCode"));
	String name = StringUtil.filter((String)request.getSession().getAttribute("name"));
	String status = StringUtil.filter((String)request.getSession().getAttribute("status"));
	String categoryStr = StringUtil.filter((String)request.getSession().getAttribute("category"));
	String platform = StringUtil.filter((String)request.getSession().getAttribute("platform"));
	String merchantName = StringUtil.filter((String)request.getSession().getAttribute("merchantName"));
	
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
    
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
<form role="form" id="productForm" action="AdminProductServlet" method="post">
<input type="hidden" name="from" value="search">
<input type="hidden" name="actionType" id="actionType" value="search">	  
  <div class="panel-body">
     
      <div class="uppertab">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
   	 <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" class="active"><a href="../product/AdminProductServlet?actionType=search&from=menu">Product Search</a></li>
    <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="productAdd.jsp">Add Product</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../product/indexIdx.jsp">Add To Index</a></li>
    <%} %>
  </ul>

  <!-- Tab panes -->
<div class="bg-light-primary pd-15">

    <div class="row">
       
      <div class="col-xs-8">
          <div class="form-group">
            <label>Product Name</label>
            <input class="form-control" name="name" autocomplete="off" value="<%=name%>">
          </div>
      </div><!--col-xs-8-->
      
      <div class="col-xs-8">
      <div class="form-group">
        <label>Product Code</label>
        <input class="form-control" name="productCode" autocomplete="off" value="<%=StringUtil.filter(productCode)%>">
      </div>
     </div>
     
       <div class="col-xs-8">
      <div class="form-group">
           <label>Category</label>
             <select name="category" class="form-control">
             	<%= CategoryService.getInstance().getCategorySearchPulldown(categoryStr) %>
      		 </select>
         </div>
       </div><!--col-xs-8-->
      </div><!--row end-->
      
       <div class="row"> 
       
       		
       		<div class="col-xs-8">
        <div class="form-group">
           <label>Status</label>
             <select name="status" class="form-control">
        		<%=GenericStatusPulldown.getPulldownForSearch(status) %> 
      		 </select>
         </div>
       </div><!--col-xs-8-->
       </div>
       
        <div class="row">
              
	        <div class="col-xs-8"></div>
        	<div class="col-xs-8"></div>
        
	       	<div class="col-xs-8 text-right">    
	       		<button onclick="search()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Search</button>
	       	</div>
       
      </div><!--row end-->
    
</div><!--.bg-light-primary-->

</div><!--.uppertab-->

<hr>
<!--result-->

<h4 class="text-primary">Product List</h4>

<%if (productList.size() > 0 ) { %>
<div class="table-responsive">
<table class="table table-condensed table-striped table-hover mb-5">
<thead class="bg-black">
<tr>
<th width="10%">Code</th>
<th width="45%">Name</th>
<th width="20%">Category</th>
<th width="10%">Status</th>
<th width="15%">Action</th>
</tr></thead>
<tbody>


<%
	for(ProductBean bean:productList){ 
		 CategoryBean category = CategoryService.getInstance().getBeanById(bean.getCategoryid());
	     
	     String categoryName = "";
	     String soldQtyStr = "";
	     String displayStatus = "";
	     
	     if(category != null) categoryName = StringUtil.filter(category.getName());
	     
	     /*if(bean.getStatus() == StaticValueUtil.Inactive || 
	         !(bean.getDisplaystart().before(new Date()) && bean.getDisplayend().after(new Date()))){ 
	    	 displayStatus = GenericStatusPulldown.getText(StaticValueUtil.Inactive);
	     }else {
	    	 displayStatus = GenericStatusPulldown.getText(StaticValueUtil.Active);
	     } */
	     	
%>  
    <tr>
    	<td class="tbl-center"><%=StringUtil.filter(bean.getProductcode()) %></td>
        <td class="tbl-center"><%=StringUtil.delHTMLTag(bean.getName())%></td>
        <td class="tbl-center"><%=categoryName %></td>
        <td class="tbl-center"><%=GenericStatusPulldown.getText(bean.getStatus())%></td>
        <td class="tbl-center">
        <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
       		<a href="productView.jsp?pid=<%=bean.getId() %>" class="btn btn-xs btn-cancel">View</a>
       	<%} %>
       	<%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
        	<a href="productEdit.jsp?pid=<%=bean.getId() %>" class="btn btn-xs btn-primary">Edit</a>
        <%} %>
        <%/*if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
        	<a href="AdminProductServlet?actionType=inactive&pid=<%=bean.getId() %>" >Inactive</a>
        <%} */%>
           <%--
           <a  onclick="return confirm('Are you sure to delete <%=bean.geteName() %>?')" href="ProductServlet?actionType=productDel&pid=<%=bean.getPid() %>" class="btn btn-sm btn-danger"><span class="fa fa-remove"></span> Delete</a>
            --%>
            </td>
    </tr>
<%} %>    
    
</tbody>
</table>
</div>
<div class="row text-center">
<%=StringUtil.getPagingString(5, pageIdx, totalPages, "AdminProductServlet?actionType=search&pageIdx=") %>

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

function search(){
	 $("#actionType").val("search");
	 $("#productForm").submit();
}

</script>
</body>
</html>
