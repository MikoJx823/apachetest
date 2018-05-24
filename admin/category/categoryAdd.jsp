﻿<%@ page language="java" import="java.util.*,com.project.bean.*,com.project.service.*,org.apache.commons.lang.StringUtils,com.project.pulldown.*,com.project.util.*" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.Category, AdminFunction.Add);
	
	AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute("loginUser");
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	
	CategoryBean bean = (CategoryBean) request.getAttribute(SessionName.beanInfo);
	
	if(bean == null){
		bean = new CategoryBean();
	}
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>

  <body>
     <jsp:include page="../main/topNav.jsp"></jsp:include>
    <section class="container">
    
    <!--main-row-->
    <div class="row">
    
    <!--left Menu area-->

  
    <jsp:include page="../main/leftMenu.jsp"><jsp:param value="category" name="pageIdx" /> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>Category Management</big></div>
  <jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <form action="AdminCategoryServlet" method="post" name="addForm" enctype="multipart/form-data" onsubmit="return checkForm()" >   
  <% 	session.setAttribute(SessionName.token,StringUtil.randomString(16)); %>
  <input type="hidden" name="<%=SessionName.token %>" value="<%= session.getAttribute(SessionName.token) %>" />
  <div class="panel-body">
  	
  	
      <fieldset>

<input type="hidden" name="actionType" value="categoryAdd">

	
      <div class="uppertab">
      
      <jsp:include page="../menu/categoryMenu.jsp"><jsp:param value="addMenu" name="target"/> </jsp:include> 
      
  <!-- Nav tabs 
  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
    <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
     	<li role="presentation"><a href="../category/AdminCategoryServlet?actionType=getSearchList&from=menu" >Category Search</a></li>
  	<%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation" class="active"><a href="categoryAdd.jsp">Add Category</a></li>
   	<%} %>
   	 
  </ul>

  <!-- Tab panes -->
	<div class="panel-body">
           <h5 class="text-primary">Category Information</h5>
           
           <div class="row">
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Name <small>(Eng)</small></label> 
                    <input class="form-control" id="eName" name="eName" autocomplete="off" value="<%=StringUtil.filter(bean.geteName())%>" >	
          			</div><!--form-group-->
                </div><!--col-xs-8-->
                
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>Name <small>(Chi)</small></label>
  					<input class="form-control" id="cName" name="cName" autocomplete="off" value="<%=StringUtil.filter(bean.getcName())%>" >
          			</div><!--form-group-->
              	</div><!--col-xs-8-->
              	
              	<div class="col-xs-4">
                	<div class="form-group">
                    <label>Sequence <small>(Web)</small></label>
  					<input class="form-control" id="seq" name="seq" autocomplete="off" value="<%=bean.getSeq() %>" >
          			</div><!--form-group-->
              	</div><!--col-xs-8-->
              	
              	<div class="col-xs-4">
                	<div class="form-group">
                    <label>Sequence <small>(App)</small></label>
  					<input class="form-control" id="seq" name="seqapp" autocomplete="off" value="<%=bean.getSeqapp() %>" >
          			</div><!--form-group-->
              	</div><!--col-xs-8-->
           </div><!--row-->

           <div class="row">
                <div class="col-xs-12">
                	<div class="form-group">
                    <label>Description <small>(Eng)</small></label> 
                    <textarea class="form-control"  name="eDesc" id="eDesc" rows="3" style="resize:none;"><%=StringUtil.filter(bean.geteDesc())%></textarea>  
          			</div><!--form-group-->
                </div><!--col-xs-8-->
                
                <div class="col-xs-12">
                	<div class="form-group">
                    <label>Description <small>(Chi)</small></label>
  					<textarea class="form-control"  name="cDesc" id="cDesc" rows="3" style="resize:none;"><%=StringUtil.filter(bean.getcDesc())%></textarea>
          			</div><!--form-group-->
              	</div><!--col-xs-8-->
           </div><!--row-->
           
           <div class="row">
           		<div class="col-xs-8" id="subCatWrap">
                	<div class="form-group">
                    <label>Parent Category</label> <br>
                    <select name="parentCat" class="form-control" >
		           		<%=CategoryService.getInstance().getParentSelectPulldown(bean.getParentId()) %>
		           	</select>
          			</div>
                </div>
                
                 <div class="col-xs-8" >
                	<div class="form-group">
                    <label>Status</label> <br>
                   	<select name="status" id="status" class="form-control">
                   		<%=GenericStatusPulldown.getPulldown(bean.getStatus()) %>
                   	</select>
          			</div><!--form-group-->
                </div><!--col-xs-8-->
           </div>

            <div class="row">
            	<div class="col-xs-8">
                	<div class="form-group">
                    <label>Image <small>1</small></label>
                    <input  type="file"  class="form-control" id="image1" name="image1" autocomplete="off" >  
                    <label><small>Only support JPG / PNG</small></label>                 
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
            </div><!--row-->
            
            <hr>
            
            <!--  
            <div class="row">
                <div class="col-xs-8">
                	<div class="form-group">
                    <label>isParent Category</label> &nbsp;&nbsp;&nbsp;
                    	Yes <input type="radio" name="isParent" value="<%=StaticValueUtil.PRODUCT_ENABLE %>" 
                    	<%=bean.getIsparent()==StaticValueUtil.PRODUCT_ENABLE?"checked":"" %> onchange="isParentOnChange()">
                    	No <input type="radio" name="isParent" value="<%=StaticValueUtil.PRODUCT_DISABLE %>" 
                    	<%=bean.getIsparent()==StaticValueUtil.PRODUCT_DISABLE?"checked":"" %> onchange="isParentOnChange()">
          			</div>
                </div>
                
                <div class="col-xs-8" id="subCatWrap">
                	<div class="form-group">
                    <label>Parent Category</label> <br>
                    <select name="parentCat" class="form-control" >
		           		<%//CategoryService.getInstance().getParentSelectPulldown(bean.getParentId()) %>
		           		<%//ParentCategoryPulldown.getPulldown(bean.getParentId()) %>
		           	</select>
          			</div>
                </div>
                
                <div class="col-xs-8" style="display:none">
                	<div class="form-group">
                    <label>Deeplink Keyword</label> <br>
                   	<input type="text" name="deeplinkkey" class="form-control" value="<%=StringUtil.filter(bean.getDeeplinkkey())%>">
          			</div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-xs-24" style="display:none" name="parentCatWrap">
                	<div class="form-group">
                    <label>Link Path <small>(web)</small></label> <br>
                   	<input type="text" name="deeplinkpathweb" class="form-control" value="<%=StringUtil.filter(bean.getDeeplinkpathweb())%>">
          			</div>
                </div>
            </div>
    
    		<div class="row">
                <div class="col-xs-24" style="display:none" name="parentCatWrap">
                	<div class="form-group">
                    <label>Link Path <small>(app)</small></label> <br>
                   	<input type="text" name="deeplinkpathapp" class="form-control" value="<%=StringUtil.filter(bean.getDeeplinkpathapp())%>">
          			</div>
                </div>
            </div>
    		-->
