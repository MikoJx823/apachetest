<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	Date now = new Date();
	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	String basePath = StringUtil.getHostAddress();
	
	
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
	        	<div class="navbar-header"> <!-- header-height -->
			        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			        </button>
			        <a class="header-logo navbar-brand " href="<%=basePath %>cart/index.jsp" style="width:150px;">
			          	<img src="<%=basePath %>images/logo2.png" alt="Navalli">
			        </a>
	        	</div>
			    <ul class="navbar-nav navbar-icons">
			    	<li style="padding-right:5px;margin:0px;" class="header-social-icon hidden-xs hidden-sm"><a href="https://www.facebook.com/nhmakeupMY/" target="_blank"><img data-u="image" src="<%=basePath %>images/icon/fb.png" height="37px"/></a></li>
					<li style="padding-right:5px;margin:0px;" class="header-social-icon hidden-xs hidden-sm"><a href="http://instagram.com/" target="_blank"><img data-u="image" src="<%=basePath %>images/icon/ig.png" height="37px"/></a></li>
			    	<li class="shopping-cart" style="padding-right:10px;margin:0px;">
			    		
			            <a href="#!" class="li-icon" style="width:30px;height:30px;line-height:33px;" <%if (cartMap!=null && !cartMap.isEmpty()){ %> data-toggle="dropdown" aria-haspopup="false" aria-expanded="false" <%} %> >
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
			                        <a href="<%=basePath %>productdetails?id=<%=orderItem.getPid()%>"><img src="<%=basePath %>images/products/<%=StringUtil.filter(orderItem.getProductimage()) %>" class="img-responsive product-img" alt=""></a>
			                        <div class="product-details">
			                            <p class="product-title clearfix"><a href="<%=basePath %>productdetails?id=<%=orderItem.getPid()%>"><%=StringUtil.filter(orderItem.getProductname()) %></a></p>
			                            <p class="product-price clearfix">Qty : <%=orderItem.getQuantity() %>
			                            <%if(!"".equals(StringUtil.filter(orderItem.getVariantname()))) { %>
			                            <p class="product-price clearfix">Variant : <%=StringUtil.filter(orderItem.getVariantname()) %></p>
			                            <%} %>
			                            <p class="product-price clearfix">Price : <%=StringUtil.formatFrontCurrencyPrice(orderItem.getPrice() - orderItem.getDiscount()) %>
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
			        <li style="padding:0px;margin:0px;"><a href="#!" class="li-icon" style="width:30px;height:30px;line-height:33px;" id="trigger-overlay"><i class="lil-search"></i></a></li>
			    </ul>
	        	<div id="navbar" class="navbar-collapse collapse"> <!-- header-topmenu -->
				    <ul class="nav navbar-nav navbar-left"> 
				         <!-- <li class="menu-parent-style" style="top:-3px;">
				            <a href="<%=basePath%>new" style="color:white;font-size:10pt;font-weight:900;">New </a>
				        </li> -->
				        
				        <%for(CategoryBean parent: parents) {
				        	
				        	List<CategoryBean> catTags = new ArrayList<CategoryBean>();
				        	
				        	if(parent.getId() == StaticValueUtil.CAT_MAKEUP){
				        %>
				        <li class="menu-parent-style" style="top:-3px;"> <!-- class="active" -->
				            <a href="javascript:menuOnClick()" id="cosmeticMenu" class="header-main-menu" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false"><%=StringUtil.filter(parent.getName()) %> <i class="resp-arrow-right-white"></i> </a>
				           	<div class="mega-dropdown1 dropdown-menu" style="top:60px;left:-185px;opacity:0.95;">				            	

				            	<%
				           		String sqlWhere = " where parentid = " + parent.getId() + " and tag = " + StaticValueUtil.TAG_FACE + " and status = " + StaticValueUtil.Active;
				           		List<CategoryBean> faceCat = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere);
				           		%>
				           		<ul class="mega-subcontent">
				           			<li class="hidden-xs subtagmenu-padding"><span style="font-weight:900;"><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_FACE)) %></span></li>
				           			<%	for(CategoryBean category : faceCat){ 	%>
				           			<li class="hidden-xs topmenu-subcat submenu-padding" ><span onClick="javascript:window.location.href='<%=basePath%>products?categoryid=<%=category.getId()%>'"><%=StringUtil.filter(category.getName()) %></span>  </li> <!-- class="active" -->
				                	<%} %>
				                
					                <!-- FOR MOBILE ONLY  -->
					                <li id="catContainer1" class="hidden-md hidden-lg hidden-sm text-center" style="padding-top:5px;padding-bottom:5px;">
					           			<button id="catBtn1" class="resp-dropdown-btn text-center " ><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_FACE)) %>
								          <i id="catArrow1" class="resp-arrow-right-black"></i>
								        </button> 
								        <div id="subcatContainer1" class="resp-dropdown-content">
									        <ul>
									        <%	for(CategoryBean category : faceCat){ 	%>
									        	<li class="topmenu-subcat" style="padding-top:5px !important; padding-bottom:5px !important;" ><span><%=StringUtil.filter(category.getName()) %></span>  </li>
									        <%} %>
									        </ul>
								      	</div>
								    </li>
				            	</ul>
				           		
				           		<%
				           		sqlWhere = " where parentid = " + parent.getId() + " and tag = " + StaticValueUtil.TAG_EYE + " and status = " + StaticValueUtil.Active;
				           		List<CategoryBean> eyeCat = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere);
				           		%>
				           		<ul class="mega-subcontent">
					           		<li class="hidden-xs subtagmenu-padding"><span style="font-weight:900;"><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_EYE)) %></span></li>
					           		<%	for(CategoryBean category : eyeCat){ 	%>
					           		<li class="hidden-xs topmenu-subcat submenu-padding" ><span onClick="javascript:window.location.href='<%=basePath%>products?categoryid=<%=category.getId()%>'"><%=StringUtil.filter(category.getName()) %></span>  </li> <!-- class="active" -->
					                <%} %>
				                
				                	<!-- FOR MOBILE ONLY  -->
					                <li id="catContainer2" class="hidden-md hidden-lg hidden-sm text-center" style="padding-top:5px;padding-bottom:5px;">
					           			<button id="catBtn2" class="resp-dropdown-btn text-center " ><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_EYE)) %>
								          <i id="catArrow2" class="resp-arrow-right-black"></i>
								        </button> 
								        <div id="subcatContainer2" class="resp-dropdown-content">
									        <ul>
									        <%	for(CategoryBean category : eyeCat){ 	%>
									        	<li class="topmenu-subcat" style="padding-top:5px !important; padding-bottom:5px !important;" ><span><%=StringUtil.filter(category.getName()) %></span>  </li>
									        <%} %>
									        </ul>
								      	</div>
								    </li>
				            	</ul>
				           		
				           		<%
				           		sqlWhere = " where parentid = " + parent.getId() + " and tag = " + StaticValueUtil.TAG_CHEEKS + " and status = " + StaticValueUtil.Active;
				           		List<CategoryBean> cheekCat = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere);
				           		%>
				           		<ul class="mega-subcontent">
					           		<li class="hidden-xs subtagmenu-padding"><span style="font-weight:900;"><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_CHEEKS)) %></span></li>
					           		<%	for(CategoryBean category : cheekCat){ 	%>
					                <li class="hidden-xs topmenu-subcat submenu-padding" ><span onClick="javascript:window.location.href='<%=basePath%>products?categoryid=<%=category.getId()%>'"><%=StringUtil.filter(category.getName()) %></span>  </li> <!-- class="active" -->
					                <%} %>
				                
				                	<!-- FOR MOBILE ONLY  -->
					                <li id="catContainer3" class="hidden-md hidden-lg hidden-sm text-center" style="padding-top:5px;padding-bottom:5px;">
					           			<button id="catBtn3" class="resp-dropdown-btn text-center " ><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_CHEEKS)) %>
								          <i id="catArrow3" class="resp-arrow-right-black"></i>
								        </button> 
								        <div id="subcatContainer3" class="resp-dropdown-content">
									        <ul>
									        <%	for(CategoryBean category : cheekCat){ 	%>
									        	<li class="topmenu-subcat" style="padding-top:5px !important; padding-bottom:5px !important;" ><span><%=StringUtil.filter(category.getName()) %></span>  </li>
									        <%} %>
									        </ul>
								      	</div>
								    </li>
				            	</ul>
				           		
				           		<%
				           		sqlWhere = " where parentid = " + parent.getId() + " and tag = " + StaticValueUtil.TAG_LIPS + " and status = " + StaticValueUtil.Active;
				           		List<CategoryBean> lipCat = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere);
				           		%>
				           		<ul class="mega-subcontent">
					           		<li class="hidden-xs subtagmenu-padding"><span style="font-weight:900;"><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_LIPS)) %></span></li>
					           		<%	for(CategoryBean category : lipCat){ 	%>
					                <li class="hidden-xs topmenu-subcat submenu-padding" ><span onClick="javascript:window.location.href='<%=basePath%>products?categoryid=<%=category.getId()%>'"><%=StringUtil.filter(category.getName()) %></span>  </li> <!-- class="active" -->
					                <%} %>
				                
				                	<!-- FOR MOBILE ONLY  -->
					                <li id="catContainer4" class="hidden-md hidden-lg hidden-sm text-center" style="padding-top:5px;padding-bottom:5px;">
					           			<button id="catBtn4" class="resp-dropdown-btn text-center " ><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_LIPS)) %>
								          <i id="catArrow4" class="resp-arrow-right-black"></i>
								        </button> 
								        <div id="subcatContainer4" class="resp-dropdown-content">
									        <ul>
									        <%	for(CategoryBean category : lipCat){ 	%>
									        	<li class="topmenu-subcat" style="padding-top:5px !important; padding-bottom:5px !important;" ><span><%=StringUtil.filter(category.getName()) %></span>  </li>
									        <%} %>
									        </ul>
								      	</div>
								    </li>
				            	</ul>
				           		
				           		<%
				           		sqlWhere = " where parentid = " + parent.getId() + " and tag = " + StaticValueUtil.TAG_TOOLS + " and status = " + StaticValueUtil.Active;
				           		List<CategoryBean> toolsCat = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere);
				           		%>
				           		<ul class="mega-subcontent">
					           		<li class="hidden-xs subtagmenu-padding"><span style="font-weight:900;"><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_TOOLS)) %></span></li>
					           		<%	for(CategoryBean category : toolsCat){ 	%>
					                <li class="hidden-xs topmenu-subcat submenu-padding" ><span onClick="javascript:window.location.href='<%=basePath%>products?categoryid=<%=category.getId()%>'"><%=StringUtil.filter(category.getName()) %></span>  </li> <!-- class="active" -->
					                <%} %>
				                
				                	<!-- FOR MOBILE ONLY  -->
					                <li id="catContainer5" class="hidden-md hidden-lg hidden-sm text-center" style="padding-top:5px;padding-bottom:5px;">
					           			<button id="catBtn5" class="resp-dropdown-btn text-center " ><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_TOOLS)) %>
								          <i id="catArrow5" class="resp-arrow-right-black"></i>
								        </button> 
								        <div id="subcatContainer5" class="resp-dropdown-content">
									        <ul>
									        <%	for(CategoryBean category : toolsCat){ 	%>
									        	<li class="topmenu-subcat" style="padding-top:5px !important; padding-bottom:5px !important;" ><span><%=StringUtil.filter(category.getName()) %></span>  </li>
									        <%} %>
									        </ul>
								      	</div>
								    </li>
				            	</ul>
				            	
				            	<%
				           		sqlWhere = " where parentid = " + parent.getId() + " and tag = " + StaticValueUtil.TAG_3D + " and status = " + StaticValueUtil.Active;
				           		List<CategoryBean> d3Cat = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere);
				           		%>
				           		<ul class="mega-subcontent">
					           		<li class="hidden-xs subtagmenu-padding"><span style="font-weight:900;"><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_3D)) %></span></li>
					           		<%	for(CategoryBean category : d3Cat){ 	%>
					                <li class="hidden-xs topmenu-subcat submenu-padding" ><span onClick="javascript:window.location.href='<%=basePath%>products?categoryid=<%=category.getId()%>'"><%=StringUtil.filter(category.getName()) %></span>  </li> <!-- class="active" -->
					                <%} %>
				                
				                	<!-- FOR MOBILE ONLY  -->
					                <li id="catContainer6" class="hidden-md hidden-lg hidden-sm text-center" style="padding-top:5px;padding-bottom:5px;">
					           			<button id="catBtn6" class="resp-dropdown-btn text-center " ><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_3D)) %>
								          <i id="catArrow6" class="resp-arrow-right-black"></i>
								        </button> 
								        <div id="subcatContainer6" class="resp-dropdown-content">
									        <ul>
									        <%	for(CategoryBean category : d3Cat){ 	%>
									        	<li class="topmenu-subcat" style="padding-top:5px !important; padding-bottom:5px !important;" ><span><%=StringUtil.filter(category.getName()) %></span>  </li>
									        <%} %>
									        </ul>
								      	</div>
								    </li>
				            	</ul>
				            	
				            	<%
				           		sqlWhere = " where parentid = " + parent.getId() + " and tag = " + StaticValueUtil.TAG_MAKEUPSETTING + " and status = " + StaticValueUtil.Active;
				           		List<CategoryBean> makeupCat = CategoryService.getInstance().getFrontMenuBySqlwhere(sqlWhere);
				           		%>
				           		<ul class="mega-subcontent">
					           		<li class="hidden-xs subtagmenu-padding"><span style="font-weight:900;"><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_MAKEUPSETTING)) %></span></li>
					           		<%	for(CategoryBean category : makeupCat){ 	%>
					                <li class="hidden-xs topmenu-subcat submenu-padding" ><span onClick="javascript:window.location.href='<%=basePath%>products?categoryid=<%=category.getId()%>'"><%=StringUtil.filter(category.getName()) %></span>  </li> <!-- class="active" -->
					                <%} %>
				                
				                	<!-- FOR MOBILE ONLY  -->
					                <li id="catContainer7" class="hidden-md hidden-lg hidden-sm text-center" style="padding-top:5px;padding-bottom:5px;">
					           			<button id="catBtn7" class="resp-dropdown-btn text-center " ><%=StringUtil.filter(CategoryTagPulldown.getText(StaticValueUtil.TAG_MAKEUPSETTING)) %>
								          <i id="catArrow7" class="resp-arrow-right-black"></i>
								        </button> 
								        <div id="subcatContainer7" class="resp-dropdown-content">
									        <ul>
									        <%	for(CategoryBean category : makeupCat){ 	%>
									        	<li class="topmenu-subcat" style="padding-top:5px !important; padding-bottom:5px !important;" ><span><%=StringUtil.filter(category.getName()) %></span>  </li>
									        <%} %>
									        </ul>
								      	</div>
								    </li>
				            	</ul>
				           	</div>
				        </li>
				        <%	
				        	}	
				        } 
				        %>
				        <li class="menu-parent-style" style="top:-3px;"><a href="<%=basePath %>cart/faqs.jsp" id="skinMenu" class="header-main-menu">SKIN CARE <i class="resp-arrow-right-white"></i></a></li>		       
				        <li class="menu-parent-style" style="top:-3px;"><a href="<%=basePath %>cart/faqs.jsp"id="shopMenu" class="header-main-menu">SHOP <i class="resp-arrow-right-white"></i></a></li>
				        <li class="menu-parent-style" style="top:-3px;">
				            <a href="#!" id="tutorialMenu" class="header-main-menu" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">TUTORIAL <i class="resp-arrow-right-white"></i></a>
				            <div class="mega-dropdown3 dropdown-menu" style="top:60px;left:-280px;opacity:0.95;">
				           		<ul class="mega-subcontent" style="width:220px;"> 
				           		<!-- style="padding-left:35px;padding-top:10px;padding-bottom:10px;"  -->
				           		<li class="topmenu-subcat submenu-padding" ><strong><span onClick="javascript:window.location.href='#'">UNBOXING</span></strong>  </li>
				           		<!--<li><a href="index.html">FEATURED OF THE MONTH</a></li> <!-- class="active" -->
				         		</ul>
				         		<ul class="mega-subcontent" style="width:140px;">
				         		<li class="topmenu-subcat submenu-padding" ><strong><span onClick="javascript:window.location.href='#'">TUTORIAL</span></strong>  </li>
				           		<!--<li><a href="index.html">VALUE BUNDLE</a></li> <!-- class="active" -->
				         		</ul>
				         		<ul class="mega-subcontent" style="width:150px;">
				         		<li class="topmenu-subcat submenu-padding" ><strong><span onClick="javascript:window.location.href='#'">TRENDING</span></strong>  </li>
				           		<!--<li><a href="index.html">OUR TOP 10</a></li> <!-- class="active" -->
				         		</ul>
				         		<ul class="mega-subcontent" style="width:150px;">
				         		<li class="topmenu-subcat submenu-padding" ><strong><span onClick="javascript:window.location.href='#'">EXPERIMENT</span></strong>  </li>
				           		<!--<li><a href="index.html">OUR TOP 10</a></li> <!-- class="active" -->
				         		</ul>
				           	</div>				            
				        </li>
				        <li class="menu-parent-style" style="top:-3px;"><a href="<%=basePath %>cart/faqs.jsp" id="faqMenu" class="header-main-menu">FAQ <i class="resp-arrow-right-white"></i></a></li>
				        <li class="menu-parent-style" style="top:-3px;"><a href="<%=basePath %>cart/faqs.jsp" id="storiesMenu" class="header-main-menu">STORIES <i class="resp-arrow-right-white"></i></a></li>
				    </ul>
			    </div><!--/.nav-collapse -->
	      	</div><!--/.container -->
	    </nav>
	</div><!-- /.nav-container -->

