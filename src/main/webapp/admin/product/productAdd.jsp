<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.service.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.util.*"%>
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
	//AdminService.checkLogin1(request, response);
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.Product, AdminFunction.View);	
	
	Date startDate = new Date();
	startDate.setHours(0);
	startDate.setMinutes(0);
	startDate.setSeconds(0);
	
	Date endDate = new Date();
	endDate.setHours(23);
	endDate.setMinutes(59);
	endDate.setSeconds(59);
	
	Date ebStartDate = new Date();
	ebStartDate.setHours(0);
	ebStartDate.setMinutes(0);
	ebStartDate.setSeconds(0);
	
	Date ebEndDate = new Date();
	ebEndDate.setHours(23);
	ebEndDate.setMinutes(59);
	ebEndDate.setSeconds(59);
	
	double price = 0, ebprice = 0;
	int quantity = 0, eco = 0;

	ProductBean bean = request.getAttribute("productBeanAdd")==null?new ProductBean():(ProductBean)request.getAttribute("productBeanAdd");
	List<ProductVariantBean> variants = new ArrayList<ProductVariantBean>();
	ProductVariantBean variant = new ProductVariantBean();

	if(bean.getProductVariant() != null && bean.getProductVariant().size() > 0){
		variants = bean.getProductVariant();
	}else {
		variants.add(variant);
	}
			
	/*if(bean.getDisplaystart()!=null){
		startDate = bean.getDisplaystart();
	}
	if(bean.getDisplayend()!=null){
		endDate = bean.getDisplayend();
	}*/
	
	//AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute(SessionName.loginAdmin);
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	
	String basePath = StringUtil.getHostAddress() + "admin/";
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>
    
<body>
<form role="form" action="AdminProductServlet" method="post" id="productAddForm" enctype="multipart/form-data" onsubmit="return checkForm()"> 
<input type="hidden" name="actionType" value="add">
<% 	session.setAttribute(SessionName.token,StringUtil.randomString(16)); %>
<input type="hidden" name="<%=SessionName.token %>" value="<%= session.getAttribute(SessionName.token) %>" />	      
<jsp:include page="../main/topNav.jsp"></jsp:include>
    <section class="container">    
    <!--main-row-->
    <div class="row">

		<jsp:include page="../main/leftMenu.jsp"><jsp:param value="product" name="pageIdx"/> </jsp:include>
	
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
    
  
  
<div class="panel-heading"><big>Product Management</big> </div>
<jsp:include page="../main/msgAlert.jsp"></jsp:include>
<div class="panel-body">
           
