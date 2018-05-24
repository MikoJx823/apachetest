<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
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
	String lang = I18nUtil.getLang(request);
	PropertiesUtil propUtil = new PropertiesUtil();
	
	String errorMsg = StringUtil.filter((String) request.getAttribute(SessionName.errorMsg));
	String errorMsgC = StringUtil.filter((String) request.getAttribute(SessionName.errorMsgC));
	String parentId = StringUtil.filter((String)request.getAttribute("parentId"));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	ProductBean product = (ProductBean)request.getSession().getAttribute("product") == null ? new ProductBean() : (ProductBean)request.getSession().getAttribute("product");
	
	if(product == null) {
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_WEB);
	}
	
	int availableQty = ProductService.getInstance().getProductAvailableQuantity(product.getProductQty().get(0).getPqid());
    
	int catId = product.getCategoryid();
	
	MerchantBean merchant = MerchantService.getInstance().getFrontBeanById(product.getMerchantCode());
	CategoryBean category = CategoryService.getInstance().getFrontBeanById(catId);
	CategoryBean parentCat = CategoryService.getInstance().getParentCat(category.getParentId());
	
	if(merchant == null) merchant = new MerchantBean();
	if(category == null) category = new CategoryBean();
	if(parentCat == null) parentCat = new CategoryBean();
	
	String merchantName = StringUtil.filter(merchant.getEname());
	String productName = StringUtil.filter(product.geteName());
	String parentCatName = StringUtil.filter(parentCat.geteName());
	String categoryName = StringUtil.filter(category.geteName());
	
	if(!isEng) {
		merchantName = StringUtil.filter( merchant.getCname());
		productName = StringUtil.filter( product.getcName());
		parentCatName = StringUtil.filter(parentCat.getcName());
		categoryName = StringUtil.filter(category.getcName());
	}
	
	boolean isCumulativeDiscount = ProductDiscountService.getInstance().isDiscountEnable(StaticValueUtil.DISPLAY_WEB);
	//boolean isCumulativeDiscount = false;
	ProductDiscountBean productDiscount = ProductDiscountService.getInstance().getBeanById();

%>


<!DOCTYPE html>
<html lang="<%=I18nUtil.getLangHtml(request) %>">
<head>
	
	

<jsp:include page="meta.jsp" />
 
<script type="text/javascript">
(function() {
	//Set title (for GA)
	document.title = "Smart Shopping - <%=parentCatName%> - <%=categoryName%> - <%=productName%>";
	
	//For Webtrends 
	 document.querySelector('meta[name="WT.cg_s"]').setAttribute("content", "<%=StringUtil.filter(parentCat.geteName())%> - <%=StringUtil.filter(product.geteName())%>");
 })();
 
</script>

</head>
<body>

<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/>

<jsp:include page="header.jsp" />

<section>
<div class="categorypg container">
<% 
	String productPath = basePath + parentCat.getDeeplinkpathweb() + "&parentId=" + parentCat.getParentidentifier() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
	String catPath = basePath + parentCat.getDeeplinkpathweb() + "&parentId=" + parentCat.getParentidentifier() + "&categoryId=" + catId + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;

	if(category.getStatus() != StaticValueUtil.Active) catPath = "#";
