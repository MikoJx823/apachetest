<%@ page language="java" import="java.sql.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<%
	boolean isEng = I18nUtil.isEng(request);
	//String lang = I18nUtil.getLang(request);
	String lang = I18nUtil.getLangHtml(request).equals("en")?"E":"C";  
    PropertiesUtil propUtils = new PropertiesUtil();
    String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
    HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap) == null ? 
			new HashMap<String, OrderItemBean>() : (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap);

	String soldoutErrorMsg = StringUtil.filter((String)request.getAttribute("soldoutErrorMsg"));
	String soldoutErrorMsgC = StringUtil.filter((String)request.getAttribute("soldoutErrorMsgC"));
	
    OrderBean orderBean = (OrderBean) request.getSession().getAttribute("orderBean");
    List<OrderItemBean> orderItems = new ArrayList<OrderItemBean>();
	if (orderBean == null)
		orderBean = new OrderBean();
	
	/*if(cartMap == null || cartMap.isEmpty()) {
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_WEB);
		requestDispatcher.forward(request, response);
		return;
	}*/
	
	//START CHECK IF IS MEMBER 
	MemberBean member = (MemberBean)request.getSession().getAttribute(SessionName.loginMember);
    boolean isMember = false;
	if(member != null){
		if(member.getUserType() == StaticValueUtil.USER_MEMBER){
			isMember = true;
		}
	}
	//END CHECK IF IS MEMBER 
	
	//START CHECK IF IS CUMULATIVE DISCOUNT 
	
	boolean isCumulativeDiscount = ProductDiscountService.getInstance().isDiscountEnable(StaticValueUtil.DISPLAY_WEB);
	//boolean isCumulativeDiscount = ProductDiscountService.getInstance().isDiscountEnable();
	ProductDiscountBean productDiscount = ProductDiscountService.getInstance().getBeanById();
	if(!isMember){
		isCumulativeDiscount = false;
	}
	//END CHECK IF IS CUMULATIVE DISCOUNT 
	
%>

<!DOCTYPE html>
<html lang="<%=I18nUtil.getLangHtml(request) %>">
<head>
<jsp:include page="meta.jsp" />


</head>
<body>

<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/>

<jsp:include page="header.jsp" />

<section>
<div class="categorypg container">
   
  <div class="row">
<div class="col-xs-24 visible-xs visible-sm  mt-15">
<p class="text-center mb-15 text-primary"><b><fmt:message key="checkout.cart.summary"/></b></p>
<ul class=" step list-unstyled">
        <li class="active"><div></div></li>
        <li><div></div></li>
        <li><div></div></li>
        <li><div></div></li>
    </ul>
