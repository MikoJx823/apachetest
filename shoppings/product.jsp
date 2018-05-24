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
%>
<% 
	Date now = new Date();
	boolean isEng = I18nUtil.isEng(request);
	String lang = I18nUtil.getLang(request);
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");	

	List<ProductBean> products = (List<ProductBean>)request.getAttribute(SessionName.products) == null ? new ArrayList<ProductBean>() : (List<ProductBean>)request.getAttribute(SessionName.products);
	
	String categoryId = StringUtil.filter((String)request.getAttribute("categoryId"));
	String parentId = StringUtil.filter((String)request.getAttribute("parentId"));
	String sorting = StringUtil.filter((String)request.getAttribute(SessionName.sorting));
	String filterAppliance = StringUtil.filter((String)request.getAttribute("filterAppliance"));
	String filterBrand = StringUtil.filter((String)request.getAttribute("filterBrand"));
	String filterBrandList = StringUtil.filter((String)request.getAttribute("filterBrandList"));
	String filterPrice = StringUtil.filter((String) request.getAttribute("filterPrice"));
	String filterPriceList = StringUtil.filter((String) request.getAttribute("filterPriceList"));
	
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
	int itemCount = StringUtil.trimToInt(request.getAttribute(SessionName.itemCount));
	
	//FOR GA EE 
	String gaEEList = "";
	String gaEEClick = "";
	boolean isGAEEEnable = false;
	if(products.size() > 0) isGAEEEnable = true;
	
	CategoryBean category = CategoryService.getInstance().getFrontBeanById(StringUtil.strToInt(categoryId));
	CategoryBean parentCat = CategoryService.getInstance().getParentCat(StringUtil.strToInt(parentId));
	
	if(category == null) category = new CategoryBean();
	if(parentCat == null) parentCat = new CategoryBean();
	
	String categoryName = StringUtil.filter(category.geteName());
	String parentCatName = StringUtil.filter(parentCat.geteName());
	
	if(!isEng) {
		categoryName = StringUtil.filter(category.getcName());
		parentCatName = StringUtil.filter(parentCat.getcName());
	}
			
	String[] selectedPrice = new String[0];
	boolean price1Selected = false;
	boolean price2Selected = false;
	boolean price3Selected = false;
	
	if(!"".equals(filterPriceList)){
		String temp = filterPriceList;
		
		if(temp.contains(",")){
			selectedPrice = temp.split(",");
		}else{
			selectedPrice = new String[1];
			selectedPrice[0] = temp;
		}
		
		for(String select : selectedPrice) {
			if(select.equals(StaticValueUtil.FILTER_PROD_PRICE_1)){
				price1Selected = true;
			}else if(select.equals(StaticValueUtil.FILTER_PROD_PRICE_2)){
				price2Selected = true;
			}/*else if(select.equals(StaticValueUtil.FILTER_ECO_PRICE_3)){
				price3Selected = true;
			}*/
			
		}
	}
	
%>


<!DOCTYPE html>

<html lang="<%=I18nUtil.getLangHtml(request) %>">
<head>
<jsp:include page="meta.jsp" />


<script type="text/javascript">
(function() {
	
	document.title = "Smart Shopping - <%=parentCatName%> <%=categoryName.equals("")? "": (" - " + categoryName) %>" ;
	
	//For Webtrends 
	document.querySelector('meta[name="WT.cg_s"]').setAttribute("content", "<%=StringUtil.filter(parentCat.geteName())%>" );
	//document.querySelector('meta[name="WT.cg_s"]').setAttribute("content", catWebtrend + (subCatWebtrend == "" ? "" : " - " + subCatWebtrend));
 })();
 
 </script>

</head>

<body>
<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/>

<jsp:include page="header.jsp" />

<!--header-->


<section>
<div class="container">
<% 
	String productPath = basePath + StringUtil.filter(parentCat.getDeeplinkpathweb()) + "&parentId=" + parentCat.getParentidentifier()  + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
