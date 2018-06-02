package com.project.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.project.bean.AdminInfoBean;
import com.project.bean.OrderBean;
import com.project.bean.OrderItemBean;
import com.project.bean.ReceiptBean;

/*import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRProperties;*/

public class MailUtil
{
	public static final Logger logger = Logger.getLogger(MailUtil.class);

	private static MailUtil instance = null;

	public static synchronized MailUtil getInstance()
	{
		if (instance == null)
			instance = new MailUtil();
		return instance;
	}
	
	public boolean sendOrderEmail(OrderBean order ){
		PropertiesUtil propUtil = new PropertiesUtil();
		Map<String, String> imagesMap = new HashMap<String, String>();
		boolean result = false;
		boolean isEng = true;
		
		try {
			// send out confirmation email
			String recipient = order.getBuyeremail();
			String subject = propUtil.getProperty("mailSubject.orderConfirmation");
			
			String templateFile = "normalOrderEmailEN.html";
			
			//String filePath = propUtil.getProperty("system.basepath") + "emailTemplate/";
			
			String logo2 = propUtil.getProperty("basePath")+ "images/CLP_efl_en.png";
			imagesMap.put("logo", propUtil.getProperty("basePath")+ "images/clp_logo_1x.png" );
			imagesMap.put("logo2", logo2 );
			
			String buyerName = "";
			String promotionStr = "";
			String discountStr = "";
			String deliveryStr = "";
			String installStr = "";
			String ecoPointStr = "";
			String ecoPointDiscountStr = "";
			String orderItemsStr = "";
			String addressStr = "";
			String subtotalStr = "";
			String totalStr = "";
			double subTotal = 0;
			double ecoPoint = 0;
			
			buyerName =  StringUtil.filter(order.getBuyerfirstname());
 			
 			String ecopoint = I18nUtil.getString("email.ecopoint", I18nUtil.Lang_EN);
			if(!isEng) ecopoint = I18nUtil.getString("email.ecopoint", I18nUtil.Lang_TC);
			
			for(OrderItemBean orderItem: order.getOrderItems()){
				
				String productName = orderItem.getProductname();
				String productPrice = "";
				String subTotalStr = "";
				
				
				//if(orderItem.getType() == StaticValueUtil.ITEM_PRODUCT) {
				// Skip Eco Reward 
			
				//if(orderItem.getPid() != 0 ){ // Skip Eco Reward 
					

					
					productPrice = "<strong>" + StringUtil.formatCurrencyPrice(orderItem.getPrice()) + "</strong>";
					subTotalStr = "<strong>" + StringUtil.formatCurrencyPrice(orderItem.getPrice() * orderItem.getQuantity()) + "</strong>";
					
					orderItemsStr += "<tr>" + 
							"<td align=\"left\" valign=\"top\" style=\"padding:5px; color:#2F2F2F; border-bottom:1px solid #2485c6;\"><strong>" + productName + "</strong></td>" + 
							"<td align=\"center\" valign=\"top\" style=\"padding:5px; color:#2F2F2F; border-bottom:1px solid #2485c6;\">" + productPrice + "</td>" +
							"<td align=\"center\" valign=\"top\" style=\"padding:5px; color:#2F2F2F; border-bottom:1px solid #2485c6;\"><strong>" + orderItem.getQuantity() + "</strong></td>" +
							"<td align=\"right\" valign=\"top\" style=\"padding:5px; color:#2F2F2F; border-bottom:1px solid #2485c6;\">" + subTotalStr + "</td>" +
							"</tr>";
					
				
				
			}
			
			subTotal = order.getOrderAmount();
			
			if(subTotal > 0){
				String text = I18nUtil.getString("email.subtotal.title", I18nUtil.Lang_EN);
				if(!isEng) text = I18nUtil.getString("email.subtotal.title", I18nUtil.Lang_TC);
				
				subtotalStr = "<tr>" + 
						  "<td colspan=\"3\" align=\"center\" valign=\"top\" style=\" color:#2F2F2F;  padding:3px; \"> </td>" +
            			  "<td align=\"right\" valign=\"top\" style=\" color:#2F2F2F;  padding:5px;\">" +
            			  "<strong>" + text +"</strong></td>" +
            			  "<td align=\"right\" valign=\"top\" style=\" color:#2F2F2F;  padding:5px;\"><strong>" + StringUtil.formatCurrencyPrice(subTotal) + "</strong></td>"+
						  "</tr>";
			}
			
			if(!"".equals(StringUtil.filter(order.getBuyeraddress1())) || !"".equals(StringUtil.filter(order.getBuyeraddress2())) 
			  ){
				
				String address = "";
				
				String text = I18nUtil.getString("email.address", I18nUtil.Lang_EN);
				if(!isEng) text = I18nUtil.getString("email.address", I18nUtil.Lang_TC);
				
				addressStr = "<tr>" +
								"<td width=\"25%\" valign=\"top\" >" + text  + ": </td>" +
								"<td width=\"26%\" valign=\"top\" colspan=\"3\">" + address + "</td>" +
            				 "</tr>";
			}
			
			if(order.getDiscountAmount() > 0){
				String text = I18nUtil.getString("email.discount.title", I18nUtil.Lang_EN);
				
				if(!isEng) text = I18nUtil.getString("email.discount.title", I18nUtil.Lang_TC);
				
				discountStr = "<tr>" + 
							  "<td colspan=\"3\" align=\"center\" valign=\"top\" style=\" color:#2F2F2F;  padding:3px; \"> </td>" +
                			  "<td align=\"right\" valign=\"top\" style=\" color:#2F2F2F;  padding:5px;\">" +
                			  "<strong>" + text +"</strong></td>" +
                			  "<td align=\"right\" valign=\"top\" style=\" color:#2F2F2F;  padding:5px;\"><strong>" + StringUtil.formatCurrencyPrice(order.getDiscountAmount()) + "</strong></td>"+
							  "</tr>";
			}
			
			if(order.getDeliveryAmount() > 0 ){
				
				String text = I18nUtil.getString("email.delivery.title", I18nUtil.Lang_EN);
				
				if(!isEng) text = I18nUtil.getString("email.delivery.title", I18nUtil.Lang_TC);
				
				deliveryStr = "<tr>" +
						   "<td colspan=\"3\" align=\"center\" valign=\"top\" style=\" color:#2F2F2F;  padding:3px; \">&nbsp;</td>" + 
                		   "<td align=\"right\" valign=\"top\" style=\" color:#2F2F2F;  padding:5px;\">" +
                		   "<strong>" + text + "</strong></td>" +
                		   "<td align=\"right\" valign=\"top\" style=\" color:#2F2F2F;  padding:5px;\"><strong>" + StringUtil.formatCurrencyPrice(order.getDeliveryAmount()) + "</strong></td>" +
                		   "</tr>";
			}
			
			if(order.getTotalAmount() > 0 ){
				String text = I18nUtil.getString("email.total.title", I18nUtil.Lang_EN);
				
				if(!isEng) text = I18nUtil.getString("email.total.title", I18nUtil.Lang_TC);
				
				totalStr = "<tr>" +
						   "<td colspan=\"3\" align=\"center\" valign=\"top\" style=\" color:#2F2F2F;  padding:3px; \">&nbsp;</td>" + 
                		   "<td align=\"right\" valign=\"top\" style=\" color:#2F2F2F;  padding:5px;\">" +
                		   "<strong>" + text + "</strong></td>" +
                		   "<td align=\"right\" valign=\"top\" style=\" color:#2F2F2F;  padding:5px;\"><strong>" + StringUtil.formatCurrencyPrice(order.getTotalAmount()) + "</strong></td>" +
                		   "</tr>";
				
			}

			HashMap<String, String> values = new HashMap<String, String>();
			
			String payMethod = StringUtil.filter(order.getPayMethod());
			
			values.put("orderRef", StringUtil.filter(order.getOrderRef()));
			values.put("orderDate", DateUtil.formatDatetime_mm(order.getTransactiondate()));
			values.put("payMethod", payMethod);
			
			//values.put("totalAmount", StringUtil.formatCurrencyPrice(order.getTotalAmount()));
			//values.put("buyerTitle", order.getBuyerTitle());
			values.put("deliveryAddress", addressStr);
			values.put("name", buyerName);
			values.put("contact", StringUtil.filter(order.getBuyerphone()));
			
			values.put("orderItems", orderItemsStr);
			//values.put("subTotal", StringUtil.formatCurrencyPrice(subTotal));
			values.put("promotion", promotionStr);
			values.put("discount", discountStr);
			values.put("delivery", deliveryStr);
			values.put("install", installStr);
			values.put("discounteco", ecoPointDiscountStr);
			values.put("ecoPoint", ecoPointStr);
			
			values.put("subTotal", subtotalStr);
			values.put("totalAmount", totalStr);
			
			result = Mail.SendWithCC(subject,order.getBuyeremail(), templateFile, values, imagesMap, new ArrayList<String>());
			
		} catch (Exception e) {
			// TODO: handle exception
			logger.info("\n***** SEND EMAIL FAIL ***** PayRef ["+StringUtil.filter(order.getPaymentRef())+"] OrderRef ["+ StringUtil.filter(order.getOrderRef())+"]");
			e.printStackTrace();
			result = false;
		}
		
		return result;
	}
	
	
	
