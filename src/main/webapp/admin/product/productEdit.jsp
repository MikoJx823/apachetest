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
	
	int pid = StringUtil.strToInt(request.getParameter("pid"));
	ProductBean bean = ProductService.getInstance().getProductById(pid);
	ProductBean productBeanUpdate =(ProductBean)request.getAttribute(SessionName.beanInfo);
	List<ProductVariantBean> variants = new ArrayList<ProductVariantBean>();
	//ProductVariantBean variant = new ProductVariantBean();
	
	if(productBeanUpdate !=null && productBeanUpdate.getId() == bean.getId()){
		bean = productBeanUpdate;
		variants = bean.getProductVariant();
		//variants = bean.getProductVariant();
	}else {
		variants = ProductService.getInstance().getProductVariantListById(pid);
		//variants.add(variant);
	}
	
	/*if(bean.getDisplaystart() !=null){
		startDate = bean.getDisplaystart();
	}
	if(bean.getDisplayend() !=null){
		endDate = bean.getDisplayend();
	}*/

	//AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute(SessionName.loginAdmin);
	
	String basePath = StringUtil.getHostAddress() + "admin/";
	
	String defaultPath = StringUtil.getHostAddress();
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>

<body>

    <jsp:include page="../main/topNav.jsp"></jsp:include>
    <section class="container">    
    <!--main-row-->
    <div class="row">
      
		<jsp:include page="../main/leftMenu.jsp"><jsp:param value="product" name="pageIdx"/> </jsp:include>
	
    <!--right main content started-->
    <div class="col-xs-19">
    	<form role="form" action="AdminProductServlet" method="post" id="productUpdateForm" enctype="multipart/form-data" onsubmit="return checkForm()"> 
		<input type="hidden" name="id" value="<%=bean.getId()%>">
		<input type="hidden" name="actionType" value="update">
		<% 	session.setAttribute(SessionName.token,StringUtil.randomString(16)); %>
  		<input type="hidden" name="<%=SessionName.token %>" value="<%= session.getAttribute(SessionName.token) %>" />	
    <div class="panel panel-default">
  