<div class="uppertab">
   <ul class="nav nav-tabs nav-tabs-main" role="tablist">
   	 <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../product/AdminProductServlet?actionType=search&from=menu">Product Search</a></li>
    <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" class="active"><a href="../product/productAdd.jsp">Add Product</a></li>
     <%} %>
  </ul>
  
  <div class="panel-body">
     
           <h5 class="text-primary">Product Information</h5>
           
           <div class="row">
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Name </label> 
                    <input class="form-control" id="eName" name="eName" maxlength="50" autocomplete="off" value="<%=StringUtils.trimToEmpty(bean.getName())%>" >
                   
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>Category </label> 
                    <select name="categoryId" class="form-control">
                    	<%=CategoryService.getInstance().getCategoryPulldown(bean.getCategoryid()) %>
      		        </select>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                  <div class="col-xs-8">
                	<div class="form-group">
                    <label>Product Code </label> 
                    <input class="form-control" id="productCode" name="productCode" autocomplete="off" value="<%=StringUtils.trimToEmpty(bean.getProductcode())%>">
          			</div><!--form-group-->
                 </div><!--col-xs-8--> 
             </div><!--row-->
			
			<div class="row">
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Status </label> 
                    <select name="status" id="status" class="form-control">
                    <%=GenericStatusPulldown.getPulldown(bean.getStatus()) %>
                    </select>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
             </div><!--row-->
			
           <!-- <div class="row">
                 <div class="col-xs-24">
                	<div class="form-group">
                    <label>Display Date</label>
                    <div class="tbl full-width">
                        
                        
                        <div class="tbl-cell">
                       <select class="form-control" name="yearFrom">
                            <%=DatePulldown.getYYYYPulldown(startDate.getYear()+1900)%>
                        </select></div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                         
                        <div class="tbl-cell">
                        <select class="form-control" name="monthFrom">
                        <%=DatePulldown.getMMPulldown(startDate.getMonth()+1)%>
                        </select>
                        </div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     
                    <div class="tbl-cell">
                    <select class="form-control" name="dayFrom">
                    <%=DatePulldown.getDDPulldown(startDate.getDate())%>
                    </select></div>
                    
                    <div class="tbl-cell tbl-center">&nbsp;&nbsp; &nbsp;</div>
                    <div class="tbl-cell">
                    <select class="form-control" name="hourFrom">
                    <%=DatePulldown.getHHPulldown(startDate.getHours())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="minuteFrom">
                    <%=DatePulldown.getSSPulldown(startDate.getMinutes())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="secondFrom">
                    <%=DatePulldown.getSSPulldown(startDate.getSeconds())%>
                    </select></div>
                    
                   &nbsp;- - -&nbsp;
                        
                   
                    <div class="tbl-cell">
                       <select class="form-control" name="yearTo">
                        <%=DatePulldown.getYYYYPulldown(endDate.getYear()+1900)%>
                        </select></div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                         
                        <div class="tbl-cell">
                        <select class="form-control" name="monthTo">
                        <%=DatePulldown.getMMPulldown(endDate.getMonth()+1)%>
                        </select>
                        </div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     
                    <div class="tbl-cell">
                    <select class="form-control"  name="dayTo">
                    <%=DatePulldown.getDDPulldown(endDate.getDate())%>
                    </select></div>
                    
                    <div class="tbl-cell tbl-center">&nbsp;&nbsp; &nbsp;</div>
                    <div class="tbl-cell">
                    <select class="form-control" name="hourTo">
                    <%=DatePulldown.getHHPulldown(endDate.getHours())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="minuteTo">
                    <%=DatePulldown.getSSPulldown(endDate.getMinutes())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="secondTo">
                    <%=DatePulldown.getSSPulldown(endDate.getSeconds())%>
                    </select></div>
                    
                    </div>
          			</div>
                               	
                 </div>
                                  
            </div> --> <!--row-->

           <div class="row">
                 <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>1</small></label>
                    <input  type="file"  class="form-control" id="image1" name="image1" autocomplete="off" >  
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                               
                  <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>2</small></label>
                    <input type="button" value="Remove" onclick="removeFile('image2')">
                    <input type="file" class="form-control" id="image2" name="image2" autocomplete="off">
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>	         	
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
                <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>3</small></label>
                    <input type="button" value="Remove" onclick="removeFile('image3')">
                    <input type="file" class="form-control" id="image3" name="image3" autocomplete="off">
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>	         	
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
           		
           		<div class="col-xs-6">
                	<div class="form-group">
                    <label>Image 4</label>
                    <input  type="file"  class="form-control" id="image4" name="image4" autocomplete="off" >  
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
            </div><!--row-->
            
           <div class="row">
           		<div class="col-xs-6">
                	<div class="form-group">
                    <label>Description Image</label>
                    <input  type="file"  class="form-control" id="image5" name="image5" autocomplete="off" >  
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
                 <div class="col-xs-12">
                	<div class="form-group">
                    <label>Description Youtube Video</label>
                    <input  type="text"  class="form-control" id="descyoutube" name="descyoutube" autocomplete="off" value="<%=StringUtil.filter(bean.getDescyoutube()) %>" >  
                    <label></label>                 
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
              <!--<div class="col-xs-24">
                	<div class="form-group">
                    <label>Product Description</label>
                    <textarea class="form-control ckeditor"  name="fulldesc" id="fulldesc" rows="3"><%=StringUtils.trimToEmpty(bean.getDetail())%></textarea>                
          			</div>
              </div>    -->                   
           </div><!--row--> 
		   
		   <div class="row">
              <div class="col-xs-12">
                	<div class="form-group">
                    <label>Short Description</label>
                    <textarea class="form-control ckeditor"  name="shortdesc" id="shortdesc" rows="3"><%=StringUtils.trimToEmpty(bean.getShortdesc())%></textarea>                
          			</div><!--form-group-->
              </div><!--col-xs-24-->   
              
              <div class="col-xs-12">
                	<div class="form-group">
                    <label>Additional Description </label>
                    <textarea class="form-control ckeditor"  name="additionaldesc" id="additionaldesc" rows="3"><%=StringUtils.trimToEmpty(bean.getAdditionaldesc())%></textarea>                
          			</div><!--form-group-->
              </div><!--col-xs-24-->                       
           </div><!--row--> 
		<hr>

        <h5 class="text-primary">Pricing Information</h5>
 		<!--  <div class="checkbox"><label  data-toggle="collapse" data-target="#priceSetup" aria-expanded="false" aria-controls="collapseExample"><input type="checkbox" id=isPriceSetup" name="isPriceSetup" value="No" >Setup Adult/Child price</label></div>
 		-->
 		
 			<table class="table">
 			<thead class="bg-black">
			<tr>
			<th width="10%">Variant</th>
			<th width="10%">Price</th>
			<th width="10%">Discount</th>
			<th width="10%">Quantity</th>
			<th width="60%">Discount Period (Leave it when discount = 0 )</th>
			</tr>
			</thead>
			<tbody><input type="hidden" id="variantcounter" name="variantcounter" value="<%=variants.size()%>">
			
			<%//for(ProductVariantBean v: variants){ 
			for(int i = 1; i <= variants.size() ; i++ ){ 
				ProductVariantBean v = variants.get(i - 1);
				
				if(v.getDiscountstart() != null){
					ebStartDate = v.getDiscountstart();
				}
				
				if(v.getDiscountend() != null){
					ebEndDate = v.getDiscountend();
				}
			%>
			
 			<tr>
 			<td><input class="form-control" id="variant<%=i %>" name="variant<%=i %>" autocomplete="off" value="<%=StringUtil.filter(v.getName()) %>"  <%if(variants.size() <= 1 ){ %>disabled <%} %>> </td>
			<td><input class="form-control" id="price<%=i %>" name="price<%=i %>" autocomplete="off" value="<%=v.getPrice() %>"  ></td>
			<td><input class="form-control" id="discount<%=i %>" name="discount<%=i %>" autocomplete="off" value="<%=v.getDiscount() %>"></td>
			<td><input class="form-control" id="quantity<%=i %>" name="quantity<%=i %>" autocomplete="off" value="<%=v.getQuantity() %>"></td>
			<td><div class="tbl full-width">
                        <!--year-->
                <div class="tbl-cell">
                <select class="form-control" name="dyearFrom<%=i %>">
                <%=DatePulldown.getYYYYPulldown2(ebStartDate.getYear()+1900)%>
                </select>
                </div><div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                
                <div class="tbl-cell">
                <select class="form-control" name="dmonthFrom<%=i %>">
                <%=DatePulldown.getMMPulldown(ebStartDate.getMonth()+1)%>
                </select>
                 </div><div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     <!--date-->
                    <div class="tbl-cell">
                    <select class="form-control" name="ddayFrom<%=i %>">
                    <%=DatePulldown.getDDPulldown(ebStartDate.getDate())%>
                    </select></div>
                    
                    <div class="tbl-cell tbl-center">&nbsp;&nbsp; &nbsp;</div>
                    <div class="tbl-cell">
                    <select class="form-control" name="dhourFrom<%=i %>">
                    <%=DatePulldown.getHHPulldown(ebStartDate.getHours())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="dminuteFrom<%=i %>">
                    <%=DatePulldown.getSSPulldown(ebStartDate.getMinutes())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="dsecondFrom<%=i %>">
                    <%=DatePulldown.getSSPulldown(ebStartDate.getSeconds())%>
                    </select></div>
                    
                    </div><!--tbl-row-->
                    
                    <div class="tbl full-width">
                     <!--year-->
                    <div class="tbl-cell">
                       <select class="form-control" name="dyearTo<%=i %>">
                        <%=DatePulldown.getYYYYPulldown2(ebEndDate.getYear()+1900)%>
                        </select></div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                         <!--month-->
                        <div class="tbl-cell">
                        <select class="form-control" name="dmonthTo<%=i %>">
                        <%=DatePulldown.getMMPulldown(ebEndDate.getMonth()+1)%>
                        </select>
                        </div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     <!--date-->
                    <div class="tbl-cell">
                    <select class="form-control"  name="ddayTo<%=i %>">
                    <%=DatePulldown.getDDPulldown(ebEndDate.getDate())%>
                    </select></div>
                    
                    <div class="tbl-cell tbl-center">&nbsp;&nbsp; &nbsp;</div>
                    <div class="tbl-cell">
                    <select class="form-control" name="dhourTo<%=i %>">
                    <%=DatePulldown.getHHPulldown(ebEndDate.getHours())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="dminuteTo<%=i %>">
                    <%=DatePulldown.getSSPulldown(ebEndDate.getMinutes())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="dsecondTo<%=i %>">
                    <%=DatePulldown.getSSPulldown(ebEndDate.getSeconds())%>
                    </select></div>
                    
                    </diV>
                 </td>
 			</tr>
 			<%} %>
 			</tbody>
 			</table>
 			<a onclick="addPriceTable()" style="cursor:pointer">add</a> / 
            <a onclick="subPriceTable()" style="cursor:pointer">del</a>

         </div>
        </div>
