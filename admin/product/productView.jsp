<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.service.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> 
<%
	Date startDate = new Date();
	Date endDate = new Date();
	//ProductBean bean = (ProductBean) request.getSession().getAttribute("product");
	String id = request.getParameter("pid");
	ProductBean bean = ProductService.getInstance().getProductBySqlwhere("where id="+id).get(0);
	/*
	if (bean==null){
		return;	
	}
	*/
	if(bean.getDisplayStartDate()!=null){
		startDate = bean.getDisplayStartDate();
	}
	if(bean.getDisplayEndDate()!=null){
		endDate = bean.getDisplayEndDate();
	}
	
	AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	
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
            	<td class="tbl-title">Name <small>(Eng)</small></td>
                <td class="tbl-content"><%=bean.geteName() %></td>
                
                <td class="tbl-title">Name <small>(Chi)</small></td>
                <td class="tbl-content"><%=bean.getcName() %></td>
            </tr>
            
             <tr>
                <td class="tbl-title">Category</td>
                <td class="tbl-content"><%=CategoryService.getInstance().getCachedCat(bean.getCategoryid(),"E") %>
                <%if(bean.getHotPick() == StaticValueUtil.PRODUCT_ENABLE) { %> &nbsp;&nbsp; (Hot Pick) <%} %>
                </td>
				
				<td class="tbl-title">Product Type </td>
                <td class="tbl-content"><%=ProductTypePulldown.getText(bean.getType()) %></td>
            </tr>
            
            <tr>
                <td class="tbl-title">Display Platform</td>
                <td class="tbl-content"></td>
				
				<td class="tbl-title">Merchant Code</td>
                <td class="tbl-content"></td>
            </tr>  
            
            <tr>
                <td class="tbl-title">OA Number</td>
                <td class="tbl-content"><%=StringUtil.filter(bean.getAONumber()) %></td>
				
				<td class="tbl-title">Material Number</td>
                <td class="tbl-content"><%=StringUtil.filter(bean.getMaterialNumber()) %></td>
            </tr>
 
            <tr>
            	<td class="tbl-title">Display Date</td>
                <td class="tbl-content"><%=DateUtil.formatDatetime_ss(startDate) %> - - -  <%=DateUtil.formatDatetime_ss(endDate) %></td>
            	
                <td class="tbl-title">Product Code</td>
                <td class="tbl-content"><%=StringUtil.filter(bean.getCode()) %></td>
            </tr> 
            
             <tr>
                <td class="tbl-title">Status</td>
                <td class="tbl-content"><%=GenericStatusPulldown.getText(bean.getStatus())%></td>
                
                <td class="tbl-title">Display Status</td>
                <td class="tbl-content">
                <%if(bean.getStatus() == StaticValueUtil.Inactive || 
                !(bean.getDisplayStartDate().before(new Date()) && bean.getDisplayEndDate().after(new Date()))){ %>
                	<%=GenericStatusPulldown.getText(StaticValueUtil.Inactive) %>
                <%}else { %>
                	<%=GenericStatusPulldown.getText(StaticValueUtil.Active) %>
                <%} %>
                </td>
                <!--  <td class="tbl-title">Code</td>
                <td class="tbl-content"><%=StringUtils.trimToEmpty(bean.getCode())%></td> -->

            </tr>

            <!--  <tr>
            	<td class="tbl-title">Support Branch</td>
                <td class="tbl-content"><%//brance==null?"":brance.geteName()%></td>
                
                <td class="tbl-title">Support Type</td>
                <td class="tbl-content"><%//type.geteName()%></td>

            </tr> -->
            <tr>
            	<td class="tbl-title" colspan="4">
            		
            	<div class="col-xs-6">
                	<div class="form-group">
                    <label>Small Image</label>
                    <%if(!(StringUtils.trimToEmpty(bean.getSimage()).equals("")) ) {  %>
                    <img src="../../GetImageFileServlet?&name=<%=StringUtil.filter(bean.getSimage()) %>" width="100px">
          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
            	  <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>1</small></label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage1()).equals("")) ) {  %>
                    <img src="../../GetImageFileServlet?&name=<%=StringUtil.filter(bean.getImage1()) %>" width="100px">
                    <!--  <img src="<%=PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost")+PropertiesUtil.getProperty("productImagePath") %><%=bean.getImage1() %>" width="100px" >              
          			
          			<img src="../../product_img/<%=bean.getImage1() %>">-->
          			
          			
          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                               
                  <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>2</small></label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage2()).equals("")) ) {  %>
                    <img src="../../GetImageFileServlet?&name=<%=StringUtil.filter(bean.getImage2()) %>" width="100px">
                     <!--  <img src="<%=PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost")+PropertiesUtil.getProperty("productImagePath") %><%=bean.getImage2() %>" width="100px" >	         	
          				-->
          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
                <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>3</small></label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage3()).equals("")) ) {  %>
                     <!--  <img src="<%=PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost")+PropertiesUtil.getProperty("productImagePath") %><%=bean.getImage3() %>" width="100px" >    	
          				-->
          				<img src="../../GetImageFileServlet?&name=<%=StringUtil.filter(bean.getImage3()) %>" width="100px">
          			<%} %>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->

            	</td>
            </tr>
            <!--  <tr>
            	<td class="tbl-title">Manufacture Description <small>(Eng)</small></td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getEmanufactdesc())%></td>
            </tr>
            <tr>
            	<td class="tbl-title">Manufacture Description  <small>(Chi)</small></td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getCmanufactdesc())%></td>
            </tr> -->
            <tr>
            	<td class="tbl-title">Product Description <small>(Eng)</small></td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.geteDescDetail())%></td>
            </tr>
            <tr>
            	<td class="tbl-title">Product Description <small>(Chi)</small></td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getcDescDetail())%></td>
            </tr>
            <tr>
            	<td class="tbl-title">Energy Grade Description <small>(Eng)</small></td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getEfeaturedesc())%></td>
            </tr>
            <tr>
            	<td class="tbl-title">Energy Grade Description <small>(Chi)</small></td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getCfeaturedesc())%></td>
            </tr>
            
            <!--
              <tr>
            	<td class="tbl-title">Delivery Details <small>(Chi)</small></td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getcDeliveyDetail())%></td>
            </tr>
            <tr>
            	<td class="tbl-title">Delivery Details <small>(Eng)</small></td>
                <td class="tbl-content" colspan="3"><%=StringUtils.trimToEmpty(bean.getDeliveyDetail())%></td>
            </tr> -->
            </tbody>
            
            </table>

	
	

	  <h5 class="text-primary">Collection Information</h5>
	  
	  	<table class="table table-hover table-condensed">
          <tbody>
          	<tr>
          		<td class="tbl-title">Collection Method(s)</td>
          		<td colspan="3">
          		<b><%=StringUtil.filter(CollectionTypePulldown.getText(bean.getCollectionmethod()))%></b> <br>
          		
          		<%if(bean.getCollectionmethod() == StaticValueUtil.COLLECT_INSTALL) {%>
          			Install Fee : HKD <%=bean.getProductPrice().get(0).getInstallprice() %>
          		<%}else { 
          				if(bean.getEnabledelivery() == StaticValueUtil.PRODUCT_ENABLE){
          		%>			Delivery Enabled <br>		
          		<% 		}
          				
          				if(bean.getEnablepickup() == StaticValueUtil.PRODUCT_ENABLE){
          					String pickUpString = "Pickup Enabled <br>";
          					String pickUpContent = "";	
          				
          					List<ProductBranchBean> productBranchs = ProductBranchService.getInstance().getProductBranchGroupListBySqlwhere(" where productid= " 
          					+ bean.getId() + " and status = " + StaticValueUtil.Active); 

          					for(ProductBranchBean productBranch : productBranchs){
          					ProductBranchInfoBean branch = ProductBranchService.getInstance().getProductBranchById(productBranch.getBranchid());
          						pickUpContent += "<li>" + branch.getEname() + "</li>";
          					}
          					
          					if(productBranchs.size() > 0) pickUpString += "<ul>" + pickUpContent + "</ul>"; %>
          					
          					<%=StringUtil.filter(pickUpString) %>	
          		<% 		}
          		   } %>
          		</td>
          	</tr>
          	<%if(bean.getCollectionmethod() == StaticValueUtil.COLLECT_INSTALL) {%>
          	<tr>
            	<td class="tbl-title">Installation Text <small>(Eng)</small></td>
                <td class="tbl-content"><%=StringUtil.filter( bean.getProductPrice().get(0).getEinstalltext()) %></td>
                
                <td class="tbl-title">Installation Text <small>(Chi)</small></td>
                <td class="tbl-content"><%=StringUtil.filter( bean.getProductPrice().get(0).getCinstalltext()) %></td>
            </tr>
            <%} %>
          </tbody>
        </table>
       
 
      <h5 class="text-primary">Pricing Information</h5>
          <table class="table table-hover table-condensed">
          <tbody>
            
 		
 <%  for (ProductPriceBean productPrice : bean.getProductPrice())  { %>
             <tr>
             	<td class="tbl-title">Price</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(productPrice.getPrice())%></td>
             	
             	<td class="tbl-title"></td>
                <td class="tbl-content"></td>
            </tr>

            <tr>
            	<td class="tbl-title">Enable Early Bird </td>
                <td class="tbl-content"><%=GenericStatusPulldown.getEnableText(productPrice.getEnableEB()) %></td>
                
            	<td class="tbl-title">Early Bird Discount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(productPrice.getDiscount()) %></td>
            </tr>
            
            <tr>
            	<td class="tbl-title">Early Bird Start </td>
                <td class="tbl-content"><%=DateUtil.formatDatetime_ss(productPrice.getEbStartDate()) %></td>
                
            	<td class="tbl-title">Early Bird End</td>
                <td class="tbl-content"><%=DateUtil.formatDatetime_ss(productPrice.getEbEndDate()) %></td>
            </tr>
<% } %>
		</tbody>
		</table>
		
	<% if(bean.getType() == StaticValueUtil.productType_actual) { %>
        <h5 class="text-primary">Quantity Information</h5>
          <table class="table table-hover table-condensed">
          <tbody>

<%
	for (ProductQtyBean productQty : bean.getProductQty())  { 
		if (bean.getProductQty().size()==1) { %>
 	
             <tr>
            	<td class="tbl-title">Quantity</td>
                <td class="tbl-content"><%=productQty.getQuantity() %></td>
                
                <td class="tbl-title"></td>
                <td class="tbl-content"></td>
            </tr>
	<% 	} else { %>
	       <tr>
            	<td class="tbl-title">Quantity</td>
                <td class="tbl-content"><%=productQty.getQuantity() %></td>
                
                <td class="tbl-title">Date</td>
                <td class="tbl-content"><%//productQty.getText()==null?"": productQty.getText() %></td>
            </tr>
<% 		} 
 	}
  }%>
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
function addBandInfoTable(){
	  try{
		  var appendHtml=$(".bankInfoClass").get(0).outerHTML;
		   
		  $("#addDate").append(appendHtml);


		  $("input[name=qty]:last").removeAttr("value");
		  $("input[name=date]:last").removeAttr("value");


	  }catch(e){
	  }
}

function subBandInfoTable(){
	  try{
		  var length=$(".bankInfoClass").length;

			if(length>1){
				$(".bankInfoClass:last").remove();
			}else{

				  $("input[name=qty]:last").removeAttr("value");
				  $("input[name=date]:last").removeAttr("value");

			}
		  
	  }catch(e){
	  }
}

	function defultBandInfoTable(){
		for(var i=0;i<=1;i++){
			addBandInfoTable();
		}
	}
	function back() {
		window.location="../product/ProductServlet?actionType=getSearchList&from=menu";
		//window.location = "../product/ProductServlet?actionType=getSearchList&pageIdx=<%=StringUtil.trimToInt(request.getSession().getAttribute(SessionName.pageIdx))%>";
	}



defultBandInfoTable();
</script>
</body>

</html>
