<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.service.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
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
	boolean isEB = false, isECO = false;;

	String installFee = "";
	String eInstallText = "";
	String cInstallText = "";

	ProductBean bean = request.getAttribute("productBeanAdd")==null?new ProductBean():(ProductBean)request.getAttribute("productBeanAdd");
	if(bean.getDisplayStartDate()!=null){
		startDate = bean.getDisplayStartDate();
	}
	if(bean.getDisplayEndDate()!=null){
		endDate = bean.getDisplayEndDate();
	}
	
	if(bean.getProductPrice() != null ){
		ProductPriceBean productPrice = bean.getProductPrice().get(0);
		
		price = productPrice.getPrice();
		ebprice = productPrice.getDiscount();
		eco = productPrice.getEpid();
		installFee = productPrice.getInstallprice() + "";
	 	eInstallText = StringUtil.filter(productPrice.getEinstalltext());
	 	cInstallText = StringUtil.filter(productPrice.getCinstalltext());

		if(productPrice.getEbStartDate() != null){
			ebStartDate = bean.getProductPrice().get(0).getEbStartDate();
		}
		if(productPrice.getEbEndDate() != null){
			ebEndDate = bean.getProductPrice().get(0).getEbEndDate();
		}
		if(productPrice.getEnableEB() == StaticValueUtil.PRODUCT_ENABLE) {
			isEB = true;
		}
		if(productPrice.getEnableEco() == StaticValueUtil.PRODUCT_ENABLE){
			isECO = true;
		}
		
	}
	
	if(bean.getProductQty() != null){
		if(bean.getProductQty().size()> 0){
			quantity = bean.getProductQty().get(0).getQuantity();
		}
	}
	
	
	
	List<ProductBranchInfoBean> branchs = ProductBranchService.getInstance().getProductBranchListBySqlwhere(" where status != " + StaticValueUtil.Delete); 
	
	AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
		
	List<CategoryBean> cats = CategoryService.getInstance().getCategoryBeanListBySqlwhere("");
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>
    
