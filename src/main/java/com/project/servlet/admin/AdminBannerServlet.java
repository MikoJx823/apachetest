package com.project.servlet.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
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
import com.project.bean.BannerInfoBean;
import com.project.bean.MsgAlertBean;
import com.project.service.AdminService;
import com.project.service.BannerService;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class AdminBannerServlet
 */
@MultipartConfig
public class AdminBannerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(AdminBannerServlet.class);
	  
	private static final String ADD = "add";
	private static final String UPDATE = "update";
	private static final String SEARCH = "search";
	private static final String DELETE = "delete";
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		response.setHeader("Cache-Control", "no-cache");
		String actionType = request.getParameter("actionType");
		
		AdminService.getInstance().checkLogin(request, response);
		
		log.info("actionType:" + actionType);
		
		if(actionType.equals(ADD)){
			add(request, response);
		}else if(actionType.equals(UPDATE)){
			update(request, response);
		}else if(actionType.equals(SEARCH)){
			search(request, response);
		}/*else if(actionType.equals(DELETE)){
			delete(request, response);
		}*/
		return; 
	}

	/*private void delete(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "bannerIdx.jsp";
		String errorMsg = "";
		try{
			String itemName = "";
			AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
			String id = StringUtil.filter(request.getParameter("id"), StaticValueUtil.DEFAULT_VALUE);

			BannerInfoBean bean = BannerService.getInstance().getBeanById(StringUtil.strToInt(id));
			
			if(bean != null) {
				bean.setModifiedBy(loginUser.getLoginId());
				if(BannerService.getInstance().delete(bean)){
					//DELETE FILE HERE;
					errorMsg = "Delete Banner Item ["+StringUtil.delHTMLTag(itemName)+"] success.";
				}
				else{
					errorMsg = "Delete Banner Item ["+StringUtil.delHTMLTag(itemName)+"] fail.";
				}
			}else {
				errorMsg = "Delete Banner Item ["+StringUtil.delHTMLTag(itemName)+"] fail.";
			}

			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			
			search(request, response);
			
		}
		catch (Exception e)
		{
			log.error(e);
		}
	}*/
	
	private void add(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "bannerAdd.jsp";
		String errorMsg = "";
		
		try{
			
			AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
			
			String name = StringUtil.filter(request.getParameter("name"));
			String link = StringUtil.filter(request.getParameter("link"));
			int position = StringUtil.strToInt(request.getParameter("position"));
			int seq = StringUtil.strToInt(request.getParameter("seq"));
			int status = StringUtil.strToInt(StringUtil.filter(request.getParameter("status"),StaticValueUtil.Inactive));
			
			BannerInfoBean bean = new BannerInfoBean();
			bean.setName(name);
			bean.setLink(link);
			bean.setSeq(seq);
			bean.setPosition(position);
			bean.setStatus(status);
			bean.setCreatedBy(loginUser.getLoginId());
			
			//IMAGE RECORD CHECK 
			try {
				for (int i = 1; i <= 4; i++) {
					Part filePart = request.getPart("image" + i);
					String fileName = StringUtil.filter(Paths.get(filePart.getSubmittedFileName()).getFileName().toString()); // MSIE fix.
					//InputStream fileContent = filePart.getInputStream();
					
					if(!"".equals(fileName) && !(fileName.toLowerCase().endsWith("jpg") || fileName.toLowerCase().endsWith("png"))) {
						errorMsg += "Image format is not correct. (only support jpg and png) ";
						break;
					}
					
					if(filePart.getName().equals("image1")) {
						bean.setImage("y");
					}else if(filePart.getName().equals("image2")) {
						bean.setAppimage("y");
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 

			errorMsg += this.checkInfo(bean);
			
			if ("".equals(errorMsg)){
				try {
					for (int i = 1; i <= 4; i++) {
						Part filePart = request.getPart("image" + i);
						String fileName = StringUtil.filter(Paths.get(filePart.getSubmittedFileName()).getFileName().toString()); // MSIE fix.
						InputStream fileContent = filePart.getInputStream();
						
						if(!"".equals(fileName)) {
							@SuppressWarnings("resource")
							OutputStream outputStream = new FileOutputStream(new File((getServletContext().getRealPath("") + "images" + File.separator + "banner" + File.separator).replace('\\', '/') + filePart.getSubmittedFileName()));
							
							int read = 0;
							byte[] bytes = new byte[1024];

							while ((read = fileContent.read(bytes)) != -1) {
								outputStream.write(bytes, 0, read);
							}
							
							if(filePart.getName().equals("image1")) {
								bean.setImage(fileName);
							}else if(filePart.getName().equals("image2")) {
								bean.setAppimage(fileName);
							}
						}
						
					}
				} catch (IOException e) {
					e.printStackTrace();
				} 
				
				//STORE BEAN 
				BannerInfoBean result = BannerService.getInstance().insert(bean);
				if(result != null){
					errorMsg = "Add Banner success.";
					resultUrl = "bannerView.jsp?id=" + result.getId();							
				}else{
					errorMsg = "Add Banner fail.";
				}
				log.info("errorMsg: " +errorMsg);
				log.info("resultUrl: " +resultUrl);
			}

			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			request.setAttribute(SessionName.beanInfo, bean);
			request.getRequestDispatcher(resultUrl).forward(request, response);
			//response.sendRedirect(resultUrl);

		}
		catch (Exception e)
		{
			log.error(e);
			e.printStackTrace();
		}
		
	}
	
	private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String resultUrl = "bannerEdit.jsp";
		String errorMsg = "";
		
		try{
			
			AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
			
			int id = StringUtil.strToInt(request.getParameter("id"));
			String name = StringUtil.filter(request.getParameter("name"));
			String link = StringUtil.filter(request.getParameter("link"));
			int position = StringUtil.strToInt(request.getParameter("position"));
			int seq = StringUtil.strToInt(request.getParameter("seq"));
			int status = StringUtil.strToInt(StringUtil.filter(request.getParameter("status"),StaticValueUtil.Inactive));
			
			BannerInfoBean bean = BannerService.getInstance().getBeanById(id);

			if(bean == null) {
				errorMsg = "Update banner [" + name + "] fail.";
				//request.getSession().setAttribute("category", category);

				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				request.getSession().setAttribute("msgAlertBean", msgAlertBean);
				search(request, response);
				//resp.sendRedirect(resultUrl);
				return;
			}

			bean.setName(name);
			bean.setLink(link);
			bean.setSeq(seq);
			bean.setPosition(position);
			bean.setStatus(status);
			bean.setModifiedBy(loginUser.getLoginId());

			//IMAGE RECORD CHECK 
			try {
				for (int i = 1; i <= 4; i++) {
					Part filePart = request.getPart("image" + i);
					String fileName = StringUtil.filter(Paths.get(filePart.getSubmittedFileName()).getFileName().toString()); // MSIE fix.
					//InputStream fileContent = filePart.getInputStream();
					
					if(!"".equals(fileName) && !(fileName.toLowerCase().endsWith("jpg") || fileName.toLowerCase().endsWith("png"))) {
						errorMsg += "Image format is not correct. (only support jpg and png) ";
						break;
					}
					
					if(filePart.getName().equals("image1")) {
						bean.setImage("y");
					}else if(filePart.getName().equals("image2")) {
						bean.setAppimage("y");
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 

			errorMsg = this.checkInfo(bean);

			if("".equals(errorMsg)){
				//STORE IMAGE 
				try {
					for (int i = 1; i <= 4; i++) {
						Part filePart = request.getPart("image" + i);
						String fileName = StringUtil.filter(Paths.get(filePart.getSubmittedFileName()).getFileName().toString()); // MSIE fix.
						InputStream fileContent = filePart.getInputStream();
						
						if(!"".equals(fileName)) {
							@SuppressWarnings("resource")
							OutputStream outputStream = new FileOutputStream(new File((getServletContext().getRealPath("") + "images" + File.separator + "banner" + File.separator).replace('\\', '/') + filePart.getSubmittedFileName()));
							
							int read = 0;
							byte[] bytes = new byte[1024];

							while ((read = fileContent.read(bytes)) != -1) {
								outputStream.write(bytes, 0, read);
							}
							
							if(filePart.getName().equals("image1")) {
								bean.setImage(fileName);
							}else if(filePart.getName().equals("image2")) {
								bean.setAppimage(fileName);
							}
						}
						
					}
				} catch (IOException e) {
					e.printStackTrace();
				} 
				
				if(BannerService.getInstance().update(bean) !=null){
					errorMsg = "Update Banner success.";
					resultUrl = "bannerView.jsp?id=" + bean.getId();							
				}else{
					errorMsg = "Update Banner fail.";
					resultUrl = "bannerEdit.jsp?id=" + id;
					
				}
			}else {
				resultUrl = "bannerEdit.jsp?id=" + id;
			}
	
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			request.getSession().setAttribute("msgAlertBean", msgAlertBean);
			request.setAttribute(SessionName.beanInfo, bean);
			request.getRequestDispatcher(resultUrl).forward(request, response);
			
		}catch (Exception e){
			log.error(e);
			e.printStackTrace();
		}
		
		return;
	}

	private String checkInfo(BannerInfoBean bean){
		String errorMsg = "";
		
		if("".equals(StringUtil.filter(bean.getName()))){
			errorMsg += "Name is required. <br>";
		}
		
		if(bean.getSeq() < 0){
			errorMsg += "Sequence incorrect. <br>";
		}
		
		if(bean.getPosition() != StaticValueUtil.BANNER_INDEX_MAIN && bean.getPosition() != StaticValueUtil.BANNER_INDEX_SUB_L && 
		   bean.getPosition() != StaticValueUtil.BANNER_INDEX_SUB_R_1 && bean.getPosition() != StaticValueUtil.BANNER_INDEX_SUB_R_2 && 
		   bean.getPosition() != StaticValueUtil.BANNER_INDEX_SUB_R_B){
			errorMsg += "Incorrect banner position <br>";
		}
		
		if(bean.getPosition() == StaticValueUtil.BANNER_INDEX_MAIN) {
			if("".equals(bean.getAppimage())) {
				errorMsg += "Mobile image is required for main banner. <br>";
			}
		}
		
		if(!(bean.getStatus() == StaticValueUtil.Active || bean.getStatus() == StaticValueUtil.Inactive || 
			bean.getStatus() == StaticValueUtil.Delete)){
			errorMsg += "Status is incorrect. <br>";
		}
		
		return errorMsg;
	}

	private void search(HttpServletRequest request, HttpServletResponse response){
		String resultUrl = "bannerIdx.jsp";
		
		try
		{	
			AdminInfoBean loginUser = (AdminInfoBean)request.getSession().getAttribute(SessionName.loginAdmin);
			
			String from = StringUtil.filter(request.getParameter("from"));
			int pageIdx = StringUtil.trimToInt(request.getParameter("pageIdx"));
			
			String name = new String(StringUtil.filter(request.getParameter("name")).getBytes("ISO8859-1"), "utf-8");
			String status = StringUtil.filter(request.getParameter("status"));
			
			if ("menu".equals(from)){
				request.getSession().removeAttribute("pageIdx");
				request.getSession().removeAttribute("name");
				request.getSession().removeAttribute("status");

			}else if ("search".equals(from)){
				//FROM SEARCH 
				request.getSession().setAttribute("name", name);
				request.getSession().setAttribute("status", status);
				request.getSession().setAttribute("pageIdx", 0);
			}else{
				//FROM PAGINATION 
				name = StringUtil.filter((String)request.getSession().getAttribute("name"));
				status = StringUtil.filter((String)request.getSession().getAttribute("status"));
				
			}
			
			if (pageIdx == 0)
				pageIdx = 1;
			
			BannerService service = BannerService.getInstance();
			
			String sqlWhere = "";
			
			if (!"".equals(status)){
				sqlWhere += " where status ='" + status + "'";
			}else {
				sqlWhere += " where status != " + StaticValueUtil.Delete ;
			}
			
			if (!"".equals(name)){
				name = name.toLowerCase();
				sqlWhere += " and ename like '%" + name + "%'";
			}
			
			sqlWhere += " order by id desc";
			
			List<BannerInfoBean> bean = service.getListBySqlwhereWithPage(sqlWhere, pageIdx);
			
			int totalPages = service.getTotalPages(pageIdx, sqlWhere);
			
			request.setAttribute("bannerList", bean);
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
}