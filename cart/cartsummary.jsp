<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	Date now = new Date();
	
	HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap) == null ? 
				new HashMap<String, OrderItemBean>() : (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap);
	
	OrderBean orderBean = (OrderBean) request.getSession().getAttribute("orderBean");
	List<OrderItemBean> orderItems = new ArrayList<OrderItemBean>();
	if (orderBean == null)
		orderBean = new OrderBean();
	
	String errorMsg = StringUtil.filter((String)request.getAttribute("errorMsg"));
	
%>

<!DOCTYPE html>
<!--[if lt IE 7 ]> <html class="ie ie6 ie-lt10 ie-lt9 ie-lt8 ie-lt7 no-js" lang="en-US"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 ie-lt10 ie-lt9 ie-lt8 no-js" lang="en-US"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 ie-lt10 ie-lt9 no-js" lang="en-US"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 ie-lt10 no-js" lang="en-US"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en-US"><!--<![endif]-->
<!-- the "no-js" class is for Modernizr. -->
<head>
	<jsp:include page="meta.jsp" />
</head>
<body>

	<jsp:include page="header.jsp" />

	<div class="page-head content-top-margin">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-sm-7">
					<ol class="breadcrumb">
						<li><a href="<%=basePath%>index.jsp">Home</a></li>
						<li class="active">Shopping Cart</li>
					</ol>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</div><!-- /.page-head -->

	<div class="page-wrapper">
		<section class="section" id="page-cart">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
					<%if(!"".equals(errorMsg)){ %>
					<div class="alert alert-success active"><%=StringUtil.filter(errorMsg) %></div>
					<%} %>
					
					<%if (cartMap!=null && !cartMap.isEmpty()){ %>
						<div class="table-responsive">
						    <table class="table cart-table" cellspacing="0">
						        <thead>
						            <tr>
						                <th class="product-remove">&nbsp;</th>
						                <th class="product-thumbnail">&nbsp;</th>
						                <th class="product-name">Product</th>
						                <th class="product-price">Price</th>
						                <th class="product-quantity">Quantity</th>
						                <th class="product-subtotal">Total</th>
						            </tr>
						        </thead>
						        <tbody>
						            
								<% 
								
								  double totalOrder = 0;
								  double shipping = 0 ;
								  
								  
								  
									  for(Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
								 		   String key = entry.getKey();
								 		   OrderItemBean orderItem = entry.getValue(); 
								 		   //orderItem.setOrderId(0);
								 		   //orderItems.add(orderItem);
								 		   	
										   String link = basePath + "productdetails?id=" + orderItem.getPid();
										   double unitPrice = orderItem.getPrice() - orderItem.getDiscount();
										   double subTotal = unitPrice * orderItem.getQuantity();
										   totalOrder += subTotal;
				
								%>
						            <tr class="item">
						                <td scope="row" class="product-remove">
						                    <a href="javascript:removeSubmit('<%=key %>',<%=orderItem.getId() %>)" class="remove" title="Remove this item"><i class="lil-close"></i></a>
						                </td>
						                <td class="product-thumbnail">
						                    <a href="<%=link%>">
						                        <img src="<%=basePath %>images/product/<%=StringUtil.filter(orderItem.getProductimage()) %>" class="img-responsive" alt="">
						                    </a>
						                </td>
						                <td class="product-name">
						                    <a href="<%=link%>"><%=StringUtil.filter(orderItem.getProductname()) %></a>
						                    <%if(orderItem.getProduct().getProductVariant().size() > 1) { %>
						                    <table class="variation">
						                        <tbody>
						                            <tr>
						                                <th class="variation-size">Variant:</th>
						                                <td class="variation-size">
						                                    <p><%=orderItem.getVariantname() %></p>
						                                </td>
						                            </tr>
						                        </tbody>
						                    </table>
						                    <%} %>
						                </td>
						                <td class="product-price">
						                    <span class="amount"><%=StringUtil.formatCurrencyPrice(unitPrice) %></span>
						                </td>
						                <td class="product-quantity">
						                    <div class="quantity">
						                        <input type="button" value="+" class="plus" onClick="javascript:changeQty('<%=key %>',<%=orderItem.getQuantity()%>)">
						                        <input type="number" step="1" max="5" min="1" name="qty<%=key %>" id="qty<%=key %>" value="<%=orderItem.getQuantity() %>" title="Qty" class="qty" size="4">
						                        <input type="button" value="-" class="minus" onClick="javascript:changeQty('<%=key %>',<%=orderItem.getQuantity()%>)">
						                    </div>
						                </td>
						                <td class="product-subtotal">
						                    <span class="amount"><%=StringUtil.formatCurrencyPrice(subTotal) %></span>
						                </td>
						            </tr>
								<%	
										}
									  
									  	//CALCULATE SHIPPING 
									    shipping = ProductService.getInstance().calShippping(totalOrder, "MY");
								  	
								%>
									
						            <tr>
						                <td colspan="6" class="actions">
						                    <div class="coupon col-md-5 col-sm-5 no-padding-left">
						                    	<div class="row">
							                        <!-- <div class="col-xs-6">
							                        	<input type="text" class="form-control" placeholder="Coupon Code">
							                        </div>
							                        <div class="col-xs-6">
								                        <input type="submit" class="btn btn-default" value="Apply Coupon">
							                        </div> -->
						                        </div>
						                    </div> 

						                    <div class="cart-collaterals col-md-5 col-sm-7 col-md-offset-2 no-padding-right">
						                        <div class="cart-totals">
						                            <h2>Cart Totals</h2>
						                            <table class="table table-condensed" cellspacing="0">
						                                <tbody>
						                                    <tr class="cart-subtotal">
						                                        <th>Subtotal</th>
						                                        <td class="text-right">
							                                        <span class="amount"><%=StringUtil.formatCurrencyPrice(totalOrder) %></span>
						                                        </td>
						                                    </tr>
						                                    <tr class="shipping">
						                                        <th>Shipping</th>
						                                        <td class="text-right">
						                                            <span class="amount"><%=StringUtil.formatCurrencyPrice(shipping) %></span>
						                                        </td>
						                                    </tr>
						                                    <tr class="order-total">
						                                        <th>Total</th>
						                                        <td class="text-right">
							                                        <strong><span class="amount"><%=StringUtil.formatCurrencyPrice(totalOrder + shipping)%></span></strong>
						                                        </td>
						                                    </tr>
						                                </tbody>
						                            </table>
						                            <div class="form-group clearfix">
						                                <!--  <div class="pull-left">
						                                    <input type="submit" class="btn btn-primary" value="Update Cart">
						                                </div> -->
						                                <div class="pull-right text-right">
						                                	<%     
						                                	if (cartMap!=null && !cartMap.isEmpty()){
						                                	%>
						                                    <a href="<%=basePath %>checkout" class="btn btn-default">Proceed to Checkout</a>
						                                	<%
						                                	} 
						                                	%>
						                                </div>
						                            </div>

						                            <div class="text-right">
						                                <a href="#!" class="shipping-calculator-button effect" data-slide-toggle=".shipping-calculator-form">Calculate Shipping</a>
						                            </div>

						                            <div class="shipping-calculator-form inputs-border inputs-bg" style="display: none;">
						                                <div class="form-group">
						                                    <select class="form-control">
						                        				<option>Select a Country..</option>
						                        				<option value="SY">Syria</option>
						                        				<option value="UK">United Kingdom</option>
						                        				<option value="US">United States</option>
						                        				<option value="TR">Turkey</option>
						                                    </select>
						                                </div>
						                                <div class="form-group">
						            						<select class="form-control">
						                                        <option>Select an City..</option>
						                                        <option value="SY">Syria</option>
						                        				<option value="UK">United Kingdom</option>
						                        				<option value="US">United States</option>
						                        				<option value="TR">Turkey</option>
						                                    </select>
						    					        </div>
						                                <div class="form-group">
						                                    <input type="text" class="form-control" placeholder="Postcode / Zip">
						                                </div>
						                                <!-- <div class="form-group text-right">
						                                    <button type="submit" class="btn btn-default">Update Totals</button>
						                                </div> -->
						                            </div>
						                        </div>
						                    </div>
						                </td>
						            </tr>
						        </tbody>
						    </table>
						</div><!-- /.table-responsive -->
					</div>
					<%}else{ %>
						
						<div class="text-center" style="min-height:300px;">
							<p>No items found. </p>
							<button class="btn btn-default" onClick="window.location='index.jsp'">Continue Shoppings</button>
						</div>
						
					<%} %>
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- #page-cart -->
	</div><!-- /.page-wrapper -->

	<jsp:include page="footer.jsp" />