</div> 
<div class="col-xs-24"> <h1 class="text-primary"><fmt:message key="checkout.title"/></h1></div>
      <div class="col-xs-24 hidden-xs hidden-sm">
        <div class="wizard bg-white">
          <a class="finish current"><span class="badge">1</span><b><fmt:message key="checkout.cart.summary"/></b></a>
          <a><span class="badge">2</span><b><fmt:message key="checkout.delivery.information"/>            </b></a>
          <a><span class="badge">3</span><b><fmt:message key="checkout.progress.confirmation"/>  </b></a>
          <a><span class="badge">4</span><b><fmt:message key="checkout.progress.payment"/>  </b></a> 
 
          </div>
      </div>
    </div>    <div class="clearfix"></div>
    
    <div class="tbl checkoutTable">
    
    <div class="tbl-header hidden-xs">
    <div class="tbl-cell ch-img"><fmt:message key="checkout.product"/></div>
    <div class="tbl-cell ch-name"></div>
     <div class="tbl-cell ch-qty"><fmt:message key="checkout.quantity"/></div>
     <div class="tbl-cell ch-unit"> <fmt:message key="checkout.delivery"/></div>
    <div class="tbl-cell ch-unit"><fmt:message key="checkout.price"/></div>
    <div class="tbl-cell ch-sub"><fmt:message key="checkout.subtotal"/></div>
    </div> <!--head-->
    
    <div class="tbl-footer">
    
    <% 
       double totalAmount = 0;
       double deliveryAmount = 0;
       double deliveryFee = StringUtil.strToDouble(propUtils.getProperty("delivery.charges"));
       double ecoPoint = 0 ;
       double installAmount = 0;
       double discountP = 0;
   	   double discountE = 0;
       double promotionAmount = 0 ;
   	   
       if (cartMap!=null && !cartMap.isEmpty()){
 	   
 	   for(Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
 		   String key = entry.getKey();
 		   OrderItemBean orderItem = entry.getValue(); 
 		   orderItem.setOrderId(0);
 		   orderItems.add(orderItem);
 		   
 		   String prodName = "";
	   	   String collectionStr = "";
	   	   String priceStr = "";
	   	   String subTotalStr = "";
	   	   
	   	   String gaEEVariant = "";
	   	   String gaEEPrice = "";
	   	   int gaEEId = 0;
		   //totalAmount = totalAmount + orderItem.getProductPrice().getPrice() * orderItem.getQuantity();
		  
		   prodName = orderItem.getProdEname();
		   if(!isEng) prodName = orderItem.getProdCname();
		   
		
			   
			   if(orderItem.getCollectMethod() == StaticValueUtil.product_Delivery) {
				  deliveryAmount += orderItem.getQuantity() * orderItem.getPrice(); 
			   }else if(orderItem.getCollectMethod() == StaticValueUtil.product_Install){
				   installAmount += orderItem.getProductPrice().getInstallprice() * orderItem.getQuantity();
			   }
			   
			   ecoPoint += orderItem.getQuantity() * orderItem.getEcopoint();
			   totalAmount += orderItem.getQuantity() * orderItem.getPrice();
			  
			   collectionStr = CollectionProductTypePulldown.getTextByLanguage(orderItem.getCollectMethod(), lang); 
			   
			   if(orderItem.getCollectMethod() == StaticValueUtil.product_PickUp) {
				   if(isEng) collectionStr += " - " + StringUtil.filter(orderItem.getPickupBranch().getEname());
				   else collectionStr += " - " + StringUtil.filter(orderItem.getPickupBranch().getCname());
			   }
			   
			   gaEEPrice = StringUtil.formatIndexPrice2(orderItem.getPrice());
			   
			   if(orderItem.getEcoType() == StaticValueUtil.PRODUCT_ISECO){
				   priceStr = StringUtil.formatCurrencyPrice(orderItem.getPrice()) + " + " + 
			   				  StringUtil.formatIndexPrice(orderItem.getEcopoint()) + " " + I18nUtil.getString("product.select.ecopoint", lang);  
				   subTotalStr = StringUtil.formatCurrencyPrice(orderItem.getPrice() * orderItem.getQuantity()) + " + " + 
						   		 StringUtil.formatIndexPrice(orderItem.getEcopoint() * orderItem.getQuantity()) + " " + I18nUtil.getString("product.select.ecopoint", lang);   
			   		
				   gaEEVariant = StringUtil.formatIndexPrice2(orderItem.getEcopoint());
			   }else {
				   priceStr = StringUtil.formatCurrencyPrice(orderItem.getPrice());
				   discountP += orderItem.getQuantity() * orderItem.getDiscount();
				   subTotalStr = StringUtil.formatCurrencyPrice(orderItem.getPrice() * orderItem.getQuantity());
				   
				   gaEEPrice = StringUtil.formatIndexPrice2(orderItem.getPrice() - orderItem.getDiscount());
			   }
		
			   gaEEId = orderItem.getPid();
			   
 	   	   
		   //I18nUtil.getLangHtml(request).equals("en")?orderItem.getProduct().geteName():orderItem.getProduct().getcName();
 	%>
    <div class="tbl-row"> 
    <div class="tbl-cell ch-img"> <a><img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="GetImageFileServlet?&name=<%=StringUtil.filter(orderItem.getProductImage())%>" class="img-responsive"></a></div>
    <div class="tbl-cell ch-name"><b><%=StringUtil.filter(prodName) %></b></div>
    <div class="tbl-cell ch-qty small"><p class=" visible-xs-inline-block"><fmt:message key="checkout.quantity"/>: </p>
    								   <input type="tel" id="qty<%=key %>" name="qty<%=key %>" value="<%=orderItem.getQuantity()%>" onchange="javascript:changeQty('<%=key %>',<%=orderItem.getQuantity()%>, '<%=gaEEId%>', '<%=StringUtil.formatGAEEProductName(orderItem.getProdEname())%>','<%=gaEEPrice %>','<%=StringUtil.filter(orderItem.getMerchant().getEname()) %>', '<%=StringUtil.filter(orderItem.getCategory().geteName()) %>','<%=gaEEVariant %>')"> &nbsp;&nbsp; 
    								   <a onclick="javascript:removeSubmit('<%=key%>', <%=gaEEId%>,'<%=StringUtil.formatGAEEProductName(orderItem.getProdEname())%>', '<%=gaEEPrice %>','<%=StringUtil.filter(orderItem.getMerchant().getEname()) %>', '<%=StringUtil.filter(orderItem.getCategory().geteName()) %>','<%=gaEEVariant %>',<%=orderItem.getQuantity()%>);" class="remove" ><span class="fa fa-trash ft-30"><b class="sr-only"> Remove Item</b></span></a></div>
    <div class="tbl-cell ch-qty small"><p class=" visible-xs-inline-block"><fmt:message key="checkout.delivery"/>: </p><b class="item-detail"><%=collectionStr %></b></div> 
    <div class="tbl-cell ch-unit small"><p class=" visible-xs-inline-block"><fmt:message key="checkout.price"/>: </p><b class="item-detail"><%=priceStr %></b></div>
    <div class="tbl-cell ch-sub small"><p class=" visible-xs-inline-block"><fmt:message key="checkout.subtotal"/>: </p><b class="item-detail"><%=subTotalStr %></b></div> 
    </div> <!--tbl-row-->

    <%	}
 	   }%>
   </div>
  
