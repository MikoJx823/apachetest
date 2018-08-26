package com.project.servlet.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.log4j.Logger;

import com.project.bean.AdminInfoBean;
import com.project.bean.MsgAlertBean;
import com.project.bean.ProductBean;
import com.project.bean.ProductVariantBean;
import com.project.pulldown.ProductStatus;
import com.project.service.ProductService;
import com.project.util.DateUtil;
import com.project.util.PropertiesUtil;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class AdminProductServlet
 */
@MultipartConfig
public class AdminProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(AdminProductServlet.class);

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		resp.setContentType("text/html");
		resp.setHeader("Cache-Control", "no-cache");
		String actionType = req.getParameter("actionType");
	
		log.info("actionType:" + actionType);

		if (SessionName.actionTypeSearch.equals(actionType)){
			search(req, resp);
		}else if (SessionName.actionTypeAdd.equals(actionType)){
			add(req, resp);
		}else if (SessionName.actionTypeView.equals(actionType)){
			// productView(req, resp, su);
		}else if (SessionName.actionTypeDelete.equals(actionType)){
			delete(req, resp);
		}else if (SessionName.actionTypeEdit.equals(actionType)){
			edit(req, resp);
		}else if (SessionName.actionTypeUpdateStatus.equals(actionType)) {
			updateStatus(req,resp);
		}
	}

	private void delete(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "productIdx.jsp";
		String errorMsg = "";
		try
		{
			AdminInfoBean loginAdmin = (AdminInfoBean) request.getSession().getAttribute("loginAdmin");
			String pid = StringUtil.filter(request.getParameter(SessionName.itemid), "0");

			ProductBean product = ProductService.getInstance().getProductById(StringUtil.strToInt(pid));

			product.setStatus(StaticValueUtil.Delete);
			product.setModifiedBy(loginAdmin.getName());

			if (ProductService.getInstance().delete(product) != null){
				errorMsg = "Delete product [" + StringUtil.delHTMLTag(product.getName()) + "] success.";
			}else{
				errorMsg = "Delete product [" + StringUtil.delHTMLTag(product.getName()) + "] fail.";
			}

			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);

			// resp.;
			search(request, response);

		}
		catch (Exception e)
		{
			log.error(e);
		}
	}

	private void add(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "productAdd.jsp";
		String errorMsg = "";
		Date now = new Date();

		if (!request.getSession().getAttribute(SessionName.token).equals(request.getParameter(SessionName.token)))
			return;

		try
		{
			AdminInfoBean loginAdmin = (AdminInfoBean) request.getSession().getAttribute(SessionName.loginAdmin);
			
			
			List<ProductVariantBean> variants = new ArrayList<ProductVariantBean>();
			
			int categoryId = StringUtil.strToInt(request.getParameter("categoryId"));
			int brandId = StringUtil.strToInt(request.getParameter("brandId"));
			String productcode = StringUtil.filter(request.getParameter("productCode"));
			String ename = StringUtil.filter(request.getParameter("eName"));
			int status = StringUtil.strToInt(StringUtil.filter(request.getParameter("status"), (StaticValueUtil.Inactive + "")));
			String descYoutube = StringUtil.filter(request.getParameter("descyoutube"));
			String fullDesc = StringUtil.filter(request.getParameter("fulldesc"));
			String shortDesc = StringUtil.filter(request.getParameter("shortdesc"));
			String additionalDesc = StringUtil.filter(request.getParameter("additionaldesc"));
			int variantcounter = StringUtil.strToInt(request.getParameter("variantcounter")); 
			
			ProductBean product = new ProductBean();

			product.setCategoryid(categoryId);
			product.setBrandid(brandId);
			product.setProductcode(productcode);
			product.setName(ename);
			product.setBrandid(brandId);
			//product.setDescimage(""); //descimage
			product.setDescyoutube(descYoutube); 
			//product.setFulldesc(fullDesc);
			product.setDetail(fullDesc);
			product.setShortdesc(shortDesc);
			product.setAdditionaldesc(additionalDesc);
			product.setStatus(status);
			product.setCreatedBy(loginAdmin.getName());
			//product.setDisplaystart(DateUtil.stringToDate(dateFromStr));
			//product.setDisplayend(DateUtil.stringToDate(dateToStr));
			log.info("second");
			log.info("counter " + variantcounter);
			for(int i = 1; i <= variantcounter; i++) {
				ProductVariantBean variant = new ProductVariantBean();
				
				String variantname = StringUtil.filter(request.getParameter("variant" + i));
				double price = StringUtil.strToDouble(request.getParameter("price" + i));
				double discount = StringUtil.strToDouble(StringUtil.filter(request.getParameter("discount" + i),"0"));
				int quantity = StringUtil.strToInt(request.getParameter("quantity" + i));
				
				String discountDayFromStr = StringUtil.filter(request.getParameter("ddayFrom" + i), now.getDate());
				String discountMonthFromStr = StringUtil.filter(request.getParameter("dmonthFrom" + i), now.getMonth());
				String discountYearFromStr = StringUtil.filter(request.getParameter("dyearFrom" + i), now.getYear() + 1900);
				String discountHourFromStr = StringUtil.filter(request.getParameter("dhourFrom" + i), "00");
				String discountMinuteFromStr = StringUtil.filter(request.getParameter("dminuteFrom" + i), "00");
				String discountSecondFromStr = StringUtil.filter(request.getParameter("dsecondFrom" + i), "00");
				
				String discountDayToStr = StringUtil.filter(request.getParameter("ddayTo" + i), now.getDate());
				String discountMonthToStr = StringUtil.filter(request.getParameter("dmonthTo" + i), now.getMonth());
				String discountYearToStr = StringUtil.filter(request.getParameter("dyearTo" + i), now.getYear() + 1900);
				String discountHourToStr = StringUtil.filter(request.getParameter("dhourTo" + i), "00");
				String discountMinuteToStr = StringUtil.filter(request.getParameter("dminuteTo" + i), "00");
				String discountSecondToStr = StringUtil.filter(request.getParameter("dsecondTo" + i), "00");
				
				String discountDateFromStr = discountYearFromStr + "-" + discountMonthFromStr + "-" + discountDayFromStr + " "+ discountHourFromStr+":"+ discountMinuteFromStr+":"+ discountSecondFromStr;
				String discountDateToStr = discountYearToStr + "-" + discountMonthToStr + "-" + discountDayToStr + " "+ discountHourToStr+":"+ discountMinuteToStr+":"+ discountSecondToStr;
				
				variant.setName(variantname);
				variant.setSeq(i);
				variant.setPrice(price);
				variant.setDiscount(discount);
				variant.setQuantity(quantity);
				variant.setDiscountstart(DateUtil.stringToDate(discountDateFromStr));
				variant.setDiscountend(DateUtil.stringToDate(discountDateToStr));
				variant.setStatus(StaticValueUtil.Active);
				variants.add(variant);
				
				log.info(discountDateFromStr);
				log.info(discountDateToStr);
			}
			
			product.setProductVariant(variants);

			try {
				for (int i = 1; i <= 5; i++) {
					Part filePart = request.getPart("image" + i);
					String fileName = StringUtil.filter(Paths.get(filePart.getSubmittedFileName()).getFileName().toString()); // MSIE fix.
					//InputStream fileContent = filePart.getInputStream();
					
					if(!"".equals(fileName) && !(fileName.toLowerCase().endsWith("jpg") || fileName.toLowerCase().endsWith("png"))) {
						errorMsg += "Image format is not correct. (only support jpg and png) ";
						break;
					}
					
					if(filePart.getName().equals("image1")) {
						product.setImage1("y");
					}
					
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 

			errorMsg = this.checkInfo(product, errorMsg);
			
			if ("".equals(errorMsg)){
				try {
					for (int i = 1; i <= 5; i++) {
						Part filePart = request.getPart("image" + i);
						String fileName = StringUtil.filter(Paths.get(filePart.getSubmittedFileName()).getFileName().toString()); // MSIE fix.
						InputStream fileContent = filePart.getInputStream();
						
						if(!"".equals(fileName)) {
							@SuppressWarnings("resource")
							OutputStream outputStream = new FileOutputStream(new File((getServletContext().getRealPath("") + "images" + File.separator + "products" + File.separator).replace('\\', '/') + filePart.getSubmittedFileName()));
							
							int read = 0;
							byte[] bytes = new byte[1024];

							while ((read = fileContent.read(bytes)) != -1) {
								outputStream.write(bytes, 0, read);
							}
							
							if(filePart.getName().equals("image1")) {
								product.setImage1(fileName);
							}else if(filePart.getName().equals("image2")) {
								product.setImage2(fileName);
							}else if(filePart.getName().equals("image3")) {
								product.setImage3(fileName);
							}else if(filePart.getName().equals("image4")) {
								product.setImage4(fileName);
							}else if(filePart.getName().equals("image5")) {
								product.setDescimage(fileName);
							}
							
						}
						
					}
				} catch (IOException e) {
					e.printStackTrace();
				} 
			}
			
			log.info("after image ");
			
			ProductBean resultProd = null;

			if ("".equals(errorMsg)){
				resultProd = ProductService.getInstance().insertProduct(product);
				log.info(resultProd == null ? "resultProd is null" : "resultProdd is not null");
				if (resultProd != null)
				{
					errorMsg = "Add product success.";
					resultUrl = "productView.jsp?pid=" + resultProd.getId();
					// resultUrl =
					// "ProductServlet?actionType=getSearchList?from=menu";
				}
				else{
					errorMsg = "Add product fail.";
				}
				log.info("errorMsg: " + errorMsg);
				log.info("resultUrl: " + resultUrl);
			}

			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			request.setAttribute("productBeanAdd", product);

			request.getRequestDispatcher(resultUrl).forward(request, response);
			// resp.sendRedirect(resultUrl);

		}
		catch (Exception e)
		{
			log.error(e);
			e.printStackTrace();
		}
	}

	private void edit(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "productIdx.jsp";
		Date now = new Date();
		String errorMsg = "";

		if (!request.getSession().getAttribute(SessionName.token).equals(request.getParameter(SessionName.token)))
			return;

		//String maxSizeStr = PropertiesUtil.getProperty("upload.maxSize");
		//Integer maxSize = Integer.parseInt(maxSizeStr);
		//String tempUpload = PropertiesUtil.getProperty("basePath") + PropertiesUtil.getProperty("upload.temp");
		String productUpload = StringUtil.getProductImagePath();//PropertiesUtil.getProperty("basePath") + PropertiesUtil.getProperty("productImagePath");
			

		File upload = new File(productUpload);
		if (!upload.exists()){
			upload.mkdirs();
		}

		try{

			AdminInfoBean loginAdmin = (AdminInfoBean) request.getSession().getAttribute("loginAdmin");

			int id = StringUtil.strToInt(request.getParameter("id"));
			int categoryId = StringUtil.strToInt(request.getParameter("categoryId"));
			int brandId = StringUtil.strToInt(request.getParameter("brandId"));
			String productcode = StringUtil.filter(request.getParameter("productCode"));
			String ename = StringUtil.filter(request.getParameter("eName"));
			int status = StringUtil.strToInt(StringUtil.filter(request.getParameter("status"), (StaticValueUtil.Inactive + "")));
			String descYoutube = StringUtil.filter(request.getParameter("descyoutube"));
			String fullDesc = StringUtil.filter(request.getParameter("fullDesc"));
			String shortDesc = StringUtil.filter(request.getParameter("shortDesc"));
			String additionalDesc = StringUtil.filter(request.getParameter("additionalDesc"));
			int variantcounter = StringUtil.strToInt(request.getParameter("variantcounter")); 
			String test = StringUtil.filter(request.getParameter("test"));
			log.info("test"  + test);

			ProductBean product = new ProductBean();
			List<ProductVariantBean> variants = new ArrayList<ProductVariantBean>();
			List<ProductVariantBean> oldvariants = new ArrayList<ProductVariantBean>();
			
			product = ProductService.getInstance().getProductById(id);
			product.setCategoryid(categoryId);
			product.setBrandid(brandId);
			product.setProductcode(productcode);
			product.setName(ename);
			product.setBrandid(brandId);
			//product.setFulldesc(fullDesc);
			product.setDescyoutube(descYoutube); 
			product.setDetail(fullDesc);
			product.setShortdesc(shortDesc);
			product.setAdditionaldesc(additionalDesc);
			product.setStatus(status);
			product.setModifiedBy(loginAdmin.getName());
			
			log.info("counter " + variantcounter);
			
			//FOR VARIANT UPDATE 
			for(int i = 1; i <= variantcounter; i++) {
				log.info("inside variant");
				int vid = StringUtil.strToInt(StringUtil.filter(request.getParameter("pvid" + i)));
				String variantname = StringUtil.filter(request.getParameter("variant" + i));
				double price = StringUtil.strToDouble(request.getParameter("price" + i));
				double discount = StringUtil.strToDouble(StringUtil.filter(request.getParameter("discount" + i),"0"));
				int quantity = StringUtil.strToInt(request.getParameter("quantity" + i));
				
				String discountDayFromStr = StringUtil.filter(request.getParameter("ddayFrom" + i), now.getDate());
				String discountMonthFromStr = StringUtil.filter(request.getParameter("dmonthFrom" + i), now.getMonth());
				String discountYearFromStr = StringUtil.filter(request.getParameter("dyearFrom" + i), (now.getYear() + 1900));
				String discountHourFromStr = StringUtil.filter(request.getParameter("dhourFrom" + i), "00");
				String discountMinuteFromStr = StringUtil.filter(request.getParameter("dminuteFrom" + i), "00");
				String discountSecondFromStr = StringUtil.filter(request.getParameter("dsecondFrom" + i), "00");
				
				String discountDayToStr = StringUtil.filter(request.getParameter("ddayTo" + i), now.getDate());
				String discountMonthToStr = StringUtil.filter(request.getParameter("dmonthTo" + i), now.getMonth());
				String discountYearToStr = StringUtil.filter(request.getParameter("dyearTo" + i), (now.getYear() + 1900));
				String discountHourToStr = StringUtil.filter(request.getParameter("dhourTo" + i), "00");
				String discountMinuteToStr = StringUtil.filter(request.getParameter("dminuteTo" + i), "00");
				String discountSecondToStr = StringUtil.filter(request.getParameter("dsecondTo" + i), "00");
				
				String discountDateFromStr = discountYearFromStr + "-" + discountMonthFromStr + "-" + discountDayFromStr + " "+ discountHourFromStr+":"+ discountMinuteFromStr+":"+ discountSecondFromStr;
				String discountDateToStr = discountYearToStr + "-" + discountMonthToStr + "-" + discountDayToStr + " "+ discountHourToStr+":"+ discountMinuteToStr+":"+ discountSecondToStr;
				
				ProductVariantBean variant = new ProductVariantBean();
				if(vid > 0 ) variant = ProductService.getInstance().getProductVariantByPvid(vid);
				
				variant.setName(variantname);
				variant.setSeq(i);
				variant.setPrice(price);
				variant.setDiscount(discount);
				variant.setQuantity(quantity);
				variant.setDiscountstart(DateUtil.stringToDate(discountDateFromStr));
				variant.setDiscountend(DateUtil.stringToDate(discountDateToStr));
				variant.setStatus(StaticValueUtil.Active);
				variants.add(variant);
				
				log.info("variant : " + vid + " start : " + discountDateFromStr + " end : " + discountDateToStr);
				log.info(variantname);
			}
			log.info("variant size " + variants.size());
			product.setProductVariant(variants);
			
			try {
				for (int i = 1; i <= 5; i++) {
					Part filePart = request.getPart("image" + i);
					String fileName = StringUtil.filter(Paths.get(filePart.getSubmittedFileName()).getFileName().toString()); // MSIE fix.
					//InputStream fileContent = filePart.getInputStream();
					
					if(!"".equals(fileName) && !(fileName.toLowerCase().endsWith("jpg") || fileName.toLowerCase().endsWith("png"))) {
						errorMsg += "Image format is not correct. (only support jpg and png) ";
						break;
					}
					
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 

			errorMsg = this.checkInfo(product, errorMsg);
			
			if("".equals(errorMsg)){
				String image2_old_flag = StringUtil.filter(request.getParameter("image2_old_flag"));
				if("0".equals(image2_old_flag)){
					product.setImage2("");
				}
				String image3_old_flag = StringUtil.filter(request.getParameter("image3_old_flag"));
				if("0".equals(image3_old_flag)){
					product.setImage3("");
				}
				String image4_old_flag = StringUtil.filter(request.getParameter("image4_old_flag"));
				if("0".equals(image4_old_flag)){
					product.setImage4("");
				}
				String image5_old_flag = StringUtil.filter(request.getParameter("image5_old_flag"));
				if("0".equals(image5_old_flag)){
					product.setImage5("");
				}
				
				
				
				try {
					for (int i = 1; i <= 5; i++) {
						Part filePart = request.getPart("image" + i);
						String fileName = StringUtil.filter(Paths.get(filePart.getSubmittedFileName()).getFileName().toString()); // MSIE fix.
						InputStream fileContent = filePart.getInputStream();
						
						if(!"".equals(fileName)) {
							@SuppressWarnings("resource")
							OutputStream outputStream = new FileOutputStream(new File((getServletContext().getRealPath("") + "images" + File.separator + "products" + File.separator).replace('\\', '/') + filePart.getSubmittedFileName()));
							
							int read = 0;
							byte[] bytes = new byte[1024];

							while ((read = fileContent.read(bytes)) != -1) {
								outputStream.write(bytes, 0, read);
							}
							
							if(filePart.getName().equals("image1")) {
								product.setImage1(fileName);
							}else if(filePart.getName().equals("image2")) {
								product.setImage2(fileName);
							}else if(filePart.getName().equals("image3")) {
								product.setImage3(fileName);
							}else if(filePart.getName().equals("image4")) {
								product.setImage4(fileName);
							}else if(filePart.getName().equals("image5")) {
								product.setDescimage(fileName);
							}
							
						}
						
					}
				} catch (IOException e) {
					e.printStackTrace();
				} 
				
			}
			log.info("errorMsg" + errorMsg);
			if ("".equals(errorMsg)){
				if(ProductService.getInstance().updateProduct(product) != null){
					errorMsg = "Update Product ["+StringUtil.filter(product.getName())+"] success.";
					resultUrl = "productView.jsp?pid="+ product.getId();
				}else{
					errorMsg = "Update Product ["+StringUtil.filter(product.getName())+"] fail.";
					request.setAttribute(SessionName.beanInfo, product);
					resultUrl = "productEdit.jsp?pid="+ product.getId();
						//resultUrl = "categoryView.jsp?id="+category.getId();
				}		
			}else{	
				resultUrl = "productEdit.jsp?pid="+ product.getId();
				//product.setProductVariant(oldvariants);
				request.setAttribute(SessionName.beanInfo, product);
			}
			
			
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			request.getRequestDispatcher(resultUrl).forward(request, response);
			//response.sendRedirect(resultUrl);

		}catch (Exception e){
			log.error(e);
			e.printStackTrace();
		}
		
		return;

	}
	
	private void updateStatus(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "productIdx.jsp";
		String errorMsg = "";

		if (!request.getSession().getAttribute(SessionName.token).equals(request.getParameter(SessionName.token)))
			return;

		try{

			AdminInfoBean loginAdmin = (AdminInfoBean) request.getSession().getAttribute(SessionName.loginAdmin);

			int id = StringUtil.strToInt(request.getParameter("id"));
			int status = StringUtil.strToInt(request.getParameter("status"));
			
			ProductBean product = new ProductBean();

			product = ProductService.getInstance().getProductById(id);
			product.setStatus(status);
			product.setModifiedBy(loginAdmin.getName());

			if(ProductService.getInstance().updateStatus(product) != null){
				errorMsg = "Update Product ["+StringUtil.filter(product.getName())+"] success.";
				//resultUrl = "productView.jsp?id="+ product.getId();
			}else{
				errorMsg = "Update Product ["+StringUtil.filter(product.getName())+"] fail.";
				request.setAttribute(SessionName.beanInfo, product);
				//resultUrl = "productEdit.jsp?id="+ product.getId();		
			}
			
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			request.getRequestDispatcher(resultUrl).forward(request, response);
			//response.sendRedirect(resultUrl);
			search(request,response);

		}catch (Exception e){
			log.error(e);
			e.printStackTrace();
		}
		
		return;

	}
	
	private void search(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "productIdx.jsp";
		try
		{
			String from = StringUtil.filter(request.getParameter("from"));
			int pageIdx = StringUtil.trimToInt(request.getParameter("pageIdx"));


			String productCode = StringUtil.filter(request.getParameter("productCode"));
			String name = new String(StringUtil.filter(request.getParameter("name")).getBytes("ISO8859-1"), "utf-8");
			String status = StringUtil.filter(request.getParameter("status"));
			String category = StringUtil.filter(request.getParameter("category"));
			
			if ("menu".equals(from)){
				request.getSession().removeAttribute("pageIdx");
				request.getSession().removeAttribute("productCode");
				request.getSession().removeAttribute("name");
				request.getSession().removeAttribute("status");
				request.getSession().removeAttribute("category");
				
			}else if ("search".equals(from)){

				if (pageIdx == 0)
					pageIdx = StringUtil.strToInt((String) request.getSession().getAttribute("pageIdx"));

				request.getSession().setAttribute("productCode", productCode);
				request.getSession().setAttribute("name", name);
				request.getSession().setAttribute("status", status);
				request.getSession().setAttribute("category", category);
				request.getSession().setAttribute("pageIdx", "0");
			}else{
				productCode = StringUtil.filter((String)request.getSession().getAttribute("productCode"));
				name = StringUtil.filter((String)request.getSession().getAttribute("name"));
				status = StringUtil.filter((String)request.getSession().getAttribute("status"));
				category = StringUtil.filter((String)request.getSession().getAttribute("category"));
			}

			if (pageIdx == 0)
				pageIdx = 1;

			//AdminInfoBean loginAdmin = (AdminInfoBean) request.getSession().getAttribute(SessionName.loginAdmin);
			
			ProductService productService = ProductService.getInstance();
			String sqlWhere = "";
			// String sqlWhere = " where status in (" +
			// ProductStatus.value[0]+","+ProductStatus.value[1] + ")";
			

			if (!"".equals(status)){
				sqlWhere += " where status = " + status ;
			}else{
				sqlWhere += " where status in (" + ProductStatus.value[0] + "," + ProductStatus.value[1] + ")";
			}

			if (!"".equals(productCode)){
				sqlWhere += " and productcode like '%" + productCode + "%' ";
			}

			if (!"".equals(name)){
				sqlWhere += " and name like '%" + name + "%'";
			}

			if (!"".equals(category)){
				sqlWhere += " and categoryid = " + category + "";
			}

			List<ProductBean> productList = productService.getProductBySqlWhereWithPage(sqlWhere, pageIdx);

			int totalPages = productService.getTotalPages(pageIdx, sqlWhere);

			request.setAttribute("productList", productList);
			request.setAttribute("pageIdx", pageIdx);
			request.setAttribute("totalPages", totalPages);

			request.getRequestDispatcher(resultUrl).forward(request, response);
		}
		catch (Exception e)
		{
			log.error(e);
			e.printStackTrace();

		}
	}

	private String checkInfo(ProductBean bean, String errorMsg){
		//int hotPick = StringUtil.trimToInt(su.getRequest().getParameter("hotPick"));
		//int brandid = StringUtil.trimToInt(su.getRequest().getParameter("brandId"));
		
		//String errorMsg = "";
		if(bean.getCategoryid() <= 0) {
			errorMsg += "Invalid category id. <br>";
		}
		/*if(bean.getBrandid() <= 0) {
			errorMsg += "Invalid brand id. <br>";
		}*/
		if("".equals(StringUtil.filter(bean.getName()))){
			errorMsg += "Please input name. <br>";
		}
		if(bean.getStatus() != StaticValueUtil.Active && bean.getStatus() != StaticValueUtil.Inactive){
			errorMsg += "Invalid status. <br>";
		}
		if("".equals(StringUtil.filter(bean.getShortdesc()))){
			errorMsg += "Please input short description.<br>";
		}
		/*if("".equals(StringUtil.filter(bean.getDetail()))) {//if("".equals(StringUtil.filter(bean.getFulldesc()))) {
			errorMsg += "Please input full description.<br>";
		}
		if("".equals(bean.getProductcode())) {
			errorMsg += "Invalid product code. <br>";
		}else{
			//check product info table
			String sqlWhere = " where code = '"+bean.getProductcode()+"' and status <>'" + StaticValueUtil.Delete + "'";
			
			if (bean.getId() > 0){
				sqlWhere = " where code = '"+bean.getProductcode()+"' and id<>" + bean.getId() + " and status <>'" + StaticValueUtil.Delete + "'";
			}
			
			 List<ProductBean> existBeanList = ProductService.getInstance().getProductBySqlwhere(sqlWhere);
			 if(existBeanList.size()>0) { 
				 errorMsg += "Exist product code." + "<br>";
			 }
		}*/
		
		if("".equals(StringUtil.filter(bean.getImage1()))) {
			errorMsg += "Image 1 is required. <br>";
		}
		
		/*if(bean.getDisplaystart().after(bean.getDisplayend())){
			errorMsg += "Product display period invalid ." + "<br>";
		}*/
		
		if(bean.getProductVariant().size() < 1 ) {
			errorMsg += "At least one variant must be created. <br>";
		}
		/*if(bean.getId() == 0 ) {
			if(bean.getProductVariant().size() < 1 ) {
				errorMsg += "At least one variant must be created. <br>";
			}
			
		}else {
			List<ProductVariantBean> oldvariants = ProductService.getInstance().getProductVariantListById(bean.getId());
			if(bean.getProductVariant().size() < 1 && oldvariants.size() < 1 ) {
				errorMsg += "At least one variant must be created. <br>";
			}
			
		}*/
		
		for(ProductVariantBean variant: bean.getProductVariant()) {
			
			if(bean.getProductVariant().size() > 1 ) {
				if("".equals(StringUtil.filter(variant.getName()))){
					errorMsg += "Variant name cannot be empty. <br>";
				}
			}
			
			if(variant.getPrice() < 0) {
				errorMsg += "Incorrect price format. <br>";
			}
			
			if(variant.getQuantity() < 0) {
				errorMsg += "Incorrect quantity format. <br>";
			}
			
			if(variant.getDiscount() < 0) {
				errorMsg += "Incorrect discount format. <br>";
			}
			
			if(variant.getDiscountstart().after(variant.getDiscountend())) {
				errorMsg += "Incorrect discount period. <br>";
			}
		}
		

		return errorMsg;
	}
}
