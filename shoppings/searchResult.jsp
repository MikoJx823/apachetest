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
	//List<ProductBean> products = (List<ProductBean>)request.getAttribute(SessionName.products) == null ? new ArrayList<ProductBean>() : (List<ProductBean>)request.getAttribute(SessionName.products);
	List<String> searchResult = (List<String>)request.getAttribute(SessionName.searchResult) == null ? new ArrayList<String>() : (List<String>)request.getAttribute(SessionName.searchResult);
	
	String searchKey = StringUtil.filter((String) request.getAttribute("key"));
	String sorting = StringUtil.filter((String)request.getAttribute(SessionName.sorting));
	
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
	int itemCount = StringUtil.trimToInt(request.getAttribute(SessionName.itemCount));
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	boolean isEng = I18nUtil.isEng(request);
	String lang = I18nUtil.getLang(request);
	
	//FOR GA EE 
	String gaEEList = "";
	boolean isGAEEEnable = false;
	if(searchResult.size() > 0) isGAEEEnable = true;
	
	//request.getSession().invalidate();
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

<!--header-->


<section>
<div class="categorypg container">
	<ol class="breadcrumb">
		<li><a href="<%=basePath %>index.jsp?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB%>"><fmt:message key="breadcrumb.home" /></a></li>				
		<li class="active"><fmt:message key="header.search.title"/></li>
	</ol>
	
    <h1 class="text-primary">
   		<fmt:message key="header.search.title"/>
    	<!--<fmt:message key="category.all"/> -->
    </h1>

    	<%//if(products.size() > 0 ){  %>
    	<%if(searchResult.size() > 0) { %>
    	
    	<p class="small mt-10 mb-10"><fmt:message key="search.itemfound.1"/>
    	<b class="text-green"><%=itemCount%><fmt:message key="search.itemfound.2"/></p> 
    	
        <div class="list-group productCat">
        	
        	<%/*for(ProductBean product: products ){ 
        		ProductPriceBean price = product.getProductPrice().get(0);
        		String productName = StringUtil.filter(product.geteName());
        		String productPrice = "";
        		
        		if(!isEng) {
        			productName = StringUtil.filter(product.getcName());
        		}
        		
        		if(price.getOrginalPrice() > price.getPrice()){
        			productPrice = StringUtil.formatCurrencyPrice(price.getPrice()) + " <small><del class=\"text-gray\">" + 
        						   StringUtil.formatCurrencyPrice(price.getOrginalPrice()) + "</del></small>";
        		}else {
        			productPrice = StringUtil.formatCurrencyPrice(price.getPrice());
        		}*/
        		
        		int count = 0;
				for(String result : searchResult) {
        			int availableQty = 0;
        			String nameStr = "";
        			String path = "";
        			String priceStr = "";
        			String imageStr = "";
        			String merchantName = "";
        			
        			ProductBean product = ProductService.getInstance().getFrontBeanById(StringUtil.strToInt(result.replace(ItemTypePulldown.PREFIX_PRODUCT,"")));
        			ProductPriceBean price = product.getProductPrice().get(0);
        				
        			availableQty = ProductService.getInstance().getProductAvailableQuantity(product.getProductQty().get(0).getPqid());
        				
        			if(product != null) {
        				MerchantBean merchant = MerchantService.getInstance().getFrontBeanById(product.getMerchantCode());
            			CategoryBean category = CategoryService.getInstance().getFrontBeanById(product.getCategoryid());
            				
        				if(merchant == null) merchant = new MerchantBean();
        				if(category == null) category = new CategoryBean();
        					
        					path = basePath + "productDetails?pid=" + product.getId() + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
        					imageStr = basePath + "GetImageFileServlet?&name=" + StringUtil.filter(product.getImage1());
        					
        					nameStr = StringUtil.filter(product.geteName());
        					merchantName = StringUtil.filter(merchant.getEname());
        					
        					if(!isEng) {
        						nameStr = StringUtil.filter(product.getcName());
        						merchantName = StringUtil.filter( merchant.getCname());
        					}
        					
        					priceStr = StringUtil.formatCurrencyPrice(price.getPrice());
        					
        					if(price.getEnableEB() == StaticValueUtil.PRODUCT_ENABLE && price.getDiscount() > 0 && 
        	        				price.getEbStartDate() != null && price.getEbEndDate() != null){
        	        			if(price.getEbStartDate().before(new Date()) && price.getEbEndDate().after(new Date()) ){
        	        				priceStr = StringUtil.formatCurrencyPrice(price.getDiscount()) + " <small><del class=\"text-gray\">" + 
        		        				  	   StringUtil.formatCurrencyPrice(price.getPrice()) + "</del></small>";
        	        				

        	        			}
        	        		}
        					
        				}
        			
        	%>
            <a href="<%=StringUtil.filter(path) %>" class="list-group-item"> 
          	<div class="media">
            <div class="media-left"> <img src="<%=StringUtil.filter(imageStr) %>" class="media-object"> </div>
            <div class="media-body">
              <p><b><%=StringUtil.filter(nameStr) %></b></p>
              <!--  <p class="text-primary">HK$ 5,990 <small><del class="text-gray">HK$ 5,990</del></small></p> -->
              <p class="text-primary"><%=StringUtil.filter(priceStr) %></p>
              <%if(!"".equals(merchantName)){ %>
              		<p><%=StringUtil.filter(merchantName) %></p>
              	<%} %>
              <%if(availableQty < 1){ 
            	  	
              %>
			  	<p class="text-danger"><fmt:message key="text.soldout"/></p>
			  <%} %>
            </div>
            <div class="media-right media-middle"><em class="fa fa-chevron-right text-primary"></em></div>
          </div>
          </a>
          
          <%} %>

      </div><!--list-group productCat-->
	 
	 <%}else { %>
	 		<fmt:message key="search.no.result"/>
	 <%} %>
	 
	<%if(searchResult.size() > 0){ 
		String navPath = "search?key=" + searchKey + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB + "&pageIdx=";
	%>
	  <div class="row text-center">
		<%=StringUtil.getFrontPagingString(5, pageIdx, totalPages, navPath) %>
 	 </div>
	<%} %>
	</div><!--category pg ended-->
</section>


<jsp:include page="footer.jsp" />
<script type="text/javascript">
(function () {

}());

</script>
</body>
</html>