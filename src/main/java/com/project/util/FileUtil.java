package com.project.util;

import java.io.*;

public class FileUtil {

	public FileUtil() {

	}

	static public String readFile(String filePath) throws Exception {
		File f = new File(filePath);
		//FileReader fr = new FileReader(f);
		//BufferedReader br = new BufferedReader(fr);
		StringBuffer sb = new StringBuffer();
		
		  BufferedReader br = new BufferedReader(
			        new InputStreamReader(new FileInputStream(f), "UTF8"));

		  
		  
		String eachLine = br.readLine();

		while (eachLine != null) {
			sb.append(eachLine);

			eachLine = br.readLine();
		}

		return sb.toString();
	}

	static public void copyFile(String srFile, String dtFile) {
		try {
			File f1 = new File(srFile);
			File f2 = new File(dtFile);
			InputStream in = new FileInputStream(f1);

			// For Append the file.
			// OutputStream out = new FileOutputStream(f2,true);

			// For Overwrite the file.
			OutputStream out = new FileOutputStream(f2);

			byte[] buf = new byte[1024];
			int len;
			while ((len = in.read(buf)) > 0) {
				out.write(buf, 0, len);
			}
			in.close();
			out.close();
			System.out.println("File copied.");
		} catch (FileNotFoundException ex) {
			System.out.println(ex.getMessage() + " in the specified directory.");
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}
}
