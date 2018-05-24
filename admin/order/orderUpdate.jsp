<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.pulldown.DatePulldown"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	Date nowDate = new Date();

    String id = request.getParameter("id");
    
    OrderBean orderBean = OrderService.getInstance().getOrderListBySqlwhere("where oId="+id).get(0);
    
    AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
    List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
    
    String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
    
    String orderStatusStr = OrderStatusPulldown.getName(orderBean.getOrderStatus());
    
    
    if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Order, AdminFunction.UpdateStatus), AdminFunction.haveRight, adminGroupFunctions)) {
    	if(orderBean.getOrderStatus().equals(OrderStatusPulldown.INSTALL_PENDING)){
        	orderStatusStr = "<select class=\"form-control\" name=\"orderStatus\">" + OrderStatusPulldown.installStatusPulldown(orderBean.getOrderStatus()) + "</select>";
        }else if(orderBean.getOrderStatus().equals(OrderStatusPulldown.ACCEPTED)){
        	orderStatusStr = 
        			"<select class=\"form-control\" name=\"orderStatus\">" +  
        			"<option value=\"" + OrderStatusPulldown.ACCEPTED + "\" >" + OrderStatusPulldown.getName(OrderStatusPulldown.ACCEPTED) + "</option>" + 
        			"<option value=\"" + OrderStatusPulldown.CANCELLED + "\" >" + OrderStatusPulldown.getName(OrderStatusPulldown.CANCELLED) + "</option>" + 
        			"<option value=\"" + OrderStatusPulldown.DELETED + "\" >" + OrderStatusPulldown.getName(OrderStatusPulldown.DELETED) + "</option>" +
        			"</select>";
        }
    }
    
    
%>

<!DOCTYPE html>
<html>
  <jsp:include page="../main/adminHeader.jsp"></jsp:include>
    
 
  </head>
  <body>
 <form action="AdminOrderServlet" name="orderForm" method="post" > 
 <input type="hidden" name="actionType" value="updateOrder">
 <input type="hidden" name="id" value="<%=orderBean.getoId() %>"/>
 <input type="hidden" name="modifiedBy" value="<%=loginUser.getLoginId() %>"/>
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
  
  <div class="panel-heading"><big>Order Information</big> </div>
  
  <div class="panel-body">
     		
            <h5 class="text-primary">Order Profile</h5>
            <table class="table table-hover table-condensed">
            <tbody>
            	
               <tr>
               	<td class="tbl-title">Order Ref.</td>
                <td class="tbl-content"><%=StringUtils.trimToEmpty(orderBean.getOrderRef()) %></td>     
            	<td class="tbl-title">Transaction Date</td>
                <td class="tbl-content"><%=DateUtil.dateFormatterSql_ss.format(orderBean.getTransactiondate()) %></td>
             </tr>
             
             <tr>
               	<td class="tbl-title">Order Status</td>
                <td class="tbl-content"><%=orderStatusStr%><%//OrderStatusPulldown.getName(orderBean.getOrderStatus()) %></td>     
            	<td class="tbl-title"></td>
                <td class="tbl-content"></td>
             </tr>
				
			<tr>
				<td class="tbl-title">Total Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getTotalAmount()) %></td>

                <td class="tbl-title">Eco-points </td>
                <td class="tbl-content"></td>
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
                <td class="tbl-content">
                <textarea class="form-control" id="remark" name="remark" autocomplete="off" rows="4"><%=orderBean.getRemark()==null?"": orderBean.getRemark()%></textarea></td>
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
                <td class="tbl-content"><input class="form-control" name="email" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerEmail())%>"></td>
                
                <td class="tbl-title">Buyer Phone</td>
                <td class="tbl-content">
                <input class="form-control" name="contact" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerPhone())%>"></td>
                
            </tr>     
            <tr>
                <td class="tbl-title">Buyer Address <small>(Eng)</small></td>
                <td class="tbl-content">
           
                  <div class="tab-content">
         
                    <li style="list-style-type:none;">
                     <input class="form-control" name="address1" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerAddress1())%>"></li>
                    <li style="list-style-type:none;">
                     <input class="form-control" name="address2" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerAddress2())%>"></li>
                    <li style="list-style-type:none;">
                     <input class="form-control" name="address3" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerAddress3())%>"></li>
                    <li style="list-style-type:none;">
                     <input class="form-control" name="address4" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerAddress4())%>"></li>       
                  </div>                  
                </td>  
                
                <td class="tbl-title">Buyer Address <small>(Chi)</small></td>
                <td class="tbl-content">
                	<li style="list-style-type:none;">
                     <input class="form-control" name="caddress1" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerCAddress1())%>"></li>
                    <li style="list-style-type:none;">
                     <input class="form-control" name="caddress2" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerCAddress2())%>"></li>
                    <li style="list-style-type:none;">
                     <input class="form-control" name="caddress3" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerCAddress3())%>"></li>
                    <li style="list-style-type:none;">
                     <input class="form-control" name="caddress4" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerCAddress4())%>"></li>   
                </td>
                            
            </tr> 
            </tbody>
            
            </table>  
        
            
            