</div><!--.bg-light-primary-->
	
</div>

        
 
    </fieldset>    
    
  </div><!--panel body ended--> 
  	<div class="panel-footer text-right">
	   <button type="submit" class="btn btn-primary loginbtn hvr-float-shadow">Submit</button>
	</div><!--panel-footer-->
  
  </form> 
	</div>   
    </div><!--right main content col-xs-19 ended-->
    
    </div><!--main row-->
    </section><!-- /section.container -->
  
  
<script type="text/javascript">
	
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
	
	function isParentOnChange(){
		
		var value = $("[name='isParent']:checked").val();
		
		if(value == <%=StaticValueUtil.PRODUCT_ENABLE%> ){
			$("[name='parentCatWrap']").css('display','');
			$("#subCatWrap").css('display','none');
		}else {
			$("[name='parentCatWrap']").css('display','none');
			$("#subCatWrap").css('display','');
		}
	}
	
	function checkForm(){
    	var errorMsg = "";
    	
    	var isParent = $.trim($("[name='isParent'").val());

    	if($.trim($("[name='eName']").val()) == '') {
    		errorMsg += "Name (Eng) is required \n";
    	}
    	
    	if($.trim($("[name='cName']").val()) == '') {
    		errorMsg += "Name (Chi) is required \n";
    	}
    	
    	if(!isInt($.trim($("[name='seq'").val())) ) {
    		errorMsg += "Incorrect sequence input \n"
    	}
    	
    	/*if( isParent == '') {
    		errorMsg += "isParent is required \n"
    	}*/
		
    	if( isParent == <%=StaticValueUtil.PRODUCT_DISABLE %>){
    		if($.trim($("[name='parentCat']").val()) == '') {
        		errorMsg += "Parent category is required \n";
        	}
    	}
    	
    	if($.trim($("[name='image1']").val()) == '') {
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
	
	isParentOnChange()

</script>
  
</body>
	
</html>