<script type="text/javascript">
$( document ).ready(function() {
	
	/*if(<%=cartMap.isEmpty()%>){
		alert('Cart is empty');
	}*/
	
});


function changeQty(cartId, oldqty) {
	var reg = new RegExp("^[0-9]*$");  
    var obj = document.getElementById("qty"+cartId); 
    
    if(!reg.test(obj.value)){ 
    	alert("Incorrect Quantity");
    	$("#qty" + cartId).val(oldqty);
	}else{
		if(obj.value<1){
			alert("Quantity must be greater than 0");
			$("#qty" + cartId).val(oldqty);
		}else{

			$.ajax({
				dataType: 'json',
	            url: '<%=basePath%>cartitemqty?actionType=changeQty&cartId='+cartId+'&qty'+cartId+'='+obj.value,
	            type: 'POST',
	            async:false,
	            success: function(jsonObj){
	  
	            	if(jsonObj.successCode == "<%=StaticValueUtil.STATUS_YES%>"){
						location.reload();
	            	}else{
	            		var msg = jsonObj.errorMsg;
	            		alert(msg);
	            	}
	           }
			});
		}
	}
}

function removeSubmit(cartId,id){
	$.ajax({
		dataType: 'json',
		url: '<%=basePath%>cartitemqty?actionType=removeCart&cartId='+cartId+'&id='+id,
        type: 'POST',
        async:false,
        success: function(jsonObj){
        	if(jsonObj.successCode == "<%=StaticValueUtil.STATUS_YES%>"){
        		location.reload();
        	}else{
        		var msg = jsonObj.errorMsg;
        		
        		alert(msg);
        	}
       }
	});
}


function checkoutDetailsSubmit(){	

		
	MM_findObj("checkoutDetailsForm").submit();	
	
}

</script>

</body>
</html>