%>
	<ol class="breadcrumb"> 
		<li><a href="<%=basePath %>index.jsp?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB%>"><fmt:message key="breadcrumb.home" /></a></li>
		<li><a href="<%=productPath %>"><%=parentCatName %></a></li>
		<li><a href="<%=catPath%>"><%=categoryName %></a></li>
	</ol>
			
    <h1 class="visible-xs"><%=productName %></h1>
    
    <!--photo gallery-->
 	<div class="product_img mt-10 col-sm-12 col-xs-24">
 		<% String defPath = basePath + "GetImageFileServlet?&name=" +  StringUtil.filter(product.getImage1()) ; %>
           <span class="zoomwrapper">
           <img src="<%=defPath %>" name="productimage" id="productimage" data-zoom-image="<%=defPath%>"/>
          
           </span>
      <div id="gal1" class="zoom_thun">
      <ol> <!-- ../GetImageFileServlet?&name=" +  StringUtil.filter(product.getImage1()) -->
      	<% if(!"".equals(StringUtil.filter(product.getImage1()))) { 
      		String path = basePath + "GetImageFileServlet?&name=" +  StringUtil.filter(product.getImage1()) ;
      	%>
          <li><a href="#" data-image="<%=path %>" data-zoom-image="<%=path%>"> <img class="img-responsive" src="<%=path %>" /> </a></li>
        <%} %>
        <% if(!"".equals(StringUtil.filter(product.getImage2()))) { 
        	String path = basePath + "GetImageFileServlet?&name=" +  StringUtil.filter(product.getImage2()) ;
        %>
          <li><a href="#" data-image="<%=path %>" data-zoom-image="<%=path%>"> <img class="img-responsive" src="<%=path %>" /> </a></li>
        <%} %>
        <% if(!"".equals(StringUtil.filter(product.getImage3()))) { 
        	String path = basePath + "GetImageFileServlet?&name=" +  StringUtil.filter(product.getImage3()) ;
        %>
          <li><a href="#" data-image="<%=path %>" data-zoom-image="<%=path%>"> <img class="img-responsive" src="<%=path %>" /> </a></li>
        <%} %>
       </ol>
</div> <!--zoom_thun ended-->
      
      </div>
