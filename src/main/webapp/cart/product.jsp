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
	//String basePath = "http://localhost:8080/navalli/";
	String basePath = StringUtil.getHostAddress();
	Date now = new Date();
	
	ProductBean product = (ProductBean)request.getAttribute("product");
	if(product == null) {
		product = new ProductBean();
		//response.sendRedirect(basePath + "index.jsp");
		//return;
	}
	
	boolean isAvailable = false;
	
	CategoryBean category = CategoryService.getInstance().getBeanById(product.getCategoryid());
	if(category == null){
		category = new CategoryBean();
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

	<!--  <div class="page-head content-top-margin" style="background:black;">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-sm-7">
					<ol class="breadcrumb">
						<li><a style="color:white;" href="<%=basePath%>index.jsp">Home</a></li>
						<li><a style="color:white;" href="<%=basePath%>products">Products</a></li>
						<li class="active"  style="color:white;"><%=StringUtil.filter(product.getName()) %></li>
					</ol>
				</div>

				
			</div>
		</div>
	</div>-->
	
	<div style="margin-bottom:15px;padding:0;margin-top:100px;">
	<div class="container"> <!--   style="margin:0" -->
		<p style="color:#e26a35">&nbsp;<b>SHOP<%=StringUtil.filter(category.getName()).equals("")? "" : " / " + category.getName().toUpperCase() %> / <%=StringUtil.filter(product.getName()).toUpperCase() %></b></p>
		</div>
	</div>
	
	<section class=" single-product-wrapper" > <!-- section -->
		<div class="container">
			<div class="row">
				<div class="col-sm-5">
					<div class="product-images">
						<div class="product-thumbnail">
							<a href="<%=basePath%>images/products/<%=product.getImage1() %>" class="fancybox" rel="gallery">
								<img src="<%=basePath%>images/products/<%=product.getImage1() %>" class="img-responsive" style="background-color:red">
							</a>
						</div>
						<div class="product-images-carousel">
							<%if(!"".equals(StringUtil.filter(product.getImage1()))) { %>
							<div class="item">
								<a href="<%=basePath %>/images/products/<%=product.getImage1() %>" class="fancybox" rel="gallery">
									<img src="<%=basePath %>/images/products/<%=product.getImage1() %>" class="img-responsive" alt="<%=product.getImage1()%>" >
								</a>
							</div>
							<%} %>
							<%if(!"".equals(StringUtil.filter(product.getImage2()))) { %>
							<div class="item">
								<a href="<%=basePath %>/images/products/<%=product.getImage2() %>" class="fancybox" rel="gallery">
									<img src="<%=basePath %>/images/products/<%=product.getImage2() %>" class="img-responsive" alt="<%=product.getImage2()%>">
								</a>
							</div>
							<%} %>
							<%if(!"".equals(StringUtil.filter(product.getImage3()))) { %>
							<div class="item">
								<a href="<%=basePath %>/images/products/<%=product.getImage3() %>" class="fancybox" rel="gallery">
									<img src="<%=basePath %>/images/products/<%=product.getImage3() %>" class="img-responsive" alt="<%=product.getImage3()%>">
								</a>
							</div>
							<%} %>
							<%if(!"".equals(StringUtil.filter(product.getImage4()))) { %>
							<div class="item">
								<a href="<%=basePath %>/images/products/<%=product.getImage4() %>" class="fancybox" rel="gallery">
									<img src="<%=basePath %>/images/products/<%=product.getImage4() %>" class="img-responsive" alt="<%=product.getImage4()%>">
								</a>
							</div>
							<%} %>
							<%if(!"".equals(StringUtil.filter(product.getImage5()))) { %>
							<div class="item">
								<a href="<%=basePath %>/images/products/<%=product.getImage5() %>" class="fancybox" rel="gallery">
									<img src="<%=basePath %>/images/products/<%=product.getImage5() %>" class="img-responsive" alt="<%=product.getImage5()%>">
								</a>
							</div>
							<%} %>
						</div>
					</div><!-- /.product-images -->
				</div>

				<div class="col-sm-6 col-sm-offset-1">
					<div class="product-details">
						<div class="rating">
							<!-- <div class="star-rating">
								<span style="width:90%"></span>
							</div>
							<span class="rating-text">3 Reviews</span>
							<span class="pull-right">Product Code: <span><%=StringUtil.filter(product.getProductcode()) %></span></span>  -->
						</div>

						<div class="product-title">
							<h3 class="product-name"><%=StringUtil.filter(product.getName())%></h3>
							<!--<p class="product-available">Shipping Available</p> -->
						</div>
						
						<%if(!"".equals(StringUtil.filter(product.getShortdesc()))){ %>
						<div class="row">
							<div class="col-md-7">
							<p class="prod-detail-short-desc"><%=StringUtil.filter(product.getShortdesc()) %></p>
							</div>
						</div>
						<%} %>
						
						<div class="row">
						<div class="col-md-12" id="pricecontainer">
						<%
							double earlybird = ProductService.getInstance().getEarlyBirdDiscount(product.getProductVariant().get(0));
							if(earlybird > 0 ){
						%>
							<p class="prod-detail-price-earlybird"><b><del><%=StringUtil.formatCurrencyPrice(product.getProductVariant().get(0).getPrice()) %></del></b> &nbsp;&nbsp;
							<span class="prod-detail-price-discount"><b> <%=StringUtil.formatIndexPrice2(product.getProductVariant().get(0).getDiscount())%>% OFF </span></b> </p>
							<p class="prod-detail-price"><%=StringUtil.formatCurrencyPrice(earlybird) %></p>
						<%	}else{ %>
							<p class="prod-detail-price"><%=StringUtil.formatCurrencyPrice(product.getProductVariant().get(0).getPrice()) %></p>
						<%	} %>
						<hr class="prod-hr">
						</div>
						</div>
						
						
						<div class="row">
						<div class="col-md-12">
						
						<form action="<%=basePath %>cart" id="AddToCartForm" method="POST" class="inputs-border">
							<input type="hidden" name="actionType" value="addCart">
							<input type="hidden" name="pid" value="<%=product.getId()%>">
							<div class="product-attributes row">
								<%if(product.getProductVariant() != null && product.getProductVariant().size() > 0 ){ 
									if(ProductService.getInstance().getProductAvailableQuantity(product.getProductVariant().get(0).getPvid()) > 0){
										isAvailable = true;
									}
									
									if(product.getProductVariant().size() == 1){
								%>
										<input type="hidden" name="pvid" value="<%=product.getProductVariant().get(0).getPvid() %>">
								<%	}
									
									if(product.getProductVariant().size() > 1){
								%>
								 <!--  <div class="form-group col-md-6">
									<label for="attr_1">Variant</label>
									<select class="form-control" id="variant" name="pvid" onchange="variantOnChange()">
										
										<%
										for(ProductVariantBean variant: product.getProductVariant()){ 
										%>
										<option value="<%=variant.getPvid()%>"><%=StringUtil.filter(variant.getName()) %></option>
										<%} %>
									</select>
								</div> -->
								
								<input type="hidden" id="variantpvid" name="pvid" value="<%=product.getProductVariant().get(0).getPvid() %>">
								<div class="form-group col-md-6">
									<label for="attr_1"><b>Colours </b></label>
									<ul >
									<%
										for(ProductVariantBean variant: product.getProductVariant()){ 
										%>
										<li style="float:left">
										<a href="javascript:variantOnChange(<%=variant.getPvid()%>)"><div id="pvid<%=variant.getPvid() %>" style="background-color: <%=StringUtil.filter(variant.getName()) %>; height: 45px; width: 45px; margin-right:10px; "></div></a>
										</li>
										
										<!-- <option value="<%=variant.getPvid()%>"><%=StringUtil.filter(variant.getName()) %></option>-->
										<%} %>
										</ul>
									<!-- <select class="form-control" id="variant" name="pvid" onchange="variantOnChange()">
										
										<%
										for(ProductVariantBean variant: product.getProductVariant()){ 
										%>
										<option value="<%=variant.getPvid()%>"><%=StringUtil.filter(variant.getName()) %></option>
										<%} %>
									</select> -->
								</div>
								<%
									}
								} %>
							</div>
							
							<div>
							<p style="margin-bottom:0;padding-bottom:0;color:#e26a35"><b>FREE SHIPPING IF PURCHASE OVER RM80 </b></p>
							<p style="font-size:8pt"><i>(WEST MALAYSIA ONLY)</i></p>
							</div>
							
							<div id="variantcontainer" >
								<div class="form-group">
								<%if(isAvailable){ %>
									<p><b>In Stock</b></p>
									<div class="quantity">
										<input type="button" value="+" class="plus" style="color:black;border:1px solid #e26a35; border-bottom:0px;">
										<input type="number" step="1" max="5" min="1" value="1" title="Qty" class="qty" size="4" name="qty">
										<input type="button" value="-" class="minus" style="color:black;border:1px solid #e26a35;">
									</div>
									
									<button type="button" class="btn btn-default" style="background-color:#e26a35;border:0" onClick="javascript:onAddToCart()"><!-- <i class="lil-add_shopping_cart"></i> --> Add to cart</button> 
								<%}else{ %>
									<p class="product-available">Out of Stock</p>
								<%} %>
								</div>
								<%
								if(category.getEnableguide() == StaticValueUtil.STATUS_ENABLE){
									String categoryPath = basePath + "cart/category.jsp?id=" + category.getId();
								%>
								<div class="form-group">
								<button type="button" class="btn btn-default" style="background-color:#e26a35;border:0" onClick="window.location.href='<%=categoryPath%>'"><!-- <i class="lil-add_shopping_cart"></i> --> Learn More</button> 
								</div>
								
								<% 
		           					
		           				}
								
								%>
								
							</div>
							
							
						</form>
						</div>
						</div>

					</div><!-- /.product-details -->
				</div>

				<div class="col-sm-12" style="padding-bottom:15px;">
					<div class="tabs-wrapper">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
						    <li class="active">
							    <a href="#tab-description" aria-controls="tab-description" data-toggle="tab" style="color:black;"><b>Tutorial / Videos</b></a>
						    </li>
						    <li>
							    <a href="#tab-information" aria-controls="tab-information" data-toggle="tab" style="color:black;"><b>Additional Information</b></a>
						    </li>
						    <!--  <li>
							    <a href="#tab-reviews" aria-controls="tab-reviews" data-toggle="tab">Reviews (3)</a>
						    </li> -->
						</ul>
						<!-- Tab panes -->
						<div class="tab-content">
						    <div class="tab-pane active" id="tab-description">
						    	<!--  <img src="https://images.pexels.com/photos/460823/pexels-photo-460823.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940" class="img-responsive"/> -->
						    	<%if(!"".equals(StringUtil.filter(product.getDescimage()))){ %>
						    	<img src="<%=basePath %>/images/products/<%=StringUtil.filter(product.getDescimage()) %>" class="img-responsive"/> <br>
						    	<%} %>
						    	<!-- 
						    	
						    	<div class="embed-responsive embed-responsive-21by9">
								  <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/C1axYRDIfVU" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
								</div>
						    	 -->
						    	 <%if(!"".equals(StringUtil.filter(product.getDescyoutube()))){ %>
						    	<div class="embed-responsive embed-responsive-16by9">
    							<iframe class="embed-responsive-item" src="<%=StringUtil.filter(product.getDescyoutube())%>"></iframe>
   								</div>
   								<%} %>
						    	<%//StringUtil.filter(product.getDescimage()) %>
						    </div>
						    <div class="tab-pane" id="tab-information" style="color:black;">
							    <%=StringUtil.filter(product.getAdditionaldesc()) %>
							    
							    <!--  <table class="table shop_attributes">
								    <tbody>
								        <tr>
								            <th>Color</th>
								            <td>
								                <p>Red, Black, Yellow</p>
								            </td>
								        </tr>
								        <tr>
								            <th>Materials</th>
								            <td>
								                <p>Wood</p>
								            </td>
								        </tr>
								        <tr>
								            <th>Dimensions</th>
								            <td>
								                <p>H:1.5″ x W: 2.75″ x D: 3.0″</p>
								            </td>
								        </tr>
								    </tbody>
								</table> -->
						    </div>
							
							<!-- 
						    <div class="tab-pane" id="tab-reviews">
						    	<div class="row">
						    		<div class="col-md-6 col-sm-12">
								    	<ol class="reviews">
								    		<li class="review">
								    			<div class="media">
												    <div class="media-left media-middle">
												        <a href="#!">
												            <img class="media-object avatar" src="build/img/users/1.jpg">
												        </a>
												    </div>
												    <div class="media-body">
												    	<div class="rating pull-right">
												        	<div class="star-rating">
																<span style="width:90%"></span>
															</div>
												        </div>
												        <h4 class="media-heading">Hussam 3bd</h4>
												        <time datetime="2016-06-07T11:44:50+00:00">June 7, 2016</time>
												        <div class="description">
												        	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the standard dummy text.
												        </div>
												    </div>
												</div>
								    		</li>

								    		<li class="review">
								    			<div class="media">
												    <div class="media-left media-middle">
												        <a href="#!">
												            <img class="media-object avatar" src="build/img/users/2.jpg">
												        </a>
												    </div>
												    <div class="media-body">
												    	<div class="rating pull-right">
												        	<div class="star-rating">
																<span style="width:60%">
															</div>
												        </div>
												        <h4 class="media-heading">Toyler</h4>
												        <time datetime="2016-06-07T11:44:50+00:00">June 25, 2016</time>
												        <div class="description">
												        	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
												        </div>
												    </div>
												</div>
								    		</li>

								    		<li class="review">
								    			<div class="media">
												    <div class="media-left media-middle">
												        <a href="#!">
												            <img class="media-object avatar" src="build/img/users/3.jpg">
												        </a>
												    </div>
												    <div class="media-body">
												    	<div class="rating pull-right">
												        	<div class="star-rating">
																<span style="width:75%">
															</div>
												        </div>
												        <h4 class="media-heading">Alex</h4>
												        <time datetime="2016-06-07T11:44:50+00:00">Feb 10, 2016</time>
												        <div class="description">
												        	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
												        </div>
												    </div>
												</div>
								    		</li>
								    	</ol><!-- /.reviews 
							    	</div>
							    	<div class="col-md-5 col-sm-12 col-md-offset-1 review-form-wrapper">
							    		<form action="#!" method="post" class="review-form">
							    			<div class="form-group">
							    				<input type="text" class="form-control" placeholder="Name*" required>
							    			</div>
							    			<div class="form-group">
							    				<input type="email" class="form-control" placeholder="Email*" required>
							    			</div>
							    			<div class="form-group">
							    				<label for="rating">Rating</label>
							    				<div class="rating-stars" data-rating="4"></div>
							    				<input type="hidden" name="rating" value="4" required>
							    			</div>
							    			<div class="form-group">
							    				<textarea class="form-control" placeholder="Your Review*" rows="5" required></textarea>
							    			</div>
							    			<div class="form-group">
							    				<button type="button" class="btn btn-default">Leave Rating</button>
							    			</div>
							    		</form>
							    	</div>
						    	</div><!-- /.row 
						    </div> -->
						</div>
					</div><!-- /.tabs-wrapper -->
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</section><!-- /.products -->

	<jsp:include page="footer.jsp" />
	
	<script type="text/javascript">
		function variantOnChange(pvid){
			//var pvid = $('select[name=pvid]').val();
			var htmlStr = "";
			var priceStr = "";
			
			
			<%for(ProductVariantBean variant: product.getProductVariant()){ %>
			$("#pvid" + <%=variant.getPvid()%>).css("border","");
			<%}%>
			$("#pvid" + pvid).css("border","1px solid #e26a35");
			
			//alert(pvid);
			$("#variantpvid").val(pvid);
			<%
			if(product.getProductVariant().size() > 1){
				for(ProductVariantBean variant : product.getProductVariant()){ 	
			%>
					if(pvid == <%=variant.getPvid()%>){
						if(<%=ProductService.getInstance().getProductAvailableQuantity(variant.getPvid())%> > 0){
							htmlStr = "<div class=\"form-group\">" + 
										"<div class=\"quantity\">" +
										 	"<input type=\"button\" value=\"+\" class=\"plus\" style=\"color:black;border:1px solid #e26a35;border-bottom:0px;\">" +
											"<input type=\"number\" step=\"1\" max=\"5\" min=\"1\" value=\"1\" title=\"Qty\" class=\"qty\" size=\"4\" name=\"qty\">" +
											"<input type=\"button\" value=\"-\" class=\"minus\" style=\"color:black;border:1px solid #e26a35;\">" +
										  "</div>" +
										  "<button type=\"button\" class=\"btn btn-default\" onClick=\"javascript:onAddToCart()\">Add to cart</button>";			  
						}
						
						var earlybird = <%=ProductService.getInstance().getEarlyBirdDiscount(variant)%>;
						if(earlybird > 0){
							/*priceStr = "<del><span class=\"amount\"><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></span></del>" +
									   "<ins><span class=\"amount\"><%=StringUtil.formatCurrencyPrice(ProductService.getInstance().getEarlyBirdDiscount(variant)) %></span></ins>";
							*/
							priceStr = "<p class=\"prod-detail-price-earlybird\"><del><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></del> &nbsp;&nbsp;" + 
							   		   "<span class=\"prod-detail-price-discount\"> <%=StringUtil.formatIndexPrice2(variant.getDiscount())%>% OFF </span> </p>" + 
							   		   "<p class=\"prod-detail-price\"><%=StringUtil.formatCurrencyPrice(ProductService.getInstance().getEarlyBirdDiscount(variant)) %></p><hr class=\"prod-hr\">";
					
						}else{
							//priceStr = "<ins><span class=\"amount\"><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></span></ins>";
							priceStr = "<p class=\"prod-detail-price\"><%=StringUtil.formatCurrencyPrice(variant.getPrice()) %></p><hr class=\"prod-hr\">";
							
						}
					}
			<%		
				}
			%>
				if(htmlStr == ""){
					htmlStr = "<div class=\"form-group\">" +
					  		  	"<p class=\"product-available\">Out of Stock</p><hr>" + 
					  		  "</div>";
				}			
			<%
			}else{
			%>	
				var earlybird = <%=ProductService.getInstance().getEarlyBirdDiscount(product.getProductVariant().get(0))%>;
				if(earlybird > 0){
					priceStr = "<p class=\"prod-detail-price-earlybird\"><del><%=StringUtil.formatCurrencyPrice(product.getProductVariant().get(0).getPrice()) %></del> &nbsp;&nbsp;" + 
							   "<span class=\"prod-detail-price-discount\"> <%=StringUtil.formatIndexPrice2(product.getProductVariant().get(0).getDiscount())%>% OFF </span> </p>" + 
							   "<p class=\"prod-detail-price\"><%=StringUtil.formatCurrencyPrice(earlybird) %></p><hr class=\"prod-hr\">";
					/*
					"<del><span class=\"amount\"><%=StringUtil.formatCurrencyPrice(product.getProductVariant().get(0).getPrice()) %></span></del>" +
							   "<ins><span class=\"amount\"><%=StringUtil.formatCurrencyPrice(ProductService.getInstance().getEarlyBirdDiscount(product.getProductVariant().get(0))) %></span></ins>";
					*/

				}else{
					priceStr = "<p class=\"prod-detail-price\"><%=StringUtil.formatCurrencyPrice(product.getProductVariant().get(0).getPrice()) %></p><hr class=\"prod-hr\">";
						
						//"<ins><span class=\"amount\"><%=StringUtil.formatCurrencyPrice(product.getProductVariant().get(0).getPrice()) %></span></ins>";
				}
				
				
				if(<%=ProductService.getInstance().getProductAvailableQuantity(product.getProductVariant().get(0).getPvid())%> > 0){
					htmlStr = "<div class=\"form-group\">" + 
					  			"<div class=\"quantity\">" +
					  			"<input type=\"button\" value=\"+\" class=\"plus\" style=\"color:black;border:1px solid #e26a35;border-bottom:0px;\">" +
								"<input type=\"number\" step=\"1\" max=\"5\" min=\"1\" value=\"1\" title=\"Qty\" class=\"qty\" size=\"4\" name=\"qty\">" +
								"<input type=\"button\" value=\"-\" class=\"minus\" style=\"color:black;border:1px solid #e26a35;\">" +
					  		  "</div>" +
					  		  "<button type=\"button\" class=\"btn btn-default\" onClick=\"javascript:onAddToCart()\"> Add to cart</button>";
 
				}else{
					htmlStr = "<div class=\"form-group\">" +
							  "<p class=\"product-available\">Out of Stock</p>" + 
							  "</div>";
				}
			<%	
			}
			%>

			$("#pricecontainer").html(priceStr);
			$("#variantcontainer").html(htmlStr);
			
		}
		
		function onAddToCart(){
			$("#AddToCartForm").submit();
		}
	</script>
</body>
</html>