<script>

function menuOnClick(){
    /*$( "#cosmeticMenu" ).click(function() {
    	
	});
	$("#cosmeticMenu").css("background-color","green");*/
}

$(document).ready(function(){
	
    $("#catContainer1").css("border-style","solid");
    $("#catContainer1").css("border-width","1px 0 0 0");
    $("#catContainer2").css("border-style","solid");
    $("#catContainer2").css("border-width","1px 0 0 0");
    $("#catContainer3").css("border-style","solid");
    $("#catContainer3").css("border-width","1px 0 0 0");
    $("#catContainer4").css("border-style","solid");
    $("#catContainer4").css("border-width","1px 0 0 0");
    $("#catContainer5").css("border-style","solid");
    $("#catContainer5").css("border-width","1px 0 0 0");
    $("#catContainer6").css("border-style","solid");
    $("#catContainer6").css("border-width","1px 0 0 0");
    $("#catContainer7").css("border-style","solid");
    $("#catContainer7").css("border-width","1px 0 0 0");
    
	//RESPONSIVE HEADER MENU ARROW STYLE 
	$(".header-main-menu" )
	  .click(function(){
		  if(this.getAttribute("aria-expanded") === 'false'){
		  	$( this ).find( "i" ).removeClass("resp-arrow-right-white");
			$( this ).find( "i" ).removeClass("resp-arrow-right-black");
			$( this ).find( "i" ).removeClass("resp-arrow-bottom-white");
			$( this ).find( "i" ).addClass("resp-arrow-bottom-black");

		  }else{
			$( this ).find( "i" ).removeClass("resp-arrow-right-white");
			  $( this ).find( "i" ).addClass("resp-arrow-right-black");
			  $( this ).find( "i" ).removeClass("resp-arrow-bottom-white");
			  $( this ).find( "i" ).removeClass("resp-arrow-bottom-black"); 	
		  }
	  })
	  .mouseover(function() {
		  if(this.getAttribute("aria-expanded") === 'true'){
			  $( this ).find( "i" ).removeClass("resp-arrow-right-white");
			  $( this ).find( "i" ).removeClass("resp-arrow-right-black");
			  $( this ).find( "i" ).removeClass("resp-arrow-bottom-white");
			  $( this ).find( "i" ).addClass("resp-arrow-bottom-black");
		  }else{
			  $( this ).find( "i" ).removeClass("resp-arrow-right-white");
			  $( this ).find( "i" ).addClass("resp-arrow-right-black");
			  $( this ).find( "i" ).removeClass("resp-arrow-bottom-white");
			  $( this ).find( "i" ).removeClass("resp-arrow-bottom-black");
		  }

	  })
	  .mouseout(function() {
		  if(this.getAttribute("aria-expanded") === 'true'){
			  $( this ).find( "i" ).removeClass("resp-arrow-right-white");
			  $( this ).find( "i" ).removeClass("resp-arrow-right-black");
			  $( this ).find( "i" ).addClass("resp-arrow-bottom-white");
			  $( this ).find( "i" ).removeClass("resp-arrow-bottom-black");
		  }else{
			  $( this ).find( "i" ).addClass("resp-arrow-right-white");
			  $( this ).find( "i" ).removeClass("resp-arrow-right-black");
			  $( this ).find( "i" ).removeClass("resp-arrow-bottom-white");
			  $( this ).find( "i" ).removeClass("resp-arrow-bottom-black");
		  }
		  
	  });


	
	$("#catBtn1" ).click(function() {
		event.stopPropagation();
		var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	      $("#catArrow1").removeClass("resp-arrow-bottom-black");
	      $("#catArrow1").addClass("resp-arrow-right-black");
	    } else {
	      //SET THE BORDER STYLE 
	      dropdownContent.style.display = "block";
	      
	      $("#catArrow1").removeClass("resp-arrow-right-black");
	      $("#catArrow1").addClass("resp-arrow-bottom-black");
	      
	      //HIDE OTHERS SUBCAT 
	      $("#subcatContainer2").css("display","none");
	      $("#subcatContainer3").css("display","none");
	      $("#subcatContainer4").css("display","none");
	      $("#subcatContainer5").css("display","none");
	      $("#subcatContainer6").css("display","none");
	      $("#subcatContainer7").css("display","none");
	    }
	    
	});
	
	$( "#catBtn2" ).click(function() {
		event.stopPropagation();
		var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	      $("#catArrow2").removeClass("resp-arrow-bottom-black");
	      $("#catArrow2").addClass("resp-arrow-right-black");
	    } else {
		  //SET THE BORDER STYLE 
		  dropdownContent.style.display = "block";
	      
	      $("#catArrow2").removeClass("resp-arrow-right-black");
	      $("#catArrow2").addClass("resp-arrow-bottom-black");
		  
	      //HIDE OTHERS SUBCAT 
	      $("#subcatContainer1").css("display","none");
	      $("#subcatContainer3").css("display","none");
	      $("#subcatContainer4").css("display","none");
	      $("#subcatContainer5").css("display","none");
	      $("#subcatContainer6").css("display","none");
	      $("#subcatContainer7").css("display","none");
	    }
	});
	
	$( "#catBtn3" ).click(function() {
		event.stopPropagation();
		var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	      $("#catArrow3").removeClass("resp-arrow-bottom-black");
	      $("#catArrow3").addClass("resp-arrow-right-black");
	    } else {
	      dropdownContent.style.display = "block";
	      
	      $("#catArrow3").removeClass("resp-arrow-right-black");
	      $("#catArrow3").addClass("resp-arrow-bottom-black");
	      
	      //HIDE OTHERS SUBCAT 
	      $("#subcatContainer1").css("display","none");
	      $("#subcatContainer2").css("display","none");
	      $("#subcatContainer4").css("display","none");
	      $("#subcatContainer5").css("display","none");
	      $("#subcatContainer6").css("display","none");
	      $("#subcatContainer7").css("display","none");
	    }
	});
	
	$( "#catBtn4" ).click(function() {
		event.stopPropagation();
		var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	      $("#catArrow4").removeClass("resp-arrow-bottom-black");
	      $("#catArrow4").addClass("resp-arrow-right-black");
	    } else {
	      dropdownContent.style.display = "block";
	      
	      $("#catArrow4").removeClass("resp-arrow-right-black");
	      $("#catArrow4").addClass("resp-arrow-bottom-black");
	      
	      //HIDE OTHERS SUBCAT 
	      $("#subcatContainer1").css("display","none");
	      $("#subcatContainer2").css("display","none");
	      $("#subcatContainer3").css("display","none");
	      $("#subcatContainer5").css("display","none");
	      $("#subcatContainer6").css("display","none");
	      $("#subcatContainer7").css("display","none");
	    }
	});
	
	$( "#catBtn5" ).click(function() {
		event.stopPropagation();
		var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	      $("#catArrow5").removeClass("resp-arrow-bottom-black");
	      $("#catArrow5").addClass("resp-arrow-right-black");
	    } else {
	      dropdownContent.style.display = "block";
	      
	      $("#catArrow5").removeClass("resp-arrow-right-black");
	      $("#catArrow5").addClass("resp-arrow-bottom-black");
	      
	      //HIDE OTHERS SUBCAT 
	      $("#subcatContainer1").css("display","none");
	      $("#subcatContainer2").css("display","none");
	      $("#subcatContainer3").css("display","none");
	      $("#subcatContainer4").css("display","none");
	      $("#subcatContainer6").css("display","none");
	      $("#subcatContainer7").css("display","none");
	    }
	});
	
	$( "#catBtn6" ).click(function() {
		event.stopPropagation();
		var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	      $("#catArrow6").removeClass("resp-arrow-bottom-black");
	      $("#catArrow6").addClass("resp-arrow-right-black");
	    } else {
	      dropdownContent.style.display = "block";
	      
	      $("#catArrow6").removeClass("resp-arrow-right-black");
	      $("#catArrow6").addClass("resp-arrow-bottom-black");
	      
	      //HIDE OTHERS SUBCAT 
	      $("#subcatContainer1").css("display","none");
	      $("#subcatContainer2").css("display","none");
	      $("#subcatContainer3").css("display","none");
	      $("#subcatContainer4").css("display","none");
	      $("#subcatContainer5").css("display","none");
	      $("#subcatContainer7").css("display","none");
	    }
	});
	
	$( "#catBtn7" ).click(function() {
		event.stopPropagation();
		var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	      $("#catArrow7").removeClass("resp-arrow-bottom-black");
	      $("#catArrow7").addClass("resp-arrow-right-black");
	    } else {
	      dropdownContent.style.display = "block";
	      
	      $("#catArrow7").removeClass("resp-arrow-right-black");
	      $("#catArrow7").addClass("resp-arrow-bottom-black");
	      
	      //HIDE OTHERS SUBCAT 
	      $("#subcatContainer1").css("display","none");
	      $("#subcatContainer2").css("display","none");
	      $("#subcatContainer3").css("display","none");
	      $("#subcatContainer4").css("display","none");
	      $("#subcatContainer5").css("display","none");
	      $("#subcatContainer6").css("display","none");
	    }
	});
});

</script>