<body>
<form role="form" action="ProductServlet" method="post" id="productAddForm" enctype="multipart/form-data" onsubmit="return checkForm()"> 
<input type="hidden" name="actionType" value="productAdd">
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
    	<li role="presentation"><a href="../product/ProductServlet?actionType=getSearchList&from=menu">Product Search</a></li>
    <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Product, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" class="active"><a href="../product/productAdd.jsp">Add Product</a></li>
     <%} %>
      <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Branch, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../productbranch/AdminProductBranchServlet?actionType=getSearchList&from=menu">Branch Search</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Branch, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../productbranch/productBranchAdd.jsp">Add Branch</a></li>
     <%} %>
           <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.EcoPoint, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../ecopoint/AdminEcoPointServlet?actionType=getSearchList&from=menu">Eco Point Search</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.EcoPoint, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../ecopoint/ecoPointAdd.jsp">Add Eco Point</a></li>
     <%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Discount, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="../productdiscount/discountView.jsp">Promotion Discount</a></li>
     <%} %>
  </ul>
  
  <div class="panel-body">
     
            <h5 class="text-primary">Product Information</h5>
           
           <div class="row">
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Name <small>(Eng)</small></label> <!-- - Suggested: 20; Max: 50 char. -->
                    <input class="form-control" id="eName" name="eName" maxlength="50" autocomplete="off" value="<%=StringUtils.trimToEmpty(bean.geteName())%>" >
                   
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>Name <small>(Chi)</small></label> <!-- - Suggested: 15; Max: 50 char. -->
                    <input class="form-control" id="cName" name="cName" maxlength="50" autocomplete="off" value="<%=StringUtils.trimToEmpty(bean.getcName())%>">
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                  <div class="col-xs-8">
                	<div class="form-group">
                    <label>SKU Name </label> <!--  - Suggested: 15; Max: 50 char. -->
                    <input class="form-control" id="cName" name="skuname" autocomplete="off" value="<%=StringUtils.trimToEmpty(bean.getSkuname())%>">
          			</div><!--form-group-->
                 </div><!--col-xs-8--> 
             </div><!--row-->
           	
           	<% 
           		String hotPick = "";
           		if(bean.getHotPick() == StaticValueUtil.PRODUCT_ENABLE) hotPick = "checked";
           	%>
          	<div class="row">
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>Category</label>&nbsp;&nbsp;
                    <input type="checkbox" id="hotPick" name="hotPick" value="<%=StaticValueUtil.PRODUCT_ENABLE%>" <%=StringUtil.filter(hotPick)%>>
                    <label> Hot Pick</label>
                    <select name="categoryId" class="form-control">
                    	<%=CategoryPulldown.getPCategoryPulldown(bean.getCategoryid()) %>
      		        </select>
          			</div><!--form-group-->
              </div><!--col-xs-8-->
              
              	<div class="col-xs-8">
                	<div class="form-group">
                    <label>Product Type </label> <br/>
                      <select class="form-control" name="type">
                            <%=ProductTypePulldown.select(-1, true)%>
                      </select>
          			</div><!--form-group-->
              </div><!--col-xs-8-->
              
              	<div class="col-xs-8">
                	<div class="form-group">
                    <label>Display Platform</label> <br/>
                      <select class="form-control" name="displayPlatform">
                            <%=DisplayPlatformPulldown.getPulldown(bean.getDisplayPlatform())%>
                      </select>
          			</div><!--form-group-->
              </div>
               </div>
               
               <div class="row">
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>OA Number</label>
                    	<input class="form-control" id="aoNumber" name="aoNumber" value="<%=StringUtil.filter(bean.getAONumber()) %>" autocomplete="off"/>
          			</div><!--form-group-->
              </div><!--col-xs-8-->
              
              <div class="col-xs-8">
                	<div class="form-group">
                    <label>Material Number</label> <br/>
                      <input class="form-control" id="code" name="materialNumber" autocomplete="off" value="<%=StringUtil.filter(bean.getMaterialNumber())%>"/>
          			</div><!--form-group-->
              </div>
              
              	<div class="col-xs-8">
                	<div class="form-group">
                    <label>Merchant Code</label> <br/>
                      <select class="form-control" name="merchantCode">
                            <%=MerchantService.getInstance().getPulldown(bean.getMerchantCode())%>
                      </select>
          			</div><!--form-group-->
              </div><!--col-xs-8-->
               </div>
               <div class="row">
              	<div class="col-xs-8">
                	<div class="form-group">
                    <label>Product Code</label> <br/>
                      <input class="form-control" id="productCode" name="code" value="<%=StringUtil.filter(bean.getCode()) %>" autocomplete="off"/>
          			</div><!--form-group-->
              </div>
              <!-- <div class="col-xs-8">
                	<div class="form-group">
                    <label>Product Brand</label> <br/>
                      <select class="form-control" name="brandId">
                            <%=ProductBrandService.getInstance().getPulldown(bean.getBrandid(), I18nUtil.Lang_EN)%>
                      </select>
          			</div><!--form-group
              </div>
              <div class="col-xs-8">
                	<div class="form-group">
                    <label>Product Appliance</label> <br/>
                      <select class="form-control" name="applianceId">
                            <%=ProductApplianceService.getInstance().getPulldown(bean.getApplianceid(), I18nUtil.Lang_EN)%>
                      </select>
          			</div><!--form-group
              </div> -->
               </div>
            
             <div class="row">
                 <div class="col-xs-24">
                	<div class="form-group">
                    <label>Display Date</label>
                    <div class="tbl full-width">
                        
                        <!--year-->
                        <div class="tbl-cell">
                       <select class="form-control" name="yearFrom">
                            <%=DatePulldown.getYYYYPulldown(startDate.getYear()+1900)%>
                        </select></div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                         <!--month-->
                        <div class="tbl-cell">
                        <select class="form-control" name="monthFrom">
                        <%=DatePulldown.getMMPulldown(startDate.getMonth()+1)%>
                        </select>
                        </div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     <!--date-->
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
                        
                    <!--year-->
                    <div class="tbl-cell">
                       <select class="form-control" name="yearTo">
                        <%=DatePulldown.getYYYYPulldown(endDate.getYear()+1900)%>
                        </select></div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                         <!--month-->
                        <div class="tbl-cell">
                        <select class="form-control" name="monthTo">
                        <%=DatePulldown.getMMPulldown(endDate.getMonth()+1)%>
                        </select>
                        </div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     <!--date-->
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
                    
                    </div><!--tbl-row-->
          			</div><!--form-group-->
                               	
                 </div><!--col-xs-16-->
                                  
            </div><!--row-->
			 <div class="row">
              <div class="col-xs-8">
                	<div class="form-group">
                    <label>Status</label>
                    <select name="status" class="form-control">
        		        <%=GenericStatusPulldown.getPulldown(bean.getStatus()) %>
        		          <%//ProductStatus.select(bean.getStatus(), false)%>
      		        </select>
      		        </div><!--form-group-->
                 </div><!--col-xs-8-->
            </div><!--row-->

            <div class="row">
            	<div class="col-xs-6">
                	<div class="form-group">
                    <label>Small Image </label>
                    <input  type="file"  class="form-control" id="simage" name="simage" autocomplete="off" >  
                    <label><small>Remarks: – 400 x 300 (max resolution)</br>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          			</div><!--form-group-->
                 </div><!--col-xs-6-->
                 
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
           
            </div><!--row-->
            
           
           <!--  <div class="row">
              <div class="col-xs-24">
                	<div class="form-group">
                    <label>Product Short Description <small>(Eng)</small></label>
                    <textarea class="form-control"  name="descShort" id="descShort" rows="2"><%//StringUtils.trimToEmpty(bean.geteDescShort())%></textarea>                
          			</div>
              </div>                     
           </div> --><!--row--> 
           
            <!--<div class="row">
              <div class="col-xs-24">
                	<div class="form-group">
                    <label>Product Short Description <small>(Chi)</small></label>
                    <textarea class="form-control" name="cDescShort" id="cDescShort" rows="2"><%//StringUtils.trimToEmpty(bean.getcDescShort())%></textarea>              
          			</div>
              </div>                    
           </div>--><!--row-->  
           
           <!--  <div class="row">
              <div class="col-xs-12">
                	<div class="form-group">
                    <label>Manufacture Description <small>(Eng)</small></label>
                    <input class="form-control" type="text" name="eManufactDesc" id="eManufactDesc" value="<%=StringUtils.trimToEmpty(bean.getEmanufactdesc())%>" >                
          			</div>
              </div>
              
              <div class="col-xs-12">
                	<div class="form-group">
                    <label>Manufacture Description <small>(Chi)</small></label>
                    <input class="form-control" type="text" name="cManufactDesc" id="cManufactDesc" value="<%=StringUtils.trimToEmpty(bean.getCmanufactdesc())%>">              
          			</div>
              </div>                  
           </div>--><!--row--> 
           
           <div class="row">
              <div class="col-xs-24">
                	<div class="form-group">
                    <label>Product Description <small>(Eng)</small></label>
                    <textarea class="form-control ckeditor"  name="eDescDetail" id="eDescDetail" rows="3"><%=StringUtils.trimToEmpty(bean.geteDescDetail())%></textarea>                
          			</div><!--form-group-->
              </div><!--col-xs-24-->                      
           </div><!--row--> 
           
            <div class="row">
              <div class="col-xs-24">
                	<div class="form-group">
                    <label>Product Description <small>(Chi)</small></label>
                    <textarea class="form-control ckeditor" name="cDescDetail" id="cDescDetail" rows="3"><%=StringUtils.trimToEmpty(bean.getcDescDetail())%></textarea>              
          			</div><!--form-group-->
              </div><!--col-xs-24-->                      
           </div><!--row--> 
           
            <div class="row">
              <div class="col-xs-24">
                	<div class="form-group">
                    <label>Energy Grade Description <small>(Eng)</small></label>
                    <textarea class="form-control ckeditor"  name="eFeatureDesc" id="eFeatureDesc" rows="3"><%=StringUtils.trimToEmpty(bean.getEfeaturedesc())%></textarea>                
          			</div><!--form-group-->
              </div><!--col-xs-24-->                      
           </div><!--row--> 
           
            <div class="row">
              <div class="col-xs-24">
                	<div class="form-group">
                    <label>Energy Grade Description <small>(Chi)</small></label>
                    <textarea class="form-control ckeditor" name="cFeatureDesc" id="cFeatureDesc" rows="3"><%=StringUtils.trimToEmpty(bean.getCfeaturedesc())%></textarea>              
          			</div><!--form-group-->
              </div><!--col-xs-24-->                      
           </div><!--row--> 
           
           
            <!--  <div class="row">
              <div class="col-xs-24">
                	<div class="form-group">
                    <label>Delivery Details<small>(Eng)</small></label>
                    <textarea class="form-control ckeditor" name="deliveyDetail" id="deliveyDetail" rows="3"><%=StringUtils.trimToEmpty(bean.getDeliveyDetail())%></textarea>              
          			</div>
              </div>                     
           </div> --> <!--row--> 
           
             <!-- <div class="row">
              <div class="col-xs-24">
                	<div class="form-group">
                    <label>Delivery Details<small>(Chi)</small></label>
                    <textarea class="form-control ckeditor" name="cDeliveyDetail" id="cDeliveyDetail" rows="3"><%=StringUtils.trimToEmpty(bean.getcDeliveyDetail())%></textarea>              
          			</div>
              </div>                  
           </div> --> <!--row--> 
		
		<hr>
		
		<h5 class="text-primary">Collection Information</h5>
		<!--  <div class="row">
             <div class="col-xs-8">
                	<div> 
                    <label>Collection Method</label> <br/>
                    <input type="radio" id="collectN" name="collectionmethod" value="<%=StaticValueUtil.COLLECT_NORMAL %>" 
                    <%if(bean.getCollectionmethod() == StaticValueUtil.COLLECT_NORMAL){ %> checked <%} %> 
                    onclick="onCollectionChange()"> <label> Delivery/Pickup </label>
                    <input type="radio" id="collectI" name="collectionmethod" value="<%=StaticValueUtil.COLLECT_INSTALL%>" 
                    <%if(bean.getCollectionmethod() == StaticValueUtil.COLLECT_INSTALL){ %> checked <%} %> 
                    onclick="onCollectionChange()"> <label> Install </label>
          			</div><!--form-group
                 </div><!--col-xs-8-
        </div><!--row
			
			<br>
			<div id="container-normal" class="hidden">
			<div class="row" >
             <div class="col-xs-8">
                	<div class="form-group">
                    <input type="checkbox" id="enableInstall" name="enablePickup" value="<%=StaticValueUtil.PRODUCT_ENABLE%>"  >
                    <label> Enable Pickup</label>
          			</div><!--form-group
                 </div><!--col-xs-8
                 
                 <div class="col-xs-8">
                	<div class="form-group">
                    <input type="checkbox" id="enableInstall" name="enableDelivery" value="<%=StaticValueUtil.PRODUCT_ENABLE%>"  >
                    <label> Enable Delivery</label>
          			</div><!--form-group
                 </div><!--col-xs-8
            </div><!--row

			</div>
			
			<div class="row hidden" id="container-install">
             <div class="col-xs-8">
                	<div class="form-group">
                    <label>Install Fee</label>
                    <input class="form-control" id="installPrice" name="installPrice" autocomplete="off" value="">
          			</div><!--form-group
                 </div><!--col-xs-8
            </div><!--row
            </div> -->
            
       
			<div class="row">
				<div class="col-xs-24">
			    	<div class="form-group">
			        	<div class="radio">
			            	<label>
			                 <input type="radio" name="collectionmethod" id="onlinepay" value="<%=StaticValueUtil.COLLECT_NORMAL %>"
			                 <%if(bean.getCollectionmethod() == StaticValueUtil.COLLECT_NORMAL){%> checked <%}%> > <b>Delivery / Self Pickup (Online Payment) </b>
			                </label>
			            </div>
					</div><!--form-group-->
                    
                    <div class="col-xs-24 pd-10 bg-light-gray hidden" id="onlinesetting" >
                    	<table class="table">
							<thead class="bg-black">
								<tr>
	  								<th width="30%">Method</th>
	   								<th width="70%"></th>
    							</tr>
    						</thead>
							<tbody>
							    <tr>
							      <td class="tbl-center"><label>
							      <input type="checkbox" name="onlineMethod" id="isDeliver" value="<%=StaticValueUtil.product_Delivery %>" 
							      <%if(bean.getEnabledelivery() == StaticValueUtil.PRODUCT_ENABLE){ %> checked <%} %>> <b>Delivery</b></label></td>
							      <td class="tbl-center"></td>
							    </tr>
							    
							    
						        <tr>
						        	<%if(branchs.size() > 0){ %>
						      		<td class="tbl-center"><label>
						      		<input type="checkbox" name="onlineMethod" id="isPickup" value="<%=StaticValueUtil.product_PickUp %>" 
						      		<%if(bean.getEnablepickup() == StaticValueUtil.PRODUCT_ENABLE){ %> checked <%} %> > <b>Self Pickup </b></label></td>
						        	<td class="tbl-center"><strong><span class="fa fa-location-arrow"></span>&ensp;Pick Up Store select </strong><br>
							          <%for(ProductBranchInfoBean branch : branchs){ 
							          		ProductBranchBean checkBranch = ProductBranchService.getInstance().getProductBranchGroupByPidBid(bean.getId(), branch.getId());
							          		String ischecked = "";
							          		if(checkBranch != null) ischecked = "checked"; 
							          %>
								          <label class="checkbox-inline"><input type="checkbox" name="branchs" value="<%=branch.getId()%>" <%=StringUtil.filter(ischecked) %>>
								          <%=StringUtil.filter(branch.getEname()) %></label>
								          
							          <%} %> 
							          
						            </td> 
						            <%}else { %>
						            <td class="tbl-center" colspan="2"><label><input type="checkbox" disabled> <b>Self Pickup </b> 
						            (Please add at least one branch to enable pickup location)</label></td>
						            <%} %>
						        </tr>
						        
							</tbody>
						  </table>
                    </div><!--col-xs-23-->
         		 </div>  
            	
            	
            	
            	
	            <div class="col-xs-24">
	              <div class="radio">
	                    <label class="radio-inline">
	                      <input type="radio" name="collectionmethod" id="offlinepay" value="<%=StaticValueUtil.COLLECT_INSTALL %>"><b>Installation required(Offline Payment)</b>
	                    </label>
	              </div>
	            </div>
	            
	            <div class="col-xs-24 pd-10 hidden" id="offlinesetting">
	            	<table width="100%">

	            		<tr>
	            		<td colspan="2">
	            		 <div class="col-xs-8" >
		                	<div class="form-group">
		                    <label>Install Fee</label>
		                    <input class="form-control" id="installPrice" name="installPrice" autocomplete="off" value="<%=installFee%>">
		          			</div><!--form-group -->
		                 </div><!--col-xs-8 -->
	            		</td>
	            		</tr>
	            		<tr>
	            		<td colspan="2">
	            			 <div class="col-xs-12">
			                	<div class="form-group">
			                    <label>Installation Text <small>(Eng)</small></label>
			                    <input class="form-control" type="text" name="eInstallText" id="eInstallText" value="<%=eInstallText%>">                
			          			</div><!--form-group-->
			              	</div><!--col-xs-12    -->
			              
			               	<div class="col-xs-12">
			                	<div class="form-group">
			                    <label>Installation Text <small>(Chi)</small></label>
			                    <input class="form-control" type="text" name="cInstallText" id="cInstallText" value="<%=cInstallText%>">              
			          			</div><!--form-group -->
			              	</div><!--col-xs-12 -->     
	            		</td>
	            		</tr>
	            	</table>
	            </div>
	           
                 
                
            </div>
			
			
        <hr>
        <h5 class="text-primary">Pricing Information</h5>
 		<!--  <div class="checkbox"><label  data-toggle="collapse" data-target="#priceSetup" aria-expanded="false" aria-controls="collapseExample"><input type="checkbox" id=isPriceSetup" name="isPriceSetup" value="No" >Setup Adult/Child price</label></div>
 		-->
    	   <div class="row">
             <!-- <div class="col-xs-8">
                	 <div class="form-group">
                    <label>Orginal Price</label>
                    <input class="form-control" id="oPrice" name="oPrice" autocomplete="off" value="">
          			</div><!--form-group
                 </div><!--col-xs-8-->
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Price</label>
                    <input class="form-control" id="price" name="price" autocomplete="off" value="<%=price%>" >
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                 <!--  <div class="col-xs-3">
                	<div class="form-group">
                    <label>Unit Name <small>(Eng)</small></label>
                    <input class="form-control" id="eText" name="eText" autocomplete="off" value="" >
          			</div><!--form-group
                 </div><!--col-xs-3
                 <div class="col-xs-3">
          			<div class="form-group">
                    <label>Unit Name <small>(Chi)</small></label>
                    <input class="form-control" id="cText" name="cText" autocomplete="off" value="" >
          			</div><!--form-group
                 </div><!--col-xs-3-->
            </div><!--row-->
            
            <div class="row">
             <div class="col-xs-8">
                	<div class="form-group">
                	<input type="checkbox" id="enableEB" name="enableEB" value="<%=StaticValueUtil.PRODUCT_ENABLE%>" 
                	<%if(isEB){ %> checked <%} %> >
                    <label>Enable Early Bird</label>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                
              
            </div><!--row-->
            
            <div class="row">
             <div class="col-xs-8">
                	<div class="form-group">
                    <label>Early Bird Discount</label>
                    <input class="form-control" id="ebPrice" name="ebPrice" autocomplete="off" value="<%=ebprice%>">
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
            </div> 
            <div class="row">
                
                <div class="col-xs-24">
                	<div class="form-group">
                    <label>Early Bird Date</label>
                    <div class="tbl full-width">
                        <!--year-->
                        <div class="tbl-cell">
                       <select class="form-control" name="ebyearFrom">
                            <%=DatePulldown.getYYYYPulldown(ebStartDate.getYear()+1900)%>
                        </select></div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                         <!--month-->
                        <div class="tbl-cell">
                        <select class="form-control" name="ebmonthFrom">
                        <%=DatePulldown.getMMPulldown(ebStartDate.getMonth()+1)%>
                        </select>
                        </div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     <!--date-->
                    <div class="tbl-cell">
                    <select class="form-control" name="ebdayFrom">
                    <%=DatePulldown.getDDPulldown(ebStartDate.getDate())%>
                    </select></div>
                    
                    <div class="tbl-cell tbl-center">&nbsp;&nbsp; &nbsp;</div>
                    <div class="tbl-cell">
                    <select class="form-control" name="ebhourFrom">
                    <%=DatePulldown.getHHPulldown(ebStartDate.getHours())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="ebminuteFrom">
                    <%=DatePulldown.getSSPulldown(ebStartDate.getMinutes())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="ebsecondFrom">
                    <%=DatePulldown.getSSPulldown(ebStartDate.getSeconds())%>
                    </select></div>
                    
                   &nbsp;- - -&nbsp;
                        
                    <!--year-->
                    <div class="tbl-cell">
                       <select class="form-control" name="ebyearTo">
                        <%=DatePulldown.getYYYYPulldown(ebEndDate.getYear()+1900)%>
                        </select></div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                         <!--month-->
                        <div class="tbl-cell">
                        <select class="form-control" name="ebmonthTo">
                        <%=DatePulldown.getMMPulldown(ebEndDate.getMonth()+1)%>
                        </select>
                        </div>
                        
                    <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
                     <!--date-->
                    <div class="tbl-cell">
                    <select class="form-control"  name="ebdayTo">
                    <%=DatePulldown.getDDPulldown(ebEndDate.getDate())%>
                    </select></div>
                    
                    <div class="tbl-cell tbl-center">&nbsp;&nbsp; &nbsp;</div>
                    <div class="tbl-cell">
                    <select class="form-control" name="ebhourTo">
                    <%=DatePulldown.getHHPulldown(ebEndDate.getHours())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="ebminuteTo">
                    <%=DatePulldown.getSSPulldown(ebEndDate.getMinutes())%>
                    </select></div>
                    <div class="tbl-cell tbl-center">&nbsp;: &nbsp;</div>
                     <div class="tbl-cell">
                    <select class="form-control" name="ebsecondTo">
                    <%=DatePulldown.getSSPulldown(ebEndDate.getSeconds())%>
                    </select></div>
                    
                    </div><!--tbl-row-->
          			</div><!--form-group-->
                               	
                 </div><!--col-xs-16-->
            </div><!--row-->
			
			<div id="ecoSetting" class="hidden">
			<div class="row">
             <div class="col-xs-8">
                	<div class="form-group">
                    <input type="checkbox" id="enableEco" name="enableEco" value="<%=StaticValueUtil.PRODUCT_ENABLE%>" 
                    <%if(isECO) { %> checked <%}%> >
                    <label> Enable Eco Points</label>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
            </div><!--row-->
			
			<div class="row">
             <div class="col-xs-8">
                	<div class="form-group">
                	<label>Eco Points Settings</label>
                    <select class="form-control" name="epId">
                    	<%=EcoPointService.getInstance().select(eco) %>
                    </select>
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
            </div><!--row-->
			
			<!--  <div class="row">
             <div class="col-xs-8">
                	<div class="form-group">
                    <label>Eco Points</label>
                    <input class="form-control" id="oPrice" name="ecoPoint" autocomplete="off" value="">
          			</div><!--form-group
                 </div><!--col-xs-8
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Eco Price</label>
                    <input class="form-control" id="price" name="ecoPrice" autocomplete="off" value="" >
          			</div><!--form-group
                 </div><!--col-xs-8
            </div><!--row-->
			</div>
			
			
		<div id="priceSetup"  class="collapse">
    	   <div class="row">
            <div class="col-xs-8">
                	<div class="form-group">
                    <label>Price tag  <small>(Eng)</small></label>
                    <input class="form-control" id="tag" name="tag" autocomplete="off" value="" placeholder="Adult" >
          			</div><!--form-group-->
             </div><!--col-xs-8-->
            <div class="col-xs-8">
                	<div class="form-group">
                    <label>Price tag  <small>(Chi)</small></label>
                    <input class="form-control" id="tagC" name="tagC" autocomplete="off" value="" placeholder="成人" >
          			</div><!--form-group-->
             </div><!--col-xs-8-->
             </div><!--row-->
             
             <div class="row">
             <div class="col-xs-8">
                	<div class="form-group">
                    <label>Orginal Price 2</label>
                    <input class="form-control" id="oPrice2" name="oPrice2" autocomplete="off" value="">
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Price 2</label>
                    <input class="form-control" id="price2" name="price2" autocomplete="off" value="" >
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
            </div><!--row-->
    	   <div class="row">
            <div class="col-xs-8">
                	<div class="form-group">
                    <label>Price tag 2 <small>(Eng)</small></label>
                    <input class="form-control" id="tag2" name="tag2" autocomplete="off" value="" placeholder="Child">
          			</div><!--form-group-->
             </div><!--col-xs-8-->
            <div class="col-xs-8">
                	<div class="form-group">
                    <label>Price tag 2 <small>(Chi)</small></label>
                    <input class="form-control" id="tagC2" name="tagC2" autocomplete="off" value="" placeholder="小童">
          			</div><!--form-group-->
             </div><!--col-xs-8-->
             </div><!--row-->
		</div>
     		<hr>
            <h5 class="text-primary">Quantity Information</h5>
            
            
           <div class="row">
             <div class="col-xs-8">
                	<div class="form-group">
                    <label>Quantity</label>
                    <input class="form-control" id="quantity" name="quantity" autocomplete="off" value="<%=quantity%>">
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
            </div><!--row-->
            
			<!--  <div class="checkbox"><label  data-toggle="collapse" data-target="#dateSetup" aria-expanded="false" aria-controls="collapseExample"><input type="checkbox" id=isDateSetup" name="isDateSetup" value="No" > Setup mulitple date</label></div>
			-->

		<div id="dateSetup"  class="collapse">
			<div class="bankInfoClass" >
			<div id="addDate" > 
             <div class="row" > 
              <div class="col-xs-8">
                	<div class="form-group">
                    <label>Quantity</label>
                    <input class="form-control" id="qty" name="qty" autocomplete="off" value="">
          			</div><!--form-group-->
                 </div><!--col-xs-8-->

             <div class="col-xs-8">
                	<div class="form-group">
                    <label>Date</label>
                    <input class="form-control" id="date" name="date" autocomplete="off" value="" placeholder="2016-01-01" >
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
             </div>
             </div>
		</div>
              <a onclick="addBandInfoTable()" style="cursor:pointer">add</a> / 
              <a onclick="subBandInfoTable()" style="cursor:pointer">del</a>
            </div><!--row-->

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
	window.location="../product/ProductServlet?actionType=getSearchList&from=menu";
	
}