<div class="panel-heading"><big>Edit Product</big> </div>
<jsp:include page="../main/msgAlert.jsp"></jsp:include>
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
                 
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>Product List Text </label> 
                    <input class="form-control" id="listtext" name="listtext" maxlength="50" autocomplete="off" value="<%=StringUtils.trimToEmpty(bean.getListtext())%>" >
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
            </div>  --> <!--row-->
            

            <div class="row">
            	<div class="col-xs-6">
                	<div class="form-group">
                    <label>Image 1</label>
                    <%if(!(StringUtils.trimToEmpty(bean.getImage1()).equals("")) ) {  %>
                    <img src="<%=defaultPath%>images/products/<%=bean.getImage1()%>" width="100px" >
                    <%} %>
                    <input  type="file"  class="form-control" id="image1" name="image1" autocomplete="off" >  
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
            
                 <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image 2</label>
                    <input type="button" value="Remove" onclick="removeFile('image2')">
                    <%if(!(StringUtils.trimToEmpty(bean.getImage2()).equals("")) ) {  %>
                    <img id="image2_old_img" src="<%=defaultPath%>images/products/<%=bean.getImage2() %>" width="100px" >
                    <input type="hidden" id="image2_old_flag" name="image2_old_flag" value="1">
                    <%} %>
                    <input  type="file"  class="form-control" id="image2" name="image2" autocomplete="off" > 
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                               
                  <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image 3</label>
                    <input type="button" value="Remove" onclick="removeFile('image3')">
                    <%if(!(StringUtils.trimToEmpty(bean.getImage3()).equals("")) ) {  %>
                    <img id="image3_old_img" src="<%=defaultPath%>images/products/<%=bean.getImage3() %>" width="100px" >
                    <input type="hidden" id="image3_old_flag" name="image3_old_flag" value="1">
                    <%} %>
                    <input type="file" class="form-control" id="image3" name="image3" autocomplete="off">
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
                <div class="col-xs-6">
                	<div class="form-group">
                    <label>Image <small>4</small></label>
                     <input type="button" value="Remove" onclick="removeFile('image4')">
                    <%if(!(StringUtils.trimToEmpty(bean.getImage4()).equals("")) ) {  %>
                    <img id="image4_old_img" src="<%=defaultPath%>images/products/<%=bean.getImage4() %>" width="100px" >
                    <input type="hidden" id="image4_old_flag" name="image4_old_flag" value="1">
                    <%} %>
                    <input type="file" class="form-control" id="image4" name="image4" autocomplete="off">
                   
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
           
            </div><!--row-->
   
           <div class="row">
           		<div class="col-xs-6">
                	<div class="form-group">
                    <label>Description Image</label>
                    <%if(!(StringUtils.trimToEmpty(bean.getDescimage()).equals("")) ) {  %>
                    <img id="image4_old_img" src="<%=defaultPath%>images/products/<%=bean.getDescimage() %>" width="100px" >
                    <%} %>
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
           </div><!--row--> 
           
           <div class="row">
              <div class="col-xs-12">
                	<div class="form-group">
                    <label>Short Description</label>
                    <textarea class="form-control ckeditor"  name="shortDesc" id="shortDesc" rows="3"><%=StringUtils.trimToEmpty(bean.getShortdesc())%></textarea>                
          			</div><!--form-group-->
              </div><!--col-xs-24-->   
              
              <div class="col-xs-12">
                	<div class="form-group">
                    <label>Additional Description </label>
                    <textarea class="form-control ckeditor"  name="additionalDesc" id="additionalDesc" rows="3"><%=StringUtils.trimToEmpty(bean.getAdditionaldesc())%></textarea>                
          			</div><!--form-group-->
              </div><!--col-xs-24-->                       
           </div><!--row--> 
           
        <hr>
        <h5 class="text-primary">Pricing Information</h5>
 		
 		<input type="hidden" id="variantcounter" name="variantcounter" value="<%=variants.size()%>">
 		<table class="table">
 			<thead class="bg-black">
			<tr>
			<th width="10%">Variant</th>
			<th width="10%">Price</th>
			<th width="10%">Discount</th>
			<th width="10%">Quantity</th>
			<th width="60%">Valid Date</th>
			</tr>
			</thead>
			<tbody>
			
			<%//for(ProductVariantBean v: variants){ 
			for(int i = 1; i <= variants.size() ; i++ ){ 
				ProductVariantBean v = variants.get(i - 1);
				
			%>
			
 			<tr>
 			<td><input class="form-control" id="variant<%=i %>" name="variant<%=i %>" autocomplete="off" value="<%=StringUtil.filter(v.getName()) %>" <%if(variants.size() <= 1 ){ %>disabled <%} %>> </td>
			<td><input class="form-control" id="price<%=i %>" name="price<%=i %>" autocomplete="off" value="<%=v.getPrice() %>"  ></td>
			<td><input class="form-control" id="discount<%=i %>" name="discount<%=i %>" autocomplete="off" value="<%=v.getDiscount() %>"></td>
			<td><input class="form-control" id="quantity<%=i %>" name="quantity<%=i %>" autocomplete="off" value="<%=v.getQuantity() %>"></td>
			<td><input type="hidden" name="pvid<%=i %>" value="<%=v.getPvid()%>">
				<div class="tbl full-width">
                        <!--year-->
                <div class="tbl-cell">
                <select class="form-control" name="dyearFrom<%=i %>">
                <%=DatePulldown.getYYYYPulldown2(v.getDiscountstart().getYear()+1900)%>
                </select>
                </div><div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                
                <div class="tbl-cell">
                <select class="form-control" name="dmonthFrom<%=i %>">
                <%=DatePulldown.getMMPulldown(v.getDiscountstart().getMonth()+1)%>
                </select>
                 </div><div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     <!--date-->
                    <div class="tbl-cell">
                    <select class="form-control" name="ddayFrom<%=i %>">
                    <%=DatePulldown.getDDPulldown(v.getDiscountstart().getDate())%>
                    </select></div>
                    
                    <div class="tbl-cell tbl-center">&nbsp;&nbsp; &nbsp;</div>
                    <div class="tbl-cell">
                    <select class="form-control" name="dhourFrom<%=i %>">
                    <%=DatePulldown.getHHPulldown(v.getDiscountstart().getHours())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="dminuteFrom<%=i %>">
                    <%=DatePulldown.getSSPulldown(v.getDiscountstart().getMinutes())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="dsecondFrom<%=i %>">
                    <%=DatePulldown.getSSPulldown(v.getDiscountstart().getSeconds())%>
                    </select></div>
                    
                    </div><!--tbl-row-->
                    
                    <div class="tbl full-width">
                     <!--year-->
                    <div class="tbl-cell">
                       <select class="form-control" name="dyearTo<%=i %>">
                        <%=DatePulldown.getYYYYPulldown2(v.getDiscountend().getYear()+1900)%>
                        </select></div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                         <!--month-->
                        <div class="tbl-cell">
                        <select class="form-control" name="dmonthTo<%=i %>">
                        <%=DatePulldown.getMMPulldown(v.getDiscountend().getMonth()+1)%>
                        </select>
                        </div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     <!--date-->
                    <div class="tbl-cell">
                    <select class="form-control"  name="ddayTo<%=i %>">
                    <%=DatePulldown.getDDPulldown(v.getDiscountend().getDate())%>
                    </select></div>
                    
                    <div class="tbl-cell tbl-center">&nbsp;&nbsp; &nbsp;</div>
                    <div class="tbl-cell">
                    <select class="form-control" name="dhourTo<%=i %>">
                    <%=DatePulldown.getHHPulldown(v.getDiscountend().getHours())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="dminuteTo<%=i %>">
                    <%=DatePulldown.getSSPulldown(v.getDiscountend().getMinutes())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="dsecondTo<%=i %>">
                    <%=DatePulldown.getSSPulldown(v.getDiscountend().getSeconds())%>
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
         	<div class="panel-footer text-right">
			   <button type="submit" class="btn btn-primary loginbtn hvr-float-shadow">Submit</button>
			   <button type="button" onclick="history.go(-1)" class="btn btn-cancel loginbtn hvr-float-shadow">Back</button>
			</div><!--panel-footer-->
        </div>
<!--.panel group plan ended-->
		</form>
  	</div><!--panel body ended-->

  
	</div> <!--panel default main panel-->
  </section><!-- /section.container --> 

<script type="text/javascript">
function removeFile(fileId)
{
	var file = $("#"+fileId);
	file.after(file.clone().val('')); 
	file.remove();
	
	$("#"+fileId).parent(".file-input-wrapper").next(".file-input-name").html("");
	
	$("#"+fileId+"_old_flag").val("0");
	$("#"+fileId+"_old_img").remove();
}

function addPriceTable(){
	var count = parseInt($("#variantcounter").val()) + 1;
	var disableStr = "";
	
	if(count == 1) disableStr = "disabled";
	
	var newRow = 
	"<tr>" + 
	"<td><input class='form-control' id='variant" + count + "' name='variant" + count + "' autocomplete='off' value='' " + disableStr +"> </td>" +
	"<td><input class='form-control' id='price" + count + "' name='price" + count + "' autocomplete='off' value=''  ></td>" +
	"<td><input class='form-control' id='discount" + count + "' name='discount" + count + "' autocomplete='off' value=''></td>" +
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
    if(count > 1) $("#variant1").prop("disabled", false);
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
		/*
		var errorMsg = "";
		
		if($.trim($("[name='eName']").val()) == '') {
			errorMsg += "Product English Name is required \n";
		}
		if($.trim($("[name='cName']").val()) == '') {
			errorMsg += "Product Chinese Name is required \n";
		}
		if($.trim($("[name='skuname']").val()) == '') {
			errorMsg += "SKU Name is required \n"
		}
		if($.trim($("[name='categoryId']").val()) == '') {
			errorMsg += "Category is required \n";
		}

		if($.trim($("[name='type']").val()) == '') {
			errorMsg += "Product Type is required \n"
		}
		
		if($.trim($("[name='displayPlatform']").val()) == '') {
			errorMsg += "Display platform is required \n"
		}
		
		if($.trim($("[name='merchantCode']").val()) == '') {
			errorMsg += "Merchant Code is required \n"
		}
		
		if($.trim($("[name='aoNumber']").val()) == '') {
			errorMsg += "OA Number is required \n"
		}
		
		if($.trim($("[name='materialNumber']").val()) == '') {
			errorMsg += "Material Number is required \n"
		}

		var startDateErrMsg = "";
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
		
		if($.trim($("[name='image1']").val()) == '' && "<%=StringUtils.trimToEmpty(bean.getImage1())%>" == '') {
			errorMsg += "Image 1 is required \n"
		}
		
		if($.trim($("[name='quantity']").val()) == '') {
			errorMsg += "Quantity is required \n"
		}else {
			if(!isInt($.trim($("[name='quantity']").val()))) {
				errorMsg += 'Quantity only accept number \n';  
			}
		}
			
		if($.trim($("[name='code']").val()) == '') {
			errorMsg += "Product Code is required \n"
		}
		
		if($.trim($("[name='status'").val()) == '') {
			errorMsg += "Status is required \n"
		}
		
		if(errorMsg != '') {
			alert(errorMsg);
			return false;
		}*/
		
	}

</script>
</body>

</html>
