<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.pulldown.DatePulldown"%>
<%@page import="com.project.util.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%


AdminInfoBean loginUser = (AdminInfoBean) request.getSession().getAttribute(SessionName.loginAdmin);
String url = request.getRequestURL().toString();

if (loginUser == null&& !url.contains("/LoginServlet") && !url.contains("login.jsp")&& !url.contains("/css/") && !url.contains("/images/") && !url.contains("/layer/")
		&& !url.contains("/js/") && !url.endsWith("/admin/"))
{
	
		PrintWriter pw = response.getWriter();
		pw.println("<script type='text/javascript'>alert('Your session has been timed out.')</script> <script type='text/javascript'>window.location.href='" + StringUtil.getHostAddress()// request.getContextPath()
				+ "admin/'</script> ");
		pw.flush();
		return;
}		
	Date nowDate = new Date();
	
    String id = request.getParameter("id");
    
    OrderBean orderBean = OrderService.getInstance().getOrderListBySqlwhere("where oId="+id).get(0);
    
    //AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute(SessionName.loginAdmin);
    List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
    
    String basePath = StringUtil.getHostAddress() + "admin/";
    
    String orderStatusStr = OrderStatusPulldown.getName(orderBean.getOrderStatus());
    
    if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Order, AdminFunction.UpdateStatus), AdminFunction.haveRight, adminGroupFunctions)) {
    	if(orderBean.getOrderStatus().equals(OrderStatusPulldown.ACCEPTED)){
        	orderStatusStr = 
        			"<select class=\"form-control\" name=\"orderStatus\">" +  
        			"<option value=\"" + OrderStatusPulldown.ACCEPTED + "\" >" + OrderStatusPulldown.getName(OrderStatusPulldown.ACCEPTED) + "</option>" + 
        			"<option value=\"" + OrderStatusPulldown.CANCELLED + "\" >" + OrderStatusPulldown.getName(OrderStatusPulldown.CANCELLED) + "</option>" + 
        			"<option value=\"" + OrderStatusPulldown.DELETED + "\" >" + OrderStatusPulldown.getName(OrderStatusPulldown.DELETED) + "</option>" +
        			"</select>";
        }
    }
    
    
%>

<!DOCTYPE html>
<html>
  <jsp:include page="../main/adminHeader.jsp"></jsp:include>
    
 
  </head>
  <body>
 <form action="AdminOrderServlet" name="orderForm" method="post" > 
 <input type="hidden" name="actionType" value="edit">
 <input type="hidden" name="id" value="<%=orderBean.getoId() %>"/>
 <input type="hidden" name="modifiedBy" value="<%=loginUser.getLoginId() %>"/>
 <jsp:include page="../main/topNav.jsp"></jsp:include>
 
<!-- header menu ended-->

    <section class="container">
    
    <!--main-row-->
    <div class="row">
    
    <!--left Menu area-->
    <jsp:include page="../main/leftMenu.jsp"><jsp:param value="order" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
      <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>Order Information</big> </div>
  
  <div class="panel-body">
     		
            <h5 class="text-primary">Order Profile</h5>
            <table class="table table-hover table-condensed">
            <tbody>
            	
              <tr>
               	<td class="tbl-title">Order Ref.</td>
                <td class="tbl-content"><%=StringUtils.trimToEmpty(orderBean.getOrderRef()) %></td>     
            	<td class="tbl-title">Total Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getTotalAmount()) %></td>
             </tr>
             
             <tr>
               	<td class="tbl-title">Transaction Date </td>
                <td class="tbl-content"><%=DateUtil.dateFormatterSql_ss.format(orderBean.getTransactiondate()) %></td>     
            	<td class="tbl-title">Order Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getOrderAmount()) %></td>
             </tr>
				
			<tr>
				<td class="tbl-title">Order Status </td>
                <td class="tbl-content"><%=orderStatusStr%> </td>

                <td class="tbl-title">Delivery Fee</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getDeliveryAmount()) %></td>
            </tr>
             
            <tr>
                <td class="tbl-title">Payment Method</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getPayMethod()) %></td>
                <td class="tbl-title">Discount Amount</td>
                <td class="tbl-content"><%=StringUtil.formatCurrencyPrice(orderBean.getDiscountAmount()) %></td>
            </tr> 
            
            <tr>
                <td class="tbl-title">Buyer Remark</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getRemark()) %></td>
                <td class="tbl-title">Remark</td>
                <td class="tbl-content"><textarea class="form-control" id="remark" name="remark" autocomplete="off" rows="4"><%=StringUtil.filter(orderBean.getAdminremark())%></textarea></td>
            </tr>
              </tbody>
            
            </table>  
            
            <h5 class="text-primary">Buyer Information</h5>
            <table class="table table-hover table-condensed">
            <tbody>
            
            <!--  <tr>
            	<td class="tbl-title">Title</td>
                <td class="tbl-content"><%= StringUtil.filter(orderBean.getBuyertitle())%></td>
                
                <td class="tbl-title"></td>
                <td class="tbl-content"><input class="form-control" name="address1" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyeraddress1())%>"></td>
            </tr>-->
            
            <tr>  
                <td class="tbl-title">Name </td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyerfirstname()) + " " + StringUtil.filter(orderBean.getBuyerlastname()) %></td>
                
                <td class="tbl-title">Address</td>
                <td class="tbl-content"><input class="form-control" name="address1" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyeraddress1())%>"></td>
                
            </tr>
            
            <tr>
            	<td class="tbl-title">Company Name</td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getBuyercompanyname())%></td>
                
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"> <input class="form-control" name="address2" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyeraddress2())%>"></td>
            </tr> 
            
            <tr>
            	<td class="tbl-title">Email</td>
                <td class="tbl-content"><input class="form-control" name="email" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyeremail())%>"></td>
                
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><input class="form-control" name="addresstown" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyertown())%>"></td>
            </tr> 
            
            <tr>
                <td class="tbl-title">Phone</td>
                <td class="tbl-content"><input class="form-control" name="contact" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerphone())%>"></td>
                
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><input class="form-control" name="addressstate" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyerstate())%>"> </td>           
            </tr> 
            
            <tr>
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content">&nbsp;</td>
                
                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><input class="form-control" name="addresscountry" autocomplete="off" value="<%=StringUtil.filter(orderBean.getBuyercountry())%>"></td>           
            </tr> 
            </tbody>
            
            </table>  
        	
        	<h5 class="text-primary">Receiver Information</h5>
            <table class="table table-hover table-condensed">
            <tbody>

            <tr>  
                <td class="tbl-title">Name </td>
                <td class="tbl-content"><%=StringUtil.filter(orderBean.getShipfirstname()) + " " + StringUtil.filter(orderBean.getShiplastname()) %></td>
                
                <td class="tbl-title">Address </td>
                <td class="tbl-content"><input class="form-control" name="shipaddress1" autocomplete="off" value="<%=StringUtil.filter(orderBean.getShipaddress1())%>"></td>
            </tr>
               
            <tr>
            	<td class="tbl-title">Company Name</td>
                <td class="tbl-content"><input class="form-control" name="shipcompanyname" autocomplete="off" value="<%=StringUtil.filter(orderBean.getShipcompanyname())%>"></td>

                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><input class="form-control" name="shipaddress2" autocomplete="off" value="<%=StringUtil.filter(orderBean.getShipaddress2())%>"></td>           
            </tr> 
            
             <tr>
            	<td class="tbl-title">Tracking Number</td>
                <td class="tbl-content"><input class="form-control" name="trackno" autocomplete="off" value="<%=StringUtil.filter(orderBean.getTracknumber())%>"></td>

                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><input class="form-control" name="shipaddresstown" autocomplete="off" value="<%=StringUtil.filter(orderBean.getShiptown())%>"></td>           
            </tr> 
            
             <tr>
            	<td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"></td>

                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><input class="form-control" name="shipaddressstate" autocomplete="off" value="<%=StringUtil.filter(orderBean.getShipstate())%>"> </td>           
            </tr> 
            
             <tr>
            	<td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"></td>

                <td class="tbl-title">&nbsp;</td>
                <td class="tbl-content"><input class="form-control" name="shipaddresscountry" autocomplete="off" value="<%=StringUtil.filter(orderBean.getShipcountry())%>"></td>           
            </tr> 
            
            </tbody>
            
            </table>  
        	
            
            
