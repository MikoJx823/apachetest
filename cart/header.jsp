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
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	
	HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap) == null ? 
	new HashMap<String, OrderItemBean>() : (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap);
	
	int cartNumber = 0;;
	if (cartMap!=null && !cartMap.isEmpty()){
		for(Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
	 		String key = entry.getKey();
	 		OrderItemBean orderItem = entry.getValue(); 
			
	 		cartNumber += orderItem.getQuantity();
		}
	}
	
	List<CategoryBean> parents = CategoryService.getInstance().getFrontMenuBySqlwhere(" where parentid = " + StaticValueUtil.PARENT_CAT + " and status = " + StaticValueUtil.Active);
	List<CategoryBean> makeupFace = CategoryService.getInstance().getFrontMenuBySqlwhere(" where tag = " + StaticValueUtil.TAG_FACE + " and status = " + StaticValueUtil.Active);
	
	
%>

	<div class="nav-container navbar-fixed-top nav-sticky" >
		<!-- <nav class="sub-navbar">
			 <div class="list-select">
				<div class="inner-select">
					<div class="selected">EN</div>
					<ul>
						<li><a href="#!">EN</a></li>
						<li><a href="#!">AR</a></li>
						<li><a href="#!">TR</a></li>
					</ul>
				</div>
			</div>
			<div class="list-select">
				<div class="inner-select">
					<div class="selected"><i class="lil-dollar"></i></div>
					<ul>
						<li><a href="#!"><i class="lil-dollar"></i></a></li>
						<li><a href="#!"><i class="lil-gbp"></i></a></li>
						<li><a href="#!"><i class="lil-try"></i></a></li>
					</ul>
				</div>
			</div>

			<ul class="pull-right list-inline">
				<li><a href="#!">My account</a></li>
				<li><a href="wishlist.html">My Wishlist</a></li>
			</ul>
			<div class="clearfix"></div> 
		</nav><!-- /.sub-navbar -->
	    <nav class="navbar navbar-default" style="background-color:#000000">
	      	<div class="container">
	        	<div class="navbar-header">
			        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			        </button>
			        <a class="navbar-brand" href="index.html">
			          	<img src="<%=basePath %>images/logo2.png" alt="Navalli" witdh="100px">
			        </a>
	        	</div>
			    <ul class="navbar-nav navbar-icons">
			    	<li style="padding-right:10px;margin:0px;" class="header-social-icon"><a href="https://www.facebook.com/nhmakeupMY/" target="_blank"><img data-u="image" src="<%=basePath %>images/icon/fb.png" height="48px"/></a></li>
					<li style="padding-right:10px;margin:0px;" class="header-social-icon"><a href="http://instagram.com/" target="_blank"><img data-u="image" src="<%=basePath %>images/icon/ig.png" height="48px"/></a></li>
			    	<li class="shopping-cart">
			    		
			            <a href="#!" class="li-icon" <%if (cartMap!=null && !cartMap.isEmpty()){ %> data-toggle="dropdown" aria-haspopup="false" aria-expanded="false" <%} %> >
			                <i class="lil-shopping_cart"></i><%if(cartNumber >0 ){%><span class="badge"><%=cartNumber %></span> <%} %>
			            </a> 
			            <%if (cartMap!=null && !cartMap.isEmpty()){ %>
			            <ul class="dropdown-menu">
			                <div class="dropdown-wrap" slim-scroll="√">
			                <%
						 	   for(Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
						 		   String key = entry.getKey();
						 		   OrderItemBean orderItem = entry.getValue(); 
						 		   
						 	%>
			                    <li>
			                        <a href="product.html"><img src="img/products/<%=StringUtil.filter(orderItem.getProductimage()) %>" class="img-responsive product-img" alt=""></a>
			                        <div class="product-details">
			                            <p class="product-title clearfix"><a href="product.html"><%=StringUtil.filter(orderItem.getProductname()) %></a></p>
			                            <%if(!"".equals(StringUtil.filter(orderItem.getVariantname()))) { %>
			                            <p class="product-price clearfix">Variant : <%=StringUtil.filter(orderItem.getVariantname()) %></p>
			                            <%} %>
			                            <p class="product-price clearfix">Price : <%=StringUtil.formatFrontCurrencyPrice(orderItem.getPrice()) %>
											<!--  <ins>
												<span class="amount">$66.50</span>
											</ins> -->
										</p>
			                        </div>
			                    </li>
			                 <%} %>
			                </div>
			                <li class="dropdown-footer">
				                <a href="<%=basePath%>cartsummary">View Cart</a>
			                </li>
			            </ul>
			             <%} %>
			        </li>
			        <li><a href="#!" class="li-icon" id="trigger-overlay"><i class="lil-search"></i></a></li>
			    </ul>
	        	<div id="navbar" class="navbar-collapse collapse" >
				    <ul class="nav navbar-nav navbar-left"> 
				         <li style="min-width:80px;text-align:center;">
				            <a href="about.html" style="color:white">New <!--  <i class="caret"></i>--></a>
				        </li>
				        
				        <%for(CategoryBean parent: parents) {
				        	
				        	List<CategoryBean> catTags = new ArrayList<CategoryBean>();
				        	
				        	if(parent.getId() == StaticValueUtil.CAT_MAKEUP){
				        %>
				        <li style="min-width:80px;text-align:center;"> <!-- class="active" -->
				            <a href="index.html" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false" style="color:white"><%=StringUtil.filter(parent.getName()) %> </a>
				           	<div class="mega-dropdown1 dropdown-menu" style="left:-80px;">
				           		<%
				           		for(int tag: CategoryTagPulldown.value) {
				           			String sqlWhere = " where parentid = " + parent.getId() + " and tag = " + tag + " and status = " + StaticValueUtil.Active;
				           			List<CategoryBean> categories = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere);
				           		%>
				           		<ul class="mega-subcontent">
				           		<li style="display:block;padding:3px 20px;"><p><b><%=StringUtil.filter(CategoryTagPulldown.getText(tag)) %></b></p></li>
				           		<!-- <li style="display:block;padding:0px 20px;"><h4>Test</h4></li> class="mega-tag" -->
				                <%for(CategoryBean category : categories){ %>
				                <li><a href="index.html" style="text-transform: none;"><%=StringUtil.filter(category.getName()) %></a></li> <!-- class="active" -->
				                <%} %>
				            	</ul>
				           		<%} %>
				           	</div>
				        </li>
				        <%	
				        	}else if(parent.getId() == StaticValueUtil.CAT_SKIN){ 
				        		String sqlWhere = " where parentid = " + parent.getId() + " and status = " + StaticValueUtil.Active;
				        		
				        		List<CategoryBean> catTag1 = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere + " and tag = 6");
				        		List<CategoryBean> catTag2 = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere + " and tag = 7");	
				        %>
				        <li style="min-width:80px;text-align:center;">
				            <a href="index.html" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false" style="color:white"><%=StringUtil.filter(parent.getName()) %> </a>
				           	<div class="mega-dropdown2 dropdown-menu" style="left:-180px;">
				           		<ul class="mega-subcontent">
				           		<%for(CategoryBean cat : catTag1 ) { %>
				                <li><a href="index.html" style="text-transform: none;"><%=StringUtil.filter(cat.getName()) %></a></li> <!-- class="active" -->
				            	<%} %>
				         		</ul>
				         		<ul class="mega-subcontent">
				           		<%for(CategoryBean cat : catTag2 ) { %>
				                <li><a href="index.html" style="text-transform: none;"><%=StringUtil.filter(cat.getName()) %></a></li> <!-- class="active" -->
				            	<%} %>
				         		</ul>
				           	</div>
				        </li>
				        <% 	
				        	}
				        } 
				        %>		       
				        <li style="min-width:80px;text-align:center;">
				            <a href="#!" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false" style="color:white">Bestseller</a>
				            <div class="mega-dropdown3 dropdown-menu" style="left:-280px;">
				           		<ul class="mega-subcontent">
				           		<li><a href="index.html">FEATURED OF THE MONTH</a></li> <!-- class="active" -->
				         		</ul>
				         		<ul class="mega-subcontent">
				           		<li><a href="index.html">VALUE BUNDLE</a></li> <!-- class="active" -->
				         		</ul>
				         		<ul class="mega-subcontent">
				           		<li><a href="index.html">OUR TOP 10</a></li> <!-- class="active" -->
				         		</ul>
				           	</div>				            
				        </li>
				        <li style="min-width:80px;text-align:center;">
				        	<a href="#!" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false" style="color:white">How To</a>
				        	<div class="mega-dropdown3 dropdown-menu" style="left:-390px;">
				           		<ul class="mega-subcontent">
				           		<li><a href="index.html">TUTORIAL</a></li> <!-- class="active" -->
				         		</ul>
				         		<ul class="mega-subcontent">
				           		<li><a href="index.html">CELERITIES CHOICES</a></li> <!-- class="active" -->
				         		</ul>
				         		<ul class="mega-subcontent">
				           		<li><a href="index.html">VIDEO</a></li> <!-- class="active" -->
				         		</ul>
				           	</div>		
				        </li>
				        <li style="min-width:80px;text-align:center;"><a href="contact.html" style="color:white">FAQ</a></li>
				    </ul>
			    </div><!--/.nav-collapse -->
	      	</div><!--/.container -->
	    </nav>
	</div><!-- /.nav-container -->