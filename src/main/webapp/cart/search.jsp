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
<body>
	<jsp:include page="header.jsp" />

	<div class="page-head content-top-margin" style="background:black;">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-sm-7">
					<ol class="breadcrumb">
						<!--  <li><a href="<%=basePath%>index.jsp">Home</a></li>-->
						<li class="active" style="color:white;">Search</li>
					</ol>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</div><!-- /.page-head -->

	<section class="section products-grid second-style">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
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
								<div class="inner-product">
									<!--<span class="onsale">Sale!</span>
									  <span class="onsale new">New!</span>
									<span class="onsale hot">Hot!</span>-->
									<%if(earlybird > 0) { %>
									<span class="salesicon">Sale</span>
									<%} %>
									<div class="product-thumbnail">
										<!--  <img src="<%=basePath%>images/<%=product.getImage1() %>" class="img-responsive" alt=""> -->
										<a href="<%=basePath%>productdetails?id=<%=product.getId()%>">
										<img src="<%=basePath%>images/products/<%=product.getImage1() %>" class="img-responsive" alt="">
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
								<h3 class="product-title"><a href="<%=path%>"><%=StringUtil.filter(product.getName()) %> </a></h3>
								<!--  <div class="star-rating">
									<span style="width:90%"></span>
								</div> -->
								<p class="product-price">
									<%
									
									if(earlybird > 0){ %>
									<ins>
										<span class="amount"><%=StringUtil.formatCurrencyPrice(earlybird) %></span>
									</ins>
									<del>
										<span class="amount"><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></span>
									</del>
										
									<%}else { %>
									<ins>
										<span class="amount"><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></span>
									</ins>
									<%} %>
								</p>
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
				<div class="col-md-12">
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