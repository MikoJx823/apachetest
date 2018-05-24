<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.Category, AdminFunction.Edit);
	
    int id = StringUtil.strToInt(request.getParameter("id"));
 	
    CategoryBean category = CategoryService.getInstance().getCategoryById(id);
	CategoryBean categoryUpdate =(CategoryBean)request.getAttribute(SessionName.beanInfo);
	
	if(categoryUpdate !=null && categoryUpdate.getId() == category.getId())
		category = categoryUpdate;
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
%>

<!DOCTYPE html>
<html>
	<jsp:include page="../main/adminHeader.jsp"></jsp:include>
  <body>

  <form action="AdminCategoryServlet" method="post" name="addForm" enctype="multipart/form-data" onsubmit="return checkForm()" > 
 <input type="hidden" name="actionType" value="updateCategory">
 <input type="hidden" name="id" value="<%=category.getId() %>"/>
 <% session.setAttribute(SessionName.token,StringUtil.randomString(16)); %>
	<input type="hidden" name="<%=SessionName.token %>" value="<%= session.getAttribute(SessionName.token) %>" />
 <jsp:include page="../main/topNav.jsp"></jsp:include>
 
<!-- header menu ended-->

    <section class="container">
    
    <!--main-row-->
    <div class="row">
    
    <!--left Menu area-->
    <jsp:include page="../main/leftMenu.jsp"><jsp:param value="category" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>Edit Category </big></div>
  	<jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <div class="panel-body">
     
            <h5 class="text-primary">Category Information</h5>
            
            
             <div class="row">
                <div class="col-xs-24">
                	<div class="form-group">
                    <table class="table table-hover table-condensed">
		            <tbody>
		             <tr>
		            	<td class="tbl-title">Category Id</td>
		                <td class="tbl-content">
		                <%if(category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE){ %>
                			<%=category.getParentidentifier() %>
		                <%}else { %>
		                	<%=category.getId() %>
		                <%} %>
		                </td>
		                <td class="tbl-title">isParent</td>
                		<td class="tbl-content"><%=category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE? "Yes" : "No" %></td>
		             </tr>
		             </tbody>
		            </table>
          			</div><!--form-group-->
                </div><!--col-xs-8-->
            </div>
            
             <div class="row">
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Name <small>(Eng)</small></label> 
                    <input class="form-control" id="eName" name="eName" autocomplete="off" value="<%=StringUtil.filter(category.geteName())%>" >	
          			</div><!--form-group-->
                </div><!--col-xs-8-->
                
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Name <small>(Chi)</small></label>
  					<input class="form-control" id="cName" name="cName" autocomplete="off" value="<%=StringUtil.filter(category.getcName())%>" >
          			</div><!--form-group-->
              	</div><!--col-xs-8-->
              	
              	<div class="col-xs-4">
                	<div class="form-group">
                    <label>Sequence</label>
  					<input class="form-control" id="seq" name="seq" autocomplete="off" value="<%=category.getSeq() %>" >
          			</div><!--form-group-->
              	</div><!--col-xs-8-->
              	
              	<div class="col-xs-4">
                	<div class="form-group">
                    <label>Sequence <small>(App)</small></label>
  					<input class="form-control" id="seq" name="seqapp" autocomplete="off" value="<%=category.getSeqapp() %>" >
          			</div><!--form-group-->
              	</div><!--col-xs-8-->
           </div><!--row-->
            
            <div class="row">
                <div class="col-xs-12">
                	<div class="form-group">
                    <label>Description <small>(Eng)</small></label> 
                    <textarea class="form-control"  name="eDesc" id="eDesc" rows="3" style="resize:none;"><%=StringUtil.filter(category.geteDesc())%></textarea>  
          			</div><!--form-group-->
                </div><!--col-xs-8-->
                
                <div class="col-xs-12">
                	<div class="form-group">
                    <label>Description <small>(Chi)</small></label>
  					<textarea class="form-control"  name="cDesc" id="cDesc" rows="3" style="resize:none;"><%=StringUtil.filter(category.getcDesc())%></textarea>
          			</div><!--form-group-->
              	</div><!--col-xs-8-->
           </div><!--row-->
            
            <div class="row">
            	<%if(category.getIsparent() == StaticValueUtil.PRODUCT_DISABLE) { %>
           		<div class="col-xs-8" id="subCatWrap">
                	<div class="form-group">
                    <label>Parent Category</label> <br>
                    <select name="parentCat" class="form-control" >
		           		<%=CategoryService.getInstance().getParentSelectPulldown(category.getParentId()) %>
		           	</select>
          			</div>
                </div>
                <%} %>
                
                 <div class="col-xs-8" >
                	<div class="form-group">
                    <label>Status</label> <br>
                   	<select name="status" id="status" class="form-control">
                   		<%=GenericStatusPulldown.getPulldown(category.getStatus()) %>
                   	</select>
          			</div><!--form-group-->
                </div><!--col-xs-8-->
           </div>
            
            <%if(category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE) { %>
            <!--  <tr>
            	<td class="tbl-title">Link Path <small>(web)</small></td>
                <td class="tbl-content" colspan="3"><input type="text" name="deeplinkpathweb" class="form-control" value="<%=StringUtil.filter(category.getDeeplinkpathweb())%>"></td> 
            </tr>
            
            <tr>
            	<td class="tbl-title">Link Path <small>(app)</small></td>
                <td class="tbl-content" colspan="3"><input type="text" name="deeplinkpathapp" class="form-control" value="<%=StringUtil.filter(category.getDeeplinkpathapp())%>"></td>
            </tr> -->
            
            <%} %>
            <!--  <tr>
            	
                <%if(category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE) { %>
                <td class="tbl-title">Deeplink Keyword</td>
                <td class="tbl-content"><input type="text" name="deeplinkkey" class="form-control" value="<%=StringUtil.filter(category.getDeeplinkkey())%>"></td>
            	<td class="tbl-title"></td>
                <td class="tbl-content"></td>
            	<%}else { %>
            	<td class="tbl-title">Parent Category</td>
                <td class="tbl-content">
                	<select name="parentCat" class="form-control" >
		           		<%//CategoryService.getInstance().getParentSelectPulldown(category.getParentId()) %>
		           		<%//ParentCategoryPulldown.getPulldown(category.getParentId()) %>
		           	</select>
                </td>
                <td class="tbl-title"></td>
                <td class="tbl-content"></td>
            	<%} %>
            </tr> -->
            
           
            

            <div class="row">
            	<div class="col-xs-8">
                	<div class="form-group">
                    <label>Image <small>1</small></label>
                    <%if(!(StringUtils.trimToEmpty(category.getImage1()).equals("")) ) {  %>
                    <img src="../../GetImageFileServlet?name=<%=category.getImage1()%>" width="100px" >
                    <%} %>
                    <input  type="file"  class="form-control" id="image1" name="image1" autocomplete="off" >  
                    <label><small>Only support JPG / PNG</small></label>                 
          			</div><!--form-group-->
                 </div><!--col-xs-8-->


            </div><!--row-->
            
 


  

