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
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
%>
	<footer class="footer">
		<div class="container">
			<div class="widgets">
				<div class="row">
					<div class="col-sm-4 widget widget-about">
						<h3 class="widget-title" style="color:white">NEED HELP ? </h3>
						<p style="color:white">admin@nhmakeup.com.my</p>
						<br>
						<h4 style="color:white">OPERATION HOURS</h4>
						<p style="color:white">Mon - Fri (except Public Holiday) <br>9.00am - 6.00pm</p>
					</div><!-- ./widget -->
					<div class="col-sm-4 widget widget-links">
						<h3 style="color:white" class="widget-title">Customer Service</h3>
						<div class="row">
							
						</div>
					</div><!-- ./widget -->
					<div class="col-sm-4 widget widget-newsletter">
						<h3 class="widget-title" style="color:white" >Join our Newsletter</h3>
						<form action="#!" method="POST" class="inputs-border clearfix">
							<div class="form-group">
								<input type="email" name="email" placeholder="Your Email" class="form-control" autocomplete="off">
								<button type="submit" class="btn btn-primary"><i class="lil-long-arrow-right"></i></button>
							</div>
						</form>
						<ul class="social">
							<li><a href="#!" target="_blank"><img data-u="image" src="../images/icon/fb.png" height="30px"/></a></li>
							<li><a href="#!" target="_blank"><img data-u="image" src="../images/icon/ig.png" height="30px"/></a></li>
						</ul>
					</div><!-- ./widget -->
				</div><!-- /.row -->
			</div><!-- /.widgets -->
		</div><!-- /.container -->
		<div class="copy-right text-center" style="backgroud-color:#000000">
			<p>© Copyright <%=year %>. All Rights Reserved. Created by </p>
		</div>
	</footer><!-- /.footer -->
	
	<!-- open/close -->
	<div class="overlay overlay-simplegenie">
		<i class="overlay-close lil-close"></i>
		<div class="container">
			<div class="row text-center pos-r">
				<div class="col-md-7 col-xs-11 col-center col-height-center search-form">
					<form action="#!" method="POST" class="inputs-bg" id="searchform">
						<strong>Type a sentence or word you want to search for, And press Enter.</strong>
						<input type="text" name="q" class="form-control" placeholder="Search..">
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