%>
		
<ol class="breadcrumb">
	<li><a href="<%=basePath %>index.jsp?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB%>"><fmt:message key="breadcrumb.home" /></a></li>
	<li><a href="<%=productPath %>"><%=parentCatName %></a></li>
</ol>

<div class="row">
	
	<%
      	String sortPath = basePath + "productList?actionType=search&categoryId=" + categoryId + "&parentId=" + parentId +
         			 	 "&filterAppliance=" + filterAppliance + "&filterBrand=" + filterBrand + "&filterPrice=" + filterPrice + 
         			 	 "&filterPriceList=" + filterPriceList + "&filterBrandList=" + filterBrandList + 
         			 	 "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB; //+ "&pageIdx=" + pageIdx;
    %>
	
	
	<div class="col-md-6 productFilterLeft   hidden-xs hidden-sm mt-15">
    <div class="panel panel-sort">
     <div class="panel-heading tbl" data-toggle="collapse" href="#desktopSort">
     <div class="tbl-cell vertical_mid"><b><fmt:message key="product.sort.title"/></b></div>
     <div class="tbl-cell vertical_mid right_icon"> <i class="fa fa-chevron-right pull-right"></i></div>
     </div>
    <nav  id="desktopSort" class="list-group panel-collapse collapse in">

  		<li class="list-group-item <%if(sorting.equals(String.valueOf(StaticValueUtil.SORT_CLP_RECOMMED))){ %> active <%} %>">  
          	<!--  <a href="ecorewardList?categoryId=&parentId=-3&type=app&sorting=1&pageIdx=1">
          	-->
          	<a href="<%=sortPath %>&<%=SessionName.sorting %>=<%=StaticValueUtil.SORT_CLP_RECOMMED %>">
					<fmt:message key="product.sort.clp.recommed"/>
             </a></li>
 		<li class="list-group-item <%if(sorting.equals(String.valueOf(StaticValueUtil.SORT_CUS_POPULAR))){ %> active <%} %>">  
          	<a href="<%=sortPath %>&<%=SessionName.sorting %>=<%=StaticValueUtil.SORT_CUS_POPULAR %>">
             	<fmt:message key="product.sort.customer.popular"/>
         </a></li>
         
          <li class="list-group-item <%if(sorting.equals(String.valueOf(StaticValueUtil.SORT_NEW_ITEM))){ %>  active <%} %>">  
          	<a href="<%=sortPath %>&<%=SessionName.sorting %>=<%=StaticValueUtil.SORT_NEW_ITEM %>">
            <fmt:message key="product.sort.new.item"/>
         </a></li>
		</nav>
			</div><!--panel sorting-->
            
            <form action="<%=basePath %>productList" name="addCartForm" method="post">
      	<input type="hidden" name="actionType" value="filter">
      	<input type="hidden" name="parentId" value="<%=parentId%>">
      	<input type="hidden" name="categoryId" value="<%=categoryId%>">
		<input type="hidden" name="sorting" value="<%=sorting %>">
		<input type="hidden" name="filterBrandList" value="<%=filterBrandList %>">
		<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB %>" >
		
             <div class="panel panel-sort">
     <div class="panel-heading tbl"  data-toggle="collapse" href="#filterSort">
     <div class="tbl-cell vertical_mid"><b><fmt:message key="product.filter.title"/></b></div>
     <div class="tbl-cell vertical_mid right_icon"> <i class="fa fa-chevron-right pull-right"></i></div>
     </div>
    <nav id="filterSort" class="list-group panel-collapse collapse in">

  		<li class="filterlist hidden">  <!--hidden appliance-->
          	<!--  <a href="ecorewardList?categoryId=&parentId=-3&type=app&sorting=1&pageIdx=1">
          	-->
          	<p data-toggle="collapse" href="#webAppliance">
					<fmt:message key="product.tab.appliance"/>
             </p>
             
            <div class="panel-collapse collapse in" id="webAppliance" aria-expanded="true">
                    <!-- Open List Group for Internal Page Links -->
                   <div class="btn-group-vertical" data-toggle="buttons">
                   	  <%//ProductApplianceService.getInstance().getFilterPulldown(filterAppliance,lang) %>
                      <!--  <div><input type="checkbox" name="appliances" autocomplete="off" value="1">appliance1</div>
                      <div><input type="checkbox" name="appliances" autocomplete="off" value="2">appliance2</div> -->
                    </div> <!-- //Close List Group for Internal Page Links -->
                  </div>
             
             </li>
             

  		<li class="filterlist">  
          	<!--  <a href="ecorewardList?categoryId=&parentId=-3&type=app&sorting=1&pageIdx=1">
          	-->
          	<p data-toggle="collapse" href="#webBrand">
					<fmt:message key="product.tab.brand"/>
             </p>
             
            <div class="panel-collapse collapse in" id="webBrand" aria-expanded="true">
                    <!-- Open List Group for Internal Page Links -->
                   <div class="btn-group-vertical" data-toggle="buttons">
                      <%=MerchantService.getInstance().getFilterPulldown(filterBrand, filterBrandList, lang) %>
                      <%//ProductBrandService.getInstance().getFilterPulldown(filterBrand, lang) %>
                    </div> <!-- //Close List Group for Internal Page Links -->
                  </div>
             
             </li>
         	
         	<li class="filterlist">  
          	<!--  <a href="ecorewardList?categoryId=&parentId=-3&type=app&sorting=1&pageIdx=1">
          	-->
          	<p data-toggle="collapse" href="#webPrice">
					<fmt:message key="product.tab.price"/>
             </p>
             
            <div class="panel-collapse collapse in" id="webPrice" aria-expanded="true">
                    <!-- Open List Group for Internal Page Links -->
                   <div class="btn-group-vertical" data-toggle="buttons">
                       <div name="resetDiv" <%if(price1Selected) {%> class="active" <%} %> >
                        <input type="checkbox" name="prices" autocomplete="off" value="<%=StaticValueUtil.FILTER_PROD_PRICE_1%>"
                        <%if(price1Selected) {%> checked <%} %> ><fmt:message key="product.tab.price.1"/>
                      </div>
                    
                      <div name="resetDiv" <%if(price2Selected) {%> class="active" <%} %> >
                        <input type="checkbox" name="prices" autocomplete="off" value="<%=StaticValueUtil.FILTER_PROD_PRICE_2%>"
                        <%if(price2Selected) {%> checked <%} %> ><fmt:message key="product.tab.price.2"/>
                      </div>
                      
                    </div> <!-- //Close List Group for Internal Page Links -->
                  </div>
             
             </li>
         
            <li class="filterlist group-fff">
                  <div class="pt-15 pb-15 tbl">
                    <div class="tbl-cell col-xs-12"><a class="btn btn-success btn-success-line btn-block" href="#" id="resetButton"><fmt:message key="product.filter.reset"/></a></div>
                    <div class="tbl-cell col-xs-12">
                    <input type="submit" class="btn btn-success btn-block" value="<fmt:message key="product.filter.confirm"/>"></div>
                  </div>
                </li>
		</nav>
			</div><!--panel sorting-->
			</form>
        </div><!--col-sm-6-->
	
	
