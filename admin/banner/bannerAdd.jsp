<%@page import="com.asiapay.clp.pulldown.*"%>
<%@page import="com.asiapay.clp.service.*"%>
<%@page import="com.asiapay.clp.bean.*"%>
<%@page import="com.asiapay.clp.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%	
	//BLOCK UNAUTHERIZE ACCESS 
	//AdminService.performBlockAccess(request, response, AdminFunction.Banner, AdminFunction.Add);
	
	BannerInfoBean bean = request.getAttribute("bannerBean")==null?new BannerInfoBean():(BannerInfoBean)request.getAttribute("bannerBean");
	
	AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>
    
<body>
<form role="form" action="AdminBannerServlet" method="post" id="form" enctype="multipart/form-data" onsubmit="return checkForm()"> 
<input type="hidden" name="actionType" value="add">

      
<jsp:include page="../main/topNav.jsp"></jsp:include>
    <section class="container">    
    <!--main-row-->
    <div class="row">

		<jsp:include page="../main/leftMenu.jsp"><jsp:param value="settings" name="pageIdx"/> </jsp:include>
	
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
    
  
  
<div class="panel-heading"><big>Banner Management</big> </div>
<jsp:include page="../main/msgAlert.jsp"></jsp:include>
<div class="panel-body">
           
<div class="uppertab">
	
	<jsp:include page="../menu/bannerMenu.jsp"><jsp:param value="bannerAdd" name="target"/> </jsp:include> 

	<div class="panel-body">
		<h5 class="text-primary">Banner Information</h5>
        
        
        <div class="row">
        	<div class="col-xs-8">
            	<div class="form-group">
                    <label>Name <small>(Eng)</small></label>
                    <input class="form-control" name="ename" autocomplete="off" value="<%=StringUtil.filter(bean.getEname())%>">
      		    </div><!--form-group-->
            </div><!--col-xs-8-->
            
             <div class="col-xs-8">
            	<div class="form-group">
                    <label>Platform</label>
                    <select name="platform" class="form-control">
                    <%=DisplayPlatformPulldown.getPulldown(bean.getPlatform()) %>
                    </select>
      		    </div><!--form-group-->
            </div><!--col-xs-8-->  
            
            <div class="col-xs-8">
	        	<div class="form-group">
	            	<label>Sequence</label>
	            	<input class="form-control" name="seq" autocomplete="off" value="<%=bean.getSeq()%>">
	          	</div>
      		</div><!--col-xs-8-->
        </div>
        
        <div class="row">
        	 <div class="col-xs-24">
            	<div class="form-group">
                    <label>Link </label>
                    <input class="form-control" name="link" autocomplete="off" value="<%=StringUtil.filter(bean.getLink())%>">
      		    </div><!--form-group-->
            </div><!--col-xs-8-->
		</div><!--row-->

		<div class="row"> 
      		<div class="col-xs-8">
            	<div class="form-group">
                    <label>Status</label>
                    <select name="status" class="form-control">
        		        <%=GenericStatusPulldown.getPulldown(bean.getStatus()) %>
      		        </select>
      		    </div><!--form-group-->
            </div><!--col-xs-8-->  
		</div><!--row-->
        
        <div class="row">
         	<div class="col-xs-6">
               <div class="form-group">
               	<label>Web Image <small>(Eng)</small></label>
               	<input  type="file"  class="form-control" id="ewebimage" name="ewebimage" autocomplete="off" >  
                <label><small>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          	   </div><!--form-group-->
            </div><!--col-xs-6-->
            
            <div class="col-xs-6">
                <div class="form-group">
                 <label>Web Image <small>(Chi)</small></label>
                 <input  type="file"  class="form-control" id="cwebimage" name="cwebimage" autocomplete="off" >  
                 <label><small>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          		</div><!--form-group-->
            </div><!--col-xs-6-->
            
            <div class="col-xs-6">
                <div class="form-group">
                 <label>App Image <small>(Eng)</small></label>
                 <input  type="file"  class="form-control" id="eappimage" name="eappimage" autocomplete="off" >  
                 <label><small>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          		</div><!--form-group-->
            </div><!--col-xs-6-->
                 
            <div class="col-xs-6">
                <div class="form-group">
                 <label>App Image <small>(Chi)</small></label>
                 <input  type="file"  class="form-control" id="cappimage" name="cappimage" autocomplete="off" >  
                 <label><small>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          		</div><!--form-group-->
            </div><!--col-xs-6-->
        
        </div>
             
	</div>
</div><!--.panel group plan ended-->			
</div><!--panel body ended-->

  <div class="panel-footer text-right">
   <button type="submit" class="btn btn-primary loginbtn hvr-float-shadow">Submit</button>
   <button type="button" onclick="history.go(-1)" class="btn btn-cancel loginbtn hvr-float-shadow">Back</button>
  </div><!--panel-footer-->
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
  </div>  

    </section><!-- /section.container -->
  
  </form> 
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
	   
function checkForm(){
	var errorMsg = "";
	
	if($.trim($("[name='ename']").val()) == '') {
		errorMsg += "Name is required \n";
	}
	
	if($.trim($("[name='link']").val()) == '') {
		errorMsg += "Link is required \n";
	}
	
	if($.trim($("[name='seq']").val()) != '') {
		if(!isInt($.trim($("[name='seq']").val()))){
			errorMsg += "Sequence number only accept numberic \n"
		} 
	}
	
	if($.trim($("[name='platform']").val()) == '') {
		errorMsg += "Platform is required \n";
	}else {
		var platform = $.trim($("[name='platform']").val());
		
		if(platform == <%=StaticValueUtil.DISPLAY_WEB%> || platform == <%=StaticValueUtil.DISPLAY_ALL%>){
 
			 if($.trim($("[name='ewebimage']").val()) == '') {
			 	errorMsg += "Web Image (Eng) is required \n";
			 }
			 
			 if($.trim($("[name='cwebimage']").val()) == '') {
				errorMsg += "Web Image (Chi) is required \n";
			 }
		}
		
		if(platform == <%=StaticValueUtil.DISPLAY_APPS%> || platform == <%=StaticValueUtil.DISPLAY_ALL%>){
			if($.trim($("[name='eappimage']").val()) == '') {
				errorMsg += "App Image (Eng) is required \n";
			}
			
			if($.trim($("[name='cappimage']").val()) == '') {
				errorMsg += "App Image (Chi) is required \n";
			}
		}
		
	}
	
	if($.trim($("[name='status']").val()) == '') {
		errorMsg += "Status is required \n";
	}	
		
	if(errorMsg != '') {
		alert(errorMsg);
		return false;
	}	
}

</script>
</body>

</html>