	public Boolean sendUserResetPwd(AdminInfoBean admin)
	{
		Boolean result = false;
		try
		{
		
			String subject = PropertiesUtil.getProperty("mailSubject.resetPassword");
			
			String templateFile = "userNewPassword.html";
			
				
			HashMap<String, String> values = new HashMap<String, String>();
			values.put("loginId", admin.getLoginId());
			values.put("newPassword", admin.getPassword());
			values.put("imageUrl",PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost"));
			
			//result = Mail.SendWithCC(subject,admin.getEmail(), templateFile, values, "","");
			result = Mail.SendWithCC(subject,admin.getEmail(), templateFile, values, new HashMap<String, String>() , new ArrayList<String>());
			
			logger.info("result: "+result);
		}
		catch (Exception e)
		{
			logger.info("\n***** SEND EMAIL FAIL ***** Reset User Password (fail)");
			logger.info(e);
		}
		return result;
	}
	
	/*public String genReceipt(ReceiptBean receipt, String type) {
		
		String  result = "";
		
		try 
		{ 
		
			ArrayList<ReceiptBean> receiptList = new ArrayList<ReceiptBean>();
			
			String destFileName = "OrderReceipt_"+receipt.getOrderRef()+".pdf";
			
			if(type.equals("D")) destFileName = "DonationReceipt_" + receipt.getOrderRef()+ ".pdf"; //Donation
			else if(type.contains("O") && (type.length() > 1)) {
				String receiptNo = type.substring(1,type.length());
				logger.info(" type " + type);
				logger.info(" receipt No " + receiptNo);
				destFileName = "OrderReceipt_"+receipt.getOrderRef()+ "_" + receiptNo + ".pdf";
				
			}
			
			//else if(type.equals("M")) destFileName = "merchantDonation_" + receipt.getOrderRef() + ".pdf"; //Merchant 
		
			String mailpath = PropertiesUtil.MAILPATH;
			
			//String template = mailpath+"receiptWithoutDonation.jasper";
			String template = mailpath+"receiptWithDonation.jasper"; // receipt with donation
			if(type.equals("D")) template = mailpath + "receiptDonation.jasper"; //Donation
			//else if(type.equals("M")) template = mailpath + "merchantDonation.jasper"; //Merchant 
			
			File sampleFile = new File(template);   
			
			String newPath = PropertiesUtil.getProperty("receiptPath");
			
		//	String temp = mailpath + destFileName;
			String temp = newPath + destFileName;
			
			File tempFile = new File(temp) ;
			
			Map<String, Object> params = new HashMap<String, Object>();
			
			params.put("imageSignature", mailpath + "Signature.png");
			params.put("imageHeader",  mailpath + "header_order.jpg");
			//params.put("imageHeader",  mailpath + "header.png");
			params.put("imageFooter",  mailpath + "footer_order.jpg");
			
	
			
			receiptList.add(receipt);
			
			InputStream reportStream = new FileInputStream(sampleFile.getPath()) ;
			OutputStream outputStream = new FileOutputStream(tempFile);
		
			JasperPrint jasperPrint = null;

			jasperPrint = JasperFillManager.fillReport(reportStream, params, new JRBeanCollectionDataSource(receiptList));

			//JRProperties.setProperty("net.sf.jasperreports.default.pdf.font.name", "Arial Unicode MS");
			//JRProperties.setProperty("net.sf.jasperreports.default.pdf.encoding", "Identify-H");
			//JRProperties.setProperty("net.sf.jasperreports.default.pdf.embedded", "false");

			JRProperties.setProperty("net.sf.jasperreports.default.pdf.font.name", "Helvetica");
			JRProperties.setProperty("net.sf.jasperreports.default.pdf.encoding", "UTF-8");
			JRProperties.setProperty("net.sf.jasperreports.default.pdf.embedded", "false");
			
			JRPdfExporter pdfExporter = new JRPdfExporter();
			pdfExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);

			pdfExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
			//export pdf
			pdfExporter.exportReport();
			
			outputStream.flush();
			outputStream.close();
			
			
			result = destFileName ;
			logger.info("genReceipt result: "+result);

		} catch (Exception e) {
			logger.info("Error in genReceipt:" + e.toString() );
			e.printStackTrace();
		}
		return result;
	}*/
	
}