<!--   RESPONSIVE SORT AND FILTER  -->
<div class="categorypg  col-md-18 col-xs-24">
    <h1 class="text-primary">
    <%if("".equals(categoryName)){ %>
    	<fmt:message key="category.all"/>
    <%}else { %>
    	<%=categoryName %>
    <%} %>
    </h1>
 	
 	
 	<nav class="tbl-list filter small  hidden-md hidden-lg">
      <!--  START Sorting  -->
      <li> 
        <div class="dropdown stopProp">
          <a class="btn btn-sm btn-link btn-block" type="button" data-toggle="dropdown"><span class="fa fa-sort"></span> <fmt:message key="product.sort.title"/></a>
         <ul class="dropdown-menu">
         
           <li <%if(sorting.equals(String.valueOf(StaticValueUtil.SORT_CLP_RECOMMED))){ %>  class="active" <%} %>>  

          	<a href="<%=sortPath %>&<%=SessionName.sorting %>=<%=StaticValueUtil.SORT_CLP_RECOMMED %>">
          	<div class="tbl-cell"><fmt:message key="product.sort.clp.recommed"/></div>
         	 <div class="tbl-cell text-right"><i class="fa fa-check" aria-hidden="true"></i></div>
             </a></li>
          
          <li <%if(sorting.equals(String.valueOf(StaticValueUtil.SORT_CUS_POPULAR))){ %>  class="active" <%} %> >
          <a href="<%=sortPath %>&<%=SessionName.sorting %>=<%=StaticValueUtil.SORT_CUS_POPULAR %>">
          <div class="tbl-cell"><fmt:message key="product.sort.customer.popular"/></div>
          <div class="tbl-cell text-right"><i class="fa fa-check" aria-hidden="true"></i></div>
             </a></li>
             
          <li <%if(sorting.equals(String.valueOf(StaticValueUtil.SORT_NEW_ITEM))){ %>  class="active" <%} %> >
          <a href="<%=sortPath %>&<%=SessionName.sorting %>=<%=StaticValueUtil.SORT_NEW_ITEM %>">
          <div class="tbl-cell"><fmt:message key="product.sort.new.item"/></div>
          <div class="tbl-cell  text-right"><i class="fa fa-check" aria-hidden="true"></i></div>
             </a></li>
        </ul>
        </div>
      </li>
      <!--  End Sorting  -->
      <li>
      	<form action="<%=basePath %>productList" name="addCartForm" method="post">
      	<input type="hidden" name="actionType" value="filter">
      	<input type="hidden" name="parentId" value="<%=parentId%>">
      	<input type="hidden" name="categoryId" value="<%=categoryId%>">
		<input type="hidden" name="sorting" value="<%=sorting %>">
		<input type="hidden" name="filterBrandList" value="<%=filterBrandList %>">
		<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB %>" >
      
        <div class="dropdown dropdown-accordion" data-accordion="#accordion">
          
          <!-- Main Link For Opening Dropdown -->
          <a class="btn btn-sm btn-link btn-block" type="button" data-toggle="dropdown"><span class="fa fa-bookmark"></span> <fmt:message key="product.filter.title"/></a>
          
          
          
          <!-- //Close Main Link For Opening Dropdown -->
          
          <!-- Open Dropdown Menu Wrapper -->
          <ul class="dropdown-menu rightDrop" role="menu" aria-labelledby="dLabel">
            
            <!-- Child li element was needed on testing as a wrapper for alignment and functionality -->
            <li>
              <!-- Open Panel Group for Accordion Content and Headings -->
              <div class="panel-group" id="accordion">
               
              <!-- energey Grade panel -->
                <div class="panel">
                  
		<div class="hidden"><!--hide filter-->
                  <!-- Panel Heading Wrapper -->
                  <div class="panel-heading">
                    <!-- Panel Heading / Accordion Content Toggle -->
                      <a href="#appliance" class="collapsed" data-toggle="collapse" data-parent="#accordion">
                      <div class="tbl-cell"><fmt:message key="product.tab.appliance"/></div>
                      <div class="tbl-cell text-right"><i class="fa fa-chevron-right" aria-hidden="true"></i></div>
                      </a> <!-- //Close Panel Heading -->
                  </div><!-- //Close Panel Heading Wrapper -->
                  
                  <!-- Open Panel Collapse Items Wrapper -->
                  <div class="panel-collapse collapse" id="appliance">
                    <!-- Open List Group for Internal Page Links -->
                   <div class="btn-group-vertical" data-toggle="buttons">
                      <%//ProductApplianceService.getInstance().getFilterPulldown(filterAppliance,lang) %>
                    </div> <!-- //Close List Group for Internal Page Links -->
                  </div> <!-- //Close Panel Collapse Items Wrapper -->
                </div> <!-- //Close Energy Grade -->
                </div><!--hide filter-->
                
                <div class="panel">
                  
                  <!-- Panel Heading Wrapper -->
                  <div class="panel-heading">
                    <!-- Panel Heading / Accordion Content Toggle -->
                      <a href="#brand" class="collapsed" data-toggle="collapse" data-parent="#accordion">
                      <div class="tbl-cell"><fmt:message key="product.tab.brand"/></div>
                      <div class="tbl-cell text-right"><i class="fa fa-chevron-right" aria-hidden="true"></i></div>
                      </a> <!-- //Close Panel Heading -->
                  </div><!-- //Close Panel Heading Wrapper -->
                  
                  <!-- Open Panel Collapse Items Wrapper -->
                  <div class="panel-collapse collapse" id="brand">
                    <!-- Open List Group for Internal Page Links -->
                   <div class="btn-group-vertical" data-toggle="buttons"> 
                      <%=MerchantService.getInstance().getFilterPulldown(filterBrand, filterBrandList, lang) %> 
                      <%//ProductBrandService.getInstance().getFilterPulldown(filterBrand, lang) %>
                      <!--  <div>
                        <input type="checkbox" autocomplete="off"> Grade 1
                      </div>
                      <div>
                        <input type="checkbox" autocomplete="off">Grade 2
                      </div> -->
                    </div> <!-- //Close List Group for Internal Page Links -->
                  </div> <!-- //Close Panel Collapse Items Wrapper -->
                </div> <!-- //Close Energy Grade -->
                
           <!-- energey price -->
                <div class="panel">
                  
                  <!-- Panel Heading Wrapper -->
                  <div class="panel-heading">
                    
                    <!-- Panel Heading / Accordion Content Toggle -->
                    
                  
                      <a href="#priceRange" class="collapsed" data-toggle="collapse" data-parent="#accordion">
                      <div class="tbl-cell"><fmt:message key="product.tab.price"/> </div>
                      <div class="tbl-cell text-right"><i class="fa fa-chevron-right" aria-hidden="true"></i></div>
                      </a>
                
                    <!-- //Close Panel Heading -->
                    
                  </div>
                  <!-- //Close Panel Heading Wrapper -->
                  
                  <!-- Open Panel Collapse Items Wrapper -->
                  <div class="panel-collapse collapse" id="priceRange">
                    
                    <!-- Open List Group for Internal Page Links -->
                   <div class="btn-group-vertical" data-toggle="buttons">
                    <div name="resetDiv" <%if(price1Selected) {%> class="active" <%} %> >
                        <input type="checkbox" name="prices" autocomplete="off" value="<%=StaticValueUtil.FILTER_PROD_PRICE_1%>"
                        <%if(price1Selected) {%> checked <%} %> ><fmt:message key="product.tab.price.1"/>
                      </div>
                    
                      <div name="resetDiv" <%if(price2Selected) {%> class="active" <%} %> >
                        <input type="checkbox" name="prices" autocomplete="off" value="<%=StaticValueUtil.FILTER_PROD_PRICE_2%>"
                        <%if(price2Selected) {%> checked <%} %> ><fmt:message key="product.tab.price.2"/>
                      </div>
                      
                     
                    </div>
                    <!-- //Close List Group for Internal Page Links -->
                    
                  </div>
                  <!-- //Close Panel Collapse Items Wrapper -->
                  
                </div>
                <!-- //Close Price range -->
                
                
              </div>
              <!-- //Close Panel Group for Accordion Content and Headings -->
              
            </li>
            <!-- //Close Dropdown Child li -->
            
            
            <li>
              <div class="pt-15 pb-15 tbl">
                <div class="tbl-cell col-xs-12"><a class="btn btn-success btn-success-line btn-block" id="resetButton2" href="#"><fmt:message key="product.filter.reset"/></a></div>
                <div class="tbl-cell col-xs-12">
					<input type="submit" class="btn btn-success  btn-block" value="<fmt:message key="product.filter.confirm"/>">
				</div>
              </div>
            </li>
            <!--button-->
          </ul>
          <!-- //Close Dropdown Menu Wrapper -->
          
        </div>
        </form>
      </li>
      
    </nav>
    
    <p class="small mt-10 mb-10"><fmt:message key="product.itemfound.1"/>
    	<b class="text-green"><%=itemCount%><fmt:message key="product.itemfound.2"/></p>
    	
        <div class="list-group productCat">
        	
        	<%
        	int count = 0;
        	for(ProductBean product: products ){ 
        		int availableQty = ProductService.getInstance().getProductAvailableQuantity(product.getProductQty().get(0).getPqid());
        	    
        		ProductPriceBean price = product.getProductPrice().get(0);
        		MerchantBean merchant = MerchantService.getInstance().getFrontBeanById(product.getMerchantCode());
        		CategoryBean cat = CategoryService.getInstance().getFrontBeanById(product.getCategoryid());
        		
        		if(merchant == null) merchant = new MerchantBean();
        		if(category == null) category = new CategoryBean();
        		
        		
        		String productName = StringUtil.filter(product.geteName());
        		String merchantName = StringUtil.filter(merchant.getEname());
        		String productPrice = "";
        		
        		String gaEEPrice = "";
        		String gaEEPoints = "";
        		String gaEEListName = StringUtil.filter(parentCat.geteName()) + " List";
        		String gaEENavPath = basePath + "productDetails?pid=" + product.getId() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;

        		if(!isEng) {
        			productName = StringUtil.filter(product.getcName());
        			merchantName = StringUtil.filter( merchant.getCname());
        		}
        		
        		productPrice = StringUtil.formatCurrencyPrice(price.getPrice());
        		gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice());
        		
        		if(price.getEnableEB() == StaticValueUtil.PRODUCT_ENABLE && price.getDiscount() > 0 && 
        				price.getEbStartDate() != null && price.getEbEndDate() != null){
        			
        			if(price.getEbStartDate().before(now) && price.getEbEndDate().after(now)){
        				productPrice = StringUtil.formatCurrencyPrice(price.getDiscount()) + 
            					" <small><del class=\"text-gray\">" + StringUtil.formatCurrencyPrice(price.getPrice()) + "</del></small>";
            			
        				gaEEPrice = StringUtil.formatIndexPrice2(price.getDiscount());
        			}
        			/*earlyBirdStr = "Early Bird Discount Valid From " + DateUtil.formatDate(price.getEbStartDate()) + " Until " +
        						   DateUtil.formatDate(price.getEbEndDate());*/
        		}else if(price.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE){
        			EcoPointBean point = EcoPointService.getInstance().getFrontBeanById(price.getEpid());
        			
        			if(point != null) {
        				double discount = (point.getRatio() * point.getPoints());
        				
        				productPrice = "<span class='text-primary'>" + StringUtil.formatCurrencyPrice(price.getPrice() - discount) +  
        						"</span> + <span class='text-success'>" + StringUtil.formatIndexPrice(point.getPoints()) 
        						+"<small> " + I18nUtil.getString("product.select.ecopoint", lang) + "</small></span>";
						
        				gaEEPrice = StringUtil.formatIndexPrice2(price.getPrice() - discount);
        				gaEEPoints = StringUtil.formatIndexPrice2(point.getPoints());
        			}
        		}
        		
        	
        		count++;
        		gaEEList += StringUtil.getGAEEProductList(StringUtil.formatGAEEProductName(product.geteName()), String.valueOf(product.getId()),
           					gaEEPrice, StringUtil.filter(merchant.getEname()), StringUtil.filter(cat.geteName()), 
           					gaEEPoints, StringUtil.filter(parentCat.geteName()), String.valueOf(count));
        	%>
            <!-- <a href="productDetails?pid=<%=product.getId()%>&type=web" class="list-group-item"> -->															
	<a href="javascript:onNavClick(<%=product.getId()%>,'<%=StringUtil.formatGAEEProductName(product.geteName())%>','<%=gaEEPrice %>','<%=StringUtil.filter(merchant.getEname())%>','<%=StringUtil.filter(cat.geteName())%>','<%=gaEEPoints%>',<%=count %>,'<%=gaEEListName%>','<%=gaEENavPath%>')" class="list-group-item">
          <div class="media">
            <div class="media-left"> <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="<%=basePath %>GetImageFileServlet?&name=<%=StringUtil.filter(product.getImage1()) %>" class="media-object" width="80px"> </div>
            <div class="media-body">
              <p><b><%=productName %></b></p>
              <!--  <p class="text-primary">HK$ 5,990 <small><del class="text-gray">HK$ 5,990</del></small></p> -->
              <p class="text-primary"><%=StringUtil.filter(productPrice) %></p>
              <%if(!"".equals(merchantName)){ %>
              	<p><!--<fmt:message key="product.detail.manufacture.name"/> : --><%=StringUtil.filter(merchantName) %></p>
              <%} %>
              <%if(availableQty < 1){ 
            	  String customstockmsg = CustomStockItemService.getInstance().returnCustomStockMsg(product.getId(), StaticValueUtil.ITEM_PRODUCT, lang);
              %>
              		<p class="text-danger"><%=StringUtil.filter(customstockmsg)%></p>
					<!--  <p class="text-danger"><fmt:message key="text.soldout"/></p> -->
			  <%} %>
            </div>
            <div class="media-right media-middle"><em class="fa fa-chevron-right text-primary"></em></div>
          </div>
          </a>
          
          <%} %>

      </div><!--list-group productCat-->

	<%if(products.size() > 0){ 
		String navPath = "productList?actionType=search&categoryId=" + categoryId + "&parentId=" + parentId + "&" + 
						 SessionName.sorting + "=" + sorting +
						 "&filterAppliance=" + filterAppliance + "&filterBrand=" + filterBrand + "&filterPrice=" + filterPrice +
						 "&filterPriceList=" + filterPriceList + "&filterBrandList=" + filterBrandList + 
						 "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB + "&pageIdx=";
		
	%>
	  <div class="row text-center">
		<%//StringUtil.getCategoryPagingString(5, pageIdx, totalPages, "AdminCategoryServlet?actionType=getCategoryList&pageIdx=") %>
		<%=StringUtil.getFrontPagingString(5, pageIdx, totalPages, navPath) %>
 	 </div>
	<%} %>
	</div><!--category  categorypg col-sm-18 col-xs-24 pg ended -->

</div><!--row-->
</div><!--container-->
</section>

<jsp:include page="footer.jsp" />

<script type="text/javascript">
 $(document).ready(function(){
	    $("#resetButton").click(function(){
	        $("div[name='resetDiv']").removeClass("active");
	        $("input[name='appliances']").removeAttr("checked");
	        $("input[name='brands']").removeAttr("checked");
	        $("input[name='prices']").removeAttr("checked");
	    });
	    
	    $("#resetButton2").click(function(e){
	        $("div[name='resetDiv']").removeClass("active");
	        $("input[name='appliances']").removeAttr("checked");
	        $("input[name='brands']").removeAttr("checked");
	        $("input[name='prices']").removeAttr("checked");
	        e.stopPropagation();
	    });
	    if(<%=isGAEEEnable%>){
	    	<%=StringUtil.getGAEEFullConfig(gaEEList, StaticValueUtil.GAEE_PROD_IMPRESSION, "")%>	
	    }
	});
 
</script>
<script type="text/javascript" src="<%=basePath %>js/gaee.js" ></script>

</body>
</html>