<!--product_gallery  ended-->
    
   
   <!--price selection-->
   	<form action="<%=basePath %>cartList" name="addCartForm" method="post">
   	<input type="hidden" name="actionType" value="addCart" id="actionType<%=product.getId()%>">
	<input type="hidden" name="pid" value="<%=product.getId()%>">
	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">
 	
	<% String priceSetup = ""; 
	   String priceValue = "";
	   String priceValueEco = "";
	   String typeStr = "";
	   String installStr = "";
	   String installStr2 = "";
	   String deliverySr = "";
	   boolean isPickup = false;
	   String pickUpSelectStr = "";
	   String deliverySelectStr = "";
	   String earlyBirdStr = "";
	   String cumulativeStr = "";
	   String gaEEPrice = ""; //FOR GA EE
	   String gaEEPoint = ""; //FOR GA EE
	   
	   Map<String, String> gaEEPrices = new HashMap<String, String>();
	   
	   boolean isExceedDeliveryLimit = false;
	   
		ProductPriceBean price= product.getProductPrice().get(0);
		ProductQtyBean quantity = product.getProductQty().get(0);
		
		//START PRICE DISPLAY SETUP 
		priceValue ="<span class='text-primary'>" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</span>";
		gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice());

		if(price.getPrice() >= StringUtil.strToDouble(propUtil.getProperty("delivery.limit"))){
			isExceedDeliveryLimit = true;
		}
		
		if(price.getEnableEB() == StaticValueUtil.PRODUCT_ENABLE && price.getDiscount() > 0 && 
				price.getEbStartDate() != null && price.getEbEndDate() != null){
			
			if(price.getEbStartDate().before(new Date()) && price.getEbEndDate().after(new Date())){
				priceValue = "<span class='text-primary'>" + StringUtil.formatCurrencyPrice(price.getDiscount()) + 
						"</span> <small><del>" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</del></small>";
				
				gaEEPrice = StringUtil.formatIndexPrice2(price.getDiscount());	
				
				earlyBirdStr = I18nUtil.getString("product.earlybird.note.1", lang)  + DateUtil.formatDate(price.getEbStartDate()) + 
						       I18nUtil.getString("product.earlybird.note.2", lang) + DateUtil.formatDate(price.getEbEndDate());
				
				if(price.getDiscount() >= StringUtil.strToDouble(propUtil.getProperty("delivery.limit"))){
					isExceedDeliveryLimit = true;
				}else {
					isExceedDeliveryLimit = false;
				}
			}
			
		}else if(price.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE){
			EcoPointBean point = EcoPointService.getInstance().getFrontBeanById(price.getEpid());
			
			if(point != null) {
				double discount = (point.getRatio() * point.getPoints());
				
				priceValueEco = "<span class='text-primary'>" + StringUtil.formatCurrencyPrice(price.getPrice() - discount) +  
						"</span> + <span class='text-success'>" + StringUtil.formatIndexPrice(point.getPoints()) 
						+"<small> " + I18nUtil.getString("product.select.ecopoint", lang) + "</small></span>";
				
				gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice() - discount);
				gaEEPoint = StringUtil.formatIndexPrice2(point.getPoints());
			}
		}
		
		// FOR GA EE 
		if(!"".equals(StringUtil.filter(gaEEPoint))) {
			gaEEPrices.put("eco", gaEEPrice);
			gaEEPrices.put("ori", StringUtil.formatIndexPrice2(price.getPrice()));
		}else {
			gaEEPrices.put("ori", gaEEPrice);
		}
		
		if(isCumulativeDiscount && earlyBirdStr.equals("") ){
			cumulativeStr = (I18nUtil.getString("product.cumulative.note.1", lang))
					.replace("#total#", StringUtil.formatCurrencyPrice(productDiscount.getCumulativeAmount()))
					.replace("#discount#", StringUtil.formatCurrencyPrice(productDiscount.getDiscountAmount())); 	
			
		}
		//END PRICE DISPLAY SETUP 
		
		if(product.getCollectionmethod() == StaticValueUtil.COLLECT_NORMAL) { //Delivery /  Pickup type 

			if(product.getEnablepickup() == StaticValueUtil.PRODUCT_ENABLE){ // Pickup only
				isPickup = true;
				
				List<ProductBranchInfoBean> branchs = ProductBranchService.getInstance().getProductBranchInfoForPickup(product.getId());

				for(ProductBranchInfoBean branch : branchs){
					String branchName = StringUtil.filter(branch.getEname()) + " - " + StringUtil.filter(branch.getEaddress());
					if(!isEng) branchName = StringUtil.filter(branch.getCname()) + " - " + StringUtil.filter(branch.getCaddress());
					
					branchName = I18nUtil.getString("product.select.selfpickup", lang) + "<br><small>" + branchName + "</small>";
					
					pickUpSelectStr += "<option value=\"" + StaticValueUtil.PREFIX_PICKUP + branch.getId() + "\" data-content=\""+ branchName + "\">f</option>" ;
				}
				
				if(branchs.size() > 0) {
					pickUpSelectStr = "<optgroup label=\"" + I18nUtil.getString("product.select.selfpickup", lang) +"\">" + pickUpSelectStr + "</optgroup>";
				}
				
				if(price.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE){ //with Eco point 
					//priceSetup = "<p>" + priceValue + "</p>"; 
					
					priceSetup = "<nav class=\"tbl-list filter delivery small\">" +
									"<li>" +
					  				"<select name=\"priceType\" class=\"selectpicker show-tick\" data-style=\"btn-link\" >" +
					    				"<option value='" + StaticValueUtil.PRODUCT_ISNORMAL +  "' data-content=\"" + priceValue + "\"></option>" +
					    				"<option value='" + StaticValueUtil.PRODUCT_ISECO + "' data-content=\"" + priceValueEco + "\"></option>" +
					  				"</select>" +
									"</li>" +  
									"</nav>"; 

				}else {
					priceSetup = "<p>" + priceValue + "</p>"; 
				}
				
				typeStr = "<input type=\"hidden\" name=\"collectionMethod\" value=\"" + StaticValueUtil.product_PickUp + "\">";
			}
			
			
			if(product.getEnabledelivery() == StaticValueUtil.PRODUCT_ENABLE ) { //Delivery only 
				
				if(!("".equals(pickUpSelectStr))){
					
					deliverySelectStr = "<option value=\"" + StaticValueUtil.PREFIX_DELIVERY + "\" data-content=\"" + 
					I18nUtil.getString("product.select.delivery", lang) + "\"></option>";
				}
				
				deliverySr = "<p class=\"mt-10\"><b>" + I18nUtil.getString("product.delivery.fee", lang)+ ":</b> " + 
					 	  "<span class=\"text-primary\">" + StringUtil.formatCurrencyPrice(StringUtil.strToDouble(PropertiesUtil.getProperty("delivery.charges"))) + "</span></p>" +
		           	 	  "<p class=\"help-block\">" + I18nUtil.getString("product.delivery.note.1", lang) + 
		           	 		StringUtil.formatCurrencyPrice(StringUtil.strToDouble(PropertiesUtil.getProperty("delivery.charges"))) + 
		           	 		I18nUtil.getString("product.delivery.note.2", lang) + "</p>";
				
				if(price.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE){ //with Eco point 
					
					priceSetup = "<nav class=\"tbl-list filter delivery small\">" +
							"<li>" +
			  				"<select name=\"priceType\" class=\"selectpicker show-tick\" data-style=\"btn-link\" >" +
			    				"<option value='" + StaticValueUtil.PRODUCT_ISNORMAL +  "' data-content=\"" + priceValue + "\"></option>" +
			    				"<option value='" + StaticValueUtil.PRODUCT_ISECO + "' data-content=\"" + priceValueEco + "\"></option>" +
			  				"</select>" +
							"</li>" +  
							"</nav>";
							
				}else {
					priceSetup = "<p>" + priceValue + "</p> ";
								
				}
				
				typeStr = "<input type=\"hidden\" name=\"collectionMethod\" value=\"" + StaticValueUtil.product_Delivery + "\">";

			}
			
		}else { //Install Type 
			String installName = StringUtil.filter(price.getEinstalltext());
			
			if(!isEng) installName = StringUtil.filter(price.getCinstalltext());
			
			priceSetup = "<p>" + priceValue + "</p> ";
			
			if(price.getInstallprice() > 0) {
				priceSetup += "<p><b>" + I18nUtil.getString("product.install.fee", lang) + ":</b> <span class=\"text-primary\">" + 
						 	  StringUtil.formatCurrencyPrice(price.getInstallprice()) + "</span></p>";
			}
			
			typeStr = "<input type=\"hidden\" name=\"collectionMethod\" value=\"" + StaticValueUtil.product_Install + "\">";
			installStr = "<div class=\"alert alert-success\">" + I18nUtil.getString("product.install.note", lang) + "</div>";
			installStr2 = "<div>" + installName +  "</div>";
		}
	%>

		<input type="hidden" name="ppid" value="<%=price.getPpid()%>"/> 
		<input type="hidden" name="pqid" value="<%=quantity.getPqid()%>"/>
        <div class="col-sm-12 col-xs-24 ">
       
           <h1 class="hidden-xs"><%=productName %></h1>
           <%if(!"".equals(merchantName)) { %>
           <p><!--<fmt:message key="product.detail.manufacture.name"/> : --><%=merchantName %></p>
           <%} %>
           
           <%=typeStr %>
           <%=priceSetup %>
           <%if(!isExceedDeliveryLimit){ %>
           <%=deliverySr %>
           <%} %>
           <%=installStr %>
           <%if(!"".equals(StringUtil.filter(earlyBirdStr))){ %>
           		<%=earlyBirdStr %>
           <%} %>
           <%=installStr2 %>
           <%if(availableQty > 0) { %> 
           
           <!-- START PICKUP STORE SELECTION  -->
           <%if(!("".equals(pickUpSelectStr)) ) { 
           		String title = I18nUtil.getString("product.select.selfpickup", lang);;
        	   if(!(deliverySelectStr.equals(""))) {
        		   title = I18nUtil.getString("product.select.both", lang);
           	   }
           	%>
           		<nav class="tbl-list filter delivery small">
				 <li>
				   <select name="customCollect" class="selectpicker  show-tick" data-style="btn-link" title="<%=title%>">
          		   <%=deliverySelectStr %>
          		   <%=pickUpSelectStr %> 
             	   </select>
				 </li>
				</nav>
			
			<%} %>	 
			<!-- END PICKUP STORE SELECTION  -->

 
           <div class="res-tbl mt-15">
	           <div class="tbl-cell vertical_mid">
		          	<div class="addminus">
		          		<div class="inc button_num"><p class="hidden">-</p><span class="fa fa-minus"></span></div>
		        			<input type="tel" name="qty" id="french-hens" value="1">
		     				<div class="dec button_num"><p class="hidden">+</p><span class="fa fa-plus"></span></div>  
		        		</div> <!--addminus-->
		        </div>
		        <div class="tbl-cell vertical_mid">
		        	<!--  <a class="btn btn-success" href="javascript:addCartSubmit();"><fmt:message key="product.button.addtocart"/></a> --> 
		        	 <input type="submit" class="btn btn-success" onclick="return addCartSubmit()" value="<fmt:message key="product.button.addtocart"/>" >
		        </div>
        	</div>
        	<%}else { 
        		String customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(product.getId(), StaticValueUtil.ITEM_PRODUCT, lang);
        	%>
        		<div class="alert alert-danger mt-10"><%=StringUtil.filter(customstockmsg) %></div>
        		<!--  <div class="alert alert-danger mt-10"><fmt:message key="error.product.soldout"/></div> -->
        	<%} %>
      	    <%=cumulativeStr %>

          
          </div><!--col-sm-12 col-xs-24--> 
      </form>    
     <!--for price information-->
                  
                
        <article class="product-desc">
		<div class="col-xs-24">
          		<!--detail-->
              <div class="horizontalTab" id="tab">
            <ul class="resp-tabs-list"><!--title-->
              <li><fmt:message key="product.tab.detail"/></li>
                <li><fmt:message key="product.tab.energygrade"/></li>
            </ul>
            
            <div class="resp-tabs-container">
            
                <div id="details"><!-- description tab content-->
        
                <%if(!isEng) { %>
                	<%=StringUtil.filter(product.getcDescDetail()) %>
                <%}else{ %>
                	<%=StringUtil.filter(product.geteDescDetail()) %>
                <%} %>
					<!-- description atab ended-->
                 </div>

                <div id="energyGade"><!-- delivery information tab-->
                	<br><%if(!isEng) { %>
                		<%=StringUtil.filter(product.getCfeaturedesc()) %>
	                <%}else{ %>
	                	<%=StringUtil.filter(product.getEfeaturedesc()) %>
	                <%} %>
	          
    			</div><!-- delivery information tab end-->
                
            </div><!--resptabscontainer-->
        </div><!--horizontal tab ended-->
       </div><!--col-xs-24--> 
      </article>
      
	</div><!--category pg ended-->
