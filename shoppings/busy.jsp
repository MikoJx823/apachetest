<%@ page language="java" contentType="text/html; charset=utf-8"%>

<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"  />

<!--facebook Meta-->
<title>Smart Shopping - Server Busy</title>
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700" rel="stylesheet">
<link href="../css/style_web.css" rel="stylesheet" type="text/css">

</head>
<body>

<header   id="top">
<nav class="navbar-inverse collapse navbar-collapse">
  <div class="container">
    <div class="col-xs-24">
      <ul class="nav navbar-nav navbar-right hidden-xs">
      
      	
   
        <li>
          <div class="navbar-btn navbar-text">
			
			
        	&nbsp;
   		  </div>
        </li>
      </ul>
    </div>
    
   
  </div>
  </nav>
  <!-- /.container-fluid -->
  
  <nav>
    <div class="container"> 
       <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">  
    
  
      
     <a class="brand-icon" href="https://www.clp.com.hk/en"  target="_blank">
     <img src="https://store.clp.com.hk/images_web/clp-logo-en.png" class="img-responsive">
</a>

	
     
     <a class="cart-menu hidden" >
     <img src="https://store.clp.com.hk/images_web/icon/iconSet_blueCart.svg"> 
	  <span class="badge">1</span> 
     </a>
     
    </div>
      <!-- Collect the nav links, forms, and other content for toggling -->      <!-- /.navbar-collapse --> 
    </div><!-- /.container-fluid --> 
  </nav>
  
  
  
  
  
  
  
  
  
   <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="navbar-collapse collapsed-desktop" id="navBar">
      <div class="container-fluid">
        <ul class="nav">
		  <li><a href="https://store.clp.com.hk/hot?actionType=search&type=web">What's Hot</a></li>
          <li><a href="https://store.clp.com.hk/category?parentId=-1&type=web">Electrical Appliances</a></li>
          <li><a href="https://store.clp.com.hk/category?parentId=-2&type=web">Smart Appliances</a></li>
          <li><a href="https://store.clp.com.hk/category?parentId=-3&type=web">Eco Rewards</a></li>
        </ul>
        
   
        
        <ul class="nav navbar-nav collapsed-desktop">
         <li>
         
         	<a href="https://store.clp.com.hk/shoppings/login.jsp">Login </a>
         
         </li>
         
          <li><a href="https://store.clp.com.hk/guestOrderSearch?type=web"><span class="icon"></span>Order History</a></li>          
	 
          <li>

          
          
          </li>
        
        </ul>
        	<form action="https://store.clp.com.hk/search" name="addCartForm" method="post">
        	<input type="hidden" name="type" value="web">
            <div class="input-group pd-10">
		      <input type="text" class="form-control" name="key" placeholder="Find a product ">
		      <span class="input-group-btn">
        		<!-- <button class="btn btn-success" type="button"><span class="fa fa-search"></span><span class="sr-only">Search</span></button> -->
        		<input class="btn btn-success" type="submit" value="Search"><span class="fa fa-search"></span><span class="sr-only">Search</span>
      		  </span>
    		</div>
    		</form>
      </div>
      <!-- /.container-fluid --> 
      
    </div>
    <!-- /.navbar-collapse --> 
  
  
  
</header>


<!--header-->












<section>
<div class="categorypg container">
   <div class="row">
           
<div class="col-xs-24"> <h1 class="text-primary">System Busy</h1>
</div>

<div class="col-xs-24">
<h4>對不起，系統繁忙, 請稍後重試。<br>
你亦可 <a class=" dark-gray-link" href="https://store.clp.com.hk"><u>https://store.clp.com.hk</u></a> 瀏覽，或回上一頁。</h4>

<br><br>

<h4>Sorry, your requested page cannot be displayed, please try again latter. <br>You may also visit the CLP home page at <a class=" dark-gray-link" href="https://store.clp.com.hk"><u>https://store.clp.com.hk</u></a>, or back to previous page.</h4>



</div>
      
    </div>   

    
    
		
		
		
		
		
		
		

		
        
        
        	<!--row-->
		
		
		

     
     
    
     
	</div><!--category pg ended-->   
    
	
     
</section>











 

<footer class="footer">
<a href="#top" class="backtop text-center  scroll"><span class="fa fa-chevron-up"></span><em class="sr-only">Back To Top 返回頁頂 </em></a>

<div class="container">

      <div class="row">
      <div class="col-xs-24 mt-15">
         
            <ul class=" list-inline pull-right tcLink">
          
          <li title="Privacy Policy"><a title="" href="https://www.clp.com.hk/en/privacy-policy"><span>Privacy </span></a> </li>
          
          <li title="Copyright"><a title="" href="https://www.clp.com.hk/en/copyright"><span>Copyright</span></a> </li>
          
          <li title="Disclaimer"><a title="" href="https://www.clp.com.hk/en/disclaimer"><span>Disclaimer</span></a> </li>
          
          <li title="Personal Information Collection Statement"><a title="" href="https://www.clp.com.hk/en/personal-information-collection-statement"><span>Personal Information Collection Statement</span></a> </li>
          
          <li> © 2017 CLP Power Hong Kong Limited.中華電力有限公司 All Rights Reserved.</li>
          
        </ul>
      
        </div>
        </div>
      
</div>
</footer>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="../js/jquery.min.js"></script>

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="../js/bootstrap.js"></script>
<script src="../js/function_web.js"></script>


</body>
</html>


