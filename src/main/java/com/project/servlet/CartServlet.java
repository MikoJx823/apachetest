package com.project.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.project.bean.CategoryBean;
import com.project.bean.OrderBean;
import com.project.bean.OrderItemBean;
import com.project.bean.ProductBean;
import com.project.bean.ProductVariantBean;
import com.project.service.CategoryService;
import com.project.service.ProductService;
import com.project.service.ReservationService;
import com.project.util.PropertiesUtil;
import com.project.util.SessionName;
import com.project.util.StringUtil;

/**
 * Servlet implementation class CartServlet
 */
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(CartServlet.class);

	private static final String ADDCART = "addCart";
	private static final String REMOVECART = "removeCart";
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");

		String actionType = request.getParameter("actionType");
		log.info("actionType:" + actionType);

		if (ADDCART.equals(actionType)){
			addCart(request, response);
		}else if(REMOVECART.equals(actionType)){
			removeCart(request, response);
		}
	}

	private void addCart(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		String errorMsg = "";
		Date now = new Date();
		boolean isMember = false;
		String memberStr = "";
		
		/*if (!request.getSession().getAttribute(SessionName.token).equals(request.getParameter(SessionName.token)))
		return ;*/
		
		//request.getSession().removeAttribute("soldoutErrorMsg");
		//request.getSession().removeAttribute("soldoutErrorMsgC");
		
		//TO IDENTIFIY IS WEB / APPS 
		
		HttpSession session = request.getSession();
		String sessionId = session.getId();
		int qty = request.getParameter("qty")==null?0:StringUtil.strToInt(request.getParameter("qty"));
		int pid = request.getParameter("pid")==null?0:StringUtil.strToInt(request.getParameter("pid"));
		int pvid = request.getParameter("pvid")==null?0:StringUtil.strToInt(request.getParameter("pvid"));
		
		String resultUrl = "productdetails?id="+ pid;
		
		log.info("sessionId:" + sessionId);
		log.info("session timeout : " + session.getMaxInactiveInterval());
		log.info("pid:" + pid);
		log.info("pvid:" + pvid);
		log.info("qty:" + qty);
		
		OrderBean orderBean = (OrderBean) request.getSession().getAttribute(SessionName.orderCart);
		if (orderBean == null)
			orderBean = new OrderBean();
		
		
		List<OrderItemBean> orderItems = (List<OrderItemBean>) request.getSession().getAttribute("orderItems");
		if (orderItems ==null)
			orderItems = orderBean.getOrderItems();
		
		HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>) request.getSession().getAttribute(SessionName.orderCartItemMap);
		if(cartMap==null)
			cartMap = new HashMap<String, OrderItemBean> ();		
		
		// START IF PURCHASED EXISTED 
		boolean existPro = false;
		
		if (cartMap!=null && !cartMap.isEmpty() ){
			// START IF PRODUCT EXISTED 
			if(cartMap.containsKey(pvid + "")){
				existPro=true;
				
				OrderItemBean orderItemOld = cartMap.get(pvid + "");
				int oldQty = orderItemOld.getQuantity();
				
				orderItemOld.setQuantity(oldQty + qty);
				
				boolean holdFlag = ReservationService.getInstance().holdItem(sessionId, orderItemOld, true);
					
				log.info("holdFlag1: " + holdFlag);
		 		log.info("pvid : " + orderItemOld.getPvid());
				if (!holdFlag){		 				
		 			orderItemOld.setQuantity(oldQty);
		 			errorMsg += "Insufficient stock " + StringUtil.filter(orderItemOld.getProductname()) + "\\n";
		 				
		 		} else {
		 			cartMap.put(orderItemOld.getPvid()+"",orderItemOld);
				}
				// END IF PRODUCT EXISTED 
			}
		}
		// END IF PURCHASED EXISTED 
		

		// START IF IS NEW ADD PRODUCT 
		if (!existPro){	
			OrderItemBean orderItem = new OrderItemBean();
			
			ProductBean product = ProductService.getInstance().getFrontProductById(pid);
			
			if(product != null) {
				
				CategoryBean category = CategoryService.getInstance().getBeanById(product.getCategoryid());
				
				if(category == null) category = new CategoryBean();
				// normal product
				
				ProductVariantBean variant = null;
				for(ProductVariantBean pvariant: product.getProductVariant()) {
					if(pvariant.getPvid() == pvid) {
						variant = pvariant;
					}
				}
			
				if(variant != null) {	
					/*if(variant.getEarlybirddiscount() > 0 && variant.getEarlybirdstart() != null && 
					   variant.getEarlybirdend() != null){
		        		if(variant.getEarlybirdstart().before(now) && variant.getEarlybirdend().after(now)){
		        			orderItem.setDiscount(variant.getPrice() - variant.getEarlybirddiscount());
		        		}
		        	}*/
					
					double earlybird = ProductService.getInstance().getEarlyBirdDiscount(variant);
					if(earlybird > 0) {
						orderItem.setDiscount(variant.getPrice() - earlybird);
					}

					orderItem.setPrice(variant.getPrice());
					orderItem.setPid(product.getId());
					orderItem.setPvid(pvid);
					orderItem.setCategoryid(product.getCategoryid());
					orderItem.setQuantity(qty);
					
					orderItem.setProductname(product.getName());
					orderItem.setProductimage(product.getImage1());
					orderItem.setProductcode(product.getProductcode());
					orderItem.setVariantname(variant.getName());
					
					orderItem.setVariant(variant);
					orderItem.setCategory(category);
					orderItem.setProduct(product);
					
					boolean holdFlag = ReservationService.getInstance().holdItem(sessionId, orderItem, true);
					
					log.info("holdFlag: " + holdFlag);
		 			log.info("pvid : " + orderItem.getPvid());
					if (!holdFlag){		 				
		 				ReservationService.getInstance().releaseSessionItem(sessionId, orderItem.getPvid() + "");
		 				errorMsg += "Not enough stock " + StringUtil.filter(orderItem.getProductname())+ "\\n";
		 			} else {
		 				cartMap.put(orderItem.getPvid() + "",orderItem);
		 			}
				} 
			}else {
				errorMsg += "Invaid product, please try again later.";
			}
		}
		// END IF IS NEW ADD PRODUCT 
		
		request.setAttribute(SessionName.errorMsg, errorMsg);
		session.setAttribute(SessionName.orderCartItemMap, cartMap);
		//response.sendRedirect(resultUrl);
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
  		requestDispatcher.forward(request, response);
		return;
	
	}
	
	private void removeCart(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		String errorMsg = "";
		String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
		String resultUrl = basePath + "cartsummary";//"../productDetails?id="+request.getParameter("id");
		String returnCart = request.getParameter("returnCart")==null?"Y":request.getParameter("returnCart");
		
		/*if (!request.getSession().getAttribute(SessionName.token).equals(request.getParameter(SessionName.token)))
		return ;*/
		
		log.info("returnCart: "+ returnCart);
		log.info("resultUrl: "+ resultUrl);
		
		HttpSession session = request.getSession();
		String sessionId = session.getId();
		
		HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)session.getAttribute(SessionName.orderCartItemMap);
		String cartId = request.getParameter("cartId");
		
		//resultUrl = "../productDetails?id="+request.getParameter("id");

		log.info("sessionId:" + sessionId);
		log.info("cartId:" + cartId);
		
		if (cartMap.containsKey(cartId)) {
			cartMap.remove(cartId);
		}
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultUrl);
  		requestDispatcher.forward(request, response);
  		return;

	}


}