<!--.panel group plan ended-->

  </div><!--panel body ended-->

  <div class="panel-footer text-right">
   <button type="submit" class="btn btn-primary loginbtn hvr-float-shadow">Submit</button>
   <button type="button" onclick="onBack()" class="btn btn-cancel loginbtn hvr-float-shadow">Back</button>
  </div><!--panel-footer-->
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
  </div>  
    </div>
  
    </section><!-- /section.container -->
    </div>
  </form> 
<script type="text/javascript">
function onBack(){
	window.location="../product/AdminProductServlet?actionType=search&from=menu";
}

function removeFile(fileId){
	var file = $("#"+fileId);
	file.after(file.clone().val('')); 
	file.remove();
	
	$("#"+fileId).parent(".file-input-wrapper").next(".file-input-name").html("");
}


function addPriceTable(){
	var count = parseInt($("#variantcounter").val()) + 1;
	var newRow = 
	"<tr>" + 
	"<td><input class='form-control' id='variant" + count + "' name='variant" + count + "' autocomplete='off' value=''> </td>" +
	"<td><input class='form-control' id='price" + count + "' name='price" + count + "' autocomplete='off' value=''  ></td>" +
	"<td><input class='form-control' id='ebPrice" + count + "' name='discount" + count + "' autocomplete='off' value=''></td>" +
	"<td><input class='form-control' id='quantity" + count + "' name='quantity" + count + "' autocomplete='off' value=''></td>" +
	"<td><div class='tbl full-width'>" +
	"<div class='tbl-cell'><select class='form-control' name='dyearFrom" + count + "'><%=DatePulldown.getYYYYPulldown(ebStartDate.getYear()+1900)%></select></div><div class='tbl-cell tbl-center'>&nbsp;/ &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control' name='dmonthFrom" + count + "'><%=DatePulldown.getMMPulldown(ebStartDate.getMonth()+1)%></select></div><div class='tbl-cell tbl-center'>&nbsp;/ &nbsp;</div>"+
    "<div class='tbl-cell'><select class='form-control' name='ddayFrom" + count + "'><%=DatePulldown.getDDPulldown(ebStartDate.getDate())%></select></div><div class='tbl-cell tbl-center'>&nbsp;&nbsp; &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control' name='dhourFrom" + count + "'><%=DatePulldown.getHHPulldown(ebStartDate.getHours())%></select></div><div class='tbl-cell tbl-center'>&nbsp;: &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control' name='dminuteFrom" + count + "'><%=DatePulldown.getSSPulldown(ebStartDate.getMinutes())%></select></div><div class='tbl-cell tbl-center'>&nbsp;: &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control' name='dsecondFrom" + count + "'><%=DatePulldown.getSSPulldown(ebStartDate.getSeconds())%></select></div>" +
	"</div>" + 
	"<div class='tbl full-width'>" + 
	"<div class='tbl-cell'><select class='form-control' name='dyearTo'" + count + "'><%=DatePulldown.getYYYYPulldown(ebEndDate.getYear()+1900)%></select></div><div class='tbl-cell tbl-center'>&nbsp;/ &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control' name='dmonthTo" + count + "'><%=DatePulldown.getMMPulldown(ebEndDate.getMonth()+1)%></select></div><div class='tbl-cell tbl-center'>&nbsp;/ &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control'  name='ddayTo" + count + "'><%=DatePulldown.getDDPulldown(ebEndDate.getDate())%></select></div><div class='tbl-cell tbl-center'>&nbsp;&nbsp; &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control' name='dhourTo" + count + "'><%=DatePulldown.getHHPulldown(ebEndDate.getHours())%></select></div><div class='tbl-cell tbl-center'>&nbsp;: &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control' name='dminuteTo" + count + "'><%=DatePulldown.getSSPulldown(ebEndDate.getMinutes())%></select></div><div class='tbl-cell tbl-center'>&nbsp;: &nbsp;</div>" +
    "<div class='tbl-cell'><select class='form-control' name='dsecondTo" + count + "'><%=DatePulldown.getSSPulldown(ebEndDate.getSeconds())%></select></div>" +
    "</div></td></tr>";
    
    $("table tbody").append(newRow);
    $("#variantcounter").val(count);
    $("#variant1").prop("disabled", false);
}