<!--.panel group plan ended-->
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
				boolean isPostCoupon = false;
				String postCouponId = "";
            	for(int i =0 ; i < orderBean.getOrderItems().size() ; i++) {
            		OrderItemBean orderItem = orderBean.getOrderItems().get(i);	
            		
            		String collectMethodStr = "";
            		String subTotalStr = "";
            		String pickUpNameStr = "";
            		String statusStr = "";
            		//String statusStr = "";
            	
            		//double subTotal = orderItem.getPrice() * orderItem.getQuantity();
     				double subTotal = (orderItem.getPrice() - orderItem.getDiscount()) * orderItem.getQuantity();
            		
            		if(orderItem.getType() == StaticValueUtil.ITEM_ECO) {
            			collectMethodStr = StringUtil.filter(CollectionEcoRewardTypePulldown.getText(orderItem.getCollectMethod()));
            			
            			if(orderItem.getCollectMethod() == StaticValueUtil.ECOREWARD_COUPON){
            				statusStr = "<select class=\"form-control\" id=\"cStatus-" + orderItem.getId() + "\" name=\"cStatus-" + orderItem.getId() + "\">" +
                        			CollectionStatusPulldown.getPulldown(orderItem.getPrintstatus(),orderItem.getCollectMethod()) + 
                        			"</select>";
            				isPostCoupon = true;
            				postCouponId += orderItem.getId() + ",";
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
            			
            			statusStr = "<select class=\"form-control\" name=\"cStatus-" + orderItem.getId() + "\">" +
                    			CollectionStatusPulldown.getPulldown(orderItem.getCollectStatus(),orderItem.getCollectMethod()) + 
                    			"</select>";
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
                <td class="tbl-center"><%=statusStr %>
                <%//CollectionStatusPulldown.getText(orderItem.getCollectStatus())%></td>
                <td class="tbl-center"><%=orderItem.getQuantity() %></td>
                <td class="tbl-center"><%=StringUtil.filter(subTotalStr) %></td>
            </tr>
            <% } %>
            
            <%if(isPostCoupon && orderBean.getOrderStatus().equals(OrderStatusPulldown.ACCEPTED) ){ 
            	if(postCouponId.endsWith(",")) postCouponId = postCouponId.substring(0, postCouponId.length() - 1);
            %>
            	<tr> 
            	<td colspan="5"></td>
                <td><input type="button" value="Update Status" onclick="onPostCouponUpdate('<%=postCouponId %>')" class="btn btn-primary loginbtn hvr-float-shadow"> </td>
                <td></td>
                <td></td>
            </tr>
            <%} %>
            <!--  <tr>  
                <td colspan="7" align="right"><strong>Total Amount</strong> </td>
                <td><%//orderBean.getTotalAmount() %></td>
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
                <td class="tbl-center"><%=redeemStr%>
                <%//CollectionStatusPulldown.getText(orderItem.getCollectStatus())%></td>
                <td class="tbl-center">1</td>
            </tr>
            <% 	 
			} 	
            %>
            </tbody>
			</table>
			<%} %>
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
  <a href="javascript:formSubmit();" class="btn btn-primary loginbtn hvr-float-shadow">Submit</a>
   <a href="javascript:history.go(-1)" class="btn btn-cancel loginbtn hvr-float-shadow">Back</a>
  </div><!--panel-footer-->
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    
    </div>
  
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


function formSubmit()
{		

	document.orderForm.submit();
 
}

function onPostCouponUpdate(ids){
	var arr = [ids];
	
	if(ids.includes(",")){
		arr = ids.split(",");
	}

	for(var i = 0; i < arr.length; i++) {
		
		var status = document.getElementById('cStatus-' + arr[i]);
	    status.value = '<%=StaticValueUtil.COLLECT_DELIVERED%>';
	}
	
}

</script>
  </body>
</html>


