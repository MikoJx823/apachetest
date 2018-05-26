package com.project.util.barcode;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.zxing.BarcodeFormat;



public class QRCodeServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			String text = request.getParameter("text");
			String mode = request.getParameter("m");

			

			// for example application/pdf, text/plain, text/html, image/jpg
			if (mode.equals("v")) {
				response.setContentType("image/png");
			} else {
				String headerKey = "Content-Disposition";
				String headerValue = String.format(
						"attachment; filename=\"%s\"", "qrcode.png");
				response.setHeader(headerKey, headerValue);
			}

			B2cQRCode qrCode = new B2cQRCode();

			OutputStream out = response.getOutputStream();
			qrCode.encode(text, out, BarcodeFormat.QR_CODE, 150, 150, null);

			out.flush();
		} catch (Exception e) {
			try {
				System.out.println(e.toString());
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				System.out.println(e1.toString());
			}
		}
	}

	protected void authErrorResponse(HttpServletRequest request,
			HttpServletResponse response, String msg) throws ServletException,
			IOException {

		PrintWriter out = response.getWriter();
		try {
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");

			out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			out.println("<paydollar>");
			out.println("<auth>");
			out.println("<status>");
			out.println("</status>");
			out.println("<message>");
			out.println(msg);
			out.println("</message>");
			out.println("</auth>");
			out.println("</paydollar>");
			out.flush();
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}