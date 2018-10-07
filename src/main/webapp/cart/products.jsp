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
	List<ProductBean> products = (List<ProductBean>)request.getAttribute(SessionName.products) == null ? new ArrayList<ProductBean>() : (List<ProductBean>)request.getAttribute(SessionName.products);
	
	int categoryid = StringUtil.trimToInt(request.getAttribute("categoryId"));
	String search = StringUtil.filter((String)request.getAttribute("search"));
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
	int itemCount = StringUtil.trimToInt(request.getAttribute(SessionName.itemCount));
	
	
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
<body style="background-color:#f8f8f8;"> 
	<jsp:include page="header.jsp" />
	
	<div style="background-color:#FFC5C5; height:350px; margin-top:85px;">
		<!--  <div class="row">
				<div class="col-md-12">
					<img src="">
				</div>
			</div>-->
	</div>
	
	<div class="page-head" style="background:white;margin-top:25px;"> <!-- content-top-margin -->
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-sm-7">
					<ol class="breadcrumb">
						<!--  <li><a href="<%=basePath%>index.jsp">Home</a></li>-->
						<li class="active" style="color:#E26A35;">Shop / Promo</li>
					</ol>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</div><!-- /.page-head -->

	<section class="section products-grid second-style">
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<div class="shop-sidebar shop-sidebar-left">
						<div class="widgets">
							<div class="widget widget-search">
								<h5 class="widget-title" style="font-size:12pt:font-weight:900">What's on your mind ?</h5>
								<form action="<%=basePath %>products" method="POST" class="inputs-border inputs-bg">
									<input type="text" class="form-control input-box" name="search" placeholder="   NAVALLI HILL" value="<%=search%>" >
									<input type="hidden" name="categoryid" value="<%=categoryid%>">
								</form>
							</div><!-- /.widget-search -->

							<div class="widget widget-categories hidden-xs hidden-sm">
								<h4 class="widget-title"><strong>Categories</strong></h4>
								<%=CategoryService.getInstance().getFrontCatFilter(categoryid) %>
								 <!-- <ul>
									<li>
										<a href="#!">Chairs <span class="count">(6)</span></a>
									</li>
									<li>
										<a href="#!">Tables <span class="count">(7)</span></a>
										<ul class="children">
											<li>
												<a href="#!">Side Tables <span class="count">(2)</span></a>
											</li>
											<li>
												<a href="#!">Lunch Tables <span class="count">(5)</span></a>
											</li>
										</ul>
									</li>
									<li>
										<a href="#!">Couches <span class="count">(3)</span></a>
									</li>
									<li>
										<a href="#!">Lighting <span class="count">(4)</span></a>
									</li>
								</ul>  -->
							</div><!-- /.widget-categories -->

						</div><!-- /.widgets -->
					</div><!-- /.shop-sidebar -->
				</div>

				<div class="col-md-9">
					<%
					if(products != null && products.size() > 0){ 
					%>
					<div class="masonry row">
						<% 
						for(ProductBean product: products){
							
							if(product != null){
								
								ProductVariantBean variant = null;
								if(product.getProductVariant() != null && product.getProductVariant().size() > 0){
									variant = product.getProductVariant().get(0);
								}else{
									variant = new ProductVariantBean();
								}
								
								double earlybird = ProductService.getInstance().getEarlyBirdDiscount(variant);
								String path = basePath + "productdetails?id=" + product.getId();
							
						%>
							<div class="product col-md-3 col-sm-6 col-xs-12" data-product-id="1">
								<div class="product-shadown"> <!-- FOR SHADOW EFFECT -->
								<div class="inner-product">
									<!--<span class="onsale">Sale!</span>
									  <span class="onsale new">New!</span>
									<span class="onsale hot">Hot!</span>-->
									
									<%if(ProductService.getInstance().checkIsNewItem(product.getId())){ %>
									<span class="newicon">NEW</span>
									<span class="salesicon">HOT</span>
									<%} %>
									<%if(earlybird > 0) { %>
									<!-- <span class="salesicon">Sale</span> -->
									<%} %>
									<div class="product-thumbnail" style="background-color:#FFC5C5;">
										<!--  <img src="<%=basePath%>images/<%=product.getImage1() %>" class="img-responsive" alt=""> -->
										<a href="<%=basePath%>productdetails?id=<%=product.getId()%>">
										<img src="<%=basePath%>images/products/<%=product.getImage1() %>" class="img-responsive" alt="" style="min-height:200px;">  <!-- style="height:250px;" -->
										</a>
									</div>
									<div class="product-details text-center">
										<div class="product-btns">
											<!-- <span data-toggle="tooltip" data-placement="top" title="Add To Cart">
												<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
											</span>
											 <span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
												<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
											</span>
											<span data-toggle="tooltip" data-placement="top" title="View">
												<a href="<%=path%>" class="li-icon view-details"><i class="lil-search"></i></a>
											</span>-->
										</div>
									</div>
								</div>
								
								<div style="background-color:white;padding-bottom:10px;">
								<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;text-align: left;"><strong><a href="<%=path%>"><%=StringUtil.filter(product.getName()) %> </a></strong></h4>
								<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;text-align: left;"><%=StringUtil.filter(product.getListtext()) %></p>
								
								<!--  <div class="star-rating">
									<span style="width:90%"></span>
								</div> -->
								<!-- <p class="product-price"></p> -->
									<% if(earlybird > 0){ %>
									<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:11pt;text-align: left;"><%=StringUtil.formatCurrencyPrice(earlybird) %> &nbsp;&nbsp;
										<span style="background-color:#e26a35;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> <%=StringUtil.formatIndexPrice2(variant.getDiscount())%>% OFF </span> </p>
									<p style="padding:0;margin:0;padding-left:15px;font-size:7pt;text-align: left;"><del><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></del></p>
									<%if("".equals(StringUtil.filter(product.getListtext()))) {%>
									<p style="padding:0;margin:0;">&nbsp;</p>
									<%} %>
									<!--  <ins>
										<span class="amount"><%=StringUtil.formatCurrencyPrice(earlybird) %></span>
									</ins>
									<del>
										<span class="amount"><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></span>
									</del>-->
										
									<%}else { %>
									<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;padding-bottom:15px;font-weight:900;font-size:11pt;text-align: left;"><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></p>
									<%if("".equals(StringUtil.filter(product.getListtext()))) {%>
									<p style="padding:0;margin:0;">&nbsp;</p>
									<%} %>
									<!--<ins>
										<span class="amount"><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></span>
									</ins> -->
									<%} %>
								
								</div>
								</div>
							</div><!-- /.product -->
						<%	
								}	
							}
						%>
					</div><!-- /.masonry -->
					
					<!--  <div class="clearfix text-center">
						<a href="#!" class="btn btn-default">Show More</a>
					</div> -->
					
					<%}else{  %>
						<p>No product found ! </p>
					<%} %>
					
				</div>
			</div><!-- /.row -->
			
			 <div class="row">
			 	<div class="col-md-3"></div>
				<div class="col-md-9">
					<%
					String navPath = basePath + "products?pageIdx=";
					
					if(products != null && products.size() > 0){ 
					%>
					 
					<div class="clearfix text-center">
						<%=StringUtil.getFrontPagingString(5, pageIdx, totalPages, navPath) %>
					</div> 
					<%} %>
				</div>
			</div>
		</div><!-- /.container -->
	</section><!-- /.products-grid -->

	<jsp:include page="footer.jsp" />

</body>
</html>