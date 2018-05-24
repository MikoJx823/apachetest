<%@ page language="java" import="java.sql.*,java.util.Calendar,java.util.*,com.project.pulldown.*,com.project.bean.*,com.project.service.*,com.project.util.*" contentType="text/html; charset=utf-8"%>
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
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute("cartMap");

	String soldoutErrorMsg = request.getSession().getAttribute("soldoutErrorMsg")==null?"":(String) request.getSession().getAttribute("soldoutErrorMsg");
	
	MemberBean member = (MemberBean)request.getSession().getAttribute(SessionName.loginMember);
	
	
	if(cartMap == null) {
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_MOBILE);
		requestDispatcher.forward(request, response);
		return;
	}
	
    OrderBean orderBean = (OrderBean) request.getSession().getAttribute("orderBean");
	if (orderBean == null)
		orderBean = new OrderBean();
	
	
	boolean isMember = false;
	boolean isLowMember = false;
	boolean isEmailDisplay = true;
	boolean isContactDisplay = true;
	if(member != null){
		if(member.getUserType() == StaticValueUtil.USER_MEMBER){
			isMember = true;
			
			if(StringUtil.filter(member.getLoginLevel()).equals(StaticValueUtil.API_LOGIN_LEVEL_L)){
				isLowMember = true;
				
				/*if(StringUtil.filter(orderBean.getBuyerEmail()).equals(StringUtil.filter(member.getAccount().getEmail()))){
					isEmailDisplay = false;
				}*/
				
				if(StringUtil.filter(orderBean.getBuyerPhone()).equals(StringUtil.filter(member.getAccount().getMobile()))){
					isContactDisplay = false;
				}
			}
		}
			
	}
	
	
	
	
	
	
	boolean isPickup = true;
	boolean isDelivery = false;
	if (cartMap!=null && !cartMap.isEmpty()){
		for (Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
			String key = entry.getKey();
	  		OrderItemBean orderItem = entry.getValue();
	  		if(orderItem.getCollectMethod() == StaticValueUtil.product_Delivery || 
	  				orderItem.getCollectMethod() == StaticValueUtil.product_Install || 
	  				orderItem.getCollectMethod() == StaticValueUtil.ECOREWARD_COUPON) {
	  			isPickup = false;
	  		}
	  		
	  		if(orderItem.getCollectMethod() == StaticValueUtil.product_Delivery) {
	  			isDelivery = true;
	  		}
		}
	}
	
	
	
	String cEmail= "";
	String cContact = "";
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


<form action="<%=basePath %>checkout" method="post" id="infoForm" name="infoForm">
	<input type="hidden" name="actionType" value="payment">
	<input type="hidden" name="lang" value="<%=lang%>">
	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">

<section>
<div class="categorypg container">
   <div class="row">
            <div class="col-xs-24 visible-xs visible-sm mt-15">
<p class="text-center mb-15 text-primary"><b><fmt:message key="checkout.progress.confirmation"/>   </b></p>
<ul class=" step list-unstyled">
        <li><div></div></li>
        <li><div></div></li>
        <li class="active"><div></div></li>
        <li><div></div></li>
    </ul>
