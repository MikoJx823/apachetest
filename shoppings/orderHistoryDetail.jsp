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
	
	boolean isEng = I18nUtil.isEng(request);
	String lang = I18nUtil.getLangHtml(request).equals("en")?"E":"C";  
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	MemberBean member = (MemberBean)request.getSession().getAttribute(SessionName.loginMember);
    boolean isMember = false;
    boolean isLowMember = false;
	if(member != null){
		if(member.getUserType() == StaticValueUtil.USER_MEMBER){
			isMember = true;
			
			if(StringUtil.filter(member.getLoginLevel()).equals(StaticValueUtil.API_LOGIN_LEVEL_L)){
				isLowMember = true;
			}
		}	
	}
	
	if(!isMember){
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_WEB);
		requestDispatcher.forward(request, response);
		return;
	}
	
	String oid = StringUtil.filter(request.getParameter("oid"));
	
	OrderBean order = OrderService.getInstance().getFrontDetailByOrderId(oid);
	
	if(order == null){
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_WEB);
		requestDispatcher.forward(request, response);
		return;
	}
	
	if(!order.getMemberid().equals(member.getToken().getContractAccount())){
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_WEB);
		requestDispatcher.forward(request, response);
		return;
	}
	
	//language settings 
	if(!"".equals(StringUtil.filter(request.getParameter("lang")))){
		I18nUtil.setLang(request, request.getParameter("lang"));
	}
		
	String returnUrl = "shoppings/orderHistoryDetail.jsp?oid=" + oid;
	request.setAttribute(SessionName.servletUrl, returnUrl);
	
	String orderHistoryPath= basePath + "history?type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
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
	<ol class="breadcrumb">
		<li><a href="<%=basePath %>index.jsp?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB%>"><fmt:message key="breadcrumb.home" /></a></li>				
		<li><a href="<%=orderHistoryPath %>"><fmt:message key="header.history.title"/></a></li>
		<li class="active"><fmt:message key="history.detail.title"/></li>
	</ol>
    <h5 class="text-primary"><fmt:message key="history.detail.title"/></h5>
    <div class="row">

     <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="history.detail.ref"/></label>
        <p class="form-control-static"><%=StringUtil.filter(order.getOrderRef()) %></p>
        </div>
        
         <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="history.detail.status"/></label>
        <p class="form-control-static"><%=OrderStatusPulldown.getNameByLanguage(order.getOrderStatus() ,lang) %></p>
        </div>
        
        <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="history.detail.date"/></label>
        <p class="form-control-static"><%=DateUtil.formatDate(order.getTransactiondate()) %></p>
        </div>
        

 </div><!--row-->
    <div class="clearfix"></div>
    
     <h5 class="text-primary"><fmt:message key="history.detail.personal.info"/></h5>

     <div class="row">
     <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="history.detail.name"/></label>
     	
     	<%/*String name =  + " " +  StringUtil.filter(order.getBuyerEname());
     	if(!isEng){
     		name=StringUtil.filter(order.getBuyerCname());
     	}*/
     	String name = "";
     	if(!isEng) {
			name = StringUtil.filter(order.getBuyerCname());
		}
		if(StringUtil.filter(name).equals("")) {
			name = StringUtil.filter(order.getBuyerEname());
		}
     	
     	
     	%>
        <p class="form-control-static"><%=StringUtil.filter(order.getBuyerTitle())%> <%=name%></p>
        </div><!--<div col-md-8 col-sm-12-->

		<%if(!isLowMember){ %>
         <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="history.detail.email"/></label>
        <p class="form-control-static"><%=StringUtil.filter(order.getBuyerEmail()) %></p>
        </div>
        <%} %>
        
        <%if(!isLowMember){ %>
        <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="history.detail.contact"/></label>
        <p class="form-control-static"><%=StringUtil.filter(order.getBuyerPhone()) %></p>
        </div>
        <%} %>
        
        <%if(!"".equals(StringUtil.filter(order.getBuyerAddress1())) || !"".equals(StringUtil.filter(order.getBuyerAddress2())) ||
        	 !"".equals(StringUtil.filter(order.getBuyerAddress3())) || !"".equals(StringUtil.filter(order.getBuyerAddress4())) ) {	
        	
        	String address = "";
        	
            /*if(!isEng && !"".equals(StringUtil.filter(order.getBuyerCAddress1())) ) {
            	address = (StringUtil.filter(order.getBuyerCAddress1()).equals("")?"" : StringUtil.filter(order.getBuyerCAddress1()) + ", " )+ 
            			  (StringUtil.filter(order.getBuyerCAddress2()).equals("")?"" : StringUtil.filter(order.getBuyerCAddress2()) + ", " )+ 
	        			  (StringUtil.filter(order.getBuyerCAddress3()).equals("")?"" : StringUtil.filter(order.getBuyerCAddress3()) + ", " )+ 
	        			  (StringUtil.filter(order.getBuyerCAddress4()).equals("")?"" : StringUtil.filter(order.getBuyerCAddress4()) );
        		
            	if(address.endsWith(", ")) {
            		address = address.substring(0, address.length() - 1);
            	}
            	
            	if(isLowMember) {
                	address = StringUtil.maskAddress(StringUtil.filter(order.getBuyerCAddress1()), StringUtil.filter(order.getBuyerCAddress2()), 
                			StringUtil.filter(order.getBuyerCAddress3()), StringUtil.filter(order.getBuyerCAddress4()));
                }
            	
            }else{*/
        		address = (StringUtil.filter(order.getBuyerAddress1()).equals("")?"" : StringUtil.filter(order.getBuyerAddress1()) + ", " )+ 
        				  (StringUtil.filter(order.getBuyerAddress2()).equals("")?"" : StringUtil.filter(order.getBuyerAddress2()) + ", " )+ 
	        			  (StringUtil.filter(order.getBuyerAddress3()).equals("")?"" : StringUtil.filter(order.getBuyerAddress3()) + ", " )+ 
	        			  (StringUtil.filter(order.getBuyerAddress4()).equals("")?"" : StringUtil.filter(order.getBuyerAddress4()) + ", ");
        		
        		if(address.endsWith(", ")) {
            		address = address.substring(0, address.length() - 2);
            	}
        		
        		if(isLowMember) {
                	address = StringUtil.maskAddress(StringUtil.filter(order.getBuyerAddress1()), StringUtil.filter(order.getBuyerAddress2()), 
                			StringUtil.filter(order.getBuyerAddress3()), StringUtil.filter(order.getBuyerAddress4()));
                }
            //} 
            
            
        
        %>
        <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="history.detail.address"/></label>
        <p class="form-control-static"><%=address %></p>
        </div>
        <%} %>
        

       </div><!--row-->
       
       <h5 class="text-primary"><fmt:message key="history.detail.order.info"/></h5>
        <!--item detail-->
        
        <div class="tbl checkoutTable">
    
    <div class="tbl-header hidden-xs">
    <div class="tbl-cell ch-img"><fmt:message key="history.detail.product"/></div>
    <div class="tbl-cell ch-name"></div>
  	<div class="tbl-cell ch-unit"><fmt:message key="history.detail.quantity"/></div>
  	<div class="tbl-cell ch-qty"><fmt:message key="history.detail.delivery"/></div>
    <div class="tbl-cell ch-unit"><fmt:message key="history.detail.unit.price"/></div>
    <div class="tbl-cell ch-sub"><fmt:message key="history.detail.subtotal"/></div>
    </div> <!--head-->
    
    <div class="tbl-footer">
    
    <%for(OrderItemBean orderItem : order.getOrderItems()){ 
    	
    	String subTotalStr = "";
    	String priceStr = "";
    	String productName = orderItem.getProdEname();
 		String collectMethod = "";
    	
    	if(!isEng){
    		productName = orderItem.getProdCname();
    	}
    	
    	if(orderItem.getPrice() > 0){
   		 subTotalStr = StringUtil.formatCurrencyPrice(orderItem.getPrice() * orderItem.getQuantity());
       	 priceStr = StringUtil.formatCurrencyPrice(orderItem.getPrice());
       	 
       	 if(orderItem.getEcopoint() > 0 ){
    			priceStr += " + ";
    			subTotalStr += " + " ;
    		}
   		}
    	
    	if(orderItem.getEcopoint() > 0 ){
    		priceStr += StringUtil.formatIndexPrice(orderItem.getEcopoint()) + " " + I18nUtil.getString("history.detail.ecopoint2", lang)  ;
    		subTotalStr += StringUtil.formatIndexPrice(orderItem.getEcopoint() * orderItem.getQuantity()) + " " + 
    		I18nUtil.getString("history.detail.ecopoint2", lang)  ;
        	
    	}
    	
    	if(orderItem.getPid() == 0){
    		collectMethod = CollectionEcoRewardTypePulldown.getTextByLanguage(orderItem.getCollectMethod(), lang);
    	}else {
    		collectMethod = CollectionProductTypePulldown.getTextByLanguage(orderItem.getCollectMethod(), lang);
    		if(orderItem.getCollectMethod() == StaticValueUtil.product_PickUp){
				OrderPickupInfoBean pickup = OrderPickupService.getInstance().getFrontBeanByOrderItemId(orderItem.getId());
				if(!isEng){
					collectMethod += "-" + pickup.getBranchcname();
				}else {
					collectMethod += "-" + pickup.getBranchename();
				}
			}
    	}
    %>
    
    <div class="tbl-row">
    <div class="tbl-cell ch-img"> <a><img src="<%=basePath %>GetImageFileServlet?&name=<%=StringUtil.filter(orderItem.getProductImage()) %>" class="img-responsive"></a></div>
    <div class="tbl-cell ch-name"><b><%=StringUtil.filter(productName) %></b></div>
    <div class="tbl-cell ch-qty small"><p class=" visible-xs-inline-block"><fmt:message key="history.detail.quantity"/>: </p><%=orderItem.getQuantity() %> </div>
    <div class="tbl-cell ch-unit small"><p class=" visible-xs-inline-block"><fmt:message key="history.detail.delivery"/>: </p><b class="item-detail"><%=StringUtil.filter(collectMethod) %></b></div> 
    <div class="tbl-cell ch-unit small"><p class=" visible-xs-inline-block"><fmt:message key="history.detail.unit.price"/>: </p><b class="item-detail"><%= priceStr%> </b></div>
    <div class="tbl-cell ch-sub small"><p class=" visible-xs-inline-block"><fmt:message key="history.detail.subtotal"/>: </p><b class="item-detail"><%=subTotalStr %></b></div> 
    </div> <!--tbl-row-->
	
	<%} %>
