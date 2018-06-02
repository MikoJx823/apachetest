<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	String basePath = StringUtil.getHostAddress();
	Date now = new Date();
	
	HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap) == null ? 
			new HashMap<String, OrderItemBean>() : (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap);
	
	OrderBean orderBean = (OrderBean) request.getSession().getAttribute("order");
	if(orderBean == null){
		orderBean = new OrderBean();
	}
	
	String errorMsg = StringUtil.filter((String)request.getAttribute("errorMsg"));
	double total = 0 ;
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
						<li><a href="<%=basePath%>/index.jsp">Home</a></li>
						<li class="active">Checkout</li>
					</ol>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</div><!-- /.page-head -->

	<div class="page-wrapper">
		<section class="section" id="page-checkout">
			<div class="container">
				<div class="row">
					<!--  <div class="col-sm-6">
						<div class="alert alert-info">
							<strong>Returning customer?</strong> <a href="#!" class="effect" data-slide-toggle=".checkout-login-form">Click here to login</a>
						</div>
					</div>

					<div class="col-sm-6">
						<div class="alert alert-info">
							<strong>Have a coupon?</strong> <a href="#!" class="effect" data-slide-toggle=".checkout-coupon-form">Click here to enter your code</a>
						</div>
					</div>

					<div class="col-sm-6">
						<div class="checkout-login-form box" style="display: none;">
							<h2>Login</h2>
							<p>
								If you have shopped with us before, please enter your details in the boxes below. If you are a new customer please proceed to the Billing &amp; Shipping section.
							</p>
							<form action="#!" method="POST" class="login-form inputs-border inputs-bg">
								<div class="form-group">
									<label for="username">Username or email*</label>
									<input type="text" id="username" class="form-control" placeholder="Username or email*">
								</div>
								<div class="form-group">
									<label for="password">Password*</label>
									<input type="password" id="password" class="form-control" placeholder="Password*">
								</div>
								<div class="form-group">
									<input type="checkbox" id="rememberme">
									<label for="rememberme" class="checkbox">Remember me</label>
									<a href="#!" class="effect pull-right">Forgot your password?</a>
								</div>
								<div class="form-group text-right">
									<button type="button" class="btn btn-default">Login</button>
								</div>
							</form>
						</div><!-- /.checkout-login-form 
					</div>

					<div class="col-sm-6">
						<div class="checkout-coupon-form box" style="display: none;">
							<form action="#!" method="POST" class="coupon-form inputs-border inputs-bg">
								<div class="form-group">
									<label for="coupon_code">Coupon code</label>
									<input type="text" id="coupon_code" class="form-control" placeholder="Coupon code">
								</div>
								<div class="form-group text-right">
									<button type="button" class="btn btn-default">Apply Coupon</button>
								</div>
							</form>
						</div><!-- /.checkout-login-form 
					</div> -->

					<div class="clearfix"></div>

					<form action="<%=basePath%>payment" method="POST" class="checkout-form inputs-border inputs-bg" id="checkoutform">
						<div class="col-md-6">
							<%if(!"".equals(errorMsg)){ %>
							<div class="alert alert-success active"><%=errorMsg %></div>
							<%} %>
							<div class="billing-field">
								<h3 class="title">Billing Details</h3>

								<div class="row">
									<div class="form-group col-sm-6">
										<div class="required">
											<input type="text" class="form-control" placeholder="First Name" name="firstname" id="firstname" value="<%=orderBean.getBuyerfirstname() %>" required>
										</div>
									</div>
									<div class="form-group col-sm-6">
										<div class="required">
											<input type="text" class="form-control" placeholder="Last Name" name="lastname" id="lastname" value="<%=orderBean.getBuyerlastname()%>" required>
										</div>
									</div>
								</div>

								<div class="form-group">
									<input type="text" class="form-control" placeholder="Company Name" name="companyname" id="companyname" value="<%=orderBean.getBuyercompanyname() %>">
								</div>

								<div class="row">
									<div class="form-group col-sm-6">
										<div class="required">
											<input type="email" class="form-control" placeholder="Email Address" name="email" id="email" value="<%=orderBean.getBuyeremail() %>" required>
										</div>
									</div>
									<div class="form-group col-sm-6">
										<div class="required">
											<input type="tel" class="form-control" placeholder="Phone" name="contact" id="contact" value="<%=orderBean.getBuyerphone() %>" required>
										</div>
									</div>
								</div>

								<div class="form-group">
									<div class="required">
										<select class="form-control" name="country" id="country" onchange="onBuyerCountryChange()">
	                        				<%=CountryPulldown.frontSelect(orderBean.getBuyercountry()) %>
	                                    </select>
                                    </div>
								</div>

								<div class="row">
									<div class="form-group col-sm-6">
										<div class="required">
											<input type="text" class="form-control" placeholder="Address" name="address" id="address" value="<%=orderBean.getBuyeraddress1() %>" required>
										</div>
									</div>
									<div class="form-group col-sm-6">
										<input type="text" class="form-control" placeholder="Address 2" name="address2" id="address2" value="<%=orderBean.getBuyeraddress2()%>">
									</div>
								</div>

								<div class="form-group">
									<div class="required">
										<input type="text" class="form-control" placeholder="Postcode / ZIP" name="postcode" id="postcode" value="<%=orderBean.getBuyerpostcode() %>" required>
									</div>
								</div>

								<div class="row">
									<div class="form-group col-sm-6">
										<div>
											<input type="text" class="form-control" placeholder="Town / City" name="town" id="town" value="<%=orderBean.getBuyertown() %>">
										</div>
									</div>
									<div class="form-group col-sm-6" id="state-container">
										<div class="required">
											<select class="form-control" name="state" id="state">
		                        				<%=MYStatePulldown.frontSelect(orderBean.getBuyerstate()) %>
		                                    </select>
	                                    </div>
                                    </div>
								</div>

								<!--  <div class="form-group">
									<input type="checkbox" id="create_account">
									<label for="create_account" class="checkbox" data-slide-toggle=".create-account">Create an account?</label>
									<div class="create-account box" style="display: none;">
										<p>
											Create an account by entering the information below. If you are a returning customer please login at the top of the page.
										</p>
										<div class="form-group">
											<input type="password" class="form-control" placeholder="Account Password">
										</div>
									</div>
								</div>-->

								<div class="form-group">
									<h3>
										<input type="checkbox" id="ship-different-address" name="shipdifferent" id="shipdifferent" value="<%=StaticValueUtil.STATUS_YES %>" onclick="onShipDiffClick()">
										<label for="ship-different-address" class="checkbox" data-slide-toggle=".different-address">Ship to a different address?</label>
									</h3>
									<div class="different-address box" style="display: none;">
										<div class="row">
											<div class="form-group col-sm-6">
												<div class="required">
													<input type="text" class="form-control" placeholder="First Name" name="shipfirstname" id="shipfirstname" value="<%=StringUtil.filter(orderBean.getShipfirstname()) %>" required>
												</div>
											</div>
											<div class="form-group col-sm-6">
												<div class="required">
													<input type="text" class="form-control" placeholder="Last Name" name="shiplastname" id="shiplastname" value="<%=StringUtil.filter(orderBean.getShiplastname()) %>" required>
												</div>
											</div>
										</div>

										<div class="form-group">
											<input type="text" class="form-control" placeholder="Company Name" name="shipcomanyname" id="shipcomanyname" value="<%=StringUtil.filter(orderBean.getShipcompanyname()) %>">
										</div>

										<div class="form-group">
											<div class="required">
												<select class="form-control" name="shipcountry" id="shipcountry" onchange="onShipCountryChange()">
			                        				<%=CountryPulldown.frontSelect(orderBean.getShipcountry()) %>
			                                    </select>
		                                    </div>
										</div>

										<div class="row">
											<div class="form-group col-sm-6">
												<div class="required">
													<input type="text" class="form-control" placeholder="Address" name="shipaddress" id="shipaddress" value="<%=StringUtil.filter(orderBean.getShipaddress1()) %>" required>
												</div>
											</div>
											<div class="form-group col-sm-6">
												<input type="text" class="form-control" placeholder="Address 2" name="shipaddress2" id="shipaddress2" value="<%=StringUtil.filter(orderBean.getShipaddress2()) %>">
											</div>
										</div>

										<div class="form-group">
											<div class="required">
												<input type="text" class="form-control" placeholder="Postcode / ZIP" name="shippostcode" id="shippostcode" value="<%=StringUtil.filter(orderBean.getShippostcode()) %>" required>
											</div>
										</div>

										<div class="row">
											<div class="form-group col-sm-6">
												<div class="required">
													<input type="text" class="form-control" placeholder="Town / City" name="shiptown" id="shiptown" value="<%=StringUtil.filter(orderBean.getShiptown()) %>" required>
												</div>
											</div>
											<div class="form-group col-sm-6" id="shipstate-container">
												<div class="required">
													<select class="form-control" name="shipstate" id="shipstate" value="<%=StringUtil.filter(orderBean.getShipstate()) %>">
				                        				<%=MYStatePulldown.frontSelect(orderBean.getShipstate()) %>
				                                    </select>
			                                    </div>
		                                    </div>
										</div>
									</div><!-- /.create-account -->
								</div>

								<div class="form-group">
									<label>Order Notes</label>
									<textarea class="form-control" placeholder="Notes about your order, e.g. special notes for delivery." rows="5" name="remark" id="remark"><%=StringUtil.filter(orderBean.getBuyerremark()) %></textarea>
								</div>
							</div><!-- /.billing-field -->
						</div>

						<div class="col-md-6">
							<div class="review-order">
								<div class="box">
									<h3 class="title">Your order</h3>
									<div class="table-responsive">
										<%if (cartMap!=null && !cartMap.isEmpty()){ %>
										<table class="table cart-table review-order-table">
										    <thead>
										        <tr>
										            <th class="product-name" width="50%">Product</th>
										            <th class="product-total">Total</th>
										        </tr>
										    </thead>
										    <tbody>
										    <% 
										    	
										    	for(Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
											 		String key = entry.getKey();
											 		OrderItemBean orderItem = entry.getValue();  
													double subtotal = (orderItem.getPrice() - orderItem.getDiscount()) * orderItem.getQuantity();
													total += subtotal;
											%>
										        <tr class="item">
										            <td class="product-name">
										                <%=StringUtil.filter(orderItem.getProductname()) %> <strong class="product-quantity">× <%=orderItem.getQuantity() %></strong>
										                <%if(!"".equals(StringUtil.filter(orderItem.getVariantname()))) { %>
										                <table class="variation">
										                    <tbody>
										                        <tr>
										                            <th class="variation-size">Variant:</th>
										                            <td class="variation-size">
										                                <p><%=StringUtil.filter(orderItem.getVariantname()) %></p>
										                            </td>
										                        </tr>
										                    </tbody>
										                </table>
										                <%} %>
										            </td>
										            <td class="product-total">
										                <span class="amount"><%=StringUtil.formatIndexPrice(subtotal) %></span>
										            </td>
										        </tr>
										    <%} %>
										    </tbody>
										    <tfoot>
										        <tr class="cart-subtotal">
										            <th>Subtotal</th>
										            <td><span class="amount"><%=StringUtil.formatIndexPrice(total) %></span></td>
										        </tr>
										        <tr class="shipping">
										            <th>Shipping</th>
										            <td id="shipping-container">
										                <p>Free Shipping</p>
										            </td>
										        </tr>
										        <tr class="order-total">
										            <th>Total</th>
										            <td id="total-container">
											            <strong><span class="amount"><%=StringUtil.formatIndexPrice(total) %></span></strong>
										            </td>
										        </tr>
										    </tfoot>
										</table><!-- /.review-order-table -->
										<%} %>
									</div>

									<h2>Payment Method</h2>
									<div id="payment" class="checkout-payment">
									    <ul class="payment-methods">
									        <!--  <li class="payment-method">
									            <input id="payment_method_cheque" type="radio" name="payment_method" checked="checked">
									            <label for="payment_method_cheque" class="radio" data-slide-toggle="#payment-cheque" data-parent=".payment-methods">Cheque Payment</label>

									            <div class="payment-box" id="payment-cheque">
									                <p>Please send your cheque to Store Name, Store Street, Store Town, Store State / County, Store Postcode.</p>
									            </div>
									        </li>
									        <li class="payment-method">
									            <input id="payment_method_cod" type="radio" name="payment_method">
									            <label for="payment_method_cod" class="radio" data-slide-toggle="#payment-cash" data-parent=".payment-methods">Cash on Delivery</label>

									            <div class="payment-box" id="payment-cash" style="display:none;">
									                <p>Pay with cash upon delivery.</p>
									            </div>
									        </li> -->
									        <li class="payment-method">
									            <input id="payment_method_paypal" type="radio" name="payment_method" >
									            <label for="payment_method_paypal" class="radio" data-slide-toggle="#payment-paypal" data-parent=".payment-methods">Credit /Debit Card</label>

									            <div class="payment-box" id="payment-paypal" style="display:none;">
									                <img src="https://www.paypalobjects.com/webstatic/mktg/Logo/AM_mc_vs_ms_ae_UK.png" class="img-responsive">
									                <!--<p><a href="#!" class="effect">What is PayPal?</a></p>
									                <p>Pay via PayPal; you can pay with your credit card if you don’t have a PayPal account.</p>-->
									            </div>
									        </li>
									    </ul>
								    	<div class="text-right">
								    		<button type="submit" class="btn btn-default" onClick="javascript:submitOrder()">Place order</button>
								    	</div>
									</div>
								</div><!-- /.box -->
							</div><!-- /.review-order -->
						</div>
					</form><!-- /.checkout-form -->
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- #page-checkout -->
	</div><!-- /.page-wrapper -->

	<jsp:include page="footer.jsp" />
	
	<script type="text/javascript">
		/*function onShipDiffClick(){
			
			var isDiffShip = $('[name=shipdifferent]:checked').val();
			
		}*/
	
		function onBuyerCountryChange(){
			var htmlState = "";
			var htmlShip = "<p>Free Shipping</p>";
			var htmlTotal = "<strong><span class=\"amount\"><%=StringUtil.formatIndexPrice(total) %></span></strong>";
			
			var isDiffShip = $('[name=shipdifferent]:checked').val();
			
			if($('select[name=country]').val() != 'MY'){
				htmlState = "<div class=\"required\">" +
					   		"<input type=\"text\" class=\"form-control\" placeholder=\"State\" name=\"state\" id=\"state\" value=\"<%=orderBean.getBuyerstate() %>\" >" +
					   		"</div>"
				
				if(isDiffShip != '<%=StaticValueUtil.STATUS_YES%>'){
					var shipping = <%=ProductService.getInstance().calShippping(total, "")%>;
					if(shipping > 0){
						var total = <%=StringUtil.formatIndexPrice(total) %>
						
						htmlShip = "<p>" +  shipping + "</p>";
						htmlTotal = "<strong><span class=\"amount\">" + (total + shipping) + "</span></strong>";
					} 
				}
				
			}else{
				htmlState = "<div class=\"required\">" +
					   		"<select class=\"form-control\" name=\"state\" id=\"state\">" +
							"<%=MYStatePulldown.frontSelect("") %>" + 
            		   		"</select>" +
        			   		"</div>"
        			   		
            	if(isDiffShip != '<%=StaticValueUtil.STATUS_YES%>'){
            		var shipping = <%=ProductService.getInstance().calShippping(total, "MY")%>;
            		if(shipping > 0){
            			var total = <%=StringUtil.formatIndexPrice(total) %>
            			
            			htmlShip = "<p>" +  shipping + "</p>";
            			htmlTotal = "<strong><span class=\"amount\">" + (total + shipping) + "</span></strong>";
            		} 
            	}
			}
			
			$("#shipping-container").html(htmlShip); 
			$("#total-container").html(htmlTotal);
			$("#state-container").html(htmlState); 
		}
		
		function onShipCountryChange(){
			var htmlState = "";
			var htmlShip = "<p>Free Shipping</p>";
			var htmlTotal = "<strong><span class=\"amount\"><%=StringUtil.formatIndexPrice(total) %></span></strong>";
			
			var isDiffShip = $('[name=shipdifferent]:checked').val();
			
			if($('select[name=shipcountry]').val() != 'MY'){
				htmlState = "<div class=\"required\">" +
					   		"<input type=\"text\" class=\"form-control\" placeholder=\"State\" name=\"shipstate\" id=\"shipstate\" value=\"<%=orderBean.getShipstate() %>\" >" +
					   		"</div>"
				
				if(isDiffShip == '<%=StaticValueUtil.STATUS_YES%>'){
					var shipping = <%=ProductService.getInstance().calShippping(total, "")%>;
					if(shipping > 0){
						var total = <%=StringUtil.formatIndexPrice(total) %>
									
						htmlShip = "<p>" +  shipping + "</p>";
						htmlTotal = "<strong><span class=\"amount\">" + (total + shipping) + "</span></strong>";
					} 
				}	   			   	
			}else{
				htmlState = "<div class=\"required\">" +
					   		"<select class=\"form-control\" name=\"shipstate\" id=\"shipstate\">" +
							"<%=MYStatePulldown.frontSelect("") %>" + 
            		   		"</select>" +
        			   		"</div>"
        			   		
            	if(isDiffShip == '<%=StaticValueUtil.STATUS_YES%>'){
                    var shipping = <%=ProductService.getInstance().calShippping(total, "MY")%>;
                    if(shipping > 0){
                    	var total = <%=StringUtil.formatIndexPrice(total) %>
                       			
                    	htmlShip = "<p>" +  shipping + "</p>";
                    	htmlTotal = "<strong><span class=\"amount\">" + (total + shipping) + "</span></strong>";
               		} 
                }
			}
			
			$("#shipping-container").html(htmlShip); 
			$("#total-container").html(htmlTotal);
			$("#shipstate-container").html(htmlState); 
		}
		
		function submitOrder(){
			
			var errorMsg = '';
			
			if($("[name='firstname']").val().trim() == '') {
				errorMsg += "First name is required. <br>";
			}
			
			if($("[name='lastname']").val().trim() == '') {
				errorMsg += "Last name is required. <br>";
			}
			
			var email = $("[name='email']").val().trim();
			if(email == '') {
				errorMsg += "Email is required. <br>";
			}else{
				var mailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
				if(!email.match(mailformat))  {
					errorMsg += "Invalid email format. <br>";
				}
			}
			
			if($("[name='contact']").val().trim() == '') {
				errorMsg += "Contact is required. <br>";
			}
			
			if($("[name='address']").val().trim() == '') {
				errorMsg += "Address line 1 is required. <br>";
			}
			
			if($("[name='postcode']").val().trim() == '') {
				errorMsg += "Postcode is required. <br>";
			}
			
			if($("[name='town']").val().trim() == '') {
				errorMsg += "Town is required. <br>";
			}
			
			if($("[name='state']").val().trim() == '') {
				errorMsg += "State is required. <br>";
			}
			
			if($("[name='country']").val().trim() == '') {
				errorMsg += "Country is required. <br>";
			}
			
			if($("[name='shipdifferent']:checked").val() == '<%=StaticValueUtil.STATUS_YES%>') {
				/*if($("[name='shipfirstname']").val().trim() == '') {
					errorMsg += "Shipping first name is required. <br>";
				}
				
				if($("[name='shiplastname']").val().trim() == '') {
					errorMsg += "Shipping last name is required. <br>";
				}
				
				if($("[name='shipaddress']").val().trim() == '') {
					errorMsg += "Shipping address line 1 is required. <br>";
				}
				
				if($("[name='shippostcode']").val().trim() == '') {
					errorMsg += "Shipping postcode is required. <br>";
				}
				
				if($("[name='shiptown']").val().trim() == '') {
					errorMsg += "Shipping town is required. <br>";
				}
				
				if($("[name='shipstate']").val().trim() == '') {
					errorMsg += "Shipping state is required. <br>";
				}
				
				if($("[name='shipcountry']").val().trim() == '') {
					errorMsg += "Shipping country is required. <br>";
				}*/
			}
			
			if(errorMsg != ''){
				
				
			}
			
			
			//alert("hi");
			$("#checkoutform").submit();
		}
		
		onBuyerCountryChange();
		
	</script>
	
</body>
</html>