package com.project.util;

import java.io.File;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

public class ZipUtil
{	

	
	public static Logger log = Logger.getLogger(ZipUtil.class);
	//pack excel into a zip with password
	public static String dozip(String filepath, String filename, String zipPassword) throws ZipException {
		try {
			
			log.info("start dozip");
			log.info("filepath: "+ filepath);
			log.info("filename: "+ filename);
			
			PropertiesUtil propUtil = new PropertiesUtil();
			File zipfile = null;
			
		    String prefix=filename.substring(filename.length()-4, filename.length());
		    log.info("prefix: " + prefix);
		    String targetfile = filename.substring(0,filename.lastIndexOf("."))+prefix.replace(prefix, ".zip");

		    log.info("targetfile: " + targetfile);


			ZipFile zipFile = new ZipFile(targetfile);

			ArrayList filesToAdd = new ArrayList();
			filesToAdd.add(new File(filename));

			ZipParameters parameters = new ZipParameters();
			parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);
			parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL); 

			parameters.setEncryptFiles(true);
			parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_AES);
			parameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);
			parameters.setPassword(zipPassword);

			zipFile.addFiles(filesToAdd, parameters);
			System.out.println("***********************zip success***********************"+targetfile);
			
			zipfile = new File(targetfile);
			//send email  this call must put here or cant find the xls
			
			System.out.println("***********************zip success***********************zipfile:"+zipfile);
			
			log.info("end dozip");
			return targetfile;
			
		} catch (ZipException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		
	}
}
