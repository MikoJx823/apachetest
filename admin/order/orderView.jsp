<%@page import="com.project.pulldown.OrderStatusPulldown"%>
<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	Date nowDate = new Date();

    String id = request.getParameter("id");
    
    OrderBean orderBean = OrderService.getInstance().getOrderListBySqlwhere("where oId="+id).get(0);
    
    String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
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
                <td class="tbl-content"><%=StringUtils.trimToEmpty(orderBean.getOrderRef())%></td>       
            	<td class="tbl-title">Transaction Date</td>
                <td class="tbl-content"><%=DateUtil.dateFormatterSql_ss.format(orderBean.getTransactiondate()) %></td>
             </tr>
             
          	<tr>
               	<td class="tbl-title">Order Status</td>
                <td class="tbl-content"> <%= OrderStatusPulldown.getName(orderBean.getOrderStatus()) %></td>     
            	<td class="tbl-title"></td>
                <td class="tbl-content"></td>
             </tr>
				
			<tr>
				<td class="tbl-title">Total Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getTotalAmount()) %></td>

                <td class="tbl-title">Eco-points </td>
                <td class="tbl-content"><%=StringUtil.formatEcoPoints(orderBean.getEcoPoint()) %></td>
             </tr>
             
               <tr>
                <td class="tbl-title">Order Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getOrderAmount()) %></td>
                <td class="tbl-title">Delivery Fee</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getDeliveryAmount()) %></td>
             </tr> 
             
              <tr>
                <td class="tbl-title">Offline Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getOfflineAmount()) %></td>
                <td class="tbl-title">Installation Fee </td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getInstallAmount()) %></td>
             </tr> 
             
              <tr>
             	<td class="tbl-title">Discount Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getDiscountAmount()) %></td>
                <td class="tbl-title">Promotion Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getPromotionAmount()) %></td>
             </tr> 
             
            <tr>
                <td class="tbl-title">(Payment Gateway)<br>Payment Method</td>
                <td class="tbl-content"><%=orderBean.getPayMethod()==null?"": orderBean.getPayMethod()%></td> 
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content">&nbsp;</td> 	
            </tr>

            <tr>
            	
                <td class="tbl-title">Remark</td>
                <td class="tbl-content"><%=orderBean.getRemark()==null?"": orderBean.getRemark()%></td>
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content">&nbsp;</td> 	
            </tr>
              </tbody>
            
            </table>  
            
            <h5 class="text-primary">Buyer Information</h5>
            <table class="table table-hover table-condensed">
            <tbody>
            
            <tr>
            	<td class="tbl-title">Buyer Title</td>
                <td class="tbl-content"><%=orderBean.getBuyerTitle()==null?"": orderBean.getBuyerTitle()%></td>
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content">&nbsp;</td>
            </tr>
            
            <tr>  
                <td class="tbl-title">Buyer Name <small>(Eng)</small></td>
                <td class="tbl-content"><%=orderBean.getBuyerEname()==null?"":orderBean.getBuyerEname() %></td>
                
                <td class="tbl-title">Buyer Name <small>(Chi)</small></td>
                <td class="tbl-content"><%=orderBean.getBuyerCname()==null?"":orderBean.getBuyerCname() %></td>
            </tr>
            
            <tr>
            	<td class="tbl-title">Buyer Email</td>
                <td class="tbl-content"><%=orderBean.getBuyerEmail()==null?"": orderBean.getBuyerEmail()%></td>
                
                <td class="tbl-title">Buyer Phone</td>
                <td class="tbl-content"><%=orderBean.getBuyerPhone()==null?"":orderBean.getBuyerPhone() %></td>
                
            </tr>
                     
            <tr>
                <td class="tbl-title">Buyer Address <small>(Eng)</small></td>
                <td class="tbl-content">
                 
                  <div class="tab-content">
         
                    <li style="list-style-type:none;"><%=orderBean.getBuyerAddress1()==null?"":orderBean.getBuyerAddress1() %></li>
                    <li style="list-style-type:none;"><%=orderBean.getBuyerAddress2()==null?"": orderBean.getBuyerAddress2()%></li>
                    <li style="list-style-type:none;"><%=orderBean.getBuyerAddress3()==null?"":orderBean.getBuyerAddress3() %></li>
                    <li style="list-style-type:none;"><%=orderBean.getBuyerAddress4()==null?"":orderBean.getBuyerAddress4() %></li>       
                  </div>                  
                </td>                 
             	
             	 <td class="tbl-title">Buyer Address <small>(Chi)</small></td>
                <td class="tbl-content">
                 
                  <div class="tab-content">
                    <li style="list-style-type:none;"><%=StringUtil.filter(orderBean.getBuyerCAddress1()) %></li>
                    <li style="list-style-type:none;"><%=StringUtil.filter(orderBean.getBuyerCAddress2()) %></li>
                    <li style="list-style-type:none;"><%=StringUtil.filter(orderBean.getBuyerCAddress3()) %></li>
                    <li style="list-style-type:none;"><%=StringUtil.filter(orderBean.getBuyerCAddress4()) %></li>       
                  </div>                  
                </td>    
            </tr>
            
            </tbody>
            </table>  
 
			<h5 class="text-primary">Product Information</h5>
			<table class="table table-hover table-condensed">
            <tbody>
            
            <tr>
            	<td widht="10%"><strong>SKU Name</strong></td>
            	<td width="31%"><strong>Name</strong> </td>
            	<td width="15%"><strong>Pickup Location</strong></td>
            	<td width="8%"><strong>Type</strong></td>
            	<td width="8%"><strong>Collect Method</strong></td>
            	<td width="10%"><strong>Status</strong></td>
            	<td width="5%"><strong>Qty </strong> </td>
                <td width="13%"><strong>SubTotal </strong></td>
            </tr>
            
            <% 
            	double total = 0;
           	 	boolean isERedeem = false;
           	 	
	        	for(int i =0 ; i < orderBean.getOrderItems().size() ; i++) {
        		OrderItemBean orderItem = orderBean.getOrderItems().get(i);	
            	//for(OrderItemBean orderItem : orderBean.getOrderItems()) {
            		//ProductBean product = ProductService.getInstance().getProductById(orderItem.getPid());
            		double subTotal = (orderItem.getPrice() - orderItem.getDiscount()) * orderItem.getQuantity();
            		//total += subTotal;
					
            		String collectMethodStr = "";
            		String pickUpNameStr = "";
            		String subTotalStr = "";
            		String statusStr = "";
            		
            		if(orderItem.getType() == StaticValueUtil.ITEM_ECO) {
            			collectMethodStr = StringUtil.filter(CollectionEcoRewardTypePulldown.getText(orderItem.getCollectMethod()));
            			
            			if(orderItem.getCollectMethod() == StaticValueUtil.ECOREWARD_COUPON){
            				statusStr = CollectionStatusPulldown.getText(orderItem.getPrintstatus());
            			}else {
            				isERedeem = true;
            			}
            			
            		}else {
            			
            			if(orderItem.getEcopoint() > 0 ){
            				subTotal = orderItem.getPrice() * orderItem.getQuantity();
            			}
            			
            			collectMethodStr = StringUtil.filter(CollectionProductTypePulldown.getText(orderItem.getCollectMethod()));
            			
						OrderPickupInfoBean pickUp = OrderPickupService.getInstance().getOrderPickupByOrderItemId(orderItem.getId());
            			
            			if(pickUp != null) {
            				pickUpNameStr = pickUp.getBranchename();
            			}
            			
            			statusStr = CollectionStatusPulldown.getText(orderItem.getCollectStatus());
            		}
            		
            		//FOR SUBTOTAL PRICING SETUP
            		subTotalStr = StringUtil.formatPrice(subTotal); 
            		if(subTotal > 0){ 
            			if(orderItem.getEcopoint() > 0){
            				subTotalStr += " + "  + StringUtil.formatEcoPoints(orderItem.getEcopoint() * orderItem.getQuantity());
            			}
            		}else {
            			subTotalStr = StringUtil.formatEcoPoints((orderItem.getEcopoint() - orderItem.getDiscount()) * orderItem.getQuantity());
            		}
            		
            		//FOR STATUS SETUP
            		if(!orderBean.getOrderStatus().equals(OrderStatusPulldown.ACCEPTED)){
            			statusStr = "";
            		}
            		
            %>
	        <tr> 
            	<td><%=StringUtils.trimToEmpty(orderItem.getSkuname())%></td> 
                <td><%=StringUtil.filter(orderItem.getProdEname()) %></td>
                <td><%=StringUtil.filter(pickUpNameStr) %></td>
                <td class="tbl-center"><%=ItemTypePulldown.getText(orderItem.getType()) %></td>
                <td class="tbl-center"><%=StringUtil.filter(collectMethodStr) %></td>
                <td class="tbl-center"><%=statusStr%></td>
                <td class="tbl-center"><%=orderItem.getQuantity() %></td>
                <td class="tbl-center"><%=StringUtil.filter(subTotalStr) %></td>
            </tr>	
           <% } %>
            
            <!--  <tr>  
                <td colspan="7" align="right"><strong>Total Amount</strong> </td>
                <td><%=orderBean.getTotalAmount() %></td>
            </tr> -->
            </tbody>
            </table> 
            
            <%if(isERedeem && orderBean.getOrderStatus().equals(OrderStatusPulldown.ACCEPTED)) { 
				String sqlWhere =" where orderref = " + StringUtil.filter(orderBean.getOrderRef());
				List<EcoRewardCodeBean> redeems = EcoRewardCodeService.getInstance().getEcoRewardCodeListBySqlwhere(sqlWhere);
			
			%>
			<h5 class="text-primary">Redemption Information</h5>
			<table class="table table-hover table-condensed">
            <tbody>
            
            <tr>
            	<td width="10%"><strong>SKU Name</strong></td>
            	<td width="35%"><strong>Name</strong> </td>
            	<td width="10%"><strong>Type</strong></td>
            	<td width="15%"><strong>Redemption Date</strong></td>
            	<td width="10%"><strong>Status</strong></td>
            	<td width="10%"><strong>Qty </strong> </td>
            </tr>
            
            <% 
            
            	for(EcoRewardCodeBean redeem: redeems ){
            		OrderItemBean orderItem = OrderService.getInstance().getOrderItemByEidRef(redeem.getEcorewardid(), redeem.getOrderref());
            		boolean isExpired = EcoRewardCodeService.getInstance().couponExpireStatus(redeem);
   
            		String productName = orderItem.getProdEname();
            		String redeemDateStr = "";
            		String redeemStr = "";
            		
            		if(redeem.getRedeemstatus() == StaticValueUtil.COLLECT_REDEEMED) {
            			redeemDateStr = DateUtil.formatDate(redeem.getRedeemdate());
            		}
            		
            		if(isExpired && redeem.getRedeemstatus() == StaticValueUtil.Pending){
            			redeemStr = "Expired";
            		}else{
            			redeemStr = CollectionStatusPulldown.getText(redeem.getRedeemstatus());
            		}
            %>	
            <tr> 
            	<td><%=StringUtils.trimToEmpty(orderItem.getSkuname())%></td> 
                <td><%=StringUtil.filter(orderItem.getProdEname()) %></td>
                <td class="tbl-center"><%=ItemTypePulldown.getText(orderItem.getType()) %></td>
                 <td class="tbl-center"><%=redeemDateStr %></td>
                <td class="tbl-center"><%=redeemStr %>
                <%//CollectionStatusPulldown.getText(orderItem.getCollectStatus())%></td>
                <td class="tbl-center">1</td>
            </tr>
            <% 	 
			} 	   	
            %>
            </tbody>
			</table>
			<%} %>
            
			
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