</div> <!--tbl-footer-->
 </div><!--checkoutTBl-->

    
     <div class=" result-tbl  col-md-12  col-sm-24 pull-right  col-sm-pull-0">
     <div class="tbl">
    
    <%if(order.getDiscountEco() > 0) { %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="history.detail.discount.eco"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatIndexPrice(order.getDiscountEco()) %></div>
    </div>
    <%} %>
    
    <%if(order.getEcoPoint() > 0 ){ %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="history.detail.ecopoint"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatIndexPrice(order.getEcoPoint()) %></div>
    </div>
    <%} %>
    
    <%if(order.getDeliveryAmount() > 0) { %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="history.detail.delivery.fee"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(order.getDeliveryAmount()) %></div>
    </div>
    <%} %>
    
    <%if(order.getInstallAmount() > 0) { %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="history.detail.install"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(order.getInstallAmount()) %></div>
    </div>
    <%} %>

    <%if(order.getDiscountAmount() > 0) { %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="history.detail.discount"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(order.getDiscountAmount()) %></div>
    </div>
    <%} %>
     
    <%if(order.getPromotionAmount() > 0) { %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="history.detail.discount.promotion"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(order.getPromotionAmount()) %></div>
    </div>
    <%} %>
     
    <%if(order.getTotalAmount() > 0 ){ %>
     <div class="tbl-row">
    <div class="tbl-cell ch-unit"><b><fmt:message key="history.detail.total"/></b></div>
    <div class="tbl-cell ch-sub"><%=StringUtil.formatCurrencyPrice(order.getTotalAmount()) %> </div>
    </div>
  	<%} %>

    </div><!--tbl-->
    </div>	<!--result-tbl-->
<div class="row">
<div class="col-xs-24">
	 <a class="btn btn-success btn-success-line" href="javascript:onBack();"><%=I18nUtil.getString("hisotry.detail.back", lang)%> </a>  
     </div>
	
</div><!--category pg ended-->   
</section>

<jsp:include page="footer.jsp" />
<script type="text/javascript">

function onBack(){
	window.history.back();
}

</script>
</body>
</html>