</div>   
      <!--result tbl-->
      <div class=" result-tbl  col-md-12  col-sm-24 pull-right  col-sm-pull-0">
     <div class="tbl">
     
     
    <%if(discountE > 0) { %>
    	<div class="tbl-row">
	    <div class="tbl-cell ch-unit"><b><fmt:message key="checkout.discount.eco"/> </b></div>
	    <div class="tbl-cell ch-sub"><%=StringUtil.formatIndexPrice(discountE) %></div>
	    </div>
    <%} %>
    
    <%if(ecoPoint > 0 ) { %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="checkout.eco.deducted"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatIndexPrice(ecoPoint - discountE) %></div>
    </div>
    
    <div class="tbl-row">
	    <div class="tbl-cell ch-unit"><b><fmt:message key="checkout.eco.remaining"/></b></div>
	    <div class="tbl-cell ch-sub"><%=StringUtil.formatIndexPrice(StringUtil.strToDouble(member.getEcoCredit().getEP_Balance()) - ecoPoint + discountE) %></div>
	    </div>
    
    <%} %>
    
    <%/*if(deliveryAmount > 0 && deliveryAmount < StringUtil.strToDouble(propUtils.getProperty("delivery.limit")) ) {
    	//totalAmount += deliveryFee;
    %>
     <!--  <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="checkout.delivery.fee"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(deliveryFee)%></div>
    </div> -->
    <%}*/ %>
    
    <%/*if(installAmount > 0) { %>
    	 <!--<div class="tbl-row">
	    <div class="tbl-cell ch-unit"><b><fmt:message key="checkout.install.fee"/> </b></div>
	    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(installAmount) %></div>
	    </div>-->
    <%}*/ %>
    
    <%if(discountP > 0) { %>
    	 <div class="tbl-row">
	    <div class="tbl-cell ch-unit"><b><fmt:message key="checkout.discount.product"/> </b></div>
	    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(discountP) %></div>
	    </div>
    <%} %>

	<%if(isCumulativeDiscount) {
		
		
    	if(ProductDiscountService.getInstance().isDiscountEnable(productDiscount, orderItems, member)){
    		promotionAmount = productDiscount.getDiscountAmount();
    		String cumulativeName = StringUtil.filter(productDiscount.getEname());
    %>
    	<div class="tbl-row">
	    <div class="tbl-cell ch-unit"><b><fmt:message key="checkout.promotion.product"/></b></div>
	    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(promotionAmount) %></div>
	    </div>
    
    <%	}
     } %>
    
    <%if(totalAmount > 0) {
    %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="checkout.total"/> </b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(totalAmount + installAmount - promotionAmount - discountP) %> </div>
    </div>
  	<%} %>
 	

    </div>
    </div>
    
    <!--result--tbl-->
    <%if (cartMap!=null && !cartMap.isEmpty()){ %>
 	<form action="<%=basePath%>checkout?type=web" method="post" name="checkoutDetailsForm">
		<input type="hidden" name="actionType" value="checkLogin1"> 
     	<input type="hidden" name="type" value="web">
  		<div class="col-xs-24 text-right">
  			<a class="btn btn-success " href="javascript:checkoutDetailsSubmit();"><fmt:message key="checkout.button.checkout"/></a>
  		</div>
    
	</form>
	
	<div class="col-xs-24">
	<%if(isCumulativeDiscount){ 
    	String cumulativeDiscountNote = (I18nUtil.getString("checkout.cumulative.1", lang)).
    			replace("#discount#", StringUtil.formatCurrencyPrice(productDiscount.getDiscountAmount())).
    			replace("#total#", StringUtil.formatCurrencyPrice(productDiscount.getCumulativeAmount())) ;
    %>
    	<h5><%=StringUtil.filter(cumulativeDiscountNote) %></h5>
    <%} %>
	</div>
	<%}else { %>
		<div class="col-xs-24 text-right">
  			<a class="btn btn-success " href="<%=basePath%>index.jsp?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB%>"><fmt:message key="checkout.back"/></a>
  		</div>
	<%} %>
      
	</div><!--category pg ended-->   
     
    
