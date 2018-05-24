package com.project.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.OrderBean;
import com.project.bean.OrderItemBean;
import com.project.bean.ProductBean;
import com.project.bean.ProductVariantBean;
import com.project.pulldown.OrderStatusPulldown;
import com.project.service.OrderService;
import com.project.service.ProductService;
import com.project.util.PropertiesUtil;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class CheckoutServlet
 */
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(CheckoutServlet.class);
	
	private static final String checkout = "checkout";
	private static final String checkoutLogin1 = "checkLogin1";
	private static final String checkoutLogin2 = "checkLogin2";
	private static final String checkout2 = "checkout2";
	private static final String checkout3 = "checkout3";
	private static final String payment = "payment";
	private static final String survey = "survey";
	private static final String removeCart = "removeCart";
	private static final String changeQty = "changeQty";
	
	@Override
	protected void service(HttpServletRequest request,  HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");

		checkout(request, response);
	}
	
	private void checkout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		
		String errorMsg = "";
		PropertiesUtil propUtil = new PropertiesUtil();
		String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
		/*if (!request.getSession().getAttribute(SessionName.token).equals(request.getParameter(SessionName.token)))
		return ;*/
		
		//TO IDENTIFIY IS WEB / APPS 
		String resultUrl =  "cart/paySuccess.jsp";//"checkoutConfirm.jsp";
		
		request.getSession().removeAttribute("order");
	    OrderBean orderBean = new OrderBean();
	    //(OrderBean) request.getSession().getAttribute(SessionName.orderCart);
	    //if(orderBean == null) orderBean = new OrderBean();
	    
	    //MemberBean member = (MemberBean) request.getSession().getAttribute(SessionName.loginMember) ;
	    
	    HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute(SessionName.orderCartItemMap);
		//NAVIGATE TO CHECKOUT 1 IF IS EMPTY 
		if (cartMap == null || cartMap.isEmpty()) { 
			resultUrl = "cart/cartsummary.jsp";
			//resultUrl = "index.jsp?type=" + type;
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
	  		requestDispatcher.forward(request, response);
	  		return;
		}
		
		String firstname =  StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("firstname")).getBytes("ISO8859-1"), "utf-8"));
		String lastname =  StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("lastname")).getBytes("ISO8859-1"), "utf-8"));
		String companyname =  StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("companyname")).getBytes("ISO8859-1"), "utf-8"));
		String email = StringUtil.blockXss(StringUtil.filter(request.getParameter("email")));
		String phone = StringUtil.blockXss(StringUtil.filter(request.getParameter("contact")));
		String address = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("address")).getBytes("ISO8859-1"), "utf-8"));
		String address2 = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("address2")).getBytes("ISO8859-1"), "utf-8"));
		String postcode =StringUtil.blockXss( new String(StringUtil.filter(request.getParameter("postcode")).getBytes("ISO8859-1"), "utf-8"));
		String town = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("town")).getBytes("ISO8859-1"), "utf-8"));
		String state = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("state")).getBytes("ISO8859-1"), "utf-8"));
		String country = StringUtil.blockXss(StringUtil.filter(request.getParameter("country")));
		String remark = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("remark")).getBytes("ISO8859-1"), "utf-8"));
		
		String shipDifferent = StringUtil.blockXss(StringUtil.filter(request.getParameter("shipdifferent")));
		String shipfirstname =  StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("shipfirstname")).getBytes("ISO8859-1"), "utf-8"));
		String shiplastname =  StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("shiplastname")).getBytes("ISO8859-1"), "utf-8"));
		String shipcompanyname =  StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("shipcomanyname")).getBytes("ISO8859-1"), "utf-8"));
		String shipaddress = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("shipaddress")).getBytes("ISO8859-1"), "utf-8"));
		String shipaddress2 = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("shipaddress2")).getBytes("ISO8859-1"), "utf-8"));
		String shippostcode = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("shippostcode")).getBytes("ISO8859-1"), "utf-8"));
		String shiptown = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("shiptown")).getBytes("ISO8859-1"), "utf-8"));
		String shipstate = StringUtil.blockXss(new String(StringUtil.filter(request.getParameter("shipstate")).getBytes("ISO8859-1"), "utf-8"));
		String shipcountry = StringUtil.blockXss(StringUtil.filter(request.getParameter("shipcountry")));
		     
		orderBean.setOrderRef("");
		orderBean.setTotalAmount(0.0);
		orderBean.setOrderAmount(0.0);
		orderBean.setDeliveryAmount(0.0);
		orderBean.setDiscountAmount(0.0);
		
		orderBean.setRemainAmount(0.0);
		orderBean.setOrderStatus("P");
		orderBean.setTransactiondate(new Date());
		orderBean.setBuyerfirstname(firstname);
		orderBean.setBuyerlastname(lastname);
		
		orderBean.setBuyercompanyname(companyname);
		orderBean.setBuyeremail(email);
		orderBean.setBuyerphone(phone);
		orderBean.setBuyeraddress1(address);
		orderBean.setBuyeraddress2(address2);
		
		orderBean.setBuyerpostcode(postcode);
		orderBean.setBuyertown(town);
		orderBean.setBuyerstate(state);
		orderBean.setBuyercountry(country);
		orderBean.setBuyerremark(remark);
		
		if(shipDifferent.equals(StaticValueUtil.STATUS_YES)){
			orderBean.setShipfirstname(shipfirstname);
			orderBean.setShiplastname(shiplastname);
			orderBean.setShipcompanyname(shipcompanyname);
			orderBean.setShipaddress1(shipaddress);
			orderBean.setShipaddress2(shipaddress2);
			
			orderBean.setShippostcode(shippostcode);
			orderBean.setShiptown(shiptown);
			orderBean.setShipstate(shipstate);
			orderBean.setShipcountry(shipcountry);
		}else{
			orderBean.setShipfirstname(firstname);
			orderBean.setShiplastname(lastname);
			orderBean.setShipcompanyname(companyname);
			orderBean.setShipaddress1(address);
			orderBean.setShipaddress2(address2);
			
			orderBean.setShippostcode(postcode);
			orderBean.setShiptown(town);
			orderBean.setShipstate(state);
			orderBean.setShipcountry(country);
		}
		
		errorMsg = onCheck(orderBean, shipDifferent);
		request.getSession().setAttribute("order", orderBean);
		
		if(!"".equals(errorMsg)){
			resultUrl = "/cart/checkout.jsp";
			request.setAttribute("errorMsg", errorMsg);
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
	  		requestDispatcher.forward(request, response);
	  		return;
		}
		
		double orderAmount = 0;
		double totalAmount = 0;
		double deliveryAmount = 0;
		double discountAmount = 0;
		double couponAmount = 0;
		
		List<OrderItemBean> orderItems = new ArrayList<OrderItemBean>();
		if (cartMap!=null && !cartMap.isEmpty()){
			for (Map.Entry<String,OrderItemBean> entry : cartMap.entrySet()) {
				String key = entry.getKey();
		  		OrderItemBean orderItem = entry.getValue();
		  		
		  		//totalAmount += orderItem.getPrice() * orderItem.getQuantity();
		  		orderAmount += orderItem.getPrice() * orderItem.getQuantity();
				discountAmount += orderItem.getDiscount() * orderItem.getQuantity();
		  		
				orderItem.setCreatedDate(new Date());
				orderItem.setCreatedBy("cart");
				orderItem.setStatus(1);
				orderItems.add(orderItem);
			}
		}
		
		if(orderAmount - discountAmount < 0){
			errorMsg = "Checkout error ! Please try again. ";
			
			resultUrl = "/cart/checkout.jsp";
			request.setAttribute("errorMsg", errorMsg);
			request.setAttribute("order", orderBean);
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
	  		requestDispatcher.forward(request, response);
	  		return;
		}
		
		if(orderBean.getShipcountry().equals("MY")){
			if(orderAmount - discountAmount < StringUtil.strToInt(propUtil.getString("shipping", "shipping.local.min.free"))){
				deliveryAmount = StringUtil.strToInt(propUtil.getString("shipping", "shipping.fee.local"));
			}
		}else{
			deliveryAmount = StringUtil.strToInt(propUtil.getString("shipping", "shipping.fee.international"));
		}
		
		totalAmount = orderAmount - discountAmount + deliveryAmount;
		
		// START STOCK CHECKING  
		if(orderItems.size() > 0) {
			for(OrderItemBean orderItem : orderItems ) {
				ProductBean product = ProductService.getInstance().getProductById(orderItem.getPid());
				
				if(product != null){
					ProductVariantBean variant = ProductService.getInstance().getProductVariantByPvid(orderItem.getPvid());
					if(variant != null){
						int availableQty = ProductService.getInstance().getProductAvailableQuantity(orderItem.getPvid());
						
						log.info("availableQty " + availableQty );
						log.info("order qty " + orderItem.getQuantity());
						
						if(availableQty - orderItem.getQuantity() < 0){
							errorMsg += product.getName() + " out of stock. <br> ";
						}
					}else {
						errorMsg = "Checkout error ! Invalid product : " + StringUtil.filter(orderItem.getProductname()) ;
					}
				}else{
					errorMsg = "Checkout error ! Invalid product : " + StringUtil.filter(orderItem.getProductname()) ;
				}
			}
		}
		
		log.info("errorMsg" + errorMsg);
		
		if(!(errorMsg.equals(""))){
			resultUrl = "cart/cartsummary.jsp";
			request.setAttribute("errorMsg", errorMsg);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
			requestDispatcher.forward(request, response);
			return;
		}
		// END STOCK CHECKING 
		
		orderBean.setOrderRef("");
		orderBean.setTotalAmount(Math.round(Double.valueOf(totalAmount) * 100.0) / 100.0);
		orderBean.setOrderAmount(Math.round(Double.valueOf(orderAmount) * 100.0) / 100.0);
		orderBean.setDeliveryAmount(Math.round(Double.valueOf(deliveryAmount) * 100.0) / 100.0);
		orderBean.setDiscountAmount(Math.round(Double.valueOf(discountAmount) * 100.0) / 100.0);
		orderBean.setCouponamount(Math.round(Double.valueOf(couponAmount) * 100.0) / 100.0);
		orderBean.setRemainAmount(Math.round(Double.valueOf(totalAmount) * 100.0) / 100.0);
		orderBean.setOrderItems(orderItems);
		
		
		log.info("Payment Start ********************************** ");
		orderBean = OrderService.getInstance().insertOrder(orderBean);

			log.info("orderBean.getoId(): "+ orderBean.getoId());
		if (orderBean != null ){

			String orderRef = OrderService.getInstance().generateOrderNo(request);
			log.info("order ref " + orderBean.getOrderRef());
			
			orderBean.setOrderRef(orderRef);
			orderBean.setModifiedDate(new Date());
			orderBean.setModifiedBy("cart");
			OrderService.getInstance().updateOrder(orderBean);
			
			//Perform time delay 
			Random r = new Random();
			int delayTime = r.nextInt(1000-1) + 1;
			try {
				Thread.sleep(delayTime);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			// START STOCK CHECKING  
			if(orderItems.size() > 0) {
				for(OrderItemBean orderItem : orderItems ) {
					ProductBean product = ProductService.getInstance().getProductById(orderItem.getPid());
					
					if(product != null){
						ProductVariantBean variant = ProductService.getInstance().getProductVariantByPvid(orderItem.getPvid());
						if(variant != null){
							int availableQty = ProductService.getInstance().getProductAvailableQuantity(orderItem.getPvid());
							
							log.info("availableQty1 " + availableQty );
							log.info("order qty1 " + orderItem.getQuantity());
							
							if(availableQty - orderItem.getQuantity() < 0){
								errorMsg += product.getName() + " out of stock. <br> ";
							}
						}else {
							errorMsg = "Checkout error ! Invalid product : " + StringUtil.filter(orderItem.getProductname()) ;
						}
					}else{
						errorMsg = "Checkout error ! Invalid product : " + StringUtil.filter(orderItem.getProductname()) ;
					}
				}
			}
			
			if(!(errorMsg.equals(""))){
				orderBean.setOrderStatus(OrderStatusPulldown.REJECTED);
				OrderService.getInstance().updateOrder(orderBean);
				
				resultUrl = "cart/cartsummary.jsp";
				request.setAttribute("errorMsg", errorMsg);
		  		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
		  		requestDispatcher.forward(request, response);
		  		return;
			}
			// STOCK CHECKING END 
			

		}else {
			resultUrl =  "cart/cartsummary.jsp";
			errorMsg = "Checkout error ! Please try again !";
			
			request.setAttribute("errorMsg", errorMsg);
			
		}
		
		//REMOVE AFTER APPLIED PAYMENT GATEWAY
		if(resultUrl.contains("paySuccess")) {
			
			
			resultUrl += "?ref=" + orderBean.getOrderRef();
			
			log.info("resultUrl " + basePath + resultUrl);
			response.sendRedirect(basePath + resultUrl);
			return;
		}
		//REMOVE AFTER APPLIED PAYMENT GATEWAY
		
		
		
		request.getSession().setAttribute(SessionName.orderCart, orderBean);
		request.getSession().setAttribute(SessionName.orderCartItemMap, cartMap);
		
		//payment(request,response);
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
  		requestDispatcher.forward(request, response);
  		return;
		
	
	}
	
	private String onCheck(OrderBean order, String isShipDifferent){
		String errorMsg = "";
		
		if("".equals(StringUtil.filter(order.getBuyerfirstname()))){
			errorMsg += "First name is required. <br>";
		}
		
		if("".equals(StringUtil.filter(order.getBuyerlastname()))){
			errorMsg += "Last name is required. <br>";
		}
		
		if("".equals(StringUtil.filter(order.getBuyeremail()))){
			errorMsg += "Email is required. <br>";
		}
		
		if("".equals(StringUtil.filter(order.getBuyerphone()))){
			errorMsg += "Contact is required. <br>";
		}
		
		if("".equals(StringUtil.filter(order.getBuyeraddress1()))){
			errorMsg += "Address line 1 is required. <br>";
		}
		
		if("".equals(StringUtil.filter(order.getBuyerpostcode()))){
			errorMsg += "Postcode is required. <br>";
		}
		
		if("".equals(StringUtil.filter(order.getBuyerstate()))){
			errorMsg += "State is required. <br>";
		}
		
		if("".equals(StringUtil.filter(order.getBuyercountry()))){
			errorMsg += "Country is required. <br>";
		}
		
		if(isShipDifferent.equals(StaticValueUtil.STATUS_YES)){
			if("".equals(StringUtil.filter(order.getShipfirstname()))){
				errorMsg += "Shipping first name is required. <br>";
			}
			
			if("".equals(StringUtil.filter(order.getShiplastname()))){
				errorMsg += "Shipping last name is required. <br>";
			}
			
			if("".equals(StringUtil.filter(order.getShipaddress1()))){
				errorMsg += "Shipping address line 1 is required. <br>";
			}
			
			if("".equals(StringUtil.filter(order.getShippostcode()))){
				errorMsg += "Shipping postcode is required. <br>";
			}
			
			if("".equals(StringUtil.filter(order.getShipstate()))){
				errorMsg += "Shipping state is required. <br>";
			}
			
			if("".equals(StringUtil.filter(order.getShipcountry()))){
				errorMsg += "Shipping country is required. <br>";
			}
		}

		return errorMsg;
	}
	
}