function subPriceTable(){
    var count = parseInt($("#variantcounter").val())
    
    if(count > 1 ){
    	$( "tr:last" ).remove();
    	count = count - 1;
    	$("#variantcounter").val(count);
    	
    	if(count == 1) {
    		$("#variant1").prop("disabled", true);
    		$("#variant1").val("");
    	}
    }
}

	
function isInt(value) {
	if (isNaN(value)) {
		return false;
	}
	var x = parseFloat(value);
	return (x | 0) === x;
}
	   
function isNumeric(val) {
	var validChars = '0123456789.';
	for(var i = 0; i < val.length; i++) {
		if(validChars.indexOf(val.charAt(i)) == -1)
	    	return false;
	    }
	return true;
}
	   
function checkForm(){
	/*var errorMsg = "";
	if($.trim($("[name='eName']").val()) == '') {
		errorMsg += "Product English Name is required \n";
	}
	if($.trim($("[name='categoryId']").val()) == '') {
		errorMsg += "Category is required \n";
	}
	if($.trim($("[name='image1']").val()) == '') {
		errorMsg += "Image 1 is required \n"
	}
	if($.trim($("[name='productCode']").val()) == '') {
		errorMsg += "Product Code is required \n"
	}
	
	if($.trim($("[name='status'").val()) == '') {
		errorMsg += "Status is required \n"
	}*/
	
	
	/*var startDateErrMsg = "";
	if($.trim($("[name='yearFrom']").val()) == '') {
		startDateErrMsg += " year,";
	}
	if($.trim($("[name='monthFrom']").val()) == '') {
		startDateErrMsg += " month,";
	}
	if($.trim($("[name='dayFrom']").val()) == '') {
		startDateErrMsg += " day,";
	}
	
	if(startDateErrMsg != "") {
		var temp = startDateErrMsg.substring(0, startDateErrMsg.length - 1);;
		startDateError = "Display Date Start" + temp + " is required \n";
		errorMsg += startDateError;
	}
	
	var endDateErrMsg = "";
	if($.trim($("[name='yearTo']").val()) == '') {
		endDateErrMsg += " year,";
	}
	if($.trim($("[name='monthTo']").val()) == '') {
		endDateErrMsg += " month,";
	}
	if($.trim($("[name='dayTo']").val()) == '') {
		endDateErrMsg += " day,";
	}
	
	if(endDateErrMsg != "") {
		var temp = endDateErrMsg.substring(0, endDateErrMsg.length - 1);;
		endDateErrMsg = "Display Date End" + temp + " is required \n";
		errorMsg += endDateErrMsg;
	}
	
	if($.trim($("[name='price']").val()) == '') {
		errorMsg += "Price is required \n"
	}else {
		if(!isNumeric($.trim($("[name='price']").val()))) {
			errorMsg += 'Price only accept number \n';
		}
	}

	var startDateErrMsg = "";
	if($.trim($("[name='ebyearFrom']").val()) == '') {
		startDateErrMsg += " year,";
	}
	if($.trim($("[name='ebmonthFrom']").val()) == '') {
		startDateErrMsg += " month,";
	}
	if($.trim($("[name='ebdayFrom']").val()) == '') {
		startDateErrMsg += " day,";
	}
	
	if(startDateErrMsg != "") {
		var temp = startDateErrMsg.substring(0, startDateErrMsg.length - 1);;
		startDateError = "Early Bird Date Start" + temp + " is required \n";
		errorMsg += startDateError;
	}
	
	var endDateErrMsg = "";
	if($.trim($("[name='ebyearTo']").val()) == '') {
		endDateErrMsg += " year,";
	}
	if($.trim($("[name='ebmonthTo']").val()) == '') {
		endDateErrMsg += " month,";
	}
	if($.trim($("[name='ebdayTo']").val()) == '') {
		endDateErrMsg += " day,";
	}
	
	if(endDateErrMsg != "") {
		var temp = endDateErrMsg.substring(0, endDateErrMsg.length - 1);;
		endDateErrMsg = "Early Bird Date End" + temp + " is required \n";
		errorMsg += endDateErrMsg;
	}*/
		
	
	
	/*if(errorMsg != '') {
		alert(errorMsg);
		return false;
	}*/
}
</script>
</body>

</html>
