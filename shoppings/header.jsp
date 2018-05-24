<%@ page language="java" import="java.util.Calendar,java.util.*,java.text.*,com.project.bean.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%	

response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
response.setContentType("text/html;charset=utf-8");
response.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

	boolean isEng = I18nUtil.isEng(request);
	String lang = I18nUtil.getLangHtml(request).equals("en")?"E":"C";
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	String gaEECartList = "";
	
    ProductBean product = (ProductBean)session.getAttribute("product");
 
    OrderBean orderBean = (OrderBean) request.getSession().getAttribute("orderBean");
	if (orderBean == null) orderBean = new OrderBean();
	
	List<OrderItemBean> orderItems = (List<OrderItemBean>) request.getSession().getAttribute("orderItems");
	
	if (orderItems == null) orderItems = orderBean.getOrderItems();
	
	HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap);

	int cartMapSize = 0;
	if (cartMap!=null && !cartMap.isEmpty()){
	 	for (Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
	  		cartMapSize++;
	  		String key = entry.getKey();
	  		OrderItemBean orderItem = entry.getValue();
	  		
	  		/*int id = orderItem.getPid() == 0 ? orderItem.getEcorewardid() : orderItem.getPid() ;
	  		double price = 0;
	  		String variant = "";
	  		
	  		if(orderItem.getEcorewardid() > 0) {
	  			price = orderItem.getEcopoint();
	  			
	  			if(orderItem.getDiscount() > 0) {
	  				price = orderItem.getEcopoint() - orderItem.getDiscount();
	  			}
	  		}else {
	  			price = orderItem.getPrice();	
	  			
	  			if(orderItem.getEcopoint() > 0) {
	  				variant = StringUtil.formatEcoPoints(orderItem.getEcopoint());
	  			}else if(orderItem.getDiscount() > 0){
	  				price = orderItem.getPrice() - orderItem.getDiscount();
	  			}
	  		}

	  		gaEECartList += "{'name': '" + orderItem.getProdEname() + "'," +
	  		          		"'id': " + id + "," +
	  		          		"'price': " + price + "," +
	  		          		"'brand': '" + StringUtil.filter(orderItem.getMerchant().getEname()) + "'," +
	  		          		"'category': '" + StringUtil.filter(orderItem.getCategory().geteName()) + "'," +
	  		          		"'variant': '" + variant + "'," +
	  		          		"'quantity': " + orderItem.getQuantity() + "},";*/
	  		gaEECartList += StringUtil.getGAEECheckoutDetail(orderItem);
		}
	 	
	 	if(gaEECartList.endsWith(",")) gaEECartList = gaEECartList.substring(0, gaEECartList.length() - 1);
	 	gaEECartList = ",'products': [" + gaEECartList + "]";
	}
	
 	gaEECartList = "'actionField': {'step':'1'}" + gaEECartList;
	
	/*String cartLink = "#"; 
	if(cartMapSize > 0 ){
		cartLink = basePath + "checkout?actionType=checkout&type=" + StaticValueUtil.LOGIN_SOURCE_WEB ;
	}*/
	String cartLink = basePath + "checkout?actionType=checkout&type=" + StaticValueUtil.LOGIN_SOURCE_WEB ;
	
	 
	String geturl = request.getRequestURI();
	
	String isindex = "";
	//isindex = "yes";
	if(geturl.contains("index.jsp")||geturl.contains("Index.jsp") || geturl.contains("productList.jsp") || geturl.contains("productInfo.jsp") || geturl.endsWith(PropertiesUtil.getProperty("virtualHost"))){
			isindex = "yes";
	}else{
			isindex = "no";
	}
	
	boolean isCheckout = false;
	if(geturl.contains("checkout")){
		isCheckout = true;
	}
	
	List<CategoryBean> catEA = CategoryService.getInstance().getFrontBeanListBySqlwhere("where status = " + StaticValueUtil.Active + " and parentid = " + StaticValueUtil.CAT_ELECTRICAL);
	List<CategoryBean> catSD = CategoryService.getInstance().getFrontBeanListBySqlwhere("where status = " + StaticValueUtil.Active + " and parentid = " + StaticValueUtil.CAT_SMART);
	List<CategoryBean> catECO = CategoryService.getInstance().getFrontBeanListBySqlwhere("where status = " + StaticValueUtil.Active + " and parentid = " + StaticValueUtil.CAT_ECO);
	String sqlWhereParent = "where status =" + StaticValueUtil.Active + " and isparent = " + StaticValueUtil.PRODUCT_ENABLE + " order by seq desc";
   	List<CategoryBean> parentCat = CategoryService.getInstance().getFrontBeanListBySqlwhere(sqlWhereParent);
    
    MemberBean member = (MemberBean)request.getSession().getAttribute(SessionName.loginMember);
    boolean isMember = false;
	if(member != null){
		if(member.getUserType() == StaticValueUtil.USER_MEMBER){
			isMember = true;
		}
			
	}
	
	String deepLink = StringUtil.filter((String)request.getAttribute("deeplink"));
	
	String servletUrl = StringUtil.filter((String) request.getAttribute(SessionName.servletUrl),"index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_WEB);
	
	if(servletUrl.contains("?")) {
		servletUrl += "&" ;
	}else {
		servletUrl += "?";
	}
%>


<script type="text/javascript">



function MM_findObj(n, d) { //v4.0

	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function removeCartSubmit(cartId){		
	MM_findObj("removeCartForm-" + cartId).submit();	
}
 
function checkoutSubmit(){		
	var form = document.createElement("form");
	var element1 = document.createElement("input"); 
	
	form.method = "POST";
	form.action = "checkout";   
	
	element1.value="checkout";
	element1.name="actionType";
	form.appendChild(element1);
	
	document.body.appendChild(form);
	
	form.submit();
}

function onChangeLang(lang){
    /*var d = new Date();
    d.setTime(d.getTime() + (181*24*60*60*1000));
    var expires = 'expires='+ d.toUTCString();
    
  	//START PERFORM REMOVE COOKIE 
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++)
    {   
        var name =  cookies[i].split("=");
        var expires2 = ';expires=Thu, 18 Dec 2013 12:00:00 UTC';
        var value= '';
        
        console.log("name : " + name);
        console.log("name2 : " + name[0])
        document.cookie = name[0] + '=' + expires2 + '; path=/';  
    }
  	//END PERFORM REMOVE COOKIE 
    
    document.cookie = '<%=SessionName.cookieLang%>=' + lang + ';' + expires + ';path=/'; 
    
   // document.cookie = '<%=SessionName.cookieLang%>' + "=" + lang + ";expires=Thu, 18 Dec 2013 12:00:00 UTC;path=/";
	window.location.href="<%=basePath %><%=servletUrl %>lang=" + lang; */
	
	 var form = document.createElement("form");
	 var element1 = document.createElement("input"); 
	 var element2 = document.createElement("input");
	 var element3 = document.createElement("input");
	 
	 form.method = "POST";
	 form.action = "<%=basePath%>changelang";   
	 
	 element1.value=lang;
	 element1.name="lang";
	 element1.className="hidden";
	 form.appendChild(element1);  

	 element2.value="<%=servletUrl %>lang=" + lang;
	 element2.name="returnUrl";
	 element2.className="hidden";
	 form.appendChild(element2);
	 
	 element3.value="changeLang";
	 element3.name="actionType";
	 element3.className="hidden";
	 form.appendChild(element3);
	    
	 document.body.appendChild(form);
	 form.submit();
	
}

function onCheckout(){
	<%=StringUtil.getGAEEFullConfig(gaEECartList, StaticValueUtil.GAEE_CHECKOUT, "window.location='" + cartLink+ "'")%>	
}

function gaSubmit(platform,num){
	var searchKey = $("#searchKey" + num +"-" + platform ).val().trim();//document.getElementById(platform + "-searchKey") 
	
	if(searchKey != ''){
		dataLayer.push({
		    'event':'searchSubmit',
		    'searchKey': searchKey,
		    'searchCategory': platform
		});
	}
}

</script>
<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/>

<header id="top">
<nav class="navbar-inverse collapse navbar-collapse">
  <div class="container">
    <div class="col-xs-24">
      <ul class="nav navbar-nav navbar-right hidden-xs">
      
      	
       <li>
           <a type="button" data-toggle="dropdown"><span class="icon"><img src="<%=basePath%>images_web/icon/iconSet_search.svg" class="img-responsive"></span> <fmt:message key="header.search.title"/></a>
           
           <ul class="dropdown-menu">
           	
             <li>
             	<form action="<%=basePath %>search" name="addCartForm" method="post">
 			 	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">
           		<div class="input-group pd-10">
			      <input type="text" class="form-control" name="key" id="searchKey1-<%=StaticValueUtil.LOGIN_SOURCE_WEB%>" placeholder="<fmt:message key="header.search.placeholder"/> ">
			      <span class="input-group-btn">
			        <!--  <button class="btn btn-success" type="button"><span class="fa fa-search"></span><span class="sr-only">Search</span></button>-->
			      	<input class="btn btn-success" type="submit" onclick="gaSubmit('<%=StaticValueUtil.LOGIN_SOURCE_WEB%>',1)" value="<fmt:message key="header.search.submit"/>"><span class="fa fa-search"></span><span class="sr-only"></span>
			      </span>
			    </div><!-- /input-group -->
			    </form>
             </li>
              
            </ul><!--drop down ended-->
          </li>
          
          
          
           <li>
           <%if(isMember){ %>
           <a href="<%=basePath%>history?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>"><span class="icon"><img src="<%=basePath%>images_web/icon/iconSet_history.svg" class="img-responsive"></span> 
           <fmt:message key="header.history.title"/></a>
           <%}else{ %>
	   <a href="<%=basePath%>guestOrderSearch?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>"><span class="icon"><img src="<%=basePath%>images_web/icon/iconSet_history.svg" class="img-responsive"></span><fmt:message key="header.history.title"/></a>          
	   <%}%>
           </li>

           <li>
           <%if(isMember){ 
		if(member.getAccount() != null){
           		if(StringUtil.isEcoNotAllowAccount(StringUtil.filter(member.getAccount().getRateCategory()))) {
           %>
           <a href="<%=basePath%>redeem?actionType=getRedeemList&type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>" ><span class="icon"><img src="<%=basePath%>images_web/icon/iconSet_coupon.svg" class="img-responsive"></span> <fmt:message key="header.redeem.title"/></a>
           <%		}
		    }
           	} %>
           </li>
          
           <li> <!-- <%//cartLink%> -->
           <a href="javascript:onCheckout()"><span class="icon"><img src="<%=basePath%>images_web/icon/iconSet_cart.svg" class="img-responsive"></span><fmt:message key="header.point.cart"/><%if(cartMapSize > 0 ) {%> <span class="badge"><%=cartMapSize%></span> <%} %> </a>
           </li>
      
       	   <li>
       	   <%if(isMember){ %>
       	   <a href="<%=basePath %>logout" ><span class="icon">
           <img src="<%=basePath%>images_web/icon/iconSet_user.svg" class="img-responsive"></span> <fmt:message key="member.logout"/>
           </a>
       	   
       	   <%}else{ %>
           <a type="button" data-toggle="dropdown"><span class="icon">
           <img src="<%=basePath%>images_web/icon/iconSet_user.svg" class="img-responsive"></span> <fmt:message key="login.member"/>
           </a>
            
 			<ul class="dropdown-menu">
             <li class=" pd-20">
                   <div class="row">
                   	<form action="<%=basePath %>login" name="loginForm" method="post">
					<input type="hidden" name="actionType" value="login">
                   	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">
                    <div class="col-xs-24"> 
                    <ul class="nav nav-tabs logintab">
                    <li class="active"><a href="#"><fmt:message key="login.member"/></a></li>
                    <li><a href="https://services.clp.com.hk/<fmt:message key="header.ln"/>/login/registration.aspx"><fmt:message key="login.register"/></a></li>
  					</ul>
                    
                  		<h4 class="text-primary">  <fmt:message key="login.member"/></h4>
                        <div class="group">      
                          <input type="text" name="loginId" required autocomplete="new-password">
                          <span class="highlight"></span>
                          <span class="bar"></span>
                          <label><fmt:message key="login.name"/></label>
                        </div>
                     
	                     <div class="group">      
	                      <input type="password" name="password" required autocomplete="new-password">
	                      <span class="highlight"></span>
	                      <span class="bar"></span>
	                      <label><fmt:message key="login.password"/></label>
	                    </div>
                 
	                    </div><!--col-xs-24-->
	                    <div class="col-xs-24 pt-10"> 
	                    <input type="submit" class="btn btn-lg btn-success btn-block" value="<fmt:message key="login.member"/>"> <br>
	                    
	                    <a href="https://services.clp.com.hk/<%=isEng == true?"en":"zh"%>/login/registration.aspx?_ga=2.173943075.1064939436.1508400737-771624725.1508400737"><u><fmt:message key="login.register.account"/></u></a><br>
	                    <a href="https://www1.clpgroup.com/clponline/<%=isEng == true?"en":"tc"%>/forgotPassword/entry.do"><u><fmt:message key="login.forgot.pass"/></u></a> 
	                    
	                    </div>
	                    
                    </form>
                </div><!--row-->
             </li>
            </ul><!--drop down ended-->
           
           <%} %>
          </li>
        
        <li>
          <div class="navbar-btn navbar-text">
			
			<%if(!isCheckout){ %>
			
	        	<% if (!isEng) { %>
	        		<a class="navbar-link active" href="javascript:onChangeLang('<%=I18nUtil.Lang_EN%>')">English</a>
	        	<% } else { %>
	        		<a class="navbar-link active" href="javascript:onChangeLang('<%=I18nUtil.Lang_TC%>')">中文</a>
	        	<% } %>   
        	<%} %>
        	
   		  </div>
        </li>
      </ul>
    </div>
    
   
  </div>
  </nav>
  <!-- /.container-fluid -->
  
  <nav>
    <div class="container"> 
       <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">  
    
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#defaultNavbar1">
      <div> <em></em> <em></em> <em></em> </div>
      <span class="sr-only">Toggle navigation</span> </button>
      
     <a class="brand-icon" href="https://www.clp.com.hk/<fmt:message key="header.ln"/>"  target="_blank">
     <img src="<%=basePath%>images_web/clp-logo-<fmt:message key="header.ln"/>.png" class="img-responsive">
</a>

	
     
     <a class="cart-menu" href="javascript:onCheckout()"> <!-- <%//cartLink%> -->
     <img src="<%=basePath%>images_web/icon/iconSet_blueCart.svg"> 
	 <%if(cartMapSize > 0 ) {%> <span class="badge"><%=cartMapSize%></span> <%} %>
     </a>
     
    </div>
      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse navbar-right catMenu" id="mainMenu">
        <ul class="nav navbar-nav">
        
         <%for(CategoryBean parent: parentCat) { 
        
        	if(parent.getParentidentifier() == StaticValueUtil.CAT_HOT){
        		String path = StringUtil.filter(parent.getDeeplinkpathweb());
        		if("".equals(path)) path = "#";
        		else path = basePath + path + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
        %>
        	<li class="dropdown">
        		<a href="<%=path%>"><%=StringUtil.filter(isEng != true ? parent.getcName() : parent.geteName()) %></a>
			</li>
        	
        <%
        	}else /*if (parent.getParentidentifier() == StaticValueUtil.CAT_SMART || parent.getParentidentifier() == StaticValueUtil.CAT_ELECTRICAL || 
        				parent.getParentidentifier() == StaticValueUtil.CAT_ECO)*/ {
       			
        		String defpath = StringUtil.filter(parent.getDeeplinkpathweb());
        		if("".equals(defpath)) defpath = "#";
        		else defpath = basePath + defpath + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB; 
				
        		String sqlWhere = "where status = " + StaticValueUtil.Active + " and parentid = " + parent.getParentidentifier() + " order by seq DESC, eName"; 
				List<CategoryBean> subcats = CategoryService.getInstance().getFrontBeanListBySqlwhere(sqlWhere);
        %>
        		
        		<li class="dropdown">
           			<a class="dropdown-toggle" href="<%=defpath %>"><%=StringUtil.filter(isEng != true ? parent.getcName() : parent.geteName()) %></a>
           
               		<ul class="dropdown-menu" role="menu">
                  	<li> 
	                  <a href="<%=defpath %>">
	                      <div class="media">
	                        <div class="media-left"> <img src="<%=basePath%>GetImageFileServlet?&name=<%=StringUtil.filter(parent.getImage1()) %>" class="media-object"></div>
	                        <div class="media-body media-middle"><p><b><fmt:message key="category.all"/></b></p></div>
	                        <div class="media-right media-middle"><em class="fa fa-chevron-right text-primary"></em></div>
	                      </div>
	                  </a>
	              	</li>
              
              <%for(CategoryBean category : subcats){ 
            	  	
            	  String subPath = StringUtil.filter(parent.getDeeplinkpathweb());
            	  if("".equals(subPath)) subPath = "#";
            	  else subPath = basePath + subPath + "&parentId=" + parent.getParentidentifier() + "&categoryId=" + category.getId() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
            	  
              %>	
	            	<li> 
	                	<a href="<%=StringUtil.filter(subPath)%>">
	                      <div class="media">
	                        <div class="media-left"> <img src="<%=basePath %>GetImageFileServlet?&name=<%=StringUtil.filter(category.getImage1()) %>"  class="media-object" > </div>
	                        <div class="media-body media-middle">
	                          <p><b><%=StringUtil.filter(isEng != true ? category.getcName() : category.geteName()) %></b></p>
	                        </div>
	                        <div class="media-right media-middle"><em class="fa fa-chevron-right text-primary"></em></div>
	                      </div>
	                	</a>
	            	</li>
              <%} %>
                	</ul><!--drop down end-->
           		</li><!--electrical Appliances-->
        <%
        	}	
         }
        %>
        </ul>
        
        <p class="navbar-text visible-xs"> 
        	<small>
			
			<%if(!isCheckout){ %>
	        	<% if (!isEng) { %>
	        		 <a class="navbar-link active" href="javascript:onChangeLang('<%=I18nUtil.Lang_EN%>')">English</a>
	        	<% } else { %>
	        		 <a class="navbar-link active" href="javascript:onChangeLang('<%=I18nUtil.Lang_TC%>')">中文</a>
	        	<% } %>   
			<%} %>
        	</small>
        </p>
      </div><!-- /.navbar-collapse --> 
    </div><!-- /.container-fluid --> 
  </nav>
  
  <%if(isMember) {
	if(member.getEcoCredit() != null) { 
		String name = "";

		if(!isEng) {
			name = StringUtil.filter(member.getAccount().getChineseName());
		}
		if(StringUtil.filter(name).equals("")) {
			name = StringUtil.filter(member.getAccount().getEnglishName());
		}
		
	%>
		<div class="scroll">
  	<div class="container">
	<div class="row">
    <div class="col-sm-12"><fmt:message key="member.welcome"/>, <strong><%=name %></strong></div>
    <div class="col-sm-12 scrollDetail">
    
    <%if(StringUtil.isEcoNotAllowAccount(StringUtil.filter(member.getAccount().getRateCategory()))) { %>
    <strong><fmt:message key="header.point.title"/> <%=StringUtil.formatIndexPrice(StringUtil.strToDouble(member.getEcoCredit().getEP_Balance())) %> <fmt:message key="header.point.eco.apps"/> </strong> 
	    <%if((StringUtil.strToInt(member.getEcoCredit().getEP_Balance()) > 0 ) ) { %>
	    <small>(<fmt:message key="header.point.expired"/> : <%=DateUtil.formatAPIDate(member.getEcoCredit().getExpiryDatetime()) %>)</small>
	    <%} %>
	 <%} %>   
	    
    </div>
	</div><!--row-->
    </div><!--container-->
  </div><!--scroll ended-->

<%  }
}	%>
  
  
  
  
  
  
  
   <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="navbar-collapse collapsed-desktop" id="navBar">
      <div class="container-fluid">
        <ul class="nav">
        <%
        	for(CategoryBean parent: parentCat) { 

        		if(parent.getParentidentifier() == StaticValueUtil.CAT_HOT){
        			String path = StringUtil.filter(parent.getDeeplinkpathweb());
            		if("".equals(path)) path = "#";
            		else path = basePath + path + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
        %>
        			<li><a href="<%=path%>"><%=StringUtil.filter(isEng != true ? parent.getcName() : parent.geteName())%></a></li>
        <%		}else {
		        	String path = StringUtil.filter(parent.getDeeplinkpathapp());
		    		if("".equals(path)) path = "#";
		    		else path = basePath + path + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
        %>
        			<li><a href="<%=path%>"><%=StringUtil.filter(isEng != true ? parent.getcName() : parent.geteName())%></a></li>
        <%		}
        	}
        %>
        </ul>
        
   
        
        <ul class="nav navbar-nav collapsed-desktop">
         <li>
         <%if(isMember){ %>
         	<a href="<%=basePath %>logout" ><fmt:message key="member.logout"/> </a>
         <%}else{ %>
         	<a href="<%=basePath %>shoppings/login.jsp"><fmt:message key="login.member"/> </a>
         <%} %>
         </li>
         <%if(isMember){ %>
          <li><a href="<%=basePath%>history?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>"><fmt:message key="header.history.title"/></a></li>
          <%if(StringUtil.isEcoNotAllowAccount(StringUtil.filter(member.getAccount().getRateCategory()))) { %>
          <li><a  href="<%=basePath%>redeem?actionType=getRedeemList&type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>"><fmt:message key="header.redeem.title"/></a></li>
          <%} %>
         <%}else{ %>
          <li><a href="<%=basePath%>guestOrderSearch?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>"><span class="icon"></span><fmt:message key="header.history.title"/></a></li>          
	 <%}%>
          <li>

          <%if(!isCheckout){ %>
	          <% if (!isEng) { %>
	        		<a class="navbar-link active" href="javascript:onChangeLang('<%=I18nUtil.Lang_EN%>')">English</a>
	        		
	        	<% } else { %>
	        		<a class="navbar-link active" href="javascript:onChangeLang('<%=I18nUtil.Lang_TC%>')">中文</a>
	        	<% } %>  
          <%} %>
          
          </li>
        
        </ul>
        	<form action="<%=basePath %>search" name="addCartForm" method="post">
        	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">
            <div class="input-group pd-10">
		      <input type="text" class="form-control" name="key" id="searchKey2-<%=StaticValueUtil.LOGIN_SOURCE_WEB%>" placeholder="<fmt:message key="header.search.placeholder"/> ">
		      <span class="input-group-btn">
        		<!-- <button class="btn btn-success" type="button"><span class="fa fa-search"></span><span class="sr-only">Search</span></button> -->
        		<input class="btn btn-success" type="submit" onclick="gaSubmit('<%=StaticValueUtil.LOGIN_SOURCE_WEB%>',2)" value="<fmt:message key="header.search.submit"/>"><span class="fa fa-search"></span><span class="sr-only"><fmt:message key="header.search.title"/></span>
      		  </span>
    		</div>
    		</form>
      </div>
      <!-- /.container-fluid --> 
      
    </div>
    <!-- /.navbar-collapse --> 
  
  
  
</header>


<!--header-->







