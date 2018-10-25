<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>

<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	Date now = new Date();
	String basePath = StringUtil.getHostAddress(); 
	
	int id = StringUtil.strToInt(request.getParameter("id"));
	CategoryBean category = CategoryService.getInstance().getBeanById(id);
	
	if(category == null){
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

  	<style>

	#myBtn {
	  display: block;
	  position: fixed;
	  bottom: 30px;
	  right: 50px;
	  z-index: 99;
	  font-size: 11px;
	  border: none;
	  outline: none;
	  background-color:#e26a35;
	  color: white;
	  cursor: pointer;
	  height:45px;
	  width:45px;
	  border-radius: 50%;
	}
	
	#myBtn:hover {
	  opacity:0.9;
	  
	}
</style>
</head>

<body style="background-color:#f8f8f8;">
	<jsp:include page="header.jsp" />

	<section  style="margin-top:82px;">
		
		<div style="position: relative;">
			<img src="<%=basePath %>images/category/<%=category.getImage()%>" width="100%">
		
			<button onclick="window.location='<%=basePath + "products?categoryid=" + id%>'" id="myBtn" title="Go to top">Buy<br> Now</button>
		</div>
		
	</section><!-- /.products-grid -->

		<footer class="footer">
		<div class="container">
			<div class="widgets">
				<div class="row">
					<div class="hidden-md hidden-lg"><div class="col-xs-1"></div> </div>
					<div class="col-xs-11 col-md-4 widget widget-about">
						<h4 style="color:white;margin-top:0px;"><strong>NEED HELP ?</strong> </h4>
						<p style="color:white;font-weight:400;font-size:10pt;padding:0px;margin:0px;"><i>customer.care@navallihill.com.my</i></p>
						<br>
						<p style="display:inline-block;background-color:#d9d7d4;height:1px;width:60%;"></p>
						<p style="color:white;font-size:10pt;padding-top:5px;">OPERATION HOURS</p>
						<p style="color:white;font-weight:400;font-size:10pt;">Mon - Fri (except public holiday) <br>9.00AM - 6.00PM</p>
					</div><!-- ./widget -->
					
					<div class="hidden-md hidden-lg"><div class="col-xs-1"></div> </div>
					<div class="col-xs-11 col-md-4 widget widget-links">
						<h4 style="color:white" class="widget-title"><strong>Customer Service</strong></h4>
						<ol style="display:inline-block;color:white;font-weight:400;">
							<li><a href="<%=basePath %>cart/faqs.jsp" style="color:white;">FAQs</a></li>
							<li><a href="#" style="color:white;">Shipping Info</a></li>
							<li><a href="#" style="color:white;">Return Policy</a></li>
							<li><a href="#" style="color:white;">Bank Account</a></li>
						</ol>
					</div><!-- ./widget -->
					
					<div class="hidden-md hidden-lg"><div class="col-xs-1"></div> </div>
					<div class="col-xs-11 col-md-4 widget widget-newsletter">
						<h4 class="widget-title" style="color:white" ><strong>Join our Newsletter</strong></h4>
						<form action="#!" method="POST" class="inputs-border clearfix">
							<div class="form-group">
									<input type="email" name="email" placeholder="customer.care@navallihill.com.my" class="form-control" autocomplete="off">
								<button type="submit" class="btn btn-primary"><i class="lil-long-arrow-right"></i></button>
							</div>
						</form>
						<ul class="social">
								<li><a href="https://www.facebook.com/nhmakeupMY/" target="_blank"><img data-u="image" src="<%=basePath%>images/icon/fb.png" height="39px"/></a></li>
								<li><a href="https://www.instagram.com/" target="_blank"><img data-u="image" src="<%=basePath%>images/icon/ig.png" height="39px"/></a></li>
						</ul>
					</div><!-- ./widget -->
				</div><!-- /.row -->
			</div><!-- /.widgets -->
		</div><!-- /.container -->
		<div class="copy-right text-center" style="backgroud-color:#000000">
			<p style="color:white;font-weight:400;font-size:9pt;">Copyright © NAVALLI HILL MALAYSIA. All rights reserved. </p>
		</div>
	</footer><!-- /.footer -->
	
	<!-- open/close -->
	<div class="overlay overlay-simplegenie">
		<i class="overlay-close lil-close"></i>
		<div class="container">
			<div class="row text-center pos-r">
				<div class="col-md-7 col-xs-11 col-center col-height-center search-form">
					<form action="<%=basePath %>search" method="POST" class="inputs-bg" id="searchform">
						<strong>Type a sentence or word you want to search for, And press Enter.</strong>
						<input type="text" name="key" class="form-control" placeholder="Search..">
					</form>
				</div>
			</div>
		</div>
	</div><!-- /.overlay -->

	<!-- All Theme Scripts -->
	<script type="text/javascript" src="<%=basePath %>js/min.js"></script> 
	
</body>
</html>