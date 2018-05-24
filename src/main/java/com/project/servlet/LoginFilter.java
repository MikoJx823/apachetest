package com.project.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.project.bean.AdminInfoBean;
import com.project.util.PropertiesUtil;


public class LoginFilter implements javax.servlet.Filter
{
	private static Logger log = Logger.getLogger(LoginFilter.class);

	public void init(FilterConfig filterConfig) throws ServletException
	{
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException
	{

		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		HttpSession session = request.getSession();
		String url = request.getRequestURL().toString();

		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		 if (ipAddress == null || "".equals(ipAddress)) {
		  ipAddress = request.getRemoteAddr();
		}
		
		boolean passIpCheck = true;
		
		/*PropertiesUtil propertiesUtil = new PropertiesUtil();
		String ips = propertiesUtil.getProperty("backlist.ip");
		String[] eachIPs = null;
		eachIPs=ips.split("\\|");
			for(int i=0;i<eachIPs.length;i++){
				String ip = eachIPs[i];
				if(ip.equals(ipAddress)){
					Calendar now = Calendar.getInstance();
					Calendar startDate = Calendar.getInstance();
					Calendar endDate = Calendar.getInstance();
					startDate.set(Calendar.YEAR, 2017);
					startDate.set(Calendar.MONTH, 8-1);
					startDate.set(Calendar.DAY_OF_MONTH, 25);
					startDate.set(Calendar.HOUR_OF_DAY, 15);
					startDate.set(Calendar.MINUTE, 59);
					startDate.set(Calendar.SECOND, 59);
					startDate.set(Calendar.MILLISECOND, 000);
					
					endDate.set(Calendar.YEAR, 2017);
					endDate.set(Calendar.MONTH, 8-1);
					endDate.set(Calendar.DAY_OF_MONTH, 25);
					endDate.set(Calendar.HOUR_OF_DAY, 17);
					endDate.set(Calendar.MINUTE, 00);
					endDate.set(Calendar.SECOND, 00);
					endDate.set(Calendar.MILLISECOND, 000);
					
					if(now.after(startDate)&&now.before(endDate)){
						passIpCheck = false;
					}
				}
			}
			
		if("138.19.57.41".equals(ipAddress)){

					Calendar now = Calendar.getInstance();
					Calendar startDate = Calendar.getInstance();
					Calendar endDate = Calendar.getInstance();
					startDate.set(Calendar.YEAR, 2017);
					startDate.set(Calendar.MONTH, 7-1);
					startDate.set(Calendar.DAY_OF_MONTH, 25);
					startDate.set(Calendar.HOUR_OF_DAY, 15);
					startDate.set(Calendar.MINUTE, 59);
					startDate.set(Calendar.SECOND, 59);
					startDate.set(Calendar.MILLISECOND, 000);
					
					endDate.set(Calendar.YEAR, 2017);
					endDate.set(Calendar.MONTH, 8-1);
					endDate.set(Calendar.DAY_OF_MONTH, 25);
					endDate.set(Calendar.HOUR_OF_DAY, 17);
					endDate.set(Calendar.MINUTE, 00);
					endDate.set(Calendar.SECOND, 00);
					endDate.set(Calendar.MILLISECOND, 000);
					
					if(now.after(startDate)&&now.before(endDate)){
						passIpCheck = false;
					}
				} */
		if(passIpCheck){
			if(url.contains("/admin/")) {
			
				AdminInfoBean loginUser = (AdminInfoBean) session.getAttribute("loginUser");
			
				if (loginUser == null&& !url.contains("/LoginServlet") && !url.contains("login.jsp")&& !url.contains("/css/") && !url.contains("/images/") && !url.contains("/layer/")
						&& !url.contains("/js/") && !url.endsWith("/admin/"))
				{
					
						PrintWriter out = response.getWriter();
						out.println("<script type='text/javascript'>alert('Your session has been timed out.')</script> <script type='text/javascript'>window.top.location='" + request.getContextPath()
								+ "/admin/'</script> ");
						out.flush();
		
						return;
				}
			}
			chain.doFilter(servletRequest, servletResponse);
		}

	}

	public void destroy()
	{
		// TODO Auto-generated method stub

	}
}
