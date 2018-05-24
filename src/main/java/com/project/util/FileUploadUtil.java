package com.project.util;

import java.io.File;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;


@SuppressWarnings("deprecation")
public class FileUploadUtil {
	
	public static final String IMAGE = "imageFile" ;
	
	private static Logger log = Logger.getLogger(FileUploadUtil.class);
	
	@SuppressWarnings("unchecked")
	public static File saveUploadedFile(HttpServlet servlet, HttpServletRequest request, HttpServletResponse response, String fileFieldName) 
	throws Exception {
		System.out.println("------------------------------------1111111111");
		File uploadedFile = null;
		String[] uploadType = {"jpg","JPG","Jpg","gif","GIF","Gif", "xls","XLS","Xls"} ;
		System.out.println("------------------------------------2222222222");
		DiskFileUpload fileUpload = new DiskFileUpload() ;
		if(IMAGE.equalsIgnoreCase(fileFieldName)) {
			fileUpload.setSizeMax(1024 * 1024 * 1) ;
		} else {
			fileUpload.setSizeMax(1024 * 1024 * 3) ;
		}
		fileUpload.setSizeThreshold(1024 * 1024) ;
		List<FileItem> uploadList = null ;
		System.out.println("------------------------------------3333333333");
		try {
			uploadList = fileUpload.parseRequest(request) ;
			System.out.println("------------------------------------444444444");
			Iterator<FileItem> it = uploadList.iterator() ;
			System.out.println(it);
			//System.out.println("------------------------------------555555555555"+it.hasNext());
			while(it != null && it.hasNext()) {
				System.out.println("------------------------------------666666666666666");
				FileItem fileItem = it.next() ;
				if(!fileItem.isFormField()) {
					String uploadPath = fileItem.getName() ;
					System.out.println("------------------------------------uploadPath:"+uploadPath);
					int start = uploadPath.lastIndexOf("\\") ;
					int end = uploadPath.length() ;
  					String uplName = uploadPath.substring(start+1) ;
					String uploadExt = uploadPath.substring(end - 3, end) ;
					boolean isUploadType = false ;
					for(String type : uploadType) {
						if(uploadExt.equals(type)) {
							isUploadType = true ;
							break ;
						}
					}
					if(!isUploadType) {
						return null ;
					}
					String tempFolder = PropertiesUtil.getProperty("upload.tempFolder");
					String filename = tempFolder + "/" + request.getSession().getId() + "_" + uplName ;
					uploadedFile = new File(filename) ;
					if(!uploadedFile.exists()) {
						uploadedFile.createNewFile() ;
					}
					fileItem.write(uploadedFile) ;
					log.info("Saved file: " + filename + " for: " + request.getSession().getId());
					String imageType = (String) request.getSession().getAttribute("imageType");
					
					if (imageType!=null){
						if (imageType.equals("idCopy")) {
							request.getSession().setAttribute(SessionName.regIdCopyName, request.getSession().getId() + "_" + uplName);
						} else {
							request.getSession().setAttribute(SessionName.regPhotoName, request.getSession().getId() + "_" + uplName);
						}
					}
				}
			}
		} catch (Exception e) {
			log.error("", e) ;
		}
		return uploadedFile;
	}
}
