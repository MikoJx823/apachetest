<%@ page language="java" import="com.project.util.*,java.sql.*,java.util.Calendar,com.project.bean.*,java.util.*" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8"); 
%>
<%
    int year = Calendar.getInstance().get(Calendar.YEAR);
	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	String basePath = StringUtil.getHostAddress();
	//String basePath = "http://localhost:8080/navalli/";
%>
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

	<!-- Go to top -->
	<a href="#top" class="go-to-top">
		<i class="lil-angle-double-down"></i>
	</a>

	<!-- All Theme Scripts -->
	<script type="text/javascript" src="<%=basePath %>js/min.js"></script> 