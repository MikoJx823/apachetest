<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
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
	Date now = new Date();
	
	List<IndexInfoBean> prodHot = IndexService.getInstance().getFrontWebList(StaticValueUtil.CAT_HOT);
	List<IndexInfoBean> prodEA = IndexService.getInstance().getFrontWebList(StaticValueUtil.CAT_ELECTRICAL);
	List<IndexInfoBean> prodSA = IndexService.getInstance().getFrontWebList(StaticValueUtil.CAT_SMART);
	List<IndexInfoBean> prodEco = IndexService.getInstance().getFrontWebList(StaticValueUtil.CAT_ECO);
	
	String errorMsg = StringUtil.filter((String)request.getSession().getAttribute(SessionName.errorMsg));
	String errorMsgC = StringUtil.filter((String)request.getSession().getAttribute(SessionName.errorMsgC));
	
	List<BannerInfoBean> banners = BannerService.getInstance().getFrontListByPlatform(StaticValueUtil.DISPLAY_WEB);
	
	//FOR GA EE 
	int count = 0;
	String gaEEList = "";
	String gaEEPromoList = "";
	boolean isGAEEEnable = false;
	boolean isGAEEPromEnable = false;
	if(prodHot.size() > 0 || prodEA.size() > 0 || prodSA.size() > 0 || prodEco.size() > 0) isGAEEEnable = true;
	if(banners.size() > 0) isGAEEPromEnable = true;

%>

<!DOCTYPE html>
<html lang="<%=I18nUtil.getLangHtml(request) %>">
<head>
<jsp:include page="meta.jsp" />
<script type="text/javascript">
(function() {
	document.title = "Smart Shopping - Homepage" ;

	//For Webtrends 
	 document.querySelector('meta[name="WT.cg_s"]').setAttribute("content", "Homepage");
 })();
 
</script>
</head>

<body>

<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/>

<jsp:include page="header.jsp" />


<section>
    <div class="container">
<div class="row">
    <ul class="bxslider">
	
	 <%
	  int promoCount = 1;
	  for(BannerInfoBean bean : banners ) { 
		  String imagePath = "";
		  
	  	  if(!isEng) imagePath = StringUtil.filter(bean.getCwebimage());
	  		
	  	  if("".equals(StringUtil.filter(imagePath))) imagePath = StringUtil.filter(bean.getEwebimage());
	  	  
	  	  String link = StringUtil.filter(bean.getLink()); 
		  
	  	  if(!link.equals("#")) {
	  		 if(link.contains("?"))  {
				  link += "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
			  }else{
				  link += "?type=" + StaticValueUtil.LOGIN_SOURCE_WEB; 
			  }
	  	  }

		  gaEEPromoList += StringUtil.getGAEEPromList(String.valueOf(bean.getId()),StringUtil.filter(bean.getEname()), String.valueOf(promoCount++));
	  
 	 %>
 	 <!--  <%//bean.getId()%>,'<%//StringUtil.filter(bean.getEname())%>',<%//promoCount %>
  	<li><a href="<%=StringUtil.filter(link)%>"><img src="<%=basePath %>images_web/index_banner/<%=imagePath%>" /></a></li>	-->
  	<li><a href="javascript:onPromoClick(<%=bean.getId()%>,'<%=StringUtil.filter(bean.getEname())%>',<%=promoCount %>,'<%=link%>')"><img src="<%=basePath %>images_web/index_banner/<%=imagePath%>" /></a></li>
  	<%} %>