<!--.panel group plan ended-->
			<h5 class="text-primary">Product Information</h5>
			<table class="table table-hover table-condensed">
            <tbody>
            
            <tr>
            	<td widht="10%"><strong>SKU Name</strong></td>
            	<td width="60%"><strong>Name</strong> </td>
            	<td width="5%"><strong>Qty </strong> </td>
                <td width="15%"><strong>SubTotal </strong></td>
            </tr>
            
            <% 
            	double total = 0;
				boolean isERedeem = false;
				boolean isPostCoupon = false;
				String postCouponId = "";
            	for(int i =0 ; i < orderBean.getOrderItems().size() ; i++) {
            		OrderItemBean orderItem = orderBean.getOrderItems().get(i);	
            		String subTotalStr = "";

            		//double subTotal = orderItem.getPrice() * orderItem.getQuantity();
     				double subTotal = (orderItem.getPrice() - orderItem.getDiscount()) * orderItem.getQuantity();
            		
            		//FOR SUBTOTAL PRICING SETUP
            		subTotalStr = StringUtil.formatPrice(subTotal); 
            %>	
            <tr> 
            	<td><%=StringUtils.trimToEmpty(orderItem.getProductcode())%></td> 
                <td><%=StringUtil.filter(orderItem.getProductname()) %></td>
                <td class="tbl-center"><%=orderItem.getQuantity() %></td>
                <td class="tbl-center"><%=StringUtil.filter(subTotalStr) %></td>
            </tr>
            <% } %>
           
            </tbody>
			</table>
			
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
  <a href="javascript:formSubmit();" class="btn btn-primary loginbtn hvr-float-shadow">Submit</a>
   <a href="javascript:history.go(-1)" class="btn btn-cancel loginbtn hvr-float-shadow">Back</a>
  </div><!--panel-footer-->
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    
    </div>
  
    </section><!-- /section.container -->
</form>  

<script type="text/javascript">
    function MM_findObj(n, d) { //v4.0

  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}


//To check if the input field is all numbers
function isFloat (s)

{   var i;
    var decimalPointDelimiter = "."
    var seenDecimalPoint = false;

    //if ((s == null) || (s.length == 0)) 
    //   if (isFloat.arguments.length == 1) return defaultEmptyOK;
    //   else return (isFloat.arguments[1] == true);
    if (s == decimalPointDelimiter) return false;
    
    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        
        if ((c == decimalPointDelimiter) && !seenDecimalPoint) seenDecimalPoint = true;
        else if (!((c >= "0") && (c <= "9"))) return false;
    }
    // All characters are numbers.
    return true;
}


function formSubmit()
{		

	document.orderForm.submit();
 
}

function onPostCouponUpdate(ids){
	var arr = [ids];
	
	if(ids.includes(",")){
		arr = ids.split(",");
	}

	for(var i = 0; i < arr.length; i++) {
		
		var status = document.getElementById('cStatus-' + arr[i]);
	    status.value = '<%=StaticValueUtil.COLLECT_DELIVERED%>';
	}
	
}

</script>
  </body>
</html>