</div> 
<div class="col-xs-24"> <h1 class="text-primary"><fmt:message key="checkout.title"/></h1></div>
      <div class="col-xs-24 hidden-xs hidden-sm">
        <div class="wizard bg-white">
          <a class="finish"><span class="badge">1</span><b><fmt:message key="checkout.cart.summary"/></b></a>
          <a class="finish"><span class="badge">2</span><b><fmt:message key="checkout.delivery.information"/> </b></a>
          <a class="finish current"><span class="badge">3</span><b><fmt:message key="checkout.progress.confirmation"/>  </b></a>
          <a><span class="badge">4</span><b><fmt:message key="checkout.progress.payment"/>  </b></a> 
 
          </div>
      </div>
    </div>    <div class="clearfix"></div>

    
     <h5 class="text-primary"><fmt:message key="checkout.personal.info"/></h5>

     <div class="row">
     <%
     String name = ""; 
     String title=TitlePulldown.getText(StringUtil.filter(orderBean.getBuyerTitle()),lang);
	  	if(!isEng){
	  		name =  StringUtil.filter(orderBean.getBuyerCname());
	  	}
	  	
	  	if(StringUtil.filter(name).equals("")) {
			name = StringUtil.filter(orderBean.getBuyerEname());
		}
  	 %>
     <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="checkout.form.name"/></label>
     	<% if (!isEng){ %>
     	<p class="form-control-static"><%=name %> <%=title %></p>
     	<% } else{ %>
     	<p class="form-control-static"><%=title %> <%=name %></p>
     	<%}%>
     </div>

      <% 
       /*if(isMember){  
    		if(!"".equals(StringUtil.filter(member.getAccount().getEmail())) ){
    			cEmail = StringUtil.filter(member.getAccount().getEmail());
       %>
       <!-- <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="checkout.form.email"/></label>
        	<p class="form-control-static"><%=StringUtil.filter(member.getAccount().getEmail()) %></p>
        </div> -->
        <%	}
     	  } */
     	  %>  
        
        <%
        /*if(isMember){  
     		if(!"".equals(StringUtil.filter(member.getAccount().getMobile())) ){
     			cContact = StringUtil.filter(member.getAccount().getMobile());
        %>
        <!--  <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="checkout.form.contact"/></label>
     		<p class="form-control-static"><%=StringUtil.filter(member.getAccount().getMobile()) %></p>
        </div> -->
       <%	}
     	  } */ %> 
     
     
    </div>
    	
    	
    
        <h5 class="text-primary"><fmt:message key="checkout.delivery.information.2"/></h5>
		
		<%//if(!isLowMember){%>
		<%if(isEmailDisplay || isContactDisplay) {%>
		<div class="row">
		
		<%if(isEmailDisplay){ %>
		<div class="form-group col-md-8 col-sm-12">
	    	<label><fmt:message key="checkout.form.email"/></label>
	        <p class="form-control-static"><%=StringUtil.filter(orderBean.getBuyerEmail()) %></p>
     	</div>
     	<%} %>
		
		<%if(isContactDisplay) { %>
	     <div class="form-group col-md-8 col-sm-12">
	     	<label><fmt:message key="checkout.form.contact"/></label>
	     	<p class="form-control-static"><%=StringUtil.filter(orderBean.getBuyerPhone()) %></p>
	     </div>
	     <%} %>
	     
		</div>
		<%} %>
		
		<%if(!isPickup) { 
			String address = "";
			boolean engAdd = false;
			
			/*if(!isEng){
				address = StringUtil.filter(orderBean.getBuyerCAddress1());
				
				if(!"".equals(StringUtil.filter(orderBean.getBuyerCAddress2()))){
					address += ", " + orderBean.getBuyerCAddress2();
				}
				if(!"".equals(StringUtil.filter(orderBean.getBuyerCAddress3()))){
					address += ", " + orderBean.getBuyerCAddress3();
				}
				if(!"".equals(StringUtil.filter(orderBean.getBuyerCAddress4()))){
					address += ", " + orderBean.getBuyerCAddress4();
				}
			}*/
			
			if("".equals(address)){
				engAdd = true;
				address = StringUtil.filter(orderBean.getBuyerAddress1()).equals("")? "" : (StringUtil.filter(orderBean.getBuyerAddress1()) + ", ");
				
				if(!"".equals(StringUtil.filter(orderBean.getBuyerAddress2()))){
					address += orderBean.getBuyerAddress2() + ", ";
				}
				if(!"".equals(StringUtil.filter(orderBean.getBuyerAddress3()))){
					address += orderBean.getBuyerAddress3() + ", ";
				}
				if(!"".equals(StringUtil.filter(orderBean.getBuyerAddress4()))){
					address += orderBean.getBuyerAddress4() + ", ";
				}
				
				if(address.endsWith(", ")){
					address = address.substring(0, address.length() - 2);
				}
			}
			
			
			//If MASKING REQUIRED 
			if(orderBean.getIsCLPAddress() == StaticValueUtil.PRODUCT_ENABLE && isMember) {
				if(StringUtil.filter(member.getLoginLevel()).equals(StaticValueUtil.API_LOGIN_LEVEL_L)){
					
					if(!engAdd){
						address = StringUtil.maskAddress(orderBean.getBuyerCAddress1(), orderBean.getBuyerCAddress2(), 
								orderBean.getBuyerCAddress3(), orderBean.getBuyerCAddress4());
					}else{
						address = StringUtil.maskAddress(orderBean.getBuyerAddress1(), orderBean.getBuyerAddress2(), 
								orderBean.getBuyerAddress3(), orderBean.getBuyerAddress4());
					}
				}
			}

		%>

		<div class="row">
		<div class="form-group col-xs-24">
	     	<label><fmt:message key="checkout.form.address"/></label>
	     	<p class="form-control-static"><%=StringUtil.filter(address) %></p>
	     </div>
     	</div>
		
		<%} %>
		
		<jsp:include page="checkoutTnc.jsp" />
		
		
		
		
		<div class="col-xs-4 col-xs-offset-20 hidden"><img src="../clp/images_web/visa-mastercard.gif" class="img-responsive"/> <br></div>
	<div class="col-xs-24 text-right mb-20">
	 <a class="btn btn-success btn-success-line" id="backButton" href="javascript:onBack();"><%=I18nUtil.getString("checkout.edit", lang)%> </a>  
     <input type="button" id="payButton" class="btn btn-success" onclick="return onSubmit();" value="<%=I18nUtil.getString("checkout.confirm.checkout", lang)%>" >
     </div>
     
     <div class="row">
		<div class="form-group col-xs-24">
		<p><fmt:message key="checkout.merchant"/></p>
		<label class="text-danger"><fmt:message key="checkout.footnote"/></label>
		</div>
	</div>
     
	</div><!--category pg ended-->   
    
	
     
</section>
</form>


<jsp:include page="footer.jsp" />
<script type="text/javascript">

function onBack(){
	//window.history.back();
	
	 var form = document.createElement("form");
	 var element3 = document.createElement("input");  
	 var element4 = document.createElement("input");
	    
	 form.method = "POST";
	 form.action = "<%=basePath%>checkout";   

	 element3.value="checkout2";
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

function onSubmit(){

	if(! ($("#tncCheckout").is(':checked'))){
		alert("<fmt:message key="error.checkout.tnc.required"/>");
		return false;
	}
	
	$("#payButton").addClass('hidden');
	$("#backButton").addClass('hidden');
	
	
	dataLayer.push({
		'event': 'checkout',
			'ecommerce': {
		      'checkout': {
		        'actionField': {'step': '5'}
		     }
		   },
			'eventCallback': function() {
				MM_findObj("infoForm").submit();
		   }
	});
	
	
	
	//return true;
}

</script>
</body>
</html>