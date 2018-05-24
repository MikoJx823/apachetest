<%@page import="org.apache.poi.hssf.record.formula.Ptg"%>
<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	Date nowDate = new Date();
	
    AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
    
    List<ProductBean> productList = (List<ProductBean>)request.getAttribute("productList");
 
	List<CategoryBean> categoryList = CategoryService.getInstance().getCategoryBeanListBySqlwhere("");
	
	String productCode = StringUtil.filter((String)request.getSession().getAttribute("productCode"));
	String name = StringUtil.filter((String)request.getSession().getAttribute("name"));
	String status = StringUtil.filter((String)request.getSession().getAttribute("status"));
	String categoryStr = StringUtil.filter((String)request.getSession().getAttribute("category"));
	String platform = StringUtil.filter((String)request.getSession().getAttribute("platform"));
	String merchantName = StringUtil.filter((String)request.getSession().getAttribute("merchantName"));
	
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
    
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
	
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
<form role="form" id="productForm" action="ProductServlet" method="post">
<input type="hidden" name="from" value="search">
<input type="hidden" name="actionType" id="actionType" value="getSearchList">	  
  <div class="panel-body">
     
      <div class="uppertab">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
   	 <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" class="active"><a href="../product/ProductServlet?actionType=getSearchList&from=menu">Product Search</a></li>
    <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="productAdd.jsp">Add Product</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Branch, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../productbranch/AdminProductBranchServlet?actionType=getSearchList&from=menu">Branch Search</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Branch, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../productbranch/productBranchAdd.jsp">Add Branch</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.EcoPoint, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../ecopoint/AdminEcoPointServlet?actionType=getSearchList&from=menu">Eco Point Search</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.EcoPoint, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../ecopoint/ecoPointAdd.jsp">Add Eco Point</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Discount, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../productdiscount/discountView.jsp">Promotion Discount</a></li>
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
           <label>Merchant Name</label>
           <input class="form-control" name="merchantName" autocomplete="off" value="<%=StringUtil.filter(merchantName)%>"> 
         </div>
       </div><!--col-xs-8-->
       
      </div><!--row end-->
      
       <div class="row"> 
       
      <div class="col-xs-8">
      <div class="form-group">
           <label>Category</label>
             <select name="category" class="form-control">
             	<%=CategoryPulldown.searchPPulldown(categoryStr) %>
      		 </select>
         </div>
       </div><!--col-xs-8-->
		
			<div class="col-xs-8">
		      <div class="form-group">
		           <label>Display Channel</label>
		             <select name="platform" class="form-control">
		                 <%=DisplayPlatformPulldown.searchPulldown(platform) %>
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
       </div>
       
        <div class="row">
              
	        <div class="col-xs-8"></div>
        	<div class="col-xs-8"></div>
        
	       	<div class="col-xs-8 text-right">    
	       		<button onclick="search()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Search</button>
	       		<%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Export), AdminFunction.haveRight, adminGroupFunctions)) {%>
	       			<button onclick="exportList()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Export</button> 
	       		<%} %>
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
<th width="100">Merchant Name</th>
<th width="100">Product Code</th>
<th width="300">Product Name</th>
<th width="100">Category</th>
<th width="100">Valid Date</th>
<th width="100">Sold(Qty)</th>
<th width="100">Total(Qty)</th>
<th >Original Price</th>
<th >Discounted Price</th>
<th >Status</th>
<th width="150">Action</th>
</tr></thead>
<tbody>


<%
	for(ProductBean bean:productList){ 
		 CategoryBean category = CategoryService.getInstance().getCategoryById(bean.getCategoryid());
	     MerchantBean merchant = MerchantService.getInstance().getMerchantById(bean.getMerchantCode());
		 
	     String categoryName = "";
	     String merName = "";
	     String originalPriceStr = "";
	     String discountedPriceStr = "";
	     int soldOutQty = 0;
	     int totalQty = 0;
	     String soldQtyStr = "";
	     String displayStatus = "";
	     
	     for(ProductQtyBean productQty: bean.getProductQty()) {
	 		 //soldOutQty = soldOutQty + ProductService.getInstance().getSoldOutProductQty(productQty.getPqid());
	 		 soldOutQty = soldOutQty + ProductService.getInstance().getHoldProductQty(productQty.getPqid());
	 		 totalQty = totalQty + productQty.getQuantity();
	     }
	     
	     for(ProductPriceBean price : bean.getProductPrice()){
	    	 originalPriceStr = price.getPrice() + "";
	    	 
	    	 if(price.getEnableEB() == StaticValueUtil.PRODUCT_ENABLE && price.getDiscount() > 0 && 
	 				price.getEbStartDate() != null && price.getEbEndDate() != null){
	 			
	 			if(price.getEbStartDate().before(new Date()) && price.getEbEndDate().after(new Date())){
	 				discountedPriceStr = price.getDiscount() + "";
	 			}
	 		}else if(price.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE) {
	 			
	 			EcoPointBean point = EcoPointService.getInstance().getEcoPointById(price.getEpid());
	 			
	 			if(point != null) {
	 				double discount = (point.getRatio() * point.getPoints());
	 				discountedPriceStr = (price.getPrice() - discount) + "" ;		
	 			}
	 		} 
	    	 
	     }
	     
	     if(category != null) categoryName = StringUtil.filter(category.geteName());
	     
	     if(merchant != null) merName = StringUtil.filter(merchant.getEname());
	    
	     if(bean.getStatus() == StaticValueUtil.Inactive || 
	         !(bean.getDisplayStartDate().before(new Date()) && bean.getDisplayEndDate().after(new Date()))){ 
	    	 displayStatus = GenericStatusPulldown.getText(StaticValueUtil.Inactive);
	     }else {
	    	 displayStatus = GenericStatusPulldown.getText(StaticValueUtil.Active);
	     } 
	     	
%>  
    <tr>
    	<td class="tbl-center"><%=merName %></td>
    	<td class="tbl-center"><%=StringUtil.filter(bean.getCode()) %></td>
        <td class="tbl-center"><%=StringUtil.delHTMLTag(bean.geteName())%></td>
        <td class="tbl-center"><%=categoryName %></td>
        <td class="tbl-center"><%=DateUtil.formatDatetime_ss(bean.getDisplayStartDate()) %> - - -  <%=DateUtil.formatDatetime_ss(bean.getDisplayEndDate()) %></td>
        <td class="tbl-center"><%=soldOutQty%></td>
        <td class="tbl-center"><%=totalQty%></td>
        <td class="tbl-center"><%=originalPriceStr%></td>
        <td class="tbl-center"><%=discountedPriceStr%></td>
        <td class="tbl-center"><%=GenericStatusPulldown.getText(bean.getStatus())%></td>
        <td class="tbl-center">
        <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
       		<a href="productView.jsp?pid=<%=bean.getId() %>" class="btn btn-xs btn-cancel">View</a>
       	<%} %>
       	<%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
        	<a href="productEdit.jsp?pid=<%=bean.getId() %>" class="btn btn-xs btn-primary">Edit</a>
        <%} %>
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
<%=StringUtil.getPagingString(5, pageIdx, totalPages, "ProductServlet?actionType=getSearchList&pageIdx=") %>

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

function exportList(){
	 $("#actionType").val("export");
	 $("#productForm").submit();
}

function search(){
	 $("#actionType").val("getSearchList");
	 $("#productForm").submit();
}

</script>
</body>
</html>
