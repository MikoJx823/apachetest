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
	<script src="js/jssor.slider.min.js" type="text/javascript"></script>
   
    <script type="text/javascript">
        jssor_1_slider_init = function() {

            var jssor_1_options = {
              $AutoPlay: 1,
              $Idle: 2000,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };

            var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

            /*#region responsive code begin*/

            var MAX_WIDTH = 980;

            function ScaleSlider() {
                var containerElement = jssor_1_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;

                if (containerWidth) {

                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);

                    jssor_1_slider.$ScaleWidth(expectedWidth);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }

            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            /*#endregion responsive code end*/
        };
        
        jssor_2_slider_init = function() {

            var jssor_2_options = {
              $AutoPlay: 1,
              $Idle: 2000,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };

            var jssor_2_slider = new $JssorSlider$("jssor_2", jssor_2_options);

            /*#region responsive code begin*/

            var MAX_WIDTH = 980;

            function ScaleSlider() {
                var containerElement = jssor_2_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;

                if (containerWidth) {

                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);

                    jssor_2_slider.$ScaleWidth(expectedWidth);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }

            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            /*#endregion responsive code end*/
        };
        
        jssor_3_slider_init = function() {

            var jssor_3_options = {
              $AutoPlay: 1,
              $Idle: 2000,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };

            var jssor_3_slider = new $JssorSlider$("jssor_3", jssor_3_options);

            /*#region responsive code begin*/

            var MAX_WIDTH = 980;

            function ScaleSlider() {
                var containerElement = jssor_3_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;

                if (containerWidth) {

                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);

                    jssor_3_slider.$ScaleWidth(expectedWidth);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }

            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            /*#endregion responsive code end*/
        };
        
        jssor_4_slider_init = function() {

            var jssor_4_options = {
              $AutoPlay: 1,
              $Idle: 2000,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };

            var jssor_4_slider = new $JssorSlider$("jssor_4", jssor_4_options);

            /*#region responsive code begin*/

            var MAX_WIDTH = 980;

            function ScaleSlider() {
                var containerElement = jssor_4_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;

                if (containerWidth) {

                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);

                    jssor_4_slider.$ScaleWidth(expectedWidth);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }

            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            /*#endregion responsive code end*/
        };
    </script>
    <style>
        /* jssor slider loading skin spin css */
        .jssorl-009-spin img {
            animation-name: jssorl-009-spin;
            animation-duration: 1.6s;
            animation-iteration-count: infinite;
            animation-timing-function: linear;
        }

        @keyframes jssorl-009-spin {
            from {
                transform: rotate(0deg);
            }

            to {
                transform: rotate(360deg);
            }
        }


        .jssorb052 .i {position:absolute;cursor:pointer;}
        .jssorb052 .i .b {fill:#000;fill-opacity:0.3;}
        .jssorb052 .i:hover .b {fill-opacity:.7;}
        .jssorb052 .iav .b {fill-opacity: 1;}
        .jssorb052 .i.idn {opacity:.3;}

        .jssora053 {display:block;position:absolute;cursor:pointer;}
        .jssora053 .a {fill:none;stroke:#fff;stroke-width:640;stroke-miterlimit:10;}
        .jssora053:hover {opacity:.8;}
        .jssora053.jssora053dn {opacity:.5;}
        .jssora053.jssora053ds {opacity:.3;pointer-events:none;}
    </style>
</head>
<body>

	<jsp:include page="header.jsp" />

	<div class="page-head content-top-margin">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-sm-7">
					<ol class="breadcrumb">
						<li><a href="index.html">Home</a></li>
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
						            <tr class="item">
						                <td scope="row" class="product-remove">
						                    <a href="#!" class="remove" title="Remove this item"><i class="lil-close"></i></a>
						                </td>
						                <td class="product-thumbnail">
						                    <a href="product.html">
						                        <img src="build/img/products/1.jpg" class="img-responsive">
						                    </a>
						                </td>
						                <td class="product-name">
						                    <a href="product.html">Patterned Scarf</a>
						                </td>
						                <td class="product-price">
						                    <span class="amount">$90.00</span>
						                </td>
						                <td class="product-quantity">
						                    <div class="quantity">
						                        <input type="button" value="+" class="plus">
						                        <input type="number" step="1" max="5" min="1" value="1" title="Qty" class="qty" size="4">
						                        <input type="button" value="-" class="minus">
						                    </div>
						                </td>
						                <td class="product-subtotal">
						                    <span class="amount">$90.00</span>
						                </td>
						            </tr>

						            <tr class="item">
						                <td scope="row" class="product-remove">
						                    <a href="#!" class="remove" title="Remove this item"><i class="lil-close"></i></a>
						                </td>
						                <td class="product-thumbnail">
						                    <a href="product.html">
						                        <img src="build/img/products/20.jpg" class="img-responsive" alt="">
						                    </a>
						                </td>
						                <td class="product-name">
						                    <a href="product.html">Men Cap</a>
						                    <table class="variation">
						                        <tbody>
						                            <tr>
						                                <th class="variation-size">Size:</th>
						                                <td class="variation-size">
						                                    <p>Large</p>
						                                </td>
						                            </tr>
						                            <tr>
						                                <th class="variation-color">Color:</th>
						                                <td class="variation-color">
						                                    <p>Dark Grey</p>
						                                </td>
						                            </tr>
						                        </tbody>
						                    </table>
						                </td>
						                <td class="product-price">
						                    <span class="amount">$450.00</span>
						                </td>
						                <td class="product-quantity">
						                    <div class="quantity">
						                        <input type="button" value="+" class="plus">
						                        <input type="number" step="1" max="5" min="1" value="2" title="Qty" class="qty" size="4">
						                        <input type="button" value="-" class="minus">
						                    </div>
						                </td>
						                <td class="product-subtotal">
						                    <span class="amount">$900.00</span>
						                </td>
						            </tr>

						            <tr class="item">
						                <td scope="row" class="product-remove">
						                    <a href="#!" class="remove" title="Remove this item"><i class="lil-close"></i></a>
						                </td>
						                <td class="product-thumbnail">
						                    <a href="product.html">
						                        <img src="build/img/products/12.jpg" class="img-responsive" alt="">
						                    </a>
						                </td>
						                <td class="product-name">
						                    <a href="product.html">Twill Silk Scarf</a>
						                </td>
						                <td class="product-price">
						                    <span class="amount">$200.00</span>
						                </td>
						                <td class="product-quantity">
						                    <div class="quantity">
						                        <input type="button" value="+" class="plus">
						                        <input type="number" step="1" max="5" min="1" value="1" title="Qty" class="qty" size="4">
						                        <input type="button" value="-" class="minus">
						                    </div>
						                </td>
						                <td class="product-subtotal">
						                    <span class="amount">$200.00</span>
						                </td>
						            </tr>

						            <tr>
						                <td colspan="6" class="actions">
						                    <div class="coupon col-md-5 col-sm-5 no-padding-left">
						                    	<div class="row">
							                        <div class="col-xs-6">
							                        	<input type="text" class="form-control" placeholder="Coupon Code">
							                        </div>
							                        <div class="col-xs-6">
								                        <input type="submit" class="btn btn-default" value="Apply Coupon">
							                        </div>
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
							                                        <span class="amount">$899.00</span>
						                                        </td>
						                                    </tr>
						                                    <tr class="shipping">
						                                        <th>Shipping</th>
						                                        <td class="text-right">
						                                            <span class="amount">$50.00</span>
						                                        </td>
						                                    </tr>
						                                    <tr class="order-total">
						                                        <th>Total</th>
						                                        <td class="text-right">
							                                        <strong><span class="amount">$999.00</span></strong>
						                                        </td>
						                                    </tr>
						                                </tbody>
						                            </table>
						                            <div class="form-group clearfix">
						                                <div class="pull-left">
						                                    <input type="submit" class="btn btn-primary" value="Update Cart">
						                                </div>
						                                <div class="pull-right text-right">
						                                    <a href="checkout.html" class="btn btn-default">Proceed to Checkout</a>
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
						                                <div class="form-group text-right">
						                                    <button type="submit" class="btn btn-default">Update Totals</button>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </td>
						            </tr>
						        </tbody>
						    </table>
						</div><!-- /.table-responsive -->
					</div>
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- #page-cart -->
	</div><!-- /.page-wrapper -->

	<jsp:include page="footer.jsp" />

</body>
</html>