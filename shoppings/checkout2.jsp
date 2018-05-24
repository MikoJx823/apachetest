<%@ page language="java" import="java.sql.*,java.util.Calendar,java.util.*,com.asiapay.clp.pulldown.*,com.asiapay.clp.bean.*,com.asiapay.clp.service.*,com.asiapay.clp.util.*" contentType="text/html; charset=utf-8"%>
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
	List<OrderItemBean> orderItems = new ArrayList<OrderItemBean>();
	HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute("cartMap");

	String soldoutErrorMsg = request.getSession().getAttribute("soldoutErrorMsg")==null?"":(String) request.getSession().getAttribute("soldoutErrorMsg");
	
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
	
	if(cartMap == null) {
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_MOBILE);
		requestDispatcher.forward(request, response);
		return;
	}
	
    OrderBean orderBean = (OrderBean) request.getSession().getAttribute("orderBean");
	if (orderBean == null)
		orderBean = new OrderBean();
	
	boolean isPickup = true;
	boolean isDelivery = false;
	if (cartMap!=null && !cartMap.isEmpty()){
		for (Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
			String key = entry.getKey();
	  		OrderItemBean orderItem = entry.getValue();
	  		orderItems.add(orderItem);
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
	
	//START CHECK IF IS CUMULATIVE DISCOUNT 
	/*boolean isCumulativeDiscount = false;
	ProductDiscountBean productDiscount = ProductDiscountService.getInstance().getBeanById();
		
	if(orderItems.size() > 0){
		if(isMember && ProductDiscountService.getInstance().isDiscountEnable(StaticValueUtil.DISPLAY_WEB)){
			if(ProductDiscountService.getInstance().isDiscountEnable(productDiscount, orderItems, member)){
				isCumulativeDiscount = true;
			}
		}
	}*/
	//END CHECK IF IS CUMULATIVE DISCOUNT 
	
	String cEmail= "";
	String cContact = "";
	String address = "";
	String clpAddress = "";
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
	<input type="hidden" name="actionType" value="checkout3">
	<input type="hidden" name="lang" value="<%=lang%>">
	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">

<section>
<div class="categorypg container">
    
   <div class="row">
      <div class="col-xs-24 visible-xs visible-sm  mt-15">
<p class="text-center mb-15 text-primary"><b><fmt:message key="checkout.delivery.information"/>   </b></p>
<ul class=" step list-unstyled">
        <li><div></div></li>
        <li class="active"><div></div></li>
        <li><div></div></li>
        <li><div></div></li>
    </ul>
</div> 
<div class="col-xs-24"> <h1 class="text-primary"><fmt:message key="checkout.title"/></h1></div>
      <div class="col-xs-24 hidden-xs hidden-sm">
        <div class="wizard bg-white">
          <a class="finish"><span class="badge">1</span><b><fmt:message key="checkout.cart.summary"/></b></a>
          <a class="finish current"><span class="badge">2</span><b><fmt:message key="checkout.delivery.information"/>            </b></a>
          <a><span class="badge">3</span><b><fmt:message key="checkout.progress.confirmation"/>  </b></a>
          <a><span class="badge">4</span><b><fmt:message key="checkout.progress.payment"/>  </b></a> 
 
          </div>
      </div>
    </div>    <div class="clearfix"></div>
	
    <%if(isMember){   %>
     <h5 class="text-primary"><fmt:message key="checkout.personal.info"/></h5>
     <%} %>
     
     <div class="row">
     <%
     String name = "";
     boolean isName = true;
 	 if(isMember){ 
 		if(member.getAccount() != null) { 
 			isName = false;
 			
 			String title = TitlePulldown.getText(StringUtil.filter(member.getAccount().getTitle()),lang);
 			if(!isEng) {
 				name = StringUtil.filter(member.getAccount().getChineseName());
 			}
 			if(StringUtil.filter(name).equals("")) {
 				name = StringUtil.filter(member.getAccount().getEnglishName());
 			}
 			
 			if(!"".equals(StringUtil.filter(member.getAccount().getEmail())))
    			cEmail = StringUtil.filter(member.getAccount().getEmail());
 			
 			if(!"".equals(StringUtil.filter(member.getAccount().getMobile())))
     			cContact = StringUtil.filter(member.getAccount().getMobile());
 		%>
       <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="checkout.form.name"/></label>	
		<%if(!isEng){ %>
     		<p class="form-control-static"><%=name%> <%=title %> </p>
		<%}else { %>
			<p class="form-control-static"><%=title %> <%=name%></p>
		<%} %>
      </div>

       <%if(/*!isLowMember &&*/ !"".equals(cEmail)){ %>
       <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="checkout.form.email"/></label>
        	<p class="form-control-static"><%=StringUtil.filter(member.getAccount().getEmail()) %></p>
        </div>
       <%	}  %>  
        
        <%if(!isLowMember && !"".equals(cContact)){ %>
        <div class="form-group col-md-8 col-sm-12">
     	<label><fmt:message key="checkout.form.contact"/></label>
     		<p class="form-control-static"><%=StringUtil.filter(member.getAccount().getMobile()) %></p>
        </div>
       <%	}  %> 
     	    
      <%	}
     	  } %>
        
        </div>
        
        <%if(!isLowMember || "".equals(cContact) || "".equals(cEmail) || !isPickup)  { %>
        <h5 class="text-primary"><fmt:message key="checkout.delivery.information.2"/></h5>
        <%} %>
        
		<div class="row">
		<div class="col-xs-24">
		<%if(isName){ %>
			<div class="col-md-10 col-sm-12">
		         <div class="group">
		     		<select name="title" class="focus" >
		     			<%=TitlePulldown.pulldown(lang) %>
		     		</select>
		            <label>Title</label>
		     	 </div>
			</div>
		<!--col-md-6-->
			<div class="col-md-10 col-sm-12">
	         <div class="group ">
	     	 	<input type="text" name="name" value="<%=StringUtil.filter(orderBean.getBuyerEname())%>">
			    <span class="highlight"></span>
			    <span class="bar"></span>
	      		<label><fmt:message key="checkout.form.name"/></label>
	      	 </div>
        	</div>
      </div>
      <%} %>	
      </div>
		
		
		<div class="row">
			<div class="col-xs-24">
<!--col-md-6-->
<%
	String isEmailHide = "";
	String isContactHide = "";
	String isHide = "";
	if(isLowMember) {
		
		if(!"".equals(StringUtil.filter(cEmail))){
			isEmailHide = "hidden" ;
		}else{
			if(!"".equals(StringUtil.filter(orderBean.getBuyerEmail()))){
				cEmail = orderBean.getBuyerEmail();
			}
		}
		
		if(!"".equals(StringUtil.filter(cContact))){
			isContactHide = "hidden";
		}else{
			if(!"".equals(StringUtil.filter(orderBean.getBuyerPhone()))){
				cContact = orderBean.getBuyerPhone();
			}
		}
		
		isHide = "hidden"; // for address
	}else {
		if(!"".equals(StringUtil.filter(orderBean.getBuyerEmail()))){
			cEmail = orderBean.getBuyerEmail();
		}
		
		if(!"".equals(StringUtil.filter(orderBean.getBuyerPhone()))){
			cContact = orderBean.getBuyerPhone();
		}
				
	}
%>

<div class="col-md-10 col-sm-12 <%=isEmailHide%>" id="emailInput" >
		 <div class="group ">      
	      <input type="email" value="<%=StringUtil.filter(cEmail)%>" name="email" >
	      <span class="highlight"></span>
	      <span class="bar"></span>
	      <label><fmt:message key="checkout.form.contact.email"/></label>
	    </div>
</div>
        <div class="col-md-10 col-sm-12 <%=isContactHide%>" id="contactInput" >
        <div class="group">      
	      <input type="tel" value="<%=StringUtil.filter(cContact) %>" name="contact" >
	      <span class="highlight"></span>
	      <span class="bar"></span>
	      <label><fmt:message key="checkout.form.contact.phone"/></label>
	    </div>
</div>

		</div><!--.col-xs-24-->
		</div>
		
		
		<%if(!isPickup) { 
			
		
		%>
		
<div class="col-xs-24">
	<div class="form-group">
	     	<label><fmt:message key="checkout.form.address"/></label>
	  	
		<div class="btn-group address wd-100" data-toggle="buttons">
		   <%

		   String manualAdd1 = StringUtil.filter(orderBean.getBuyerAddress1());
		   String manualAdd2 = StringUtil.filter(orderBean.getBuyerAddress2());
		   String manualAdd3 = StringUtil.filter(orderBean.getBuyerAddress3());
		   String manualAdd4 = StringUtil.filter(orderBean.getBuyerAddress4());

		   if(isMember ){ 
			   	if(member.getAddress() != null) {

			   	  if(StringUtil.filter(orderBean.getBuyerAddress1()).equals(StringUtil.filter(member.getAddress().getSupply_Eng_Street3())) ||
					 StringUtil.filter(orderBean.getBuyerAddress1()).equals(StringUtil.filter(member.getAddress().getPost_Eng_Street3())) ||
					 isLowMember	 
						){
						   manualAdd1 = "";
						   manualAdd2 = "";
						   manualAdd3 = "";
						   manualAdd4 = "";
					   }
					
	     			//member.getAddress().setPost_Eng_Street3("Test1");
	     			//member.getAddress().setPost_Eng_Street2("");
	     			//member.getAddress().setPost_Eng_Street("");
	     			//member.getAddress().setPost_Eng_Region("");
	     			
	     			//member.getAddress().setPost_Eng_HouseNum1("");
	     			//member.getAddress().setPost_Eng_District("");
	     			
	     			//member.getAddress().setSupply_Eng_Street3("");
			     	//member.getAddress().setSupply_Eng_Street2("");
			     	//member.getAddress().setSupply_Eng_Street("");
			     	//member.getAddress().setSupply_Eng_Region("");
			     	
			     	//member.getAddress().setSupply_Eng_HouseNumber1("");
					//member.getAddress().setSupply_Eng_District("");
					
	     			if((!"".equals(StringUtil.filter(member.getAddress().getPost_Eng_Street3())) ||
		     			!"".equals(StringUtil.filter(member.getAddress().getPost_Eng_Street2())) ||
		     			!"".equals(StringUtil.filter(member.getAddress().getPost_Eng_Street()))) &&
		     			!"".equals(StringUtil.filter(member.getAddress().getPost_Eng_Region()))
		     		){
		     					
						address = (StringUtil.filter(member.getAddress().getPost_Eng_Street3())).equals("")? "" : (StringUtil.filter(member.getAddress().getPost_Eng_Street3()) + ", " ) ;
				     	address += (StringUtil.filter(member.getAddress().getPost_Eng_Street2())).equals("")? "" : (StringUtil.filter(member.getAddress().getPost_Eng_Street2()) + ", ");
				     	address += (StringUtil.filter(member.getAddress().getPost_Eng_HouseNum1())).equals("")? "" : (StringUtil.filter(member.getAddress().getPost_Eng_HouseNum1()) + ", ");
				     	
						if(!"".equals(StringUtil.filter(member.getAddress().getPost_Eng_Street()))){
							
							if(!"".equals(StringUtil.filter(member.getAddress().getPost_Eng_HouseNum1())))
								address = address.substring(0, address.length() - 2) + " ";
							
							address += StringUtil.filter(member.getAddress().getPost_Eng_Street()) + ", ";
						}
						
						address += (StringUtil.filter(member.getAddress().getPost_Eng_District())).equals("")? "" : (StringUtil.filter(member.getAddress().getPost_Eng_District()) + ", ");
						address += (StringUtil.filter(member.getAddress().getPost_Eng_Region())).equals("")? "" : (StringUtil.filter(member.getAddress().getPost_Eng_Region()) + ", ");
				     	
						
						if(address.endsWith(", ")){
							address = address.substring(0, address.length() - 2);
						}
				     	
						clpAddress = address;
						
						if(isLowMember){
							address = StringUtil.maskAddress(member.getAddress().getPost_Eng_Street3(), member.getAddress().getPost_Eng_Street2(), 
									member.getAddress().getPost_Eng_Street(), ((StringUtil.filter(member.getAddress().getPost_Eng_District()).equals("")? "" : StringUtil.filter(member.getAddress().getPost_Eng_District()) + " " )+
									StringUtil.filter(member.getAddress().getPost_Eng_Region())));
		     			}	
							
		     		}else {
		     			
		     			address = (StringUtil.filter(member.getAddress().getSupply_Eng_Street3())).equals("")? "" : (StringUtil.filter(member.getAddress().getSupply_Eng_Street3()) + ", " ) ;
				     	address += (StringUtil.filter(member.getAddress().getSupply_Eng_Street2())).equals("")? "" : (StringUtil.filter(member.getAddress().getSupply_Eng_Street2()) + ", ");
				     	address += (StringUtil.filter(member.getAddress().getSupply_Eng_HouseNumber1())).equals("")? "" : (StringUtil.filter(member.getAddress().getSupply_Eng_HouseNumber1()) + ", ");
				     	
						if(!"".equals(StringUtil.filter(member.getAddress().getSupply_Eng_Street()))){
							
							if(!"".equals(member.getAddress().getSupply_Eng_HouseNumber1()))
								address = address.substring(0, address.length() - 2) + " ";
							
							address += StringUtil.filter(member.getAddress().getSupply_Eng_Street()) + ", ";
						}
						
						address += (StringUtil.filter(member.getAddress().getSupply_Eng_District())).equals("")? "" : (StringUtil.filter(member.getAddress().getSupply_Eng_District()) + ", ");
						address += (StringUtil.filter(member.getAddress().getSupply_Eng_Region())).equals("")? "" : (StringUtil.filter(member.getAddress().getSupply_Eng_Region()) + ", ");
				     	
						
						if(address.endsWith(", ")){
							address = address.substring(0, address.length() - 2);
						}
						
						clpAddress = address;
							
						if(isLowMember){
							address = StringUtil.maskAddress(member.getAddress().getSupply_Eng_Street3(), member.getAddress().getSupply_Eng_Street2(), 
											member.getAddress().getSupply_Eng_Street(), ((StringUtil.filter(member.getAddress().getSupply_Eng_District()).equals("")? "" : StringUtil.filter(member.getAddress().getSupply_Eng_District()) + " " )+
											StringUtil.filter(member.getAddress().getSupply_Eng_Region())));
						}
		     		}
	     			
			   	}
		   		 
		   
		   %>
	 		<label class="btn active btn-block text-left">
		  	<div>
			    <input type="radio" name="address" id="option1" value="default" autocomplete="off" <% if("".equals(StringUtil.filter(manualAdd1))) { %> checked <% } %> > 
			    <p class="label"><fmt:message key="checkout.form.address.same"/>  </p>
			    <p class="content" id="clpAddress" ><%=address %></p> 
		    </div>
	  		</label>
	  	<%} %>
	  
  
		  <label class="btn btn-block <%=isHide%>" id="otherAddress" >
		  <div>
		    <input type="radio" name="address" id="option2" value="others" autocomplete="off" <%if(!isMember || !"".equals(StringUtil.filter(manualAdd1)) ){ %> checked <%} %>>
		    <p class="label dynamic"><fmt:message key="checkout.form.address.others"/> </p>
		    <input class="form-control" name="oAddress1" type="text" value="<%=StringUtil.filter(manualAdd1) %>" placeholder="<fmt:message key="checkout.form.address.ln1"/>">
		    <input class="form-control" name="oAddress2" type="text" value="<%=StringUtil.filter(manualAdd2) %>" placeholder="<fmt:message key="checkout.form.address.ln2"/>">
		    <input class="form-control" name="oAddress3" type="text" value="<%=StringUtil.filter(manualAdd3) %>" placeholder="<fmt:message key="checkout.form.address.ln3"/>">
		    <input class="form-control" name="oAddress4" type="text" value="<%=StringUtil.filter(manualAdd4) %>" placeholder="<fmt:message key="checkout.form.address.ln4"/>">
		    </div>
		  </label>
 
</div>
<br>

</div><!--form-group-->
</div><!--col-xs-24-->

	<%} %>
	
<%if(isLowMember){%>
	
	<!--  <div class="col-xs-24">
	<div class="form-group">
		<label><fmt:message key="checkout.form.address"/></label>
	</div>
	</div> -->
	
<%} %>
	
<div class="col-xs-24 text-right mb-20">  
	 <%if(isLowMember){ %>
	 <input type="button" class="btn btn-success btn-success-line" id="lowAuthEdit" value="<%=I18nUtil.getString("checkout.low.auth.edit", lang)%>"  onclick="edit()">
     <%} %>
     <input type="submit" class="btn btn-success" value="<%=I18nUtil.getString("checkout.con.guest", lang)%>" onclick="return checkForm()">
     </div>
	</div><!--category pg ended-->   
    
     
</section>
</form>



<jsp:include page="footer.jsp" />

<script type="text/javascript">

function checkForm(){
	var errorMsg = '';
	var errorEmpty = '';
	var errorMsgInvalid = '';
	var contact = $("[name='contact']").val().trim();
	var email = $("[name='email']").val().trim();
	
	if(<%=isName%> == true){
		var name = $("[name='name']").val().trim(); 
		if(name == ''){
			errorEmpty += "<fmt:message key="error.checkout.form.name.required"/>" + "\n";
		}
		//\_\[\]\{\}\\\|;:"'<>,.\/?
		var format = /[0-9]|[`~!@#$%^&*()+=_\[\]{}\\\|;:<>.,?"'\/-]/;
		
		//var format = /^[ A-Za-z0-9_./#&]*$/;
		if(name.match(format)){
			errorMsgInvalid += "<fmt:message key="error.checkout.form.name.incorrect"/>" + "/";
		}
	}
	
	if(contact == '') {
		errorEmpty += "<fmt:message key="error.checkout.form.contact.required"/>" + "\n";
	}else {
		var format = /(^0|^1|^4|^8)|[^0-9]/; 
		
		if (contact.length != 8 || contact.match(format) ){
			errorMsgInvalid += "<fmt:message key="error.checkout.form.contact.incorrect"/>" + "/"; 
        	//"<fmt:message key="error.checkout.form.contact.limit"/>" + "/";
        }
		
		/*var format = /(^0|^1|^4|^8)|[^0-9]/; ///(^2|^3|^5|^6|^7|^9)[0-9]/;
		if(contact.match(format)){
			errorMsg += "<fmt:message key="error.checkout.form.contact.incorrect"/>" + " ";
		}*/
		
	}

	if(email == '') {
		errorEmpty += "<fmt:message key="error.checkout.form.email.required"/>" + "\n";
	}else {
		//var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  
		var mailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		if(!email.match(mailformat))  {
			errorMsgInvalid += "<fmt:message key="error.checkout.form.email.incorrect"/>" + "/";
		}
		
		/*if(!email.match(/asiapay.com$/) && !email.match(/clp.com.hk$/)){
			errorMsg += "This is UAT Version, only CLP Email are allow to process.\n";
		}*/
		/*if(!email.endsWith("@asiapay.com") && !email.endsWith("@clp.com.hk")){
			errorMsg += "This is UAT Version, only CLP Email are allow to process.\n";
		}*/
	}

	if($("[name='address']:checked").val() == 'others') {
		
		if($("[name='oAddress1']").val().trim() == '') {
			errorEmpty += "<fmt:message key="error.checkout.form.address.required"/>" + "\n";
		}
		
		var format = /[`~!@$%^*()+=_\[\]{}\\\|;:<>.?"'-]/ ;
		///[`~!@$%^*()+=-\_\[\]{}\\\|;:"'<>.?\/ ]/;
		// /^[ A-Za-z0-9_./#&]*$/;
		if($("[name='oAddress1']").val().trim().match(format) || $("[name='oAddress2']").val().trim().match(format) ||
		   $("[name='oAddress3']").val().trim().match(format) || $("[name='oAddress4']").val().trim().match(format)	){
			errorMsgInvalid += "<fmt:message key="error.checkout.form.address.incorrect"/>" + "/";
		}
	}
	
	if(errorEmpty != '') {
		errorEmpty = "<fmt:message key="error.fields.are.mandatory"/>" + "\n" + errorEmpty;
		errorMsg = errorEmpty;
	}
	
	if(errorMsgInvalid != ''){
		errorMsgInvalid = errorMsgInvalid.substring(0, errorMsgInvalid.length -1);
		
		if(<%=isEng%>){
			errorMsgInvalid = "<fmt:message key="error.checkout.invalid"/>" + " " + errorMsgInvalid;
		}else{
			errorMsgInvalid =  errorMsgInvalid + "<fmt:message key="error.checkout.invalid"/>";
		}
		
		
		
		errorMsg += errorMsgInvalid;
	}
	
	if(errorMsg != ''){
		alert(errorMsg);
		return false;
	}
	
	dataLayer.push({
		'event': 'checkout',
			'ecommerce': {
		      'checkout': {
		        'actionField': {'step': '4'}
		     }
		   },
			'eventCallback': function() {}
	});
	
	//return false;

}

function edit(){
	
	var count = 0 ;
	var promptTitle = "<%=I18nUtil.getString("checkout.low.auth.prompt.title", lang) %>";
	var confirm = "<%=I18nUtil.getString("button.confirm", lang) %>";
	var cancel = "<%=I18nUtil.getString("button.cancel", lang) %>";
	var msgBoxTitle = "<%=I18nUtil.getString("messagebox.title.info", lang) %>";
	
	var forgotPass = "<%=I18nUtil.getString("login.forgot.pass", lang) %>";
	var register = "<%=I18nUtil.getString("login.register.account", lang) %>";
	var forgotPassLink='https://www1.clpgroup.com/clponline/<%=isEng == true?"en":"tc"%>/forgotPassword/entry.do';
	var registerLink = 'https://services.clp.com.hk/<%=isEng == true?"en":"zh"%>/login/registration.aspx?_ga=2.173943075.1064939436.1508400737-771624725.1508400737';

	var content = '\<\input type="password" class="layui-layer-input form-control">' + 
				  '\<\div style="margin-top:10px;">' + 
				  '\<\small><\a style="color:black; text-decoration:underline; " href=' + registerLink + '>'+ register + '<\/a><\/small><br>' + 
				  '\<\small><\a style="color:black; text-decoration:underline; " href=' + forgotPassLink + '>'+ forgotPass + '<\/a><\/small>' + 
				  '<\/div>';
	var count = 0 ;
	
	layer.prompt({
		title: promptTitle, 
		btn:[confirm,cancel], 
		formType: 1,
		content: content
	}, function(pass, index){
		layer.close(index);
		
		if(count < 1) { // to prevent multiple click 
			$.ajax({
				dataType: 'json',
	            url: '<%=basePath%>lowauthlogin?actionType=lowAuthLogin&password='+pass ,
	            type: 'POST',
	            async:false,
	            success: function(jsonObj){
	  
	            	if(jsonObj.successCode == "<%=StaticValueUtil.STATUS_YES%>"){
	            		
						if(!<%=isPickup%>){
							$("#clpAddress").text("<%=clpAddress%>");
		            		$("#otherAddress").removeClass('hidden');
						}
	
	            		$("#lowAuthEdit").remove();
	            		$("#emailInput").removeClass('hidden');
	            		$("#contactInput").removeClass('hidden');
	            	}
	            	else{
	            		var displayError = jsonObj.errorMsg;
	            		
	            		if(!<%=isEng%>){
	            			displayError = jsonObj.errorMsgC;
	            		}
	            		
	            		layer.alert(displayError, {title: msgBoxTitle, btn: [confirm]});
	            	}
	           }
			});
		  
		 count++;  
		}
		  
		  
		  
		  //layer.prompt({title: '随便写点啥，并确认', formType: 2}, function(text, index){
		  //  layer.close(index);
		   // layer.msg('演示完毕！您的口令：'+ pass +'您最后写下了：'+text);
		  // });
		}); 
	
	
}
</script>

</body>
</html>