</ul>
</div>
    
  <div class="row">
    	<div class="col-xs-24">
        	<h3 class="text-primary"><strong><fmt:message key="category.parent.hot"/></strong></h3>
            <nav class="productlist list-unstyled scrollbanner">
            
				<%for(IndexInfoBean item : prodHot) {
					int availableQty = 0;
					String productPrice = "";
					String productName = "";
					String linkPath = "";
					String imagePath = basePath + "product_img/";
					String merchantName = "";
					
					//FOR GA EE
            		String gaEEName = "";
            		String gaEEId = "";
            		String gaEEPrice = ""; 
            		String gaEEBrand = "";
            		String gaEECategory = "";
            		String gaEEVariant = "";
            		String gaEEPosition = "";
            		String gaEEListName = StaticValueUtil.GAEE_LIST_INDEX ;
					
					if(item.getType() == StaticValueUtil.ITEM_ECO){
						EcoRewardInfoBean bean = EcoRewardService.getInstance().getFrontBeanById(item.getEcorewardid());
						
						if(bean != null){
							MerchantBean merchant = MerchantService.getInstance().getFrontBeanById(bean.getMerchantCode());
							CategoryBean category = CategoryService.getInstance().getFrontBeanById(bean.getCategoryid());
							
							if(merchant == null) merchant = new MerchantBean();
							if(category == null) category = new CategoryBean();
							
							merchantName = StringUtil.filter(merchant.getEname());
							productName = StringUtil.filter(bean.getEname());
							
							if(!isEng) {
			        			merchantName = StringUtil.filter( merchant.getCname());
			        			productName = StringUtil.filter(bean.getCname());
			        		}
							
			    			availableQty = EcoRewardService.getInstance().getEcoRewardAvailableQuantity(bean.getId());
			    			
			    			linkPath = basePath + "ecorewardDetails?eid=" + bean.getId() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
			    			imagePath += StringUtil.filter(bean.getImage1());
			        		
			        		productPrice = "<span class='text-success'>" + StringUtil.formatIndexPrice(bean.getPrice()) + " " + I18nUtil.getString("product.select.ecopoint", lang) + "</span>" ;
			        		gaEEVariant = StringUtil.formatIndexPrice2(bean.getPrice());
			        		
			        		if(bean.getEnableeb() == StaticValueUtil.PRODUCT_ENABLE && bean.getDiscount() > 0 && 
			        				bean.getEbStartDate() != null && bean.getEbEndDate() != null){
			        			if(bean.getEbStartDate().before(new Date()) && bean.getEbEndDate().after(new Date()) ){
			        				productPrice = "<span class='text-success'>" + StringUtil.formatIndexPrice(bean.getDiscount()) + " " + I18nUtil.getString("product.select.ecopoint", lang) + "</span>" + 
									       	 	" <small><del class=\"text-gray\">" + StringUtil.formatIndexPrice(bean.getPrice()) + " " + 
									       		I18nUtil.getString("product.select.ecopoint", lang) + "</del></small> ";
									gaEEVariant = StringUtil.formatIndexPrice2(bean.getDiscount());
			        			}
			        		}
							
			        		//FOR GA EE 
			        		count++;
			        		gaEEList += StringUtil.getGAEEProductList(StringUtil.formatGAEEProductName(bean.getEname()), String.valueOf(bean.getId()), 
			        				"0", StringUtil.filter(merchant.getEname()), StringUtil.filter(category.geteName()), 
			        				gaEEVariant, gaEEListName, String.valueOf(count));
			        		
                 			gaEEName = StringUtil.formatGAEEProductName(bean.getEname());
                         	gaEEId = String.valueOf(bean.getId());	   
                         	gaEEBrand = StringUtil.filter(merchant.getEname());
                         	gaEECategory = StringUtil.filter(category.geteName());
						}
						
					}else{

						ProductBean bean = ProductService.getInstance().getFrontBeanById(item.getProductid());
						
						if(bean != null){
							ProductPriceBean price = bean.getProductPrice().get(0);
							MerchantBean merchant = MerchantService.getInstance().getFrontBeanById(bean.getMerchantCode());
							CategoryBean category = CategoryService.getInstance().getFrontBeanById(bean.getCategoryid());
							
							if(merchant == null) merchant = new MerchantBean();
 							if(category == null) category = new CategoryBean();
							
							productName = StringUtil.filter(bean.geteName());
							merchantName = StringUtil.filter(merchant.getEname());
							
							if(!isEng) {
								productName = StringUtil.filter(bean.getcName()); 
			        			merchantName = StringUtil.filter( merchant.getCname());
			        		}
			        		
							linkPath = basePath + "productDetails?pid=" + bean.getId() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
							imagePath += StringUtil.filter(bean.getImage1());
							availableQty = ProductService.getInstance().getProductAvailableQuantity(bean.getProductQty().get(0).getPqid());
					    
					    	productPrice = "<span class=\"text-primary\">" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</span> " ;
					    	gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice());
					    			
					    	if(price.getEnableEB() == StaticValueUtil.PRODUCT_ENABLE && price.getDiscount() > 0 && price.getEbStartDate() != null &&
					    			price.getEbEndDate() != null){
					    		if(price.getEbStartDate().before(new Date()) && price.getEbEndDate().after(new Date()) ){
					    			productPrice = "<span class=\"text-primary\">" + StringUtil.formatCurrencyPrice(price.getDiscount()) + 
					    						   "</span> <small><del>" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</del></small> ";
					    			gaEEPrice = StringUtil.formatIndexPrice2(price.getDiscount());
					    		}
					    	}else if(price.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE){
				        		EcoPointBean point = EcoPointService.getInstance().getFrontBeanById(price.getEpid());
				        			
				        		if(point != null) {
				        			double discount = (point.getRatio() * point.getPoints());
				        				
				        			productPrice = "<span class='text-primary'>" + StringUtil.formatCurrencyPrice(price.getPrice() - discount) +  
				        						"</span> + <span class='text-success'>" + StringUtil.formatIndexPrice(point.getPoints()) 
				        						+"<small> " + I18nUtil.getString("product.select.ecopoint", lang) + "</small></span>";
				        			gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice() - discount);
				        			gaEEVariant = StringUtil.formatIndexPrice2(point.getPoints());
				        		}
				        	}
					    	
					    	//FOR GA EE 
			        		count++;
			        		gaEEList += StringUtil.getGAEEProductList(StringUtil.formatGAEEProductName(bean.geteName()), String.valueOf(bean.getId()), 
			        				gaEEPrice, StringUtil.filter(merchant.getEname()), StringUtil.filter(category.geteName()), 
			        				gaEEVariant, gaEEListName, String.valueOf(count));
			        		
                 			gaEEName = StringUtil.formatGAEEProductName(bean.geteName());
                         	gaEEId = String.valueOf(bean.getId());	   
                         	gaEEBrand = StringUtil.filter(merchant.getEname());
                         	gaEECategory = StringUtil.filter(category.geteName());
						}
					}
		    	%>
		    		<li>
		    			<a href="javascript:onNavClick('<%=gaEEId%>', '<%=gaEEName%>', '<%=gaEEPrice %>', '<%=gaEEBrand%>', '<%=gaEECategory%>', '<%=gaEEVariant%>', <%=count %>,'<%=gaEEListName%>','<%=linkPath %>')" class="thumbnail">
					    <!-- <a class="thumbnail" href="<%=linkPath%>">-->
					    	<div class="productimg"><img src="<%=imagePath %>" alt="" class="img-responsive"></div>
					        <div class="caption">
					        	<h5><%=productName %></h5>
					   			<h5 class="mt-5"><%=StringUtil.filter(productPrice) %></h5>
					   			 <%if(!"".equals(merchantName)){ %>
				              		<p><%=StringUtil.filter(merchantName) %></p>
				              	<%} %>
					        	<%if(availableQty < 1){ 
					        		String customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(item.getProductid(), StaticValueUtil.ITEM_PRODUCT, lang);
					            	  
				            	  	if(item.getType() == StaticValueUtil.ITEM_ECO){
				            			customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(item.getEcorewardid(), StaticValueUtil.ITEM_ECO, lang);
				            	  	}
					        	%>
					        		<p class="text-danger"><%=StringUtil.filter(customstockmsg) %></p>
					        	<!--  <p class="text-danger"><fmt:message key="text.soldout"/></p> -->
					        	<%} %>
					        </div>
					        
				        </a>
				    </li>
		    	<%
					
				} %>
				
    		
    		</nav>
    
    
    <h3 class="text-primary"><strong><fmt:message key="category.parent.electrical"/></strong></h3>
    
    <nav class="productlist list-unstyled scrollbanner4">
		<%for(IndexInfoBean item : prodEA) {
			ProductBean bean = ProductService.getInstance().getFrontBeanById(item.getProductid());
			String merchantName = "";
			String productName = "";
			String linkPath = "";
			
			//FOR GA EE
    		String gaEEName = "";
    		String gaEEId = "";
    		String gaEEPrice = ""; 
    		String gaEEBrand = "";
    		String gaEECategory = "";
    		String gaEEVariant = "";
    		String gaEEPosition = "";
    		String gaEEListName = StaticValueUtil.GAEE_LIST_INDEX ;
			
			if(bean != null){
				MerchantBean merchant = MerchantService.getInstance().getFrontBeanById(bean.getMerchantCode());
				CategoryBean category = CategoryService.getInstance().getFrontBeanById(bean.getCategoryid());
				if(merchant == null) merchant = new MerchantBean();
				if(category == null) category = new CategoryBean();
				
				linkPath = basePath + "productDetails?pid=" + bean.getId() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
	    		ProductPriceBean price = bean.getProductPrice().get(0);
	    		
				productName = StringUtil.filter(bean.geteName());
				merchantName = StringUtil.filter(merchant.getEname());
				
    			if(!isEng){ 
    				productName = StringUtil.filter(bean.getcName());
    				merchantName = StringUtil.filter( merchant.getCname());
    			}
	    		
	    		int availableQty = ProductService.getInstance().getProductAvailableQuantity(bean.getProductQty().get(0).getPqid());
	    	    
	    		String productPrice = "<span class=\"text-primary\">" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</span> ";
	    		gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice());
	    		
	    		if(price.getEnableEB() == StaticValueUtil.PRODUCT_ENABLE && price.getDiscount() > 0 && price.getEbStartDate() != null && 
	    				price.getEbEndDate() != null){
	    			if(price.getEbStartDate().before(now) && price.getEbEndDate().after(now) ){
	    				productPrice = "<span class=\"text-primary\">" + StringUtil.formatCurrencyPrice(price.getDiscount()) + 
	    							   "</span> <small><del>" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</del></small> " ;
	    				gaEEPrice = StringUtil.formatIndexPrice2(price.getDiscount());
	    			}
	    		}else if(price.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE){
	    			EcoPointBean point = EcoPointService.getInstance().getFrontBeanById(price.getEpid());
	    			
	    			if(point != null) {
	    				double discount = (point.getRatio() * point.getPoints());
	    				
	    				productPrice = "<span class='text-primary'>" + StringUtil.formatCurrencyPrice(price.getPrice() - discount) +  
	    						"</span> + <span class='text-success'>" + StringUtil.formatIndexPrice(point.getPoints()) 
	    						+"<small> " + I18nUtil.getString("product.select.ecopoint", lang) + "</small></span>";
						
	    				gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice() - discount);
	    				gaEEVariant = StringUtil.formatIndexPrice2(point.getPoints());
	    			}
	    		}
	    		
	    		//FOR GA EE 
        		count++;
        		gaEEList += StringUtil.getGAEEProductList(StringUtil.formatGAEEProductName(bean.geteName()), String.valueOf(bean.getId()), 
        				gaEEPrice, StringUtil.filter(merchant.getEname()), StringUtil.filter(category.geteName()), 
        				gaEEVariant, gaEEListName, String.valueOf(count));
        		
     			gaEEName = StringUtil.formatGAEEProductName(bean.geteName());
             	gaEEId = String.valueOf(bean.getId());	   
             	gaEEBrand = StringUtil.filter(merchant.getEname());
             	gaEECategory = StringUtil.filter(category.geteName());

    	%>
    		<li> <!-- <%//basePath %>GetImageFileServlet?&name= -->
    			
    			<a href="javascript:onNavClick('<%=gaEEId%>', '<%=gaEEName%>', '<%=gaEEPrice %>', '<%=gaEEBrand%>', '<%=gaEECategory%>', '<%=gaEEVariant%>', <%=count %>,'<%=gaEEListName%>','<%=linkPath %>')" class="thumbnail">
			    <!-- <a class="thumbnail" href="<%=basePath %>productDetails?pid=<%=bean.getId()%>&type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>"> -->
			    	<div class="productimg"><img src="<%=basePath %>product_img/<%=StringUtil.filter(bean.getImage1()) %>" alt="<%=StringUtil.filter(bean.getImage1())%>" class="img-responsive"></div>
			        <div class="caption">
			        	<h5><%=productName %></h5>
			   			<h5 class="mt-5"><%=StringUtil.filter(productPrice) %></h5>
			   			 <%if(!"".equals(merchantName)){ %>
		              		<p><%=StringUtil.filter(merchantName) %></p>
		              	 <%} %>
			   			<%if(availableQty < 1){ 
			   				String customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(item.getProductid(), StaticValueUtil.ITEM_PRODUCT, lang);
			            	  
		            	  	if(item.getType() == StaticValueUtil.ITEM_ECO){
		            			customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(item.getEcorewardid(), StaticValueUtil.ITEM_ECO, lang);
		            	  	}
			   			%>
			   				<p class="text-danger"><%=StringUtil.filter(customstockmsg)%></p>
					        <!--  <p class="text-danger"><fmt:message key="text.soldout"/></p> -->
					    <%} %>
			        </div>
		        </a>
		    </li>
    	<%
			}
		} %>

 
    </nav>
    
    
     <h3 class="text-primary"><strong><fmt:message key="category.parent.smart"/></strong></h3>
    
    <nav class="productlist list-unstyled scrollbanner4">
    
    	<%for(IndexInfoBean item : prodSA) {
			ProductBean bean = ProductService.getInstance().getFrontBeanById(item.getProductid());
			String merchantName = "";
			String productName = "";
			String linkPath = "";
			
			//FOR GA EE
    		String gaEEName = "";
    		String gaEEId = "";
    		String gaEEPrice = ""; 
    		String gaEEBrand = "";
    		String gaEECategory = "";
    		String gaEEVariant = "";
    		String gaEEPosition = "";
    		String gaEEListName = StaticValueUtil.GAEE_LIST_INDEX ;
			
			if(bean != null){
				MerchantBean merchant = MerchantService.getInstance().getFrontBeanById(bean.getMerchantCode());
				CategoryBean category = CategoryService.getInstance().getFrontBeanById(bean.getCategoryid());
				if(merchant == null) merchant = new MerchantBean();
				if(category == null) category = new CategoryBean();
				
				linkPath = basePath + "productDetails?pid=" + bean.getId() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
	    		ProductPriceBean price = bean.getProductPrice().get(0);
	    		
				productName = StringUtil.filter(bean.geteName());
				merchantName = StringUtil.filter(merchant.getEname());
				
    			if(!isEng){ 
    				productName = StringUtil.filter(bean.getcName());
    				merchantName = StringUtil.filter( merchant.getCname());
    			}

	    		int availableQty = ProductService.getInstance().getProductAvailableQuantity(bean.getProductQty().get(0).getPqid());
	    	    
	    		String productPrice = "<span class=\"text-primary\">" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</span> " ;
	    		gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice());
	    		
	    		if(price.getEnableEB() == StaticValueUtil.PRODUCT_ENABLE && price.getDiscount() > 0 && price.getEbStartDate() != null 
	    				&& price.getEbEndDate() != null){
	    			if(price.getEbStartDate().before(now) && price.getEbEndDate().after(now) ){
	    				productPrice = "<span class=\"text-primary\">" + StringUtil.formatCurrencyPrice(price.getDiscount()) + 
	    							   "</span> <small><del>" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</del></small> ";
	    				gaEEPrice = StringUtil.formatIndexPrice2(price.getDiscount());
	    			}
	    		}else if(price.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE){
	    			EcoPointBean point = EcoPointService.getInstance().getFrontBeanById(price.getEpid());
	    			
	    			if(point != null) {
	    				double discount = (point.getRatio() * point.getPoints());
	    				
	    				productPrice = "<span class='text-primary'>" + StringUtil.formatCurrencyPrice(price.getPrice() - discount) +  
	    						"</span> + <span class='text-success'>" + StringUtil.formatIndexPrice(point.getPoints()) 
	    						+"<small> " + I18nUtil.getString("product.select.ecopoint", lang) + "</small></span>";
	    				gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice() - discount);
	    				gaEEVariant = StringUtil.formatIndexPrice2(point.getPoints());
	    			}
	    		}
	    		
	    		//FOR GA EE 
        		count++;
        		gaEEList += StringUtil.getGAEEProductList(StringUtil.formatGAEEProductName(bean.geteName()), String.valueOf(bean.getId()), 
        				gaEEPrice, StringUtil.filter(merchant.getEname()), StringUtil.filter(category.geteName()), 
        				gaEEVariant, gaEEListName, String.valueOf(count));
        		
     			gaEEName = StringUtil.formatGAEEProductName(bean.geteName());
             	gaEEId = String.valueOf(bean.getId());	   
             	gaEEBrand = StringUtil.filter(merchant.getEname());
             	gaEECategory = StringUtil.filter(category.geteName());
    	%>
    		<li>
    			<a href="javascript:onNavClick('<%=gaEEId%>', '<%=gaEEName%>', '<%=gaEEPrice %>', '<%=gaEEBrand%>', '<%=gaEECategory%>', '<%=gaEEVariant%>', <%=count %>,'<%=gaEEListName%>','<%=linkPath %>')" class="thumbnail">
			    <!--  <a class="thumbnail" href="<%=basePath %>productDetails?pid=<%=bean.getId()%>&type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>"> -->
			    	<div class="productimg"><img src="<%=basePath %>product_img/<%=StringUtil.filter(bean.getImage1()) %>" alt="<%=StringUtil.filter(bean.getImage1())%>" class="img-responsive"></div>
			        <div class="caption">
			        	<h5><%=productName %></h5>
			   			<h5 class="mt-5"><%=StringUtil.filter(productPrice) %></h5>
			   			 <%if(!"".equals(merchantName)){ %>
		              		<p><%=StringUtil.filter(merchantName) %></p>
		              	<%} %>
			   			<%if(availableQty < 1){ 
			   				String customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(item.getProductid(), StaticValueUtil.ITEM_PRODUCT, lang);
			            	  
		            	  	if(item.getType() == StaticValueUtil.ITEM_ECO){
		            			customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(item.getEcorewardid(), StaticValueUtil.ITEM_ECO, lang);
		            	  	}
			   			%>
			   				<p class="text-danger"><%=StringUtil.filter(customstockmsg) %></p>
					        <!--  <p class="text-danger"><fmt:message key="text.soldout"/></p> -->
					    <%} %>
			        </div>
		        </a>
		    </li>
    	<%
			}
		} %>
    </nav>

    <h3 class="text-primary"><strong><fmt:message key="category.parent.eco"/></strong></h3>
    <nav class="productlist list-unstyled scrollbanner4">
    	<%for(IndexInfoBean item : prodEco) {
    		EcoRewardInfoBean bean = EcoRewardService.getInstance().getFrontBeanById(item.getEcorewardid());
    		String merchantName = "";
    		String productName = "";
    		String linkPath = "";
    		
    		//FOR GA EE
    		String gaEEName = "";
    		String gaEEId = "";
    		String gaEEPrice = ""; 
    		String gaEEBrand = "";
    		String gaEECategory = "";
    		String gaEEPosition = "";
    		String gaEEListName = StaticValueUtil.GAEE_LIST_INDEX;
    		
    		if(bean != null){
    			MerchantBean merchant = MerchantService.getInstance().getFrontBeanById(bean.getMerchantCode());
        		CategoryBean category = CategoryService.getInstance().getFrontBeanById(bean.getCategoryid());
        		if(merchant == null) merchant = new MerchantBean();
        		if(category == null) category = new CategoryBean();
        		
        		linkPath = basePath + "ecorewardDetails?eid=" + bean.getId() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
    			productName = StringUtil.filter(bean.getEname());
    			merchantName = StringUtil.filter(merchant.getEname());
    			
    			if(!isEng){ 
    				productName = StringUtil.filter(bean.getCname());
    				merchantName = StringUtil.filter( merchant.getCname());
    			}
    			
    			String productPrice = "<span class=\"text-primary\">" + StringUtil.formatIndexPrice(bean.getPrice()) + "</span> " + 
						  I18nUtil.getString("product.select.ecopoint", lang);
    			gaEEPrice = StringUtil.formatIndexPrice2(bean.getPrice());
    			
				int availableQty = EcoRewardService.getInstance().getEcoRewardAvailableQuantity(bean.getId());
			  
				if(bean.getEnableeb() == StaticValueUtil.PRODUCT_ENABLE && bean.getDiscount() > 0 && bean.getEbStartDate() != null 
						&& bean.getEbEndDate() != null){
					if(bean.getEbStartDate().before(now) && bean.getEbEndDate().after(now) ){
						productPrice = "<span class=\"text-primary\">" + StringUtil.formatIndexPrice(bean.getDiscount()) + " " + I18nUtil.getString("product.select.ecopoint", lang) +
									   "</span> <small><del>" + StringUtil.formatIndexPrice(bean.getPrice()) + I18nUtil.getString("product.select.ecopoint", lang) + 
									   "</del></small> ";
						gaEEPrice = StringUtil.formatIndexPrice2(bean.getDiscount());
					}
				}
				
				//FOR GA EE 
        		count++;
        		gaEEList += StringUtil.getGAEEProductList(StringUtil.formatGAEEProductName(bean.getEname()), String.valueOf(bean.getId()), 
        				"0", StringUtil.filter(merchant.getEname()), StringUtil.filter(category.geteName()), 
        				gaEEPrice, gaEEListName, String.valueOf(count));
        		
     			gaEEName = StringUtil.formatGAEEProductName(bean.getEname());
             	gaEEId = String.valueOf(bean.getId());	   
             	gaEEBrand = StringUtil.filter(merchant.getEname());
             	gaEECategory = StringUtil.filter(category.geteName());
    	%>
    		<li>
    			<a href="javascript:onNavClick('<%=gaEEId%>', '<%=gaEEName%>', '0', '<%=gaEEBrand%>', '<%=gaEECategory%>', '<%=gaEEPrice %>', <%=count %>,'<%=gaEEListName%>','<%=linkPath %>')" class="thumbnail">
			    <!--  <a class="thumbnail" href="<%=basePath %>ecorewardDetails?eid=<%=bean.getId()%>&type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>"> -->
			    	<div class="productimg"><img src="<%=basePath %>product_img/<%=StringUtil.filter(bean.getImage1()) %>" alt="<%=StringUtil.filter(bean.getImage1())%>" class="img-responsive"></div>
			        <div class="caption">
			        	<h5><%=productName %></h5>
			   			<h5 class="mt-5"><%=StringUtil.filter(productPrice) %></h5>
			   			 <%if(!"".equals(merchantName)){ %>
		              		<p><%=StringUtil.filter(merchantName) %></p>
		              	<%} %>
			   			<%if(availableQty < 1){ 
			   				String customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(item.getProductid(), StaticValueUtil.ITEM_PRODUCT, lang);
			            	  
		            	  	if(item.getType() == StaticValueUtil.ITEM_ECO){
		            			customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(item.getEcorewardid(), StaticValueUtil.ITEM_ECO, lang);
		            	  	}
			   			%>	
			   				<p class="text-danger"><%=StringUtil.filter(customstockmsg) %></p>
					        <!--  <p class="text-danger"><fmt:message key="text.soldout"/></p>-->
					    <%} %>
			        </div>
		        </a>
		    </li>
    	<%
    		}
    	} %>
    
       <!--product group-->
 
    </nav>
    
        </div><!--col-xs-24-->
    </div><!--row-->
    
    </div>
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
		
	if(<%=isGAEEEnable%>){
		<%=StringUtil.getGAEEFullConfig(gaEEList, StaticValueUtil.GAEE_PROD_IMPRESSION,"")%>
	}
	
	if(<%=isGAEEPromEnable%>){
		<%=StringUtil.getGAEEFullConfig(gaEEPromoList, StaticValueUtil.GAEE_PROM_IMPRESSION,"")%>
	}
});

</script>
<script type="text/javascript" src="<%=basePath %>js/gaee.js" ></script>
<%

	request.getSession().removeAttribute(SessionName.errorMsg);
	request.getSession().removeAttribute(SessionName.errorMsgC);
%>
</body>
</html>