function removeFile(fileId)
{
	var file = $("#"+fileId);
	file.after(file.clone().val('')); 
	file.remove();
	
	$("#"+fileId).parent(".file-input-wrapper").next(".file-input-name").html("");
}


function addBandInfoTable(){
	  try{
		  var appendHtml=$(".bankInfoClass").get(0).outerHTML;
		   
		  $("#addDate").append(appendHtml);


		  $("input[name=qty]:last").removeAttr("value");
		  $("input[name=date]:last").removeAttr("value");


	  }catch(e){
	  }
}

function subBandInfoTable(){
	  try{
		  var length=$(".bankInfoClass").length;

			if(length>1){
				$(".bankInfoClass:last").remove();
			}else{

				  $("input[name=qty]:last").removeAttr("value");
				  $("input[name=date]:last").removeAttr("value");

			}
		  
	  }catch(e){
	  }
}

	function defultBandInfoTable(){
		for(var i=0;i<=1;i++){
			addBandInfoTable();
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
	   
	   function onCollectionChange(){
			if($("[name='collectionmethod']:checked").val() == <%=StaticValueUtil.COLLECT_INSTALL%>) {
				$("#offlinesetting" ).removeClass("hidden");
				$("#onlinesetting").addClass("hidden");
				$("#ecoSetting").addClass("hidden");
	    	}else  {
	    		$("#offlinesetting" ).addClass("hidden");
				$("#onlinesetting").removeClass("hidden");
				$("#ecoSetting").removeClass("hidden");
	    	}
	    	
		}
	   
function checkForm(){
	/*return true;
	if($.trim($("#name").val())=="")
	{
		layer.alert('Please input name.', {
			  title: 'Notice',
		      skin: 'layui-layer-molv',
		      shift: 3 //动画类型0-6
		  });
		return false;
	}
	return true;*/
	
	var errorMsg = "";
	//if($.trim($("name: ").val())=="")
	if($.trim($("[name='eName']").val()) == '') {
		errorMsg += "Product English Name is required \n";
	}
	if($.trim($("[name='cName']").val()) == '') {
		errorMsg += "Product Chinese Name is required \n";
	}
	if($.trim($("[name='skuname']").val()) == '') {
		errorMsg += "SKU Name is required \n"
	}
	/*if($.trim($("[name='pCode']").val()) == '') {
		errorMsg += "Campaign Code is required \n";
	}*/
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
	
	if($.trim($("[name='simage']").val()) == '') {
		errorMsg += "Small Image is required \n"
	}
	
	if($.trim($("[name='image1']").val()) == '') {
		errorMsg += "Image 1 is required \n"
	}
	/*if($.trim($("[name='image2']").val()) == '') {
		errorMsg += "Image 2 is required \n"
	}
	if($.trim($("[name='image3']").val()) == '') {
		errorMsg += "Image 3 is required \n"
	}
	
	if($.trim($("[name='descShort']").val()) == '') {
		errorMsg += "Description Short English is required \n"
	}
	
	if($.trim($("[name='cDescShort']").val()) == '') {
		errorMsg += "Description Short Chinese is required \n"
	}*/
	
	/*if($.trim($("[name='eDescDetail']").val()) == '') {
		errorMsg += "Description English is required \n"
	}
	
	if($.trim($("[name='cDescDetail']").val()) == '') {
		errorMsg += "Description Chinese is required \n"
	}*/
	
	if($("[name='collectionmethod']:checked").val() == <%=StaticValueUtil.COLLECT_NORMAL%>) {
		var isTrue = false;
		if($("#isDeliver").is(':checked')){
			isTrue = true;
		}
		
		if($("#isPickup").is(':checked'))  {
			isTrue = true;
			
			var len = $( "[name='branchs']:checked" ).length;
			if(len <= 0) {
				errorMsg += 'At least one of the pickup location must be selected \n';
			}
		}
		
		if(!isTrue) {
			errorMsg += 'At least one of the delivery/pickup method must be selected \n';
		}
	}else {
		if($.trim($("[name='installPrice']").val()) == '') {
			errorMsg += "Installation Fee is required \n";
		}else {
			if(!isNumeric($.trim($("[name='installPrice']").val()))) {
				errorMsg += 'Installation Fee only accept number \n';
			}
		}
	}
	
	if($.trim($("[name='price']").val()) == '') {
		errorMsg += "Price is required \n"
	}else {
		if(!isNumeric($.trim($("[name='price']").val()))) {
			errorMsg += 'Price only accept number \n';
		}
	}
	
	if($.trim($("[name='oPrice']").val()) != '') {
		if(!isNumeric($.trim($("[name='oPrice']").val()))) {
			   errorMsg += 'Original Price only accept number \n';
		}
	}
	
	if($("#enableEB").is(':checked'))  {
		if($.trim($("[name='ebPrice']").val()) == '') {
			errorMsg += "Early Bird Price is required \n"
		}
	}
	
	if(!isNumeric($.trim($("[name='ebPrice']").val()))) {
		errorMsg += 'Early Bird Price only accept number \n';
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
	}
	
	if($("#enableEco").is(':checked'))  {
		if($.trim($("[name='epId']").val()) == '') {
			errorMsg += "Eco-point is required \n"
		}
		/*if($.trim($("[name='ecoPoint']").val()) == '') {
			errorMsg += "Eco-point is required \n"
		}else {
			if(!isNumeric($.trim($("[name='ecoPoint']").val()))) {
				errorMsg += 'Eco-point only accept number \n';
			}
		}
		
		if($.trim($("[name='ecoPrice']").val()) == '') {
			errorMsg += "Eco-price is required \n"
		}else {
			if(!isNumeric($.trim($("[name='ecoPrice']").val()))) {
				errorMsg += 'Eco-price only accept number \n';
			}
		}*/
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
	
	/*if($.trim($("[name='brandId']").val()) == '') {
		errorMsg += "Product Brand is required \n"
	}
	if($.trim($("[name='applianceId']").val()) == '') {
		errorMsg += "Product Appliance is required \n"
	}*/
	
	if($.trim($("[name='status'").val()) == '') {
		errorMsg += "Status is required \n"
	}
	
	if(errorMsg != '') {
		alert(errorMsg);
		return false;
	}
	
}

//<![CDATA[
$(window).load(function(){
	$(function() {
		$("#onlinepay").click(function(){
			$('#onlinesetting').fadeIn();
			$('#offlinesetting').fadeOut();	
			$("#ecoSetting").fadeIn();
		    	
			onCollectionChange();
		});
		$("#offlinepay").click(function(){
			$('#onlinesetting').fadeOut();
			$('#offlinesetting').fadeIn();
			$("#ecoSetting").fadeOut();
				
			onCollectionChange();
		});
		
		$("#enableEB").click(function(){
			$("#enableEco").removeAttr('checked');
		});
		
		$("#enableEco").click(function(){
			$("#enableEB").removeAttr('checked');
		});
	});
});//]]> 

onCollectionChange();
defultBandInfoTable();
</script>
</body>

</html>
