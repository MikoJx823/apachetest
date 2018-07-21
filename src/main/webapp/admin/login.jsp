<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String validInfo = StringUtils.trimToEmpty((String)request.getAttribute("validInfo"));
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Navalli Admin</title>
    <meta name="description" content="clps ">
    <meta name="viewport" content="width=device-width">
    <!-- <link rel="stylesheet" href="css/bootstrap.css"> -->
    <link rel="stylesheet" href="css/style.css">
 	
    <script src="js/jquery-1.12.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/modernizr.custom.65704.js"></script>
     <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  </head>
  <body>
   <nav class="navbar header">
      <div class="container">
      
        <div class="navbar-header">
          <!--  <img src="images/logo.png" class="brand">-->
         </div>
         
       
        
             <div class="navbar-form navbar-right hidden">
            
                <a class="btn btn-cancel">Logout</a>
              </div><!--navbar--right-->
              
              <div class="navbar-right loginname tbl hidden">
          <div class="tbl-cell tbl-center">
            <small>You are login as:</small><br>
            <big>Name</big>
         </div>
           </div> <!--navbar--right-->
  
       
      </div><!--container-->
    </nav>
<!-- header menu ended-->

    <section class="container">
    
		<div class="loginpage">
        <div class="tbl full-width">
        <div class="tbl-cell tbl-center ">
        
    

    
     <div class="row"> 
     <div class="col-xs-24"> 
<form role="form" action="LoginServlet" method="post">  
  <input type="hidden" name="actionType" value="login"> 
  <div class="panel panel-default center-block"> 
 
  <div class="panel-heading"> <img src="images/login.png">&nbsp;<big> User Login</big></div>
  
  <div class="panel-body">
   
  <div class="form-group">
    <label>Login ID</label>
    <input class="form-control " id="login-id-no" name="loginId" autocomplete="off" placeholder=" Input Login ID">
  </div>
  <div class="form-group">
    <label>Password</label>
    <input class="form-control" type="password" id="login-id-no" name="password" autocomplete="off" placeholder=" Input Password">
  </div>
  <div class="alert alert-warning col-sm-offset-2 col-sm-20 <% if("".equals(validInfo)){ %> hidden" <%} %>">
		<a href="#" class="close" data-dismiss="alert">
		 &times;
		</a>
		<strong><%=validInfo %></strong>
	</div>
  </div>
  
  <div class="panel-footer text-center"><button type="submit" class="btn btn-primary loginbtn hvr-float-shadow">Login</button></div>
  
	</div><!--panel-->
</form>
      
      </div><!--col-xs-24-->
      </div><!--row -->
    
    
 </div><!--tbl-cell-->
        </div><!--tbl-->
        </div>
    

    </section><!-- /section.container -->
  
  </body>
</html>