</section>


<jsp:include page="footer.jsp" />

<script type="text/javascript">
$( document ).ready(function() {
	
	if('<%=soldoutErrorMsg %>' != '') {
		if(<%=isEng%>){
			alert('<%=soldoutErrorMsg%>');
		}
	}
	
	if('<%=soldoutErrorMsgC%>' != '') {
		if(!<%=isEng%>){
			alert('<%=soldoutErrorMsgC%>');
		}
	}
	
	if(<%=cartMap.isEmpty()%>){
		alert('<fmt:message key="error.checkout.empty.cart"/>');
	}
	
});


function MM_findObj(n, d) { //v4.0
	
	var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	  d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && document.getElementById) x=document.getElementById(n); return x;
}



function addCartSubmit()
{		
	MM_findObj("addCartForm").submit();	
}

function removeCartSubmit()
{		
	MM_findObj("removeCartForm").submit();	
}

function changeQty(cartId, oldqty, id, name, price, brand, category, variant) {
	var reg = new RegExp("^[0-9]*$");  
    var obj = document.getElementById("qty"+cartId); 
    

    if(!reg.test(obj.value)){ 
    	alert("<fmt:message key="checkout.alert.validQuantity"/>");
    	$("#qty" + cartId).val(oldqty);
	}else{
		if(obj.value<1){
			alert("<fmt:message key="checkout.alert.validQuantity"/>");
			$("#qty" + cartId).val(oldqty);
		}else{
			
			//FOR GA EE 
			if(obj.value > oldqty){
				
				gaEEAddToCart(name, id, price, brand, category, (obj.value - oldqty), variant);
				
				/*dataLayer.push({
					  'event': 'addToCart',
					  'ecommerce': {
					    //'currencyCode': 'EUR',
					    'add': {
					      'products': [{
					        'name': name ,
					        'id': id,
					        'price': price,
					        'brand': brand,
					        'category': category,
					        'variant': variant,
					        'quantity': (obj.value - oldqty)
					       }]
					    }
					}
				});*/
			}else {
				gaEERemoveFromCart(name, id, price, brand, category, (oldqty - obj.value), variant);
				
				/*dataLayer.push({
					  'event': 'removeFromCart',
					  'ecommerce': {
					    'remove': {
					      'products': [{
					          'name': name,
					          'id': id,
					          'price': price,
					          'brand': brand,
					          'category': category,
					          'variant': variant,
					          'quantity': (oldqty - obj.value)
					      }]
					   }
					}
				});*/
			}
			
			
			var form = document.createElement("form");
			var element1 = document.createElement("input"); 
			var element2 = document.createElement("input");
			var element3 = document.createElement("input");
			var element4 = document.createElement("input");
			    
			form.method = "POST";
			form.action = "<%=basePath%>checkout";   

			element1.value=cartId;
			element1.name="cartId";
			    element1.className="hidden";
			    form.appendChild(element1);  
			    
			    element2.value=obj.value;
			    element2.name="qty"+cartId
			    element2.className="hidden";
			    form.appendChild(element2);
			    
			    element3.value="changeQty";
			    element3.name="actionType";
			    element3.className="hidden";
			    form.appendChild(element3);
				
			    element4.value="web";
			    element4.name="type";
			    element4.className="hidden";
			    form.appendChild(element4);
			    
			    document.body.appendChild(form);

			    form.submit();
			    
		}
		
	}
}
function removeSubmit(cartId,id, name, price, brand, category,variant, quantity){
	
	/*dataLayer.push({
		  'event': 'removeFromCart',
		  'ecommerce': {
		    'remove': {                               // 'remove' actionFieldObject measures.
		      'products': [{                          //  removing a product to a shopping cart.
		          'name': name,
		          'id': id,
		          'price': price,
		          'brand': brand,
		          'category': category,
		          'variant': variant,
		          'quantity': quantity
		      }]
		    }
		}
	});*/
	
	gaEERemoveFromCart(name, id, price, brand, category, quantity, variant);
	
	
	var form = document.createElement("form");
	var element1 = document.createElement("input"); 
	var element2 = document.createElement("input");
	var element3 = document.createElement("input");  
	var element4 = document.createElement("input");
	    
	form.method = "POST";
	form.action = "<%=basePath%>checkout";   

	element1.value=cartId;
	element1.name="cartId";
	element1.className="hidden";
	form.appendChild(element1);  

	element2.value=id;
	element2.name="id";
	element2.className="hidden";
	form.appendChild(element2);
	    
	element3.value="removeCart";
	element3.name="actionType";
	element3.className="hidden";
	form.appendChild(element3);
		
	element4.value="web";
	element4.name="type";
	element4.className="hidden";
	form.appendChild(element4);
	    
	document.body.appendChild(form);

	form.submit();
}

function checkoutDetailsSubmit(){	
	
	var step = '3';
	
	if(!<%=isMember%>) {
		step = '2';
	}
		
	dataLayer.push({
		'event': 'checkout',
			'ecommerce': {
		      'checkout': {
		        'actionField': {'step': step}
		     }
		   },
			'eventCallback': function() {
			   MM_findObj("checkoutDetailsForm").submit();	
		   }
	});
}

</script>
<script type="text/javascript" src="<%=basePath %>js/gaee.js" ></script>
<%
request.getSession().removeAttribute(SessionName.orderCart);
%>
</body>
</html>