<!--.panel group plan ended-->

			
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
   <button type="submit" class="btn btn-primary loginbtn hvr-float-shadow">Submit</button>
   <a href="javascript:back()" class="btn btn-cancel loginbtn hvr-float-shadow">Back</a>
  </div><!--panel-footer-->
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    </div>
  
    </section><!-- /section.container -->
 </form> 
 	
<script type="text/javascript">
	
	function back() {
		window.location="./AdminCategoryServlet?actionType=getSearchList"; 
		//history.go(-1)
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
	
	/*function isParentOnChange(){
		
		var value = $("[name='isParent']:checked").val();
		
		if(value == <%=StaticValueUtil.PRODUCT_ENABLE%> ){
			$("#subCatWrap").css('display','none');
		}else {
			$("#subCatWrap").css('display','');
		}
	}*/
	
	function checkForm(){
 	var errorMsg = "";
 	
 	if($.trim($("[name='eName']").val()) == '') {
 		errorMsg += "Name (Eng) is required \n";
 	}
 	
 	if($.trim($("[name='cName']").val()) == '') {
 		errorMsg += "Name (Chi) is required \n";
 	}
 	
 	if(!isInt($.trim($("[name='seq'").val())) ) {
 		errorMsg += "Incorrect sequence input \n"
 	}
 	
 	if( <%=category.getIsparent()%> == <%=StaticValueUtil.PRODUCT_DISABLE %>){
 		if($.trim($("[name='parentCat']").val()) == '') {
     		errorMsg += "Parent category is required \n";
     	}
 	}
 	
 	if($.trim($("[name='image1']").val()) == '' && '<%=StringUtil.filter(category.getImage1())%>' == '' && 
 		<%=category.getParentidentifier()%> != <%=StaticValueUtil.CAT_HOT%>
 	   ) {
 		errorMsg += "Image 1 is required \n"
 	}
 		
 	if($.trim($("[name='status'").val()) == '') {
 		errorMsg += "Status is required \n"
 	}
 	
 	if(errorMsg != '') {
 		alert(errorMsg);
 		return false;
 	}	
 }

</script>
 
  </body>
</html>


