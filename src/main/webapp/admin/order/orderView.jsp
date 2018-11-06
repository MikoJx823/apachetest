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

	Date nowDate = new Date();
	AdminService.getInstance().checkLogin(request, response);
	
    String id = request.getParameter("id");
    
    OrderBean orderBean = OrderService.getInstance().getOrderListBySqlwhere("where oId="+id).get(0);
    
    String basePath = StringUtil.getHostAddress() + "admin/";
    String orderStatusStr = OrderStatusPulldown.getName(orderBean.getOrderStatus());
%>

<!DOCTYPE html>
<html>
  <jsp:include page="../main/adminHeader.jsp"></jsp:include>
  <body>
  
 <jsp:include page="../main/topNav.jsp"></jsp:include>
 
<!-- header menu ended-->

    <section class="container">
    
    <!--main-row-->
    <div class="row">
    
    <!--left Menu area-->
    <jsp:include page="../main/leftMenu.jsp"><jsp:param value="order" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>Order Information</big></div>
  	<jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <div class="panel-body">
     		
     		
     		
            <h5 class="text-primary">Order Profile</h5>
            <table class="table table-hover table-condensed">
            <tbody>
            
              <tr>
               	<td class="tbl-title">Order Ref.</td>
                <td class="tbl-content"><%=StringUtils.trimToEmpty(orderBean.getOrderRef()) %></td>     
            	<td class="tbl-title">Total Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getTotalAmount()) %></td>
             </tr>
             
             <tr>
               	<td class="tbl-title">Transaction Date </td>
                <td class="tbl-content"><%=DateUtil.dateFormatterSql_ss.format(orderBean.getTransactiondate()) %></td>     
            	<td class="tbl-title">Order Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getOrderAmount()) %></td>
             </tr>
				
			<tr>
				<td class="tbl-title">Order Status </td>
                <td class="tbl-content"><%=orderStatusStr%> </td>

                <td class="tbl-title">Delivery Fee</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getDeliveryAmount()) %></td>
            </tr>
             
            <tr>
                <td class="tbl-title">Payment Method</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getPayMethod()) %></td>
                <td class="tbl-title">Discount Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getDiscountAmount()) %></td>
            </tr> 

            <tr>
            	
                <td class="tbl-title">Buyer Remark</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getRemark())%></td>
                <td class="tbl-title">Remark</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getAdminremark())%></td> 	
            </tr>
              </tbody>
            
            </table>  
            
            <h5 class="text-primary">Buyer Information</h5>
            <table class="table table-hover table-condensed">
            <tbody>
            
            <!-- <tr>
            	<td class="tbl-title">Title</td>
                <td class="tbl-content"><%= StringUtil.filter(orderBean.getBuyertitle())%></td>
                
                <td class="tbl-title">Address</td>
                <td class="tbl-content"></td>
            </tr> -->
            
            <tr>  
                <td class="tbl-title">Name </td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyerfirstname()) + " " + StringUtil.filter(orderBean.getBuyerlastname()) %></td>
                
                <td class="tbl-title">Address</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyeraddress1())%></td>
                
            </tr>
            
            <tr>
            	<td class="tbl-title">Company Name</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyercompanyname())%></td>
                
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyeraddress2())%></td>
            </tr> 
            
            <tr>
            	<td class="tbl-title">Email</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyeremail())%></td>
                
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyertown())%></td>
            </tr> 
            
            <tr>
                <td class="tbl-title">Phone</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyerphone())%></td>
                
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyerstate())%></td>           
            </tr> 
            
            <tr>
                <td class="tbl-title"></td>
                <td class="tbl-content"></td>
                
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyercountry())%></td>           
            </tr> 
            
            </tbody>
            </table>  
 			
 			<h5 class="text-primary">Receiver Information</h5>
            <table class="table table-hover table-condensed">
            <tbody>

            <tr>  
                <td class="tbl-title">Name </td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getShipfirstname()) + " " + StringUtil.filter(orderBean.getShiplastname()) %></td>
                
                <td class="tbl-title">Address </td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getShipaddress1())%></td>
            </tr>
               
            <tr>
            	<td class="tbl-title">Company Name</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getShipcompanyname())%></td>

                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getShipaddress2())%></td>           
            </tr> 
            
             <tr>
            	<td class="tbl-title">Tracking Number</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getTracknumber())%></td>

                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getShiptown())%></td>           
            </tr> 
            
             <tr>
            	<td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"></td>

                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getShipstate())%> </td>           
            </tr> 
            
             <tr>
            	<td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"></td>

                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getShipcountry())%></td>           
            </tr> 
            
            </tbody>
            
            </table>  
 			
			<h5 class="text-primary">Product Information</h5>
			<table class="table table-hover table-condensed">
            <tbody>
            
            <tr>
            	<td widht="10%"><strong>Product Code</strong></td>
            	<td width="70%"><strong>Name</strong> </td>
            	<td width="5%"><strong>Qty </strong> </td>
                <td width="15%"><strong>SubTotal </strong></td>
            </tr>
            
           <% 
            	double total = 0;
				boolean isERedeem = false;
				boolean isPostCoupon = false;
				String postCouponId = "";
            	for(int i =0 ; i < orderBean.getOrderItems().size() ; i++) {
            		OrderItemBean orderItem = orderBean.getOrderItems().get(i);	

            		String subTotalStr = "";
            	
            		//double subTotal = orderItem.getPrice() * orderItem.getQuantity();
     				double subTotal = (orderItem.getPrice() - orderItem.getDiscount()) * orderItem.getQuantity();
            		
            		//FOR SUBTOTAL PRICING SETUP
            		subTotalStr = StringUtil.formatPrice(subTotal); 
            %>	
	        <tr> 
            	<td><%=StringUtils.trimToEmpty(orderItem.getProductcode())%></td> 
                <td><%=StringUtil.filter(orderItem.getProductname()) + (!"".equals(StringUtil.filter(orderItem.getVariantname())) ? " - " + orderItem.getVariantname() :"") %></td>
                <td class="tbl-center"><%=orderItem.getQuantity() %></td>
                <td class="tbl-center"><%=StringUtil.filter(subTotalStr) %></td>
            </tr>
           <% } %>

            </tbody>
            </table> 
            
<!--.panel group plan ended-->

			
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">

   <a href="javascript:onBack();" class="btn btn-cancel loginbtn hvr-float-shadow">Back</a>
  </div><!--panel-footer-->
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    </div>
  
    </section><!-- /section.container -->
  
  <script type="text/javascript">
  	function onBack(){
  		if(document.referrer.includes("orderUpdate.jsp")){
			window.location.href = "<%=basePath%>order/AdminOrderServlet?actionType=getSearchList&from=menu";
		}else{
			window.history.back();
		}
  	}
  </script>
  
  </body>
</html>


