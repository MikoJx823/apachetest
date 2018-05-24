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
	
	String orderRef = request.getParameter("ref")==null?"":StringUtil.blockXss(request.getParameter("ref"));
	
	OrderBean order = OrderService.getInstance().getSuccessOrderByRefNo(orderRef);
	
	if(order == null || order.getOrderItems() == null){
		response.sendRedirect(basePath + "index.jsp");
		return;
	}

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
						<li><a href="<%=basePath %>index.jsp">Home</a></li>
						<li><a href="<%=basePath%>cartsummary">Checkout</a></li>
						<li class="active">Order Received</li>
					</ol>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</div><!-- /.page-head -->

	<div class="page-wrapper">
		<section class="section" id="page-order-received">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<div class="alert alert-success active">Thank you, Your order has been received.</div>
						<ul class="order-details">
						    <li class="order">
						        Order Number: <strong><%=StringUtil.filter(order.getOrderRef()) %></strong>
						    </li>
						    <li class="date">
						        Date: <strong><%=DateUtil.formatDate(order.getTransactiondate()) %></strong>
						    </li>
						    <li class="total">
						        Total: <strong><span class="amount"><%=StringUtil.formatIndexPrice(order.getTotalAmount()) %></span></strong>
						    </li>
						    <li class="method">
						        Payment Method: <strong>Online Payment</strong>
						    </li>
						</ul><!-- /.order-details -->

						<p>Item will be ship out within 3-5 business days. </p>
						<div class="box table-responsive">
						    <h3 class="title">Order Details</h3>
						    <table class="table cart-table order-details-table">
						        <thead>
						            <tr>
						                <th class="product-name">Product</th>
						                <th class="product-total">Total</th>
						            </tr>
						        </thead>
						        <tbody>
						            <%
						            double total = 0;
						            for(OrderItemBean item : order.getOrderItems()) {
						            	double subtotal = (item.getPrice() - item.getDiscount()) * item.getQuantity();
						            	total += subtotal;
						            %>
						     
						            <tr class="item">        
						                <td class="product-name">
						                    <a href="product.html"><%=StringUtil.filter(item.getProductname()) %></a> <strong class="product-quantity">× <%=item.getQuantity() %></strong>
						                    <%if(!"".equals(StringUtil.filter(item.getVariantname()))) {%>
						                    <table class="variation">
						                        <tbody>
						                            <tr>
						                                <th class="variation-size">Variant:</th>
						                                <td class="variation-size">
						                                    <p><%=StringUtil.filter(item.getVariantname()) %></p>
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
						            <tr>
						                <th scope="row">Subtotal:</th>
						                <td><span class="amount"><%=StringUtil.formatIndexPrice(order.getOrderAmount()) %></span></td>
						            </tr>
						            <tr>
						                <th scope="row">Shipping:</th>
						                <td><%=order.getDeliveryAmount() > 0 ? StringUtil.formatIndexPrice(order.getDeliveryAmount()) :"Free Shipping" %></td>
						            </tr>
						            <tr>
						                <th scope="row">Payment Method:</th>
						                <td>Online Payment</td>
						            </tr>
						            <tr>
						                <th scope="row">Total:</th>
						                <td><span class="amount"><%=StringUtil.formatIndexPrice(order.getTotalAmount()) %></span></td>
						            </tr>
						        </tfoot>
						    </table>
						</div><!-- /.box -->
						<div class="text-right">
							<a href="<%=basePath %>index.jsp" class="btn btn-default">Go Back</a>
						</div>
					</div>
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- #page-order-received -->
	</div><!-- /.page-wrapper -->

	<jsp:include page="footer.jsp" />

</body>
</html>