</section>

<jsp:include page="footer.jsp" />

<script type="text/javascript">
$( document ).ready(function() {
	
	if('<%=errorMsg %>' != '') {
		if(<%=isEng%>){
			alert('<%=errorMsg%>');
		}
	}
	
	if('<%=errorMsgC%>' != '') {
		if(!<%=isEng%>){
			alert('<%=errorMsgC%>');
		}
	}
	
	<%=StringUtil.geGAEEDetail(StringUtil.formatGAEEProductName(product.geteName()), String.valueOf(product.getId()), gaEEPrices, StringUtil.filter(merchant.getEname()), StringUtil.filter(category.geteName()), gaEEPoint)%>
});
	function MM_findObj(n, d) { //v4.0

	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && document.getElementById) x=document.getElementById(n); return x;
	}
	
	function addCartSubmit(){		
		
		<%   if (product.getProductPrice().size()==1)  {%>
	    var qty = MM_findObj("qty");    
	    
	    if (qty.value== 0 ){
	    	
			alert("<fmt:message key="error.product.insert.quantity"/>");
			return false;
		}
	    <% } %>
	   
		<% if(!(pickUpSelectStr.equals(""))) { %>
			
			if($.trim($("[name='customCollect']").val()) == '') {
				alert("<fmt:message key="error.product.pickup.required"/>");
				return false;
			}
		
		<%}%>
		
		//FOR GA EE ATC 
		var priceType = $("select[name='priceType'] option:selected").val();
		if(priceType == '<%=StaticValueUtil.PRODUCT_ISECO%>') {
			
			gaEEAddToCart('<%=StringUtil.formatGAEEProductName(product.geteName())%>',<%=String.valueOf(product.getId())%>,<%=gaEEPrices.get("eco")%>,'<%=StringUtil.filter(merchant.getEname())%>','<%=StringUtil.filter(category.geteName())%>', qty.value, <%=gaEEPoint%>);
			  
		}else {
			gaEEAddToCart('<%=StringUtil.formatGAEEProductName(product.geteName())%>',<%=String.valueOf(product.getId())%>,<%=gaEEPrices.get("ori")%>,'<%=StringUtil.filter(merchant.getEname())%>','<%=StringUtil.filter(category.geteName())%>', qty.value, '0');

		}
		//MM_findObj("addCartForm").submit();	
		return false;
	}

</script>
<script type="text/javascript" src="<%=basePath %>js/gaee.js" ></script>
</body>
</html>