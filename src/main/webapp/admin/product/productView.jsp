<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.service.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.util.*"%>
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

	Date startDate = new Date();
	Date endDate = new Date();
	
	int pid = StringUtil.strToInt(request.getParameter("pid"));
	ProductBean bean = ProductService.getInstance().getProductById(pid);
	List<ProductVariantBean> variants = ProductService.getInstance().getProductVariantListById(pid);
	
	/*if(bean.getDisplaystart()!=null){
		startDate = bean.getDisplaystart();
	}
	if(bean.getDisplayend()!=null){
		endDate = bean.getDisplayend();
	}*/
	
	//AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute(SessionName.loginAdmin);
	
	String basePath = StringUtil.getHostAddress() + "admin/";
	
	String defaultPath = StringUtil.getHostAddress();
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
  			
	<div class="panel-heading"><big>View Product</big> </div>
		<jsp:include page="../main/msgAlert.jsp"></jsp:include>
  		<div class="panel-body">
     		
            <h5 class="text-primary">Product Information </h5>
          
            <table class="table table-hover table-condensed">
            <tbody>
            <tr>
            	<td class="tbl-title">Product Id </td>
                <td class="tbl-content"><%=bean.getId() %></td>
                
                <td class="tbl-title"></td>
                <td class="tbl-content"></td>
            </tr>
            
            <tr>
            	<td class="tbl-title">Name </td>
                <td class="tbl-content"><%=StringUtil.filter(bean.getName()) %></td>
                
                <td class="tbl-title">Category</td>
                <td class="tbl-content"><%=CategoryService.getInstance().getBeanById(bean.getCategoryid()).getName() %></td>
            </tr>
 
            <tr>
            	<td class="tbl-title">Product Code</td>
                <td class="tbl-content"><%=StringUtil.filter(bean.getProductcode()) %></td>
                
            	<td class="tbl-title">Status</td>
                <td class="tbl-content"><%=GenericStatusPulldown.getText(bean.getStatus())%></td>
            </tr> 
            
            <tr>
            	<td class="tbl-title">Product List Text</td>
                <td class="tbl-content"><%=StringUtil.filter(bean.getListtext()) %></td>
                
            	<td class="tbl-title"></td>
                <td class="tbl-content"></td>
            </tr>

            <tr>
            	<td class="tbl-title" colspan="4">
            		
            	<div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>1</small></label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage1()).equals("")) ) {  %>
                    <img src="<%=defaultPath%>images/products/<%=StringUtil.filter(bean.getImage1()) %>" width="100px">
          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
            	  <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>2</small></label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage2()).equals("")) ) {  %>
                    <img src="<%=defaultPath%>images/products/<%=StringUtil.filter(bean.getImage2()) %>" width="100px">
          			          			
          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                               
                  <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>3</small></label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage3()).equals("")) ) {  %>
                    <img src="<%=defaultPath%>images/products/<%=StringUtil.filter(bean.getImage3()) %>" width="100px">

          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
                <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>4</small></label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage4()).equals("")) ) {  %>
          				<img src="<%=defaultPath%>images/products/<%=StringUtil.filter(bean.getImage4()) %>" width="100px">
          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
				
				<!--<div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>5</small></label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage5()).equals("")) ) {  %>
          				<img src="<%=defaultPath%>images/products/<%=StringUtil.filter(bean.getImage5()) %>" width="100px">
          			<%} %>
          			</div>
                 </div> col-xs-6-->
            	</td>
            </tr>
            
            <tr>
            	<td class="tbl-title" colspan="4">
            		
            	<div class="col-xs-6">
                	<div class="form-group">
                    <label>Description Image </label>
                    <%if(!(StringUtils.trimToEmpty(bean.getDescimage()).equals("")) ) {  %>
                    <img src="<%=defaultPath%>images/products/<%=StringUtil.filter(bean.getDescimage()) %>" width="100px">
          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
                 <div class="col-xs-12">
                	<div class="form-group">
                    <label>Description Youtube </label>
                    <%= StringUtils.trimToEmpty(bean.getDescyoutube()) %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
            	</td>
            </tr>
            <tr>
            	<td class="tbl-title">Short Description </td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getShortdesc())%></td>
            </tr>
            
            <tr>
            	<td class="tbl-title">Additional Description </td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getAdditionaldesc())%></td>
            </tr>
            
            <!--  <tr>
            	<td class="tbl-title">Product Description </td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getDetail())%></td>
            </tr> -->
            
            
            </tbody>
            
            </table>
       
 
      <h5 class="text-primary">Pricing Information</h5>
          <table class="table table-hover table-condensed">
          
          <thead class="bg-black">
			<tr>
			<th width="10%">Name</th>
			<th width="10%">Colour Code</th>
			<th width="10%">Price</th>
			<th width="10%">Discount</th>
			<th width="10%">Quantity</th>
			<th width="60%">Valid Date</th>
			</tr>
		  </thead>
 		  <tbody>
 <%  
	 for (ProductVariantBean variant : variants)  { 
	 
 %>
            <tr>
             	<td><%=StringUtil.filter(variant.getName()) %></td>
             	<td><%=StringUtil.filter(variant.getCode()) %></td>
                <td><%=variant.getPrice()%></td>
             	<td><%=variant.getDiscount() %></td>
             	<td><%=variant.getQuantity() %></td>
                <td><%=DateUtil.formatDatetime_ss(variant.getDiscountstart()) %> --- 
                	<%=DateUtil.formatDatetime_ss(variant.getDiscountend()) %>
                </td>
            </tr>
<% } %>
		</tbody>
		</table>
		 
         </div>
         	<div class="panel-footer text-right"> <!--  onclick="history.go(-1)" -->
			   	<button type="button" onclick="back()" class="btn btn-cancel loginbtn hvr-float-shadow">Back</button>
			</div><!--panel-footer-->
        </div>
<!--.panel group plan ended-->
	
  </div><!--panel body ended-->
	  	
	</div> <!--panel default main panel-->
  
    </section><!-- /section.container -->
  
<script type="text/javascript">

function back() {
	window.location="../product/AdminProductServlet?actionType=search&from=menu";
		//window.location = "../product/AdminProductServlet?actionType=getSearchList&pageIdx=<%=StringUtil.trimToInt(request.getSession().getAttribute(SessionName.pageIdx))%>";
}

</script>
</body>

</html>
