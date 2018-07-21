package com.project.servlet.admin;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.AdminInfoBean;
import com.project.pulldown.OrderStatusPulldown;
import com.project.service.AdminService;
import com.project.service.OrderService;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class AdminReportServlet
 */
public class AdminReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(AdminReportServlet.class);
    
	private static final String REPORT_ORDER = "orderReport";
	private static final String REPORT_PAYMENT = "paymentReport";
	
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		AdminService.getInstance().checkLogin(request, response);
		
		//Install Type item not included 
		/*try {
			Calendar toDate = Calendar.getInstance();
			String toYearDefault = String.valueOf(toDate.get(Calendar.YEAR));
			String toMonthDefault = String.valueOf(toDate.get(Calendar.MONTH)+1);
			String toDayDefault = String.valueOf(toDate.get(Calendar.DAY_OF_MONTH));
			Calendar fromDate = Calendar.getInstance();
			fromDate.add(Calendar.DATE,  -2);
			String fromYearDefault = String.valueOf(fromDate.get(Calendar.YEAR));
			String fromMonthDefault = String.valueOf(fromDate.get(Calendar.MONTH)+1);
			String fromDayDefault = String.valueOf(fromDate.get(Calendar.DAY_OF_MONTH));
						
			String dayFromStr = StringUtil.filter(request.getParameter("dayFrom"), fromDayDefault);
			String monthFromStr = StringUtil.filter(request.getParameter("monthFrom"), fromMonthDefault);
			String yearFromStr = StringUtil.filter(request.getParameter("yearFrom"), fromYearDefault);
			String dayToStr = StringUtil.filter(request.getParameter("dayTo"), toDayDefault);
			String monthToStr = StringUtil.filter(request.getParameter("monthTo"), toMonthDefault);
			String yearToStr = StringUtil.filter(request.getParameter("yearTo"), toYearDefault);
						
			String dateFromStr = yearFromStr + "-" + monthFromStr + "-" + dayFromStr + " 00:00:00";
			String dateToStr = yearToStr + "-" + monthToStr + "-" + dayToStr + " 23:59:59";
						
			String orderId = StringUtil.filter(request.getParameter("orderId"));
			String name = new String(StringUtil.filter(request.getParameter("name")).getBytes("ISO8859-1"), "utf-8");
			String phone = StringUtil.filter(request.getParameter("phone"));
			String email = StringUtil.filter(request.getParameter("email"));
			String status = StringUtil.filter(request.getParameter("status"));
			String caNo = StringUtil.filter(request.getParameter("caNo"));
					
			String sqlWhere = "where transactiondate>='" + dateFromStr + "' and transactiondate<='" + dateToStr + "'";;
			if (!"".equals(orderId)){
				sqlWhere += " and orderRef in ( " + orderId + " )";
			}		
			if (!"".equals(status)){
				sqlWhere += " and orderStatus = '" + status + "'";
			}else {
				sqlWhere += " and orderStatus not in ('" + OrderStatusPulldown.DELETED + "')";
			}
				
			//RETRIEVE ONLY ONLIME PAYMENT 
			sqlWhere += " and type = '" + StaticValueUtil.ORDERTYPE_NORMAL + "'";
				
			orderList = OrderService.getInstance().getOrderListBySqlwhere(sqlWhere);
			

			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename=OrderReport.xls");
					
			WritableWorkbook book = Workbook.createWorkbook(response.getOutputStream());
			WritableSheet sheet = book.createSheet("PaymentList", 0);
					
			sheet.setPageSetup(PageOrientation.LANDSCAPE);
			sheet.getSettings().setDefaultColumnWidth(20);
								
			WritableCellFormat formatAlign = new WritableCellFormat();
			formatAlign.setAlignment(jxl.format.Alignment.CENTRE);
			WritableFont fonTitle = new WritableFont(WritableFont.TIMES, 12, WritableFont.BOLD);
			WritableFont fonTitle2 = new WritableFont(WritableFont.TIMES, 12, WritableFont.NO_BOLD);
			WritableFont fonTitle3 = new WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD);
			WritableFont fonTitle4 = new WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE, Colour.GRAY_25);
					
			WritableCellFormat formatTitle = new WritableCellFormat(fonTitle);
			formatTitle.setAlignment(jxl.format.Alignment.CENTRE);
			WritableCellFormat formatTitle2 = new WritableCellFormat(fonTitle2);
			formatTitle2.setAlignment(jxl.format.Alignment.LEFT);
			WritableCellFormat formatTitle3 = new WritableCellFormat(fonTitle3);
			formatTitle3.setAlignment(jxl.format.Alignment.LEFT);
			WritableCellFormat formatTitle4 = new WritableCellFormat(fonTitle4);
			formatTitle4.setAlignment(jxl.format.Alignment.LEFT);
					
			int colNum = 0;
			int rowNum = 0;
			Label label = new Label(colNum, rowNum, "Transaction Date",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "OrderRef (merchant ref)",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Buyer Title",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Buyer Name(en)",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Buyer Name(cn)",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Buyer Email",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Buyer Address",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Customer Phone",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Payment Ref",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Payment Method",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Card/Account",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Holder Name",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Currency",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Amount",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Status",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Src",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "Payer IP",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "IP Country",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			label = new Label(colNum, rowNum, "ECI",formatTitle3);
			sheet.addCell(label);
			colNum ++ ;
			
			// START FOR PRODUCT SECTION 
			for (OrderBean bean : orderList){
				String address = StringUtil.filter(bean.getBuyerAddress1()) + " " + StringUtil.filter(bean.getBuyerAddress2()) + " " + 
								 StringUtil.filter(bean.getBuyerAddress3()) + " " + StringUtil.filter(bean.getBuyerAddress4());
				
				colNum = 0;
				rowNum++;
							
				label = new Label(colNum, rowNum, DateUtil.formatDatetime_mm(bean.getTransactiondate()) );
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getOrderRef()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getBuyerTitle()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getBuyerEname()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getBuyerCname()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getBuyerEmail()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, address);
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getBuyerPhone()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getPaymentRef()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getPayMethod()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getMaskedCardNo()));
				sheet.addCell(label);
				colNum ++ ;
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getHolderName()));
				sheet.addCell(label);
				colNum ++ ;

				Number num = new Number(colNum, rowNum, bean.getTotalAmount());
				sheet.addCell(num);
				colNum ++ ;
				label = new Label(colNum, rowNum, OrderStatusPulldown.getName(bean.getOrderStatus()) );
				sheet.addCell(label);
				colNum ++ ; 
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getSrc()));
				sheet.addCell(label);
				colNum ++; 
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getSourceip()));
				sheet.addCell(label);
				colNum ++; 
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getIpcountry()));
				sheet.addCell(label);
				colNum ++; 
				label = new Label(colNum, rowNum, StringUtil.filter(bean.getEci()));
				sheet.addCell(label);
				colNum ++; 
			}
			book.write();
			book.close();
					
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e);
			e.printStackTrace();
					
		}*/
	}
	
}