package com.project.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;

public class Mail
{
	public static final Logger logger = Logger.getLogger(Mail.class);

	private static String hostName = "mail.smtp.host";

	private static String mailFrom = "mail.from";

	public String consturctMail(String templateFile, HashMap<String, String> map)
	{
		String mailpath = PropertiesUtil.MAILPATH;
		return this.getEmailContent(templateFile, map, mailpath);
	}

	@SuppressWarnings("unchecked")
	private String getEmailContent(String templateFile, HashMap<String, String> map, String mailpath)
	{
		logger.debug("Start consturct mail content........");
		String htmlText = "";
		try
		{
			String mailfile = mailpath + templateFile;
			System.err.println(mailfile);
			FileInputStream fis = new FileInputStream(mailfile);
			InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
			BufferedReader br = new BufferedReader(isr);

			StringBuffer tmpHtmlText = new StringBuffer((int) templateFile.length());
			String tempLine = null;
			while ((tempLine = br.readLine()) != null)
			{
				tmpHtmlText.append(tempLine).append("\n");
			}
			htmlText = tmpHtmlText.toString();
			logger.debug(htmlText);
			br.close();
			isr.close();
			fis.close();

			logger.debug("Reading parameters into template file.......");
			Iterator iter = map.entrySet().iterator();
			while (iter.hasNext())
			{
				Map.Entry entry = (Map.Entry) iter.next();
				String key = (String) entry.getKey();
				String value = (String) entry.getValue();
				logger.debug("key: " + key + " value: " + value);
				htmlText = htmlText.replace("#" + key + "#", value);
			}
		}
		catch (FileNotFoundException e)
		{
			logger.error(e.getMessage(), e);
			return htmlText;
		}
		catch (UnsupportedEncodingException e)
		{
			logger.error(e.getMessage(), e);
			return htmlText;
		}
		catch (IOException e)
		{
			logger.error(e.getMessage(), e);
			return htmlText;
		}
		catch (Exception e)
		{
			logger.error(e.getMessage(), e);
			return htmlText;
		}
		logger.debug("Construct mail content successfully.");
		return htmlText;
	}

	public static boolean Send(String subject, String to, String templateFile, HashMap<String, String> values)
	{
		try
		{
			logger.debug("Getting email session.......");
			Properties props = null;

			props = new Properties();
			props.put(hostName, PropertiesUtil.MAILHOST);
			props.put(mailFrom, PropertiesUtil.MAILFROM);

			Session session = null;
			if (PropertiesUtil.MAILPASS == null || "".equalsIgnoreCase(PropertiesUtil.MAILPASS.trim()))
			{

				session = Session.getInstance(props, null);
			}
			else
			{

				props.put("mail.smtp.auth", "true");

				Authenticator authenticator = new SendMailAuthenticator(PropertiesUtil.MAILUSER, PropertiesUtil.MAILPASS);

				session = Session.getInstance(props, authenticator);
			}

			logger.debug("Got email session.");

			MimeMessage message = new MimeMessage(session);

			StringTokenizer st = new StringTokenizer(to, ",");

			InternetAddress toAdd[] = new InternetAddress[st.countTokens()];

			logger.debug("Initialize Recipients email address....");
			int i = 0;
			while (st.hasMoreTokens())
			{
				String mailAddr = st.nextToken().trim();
				logger.info("Email send to address: " + mailAddr + " -- Subject: " + subject);
				toAdd[i] = new InternetAddress(mailAddr);
			}

			message.addRecipients(Message.RecipientType.TO, toAdd);
			logger.debug("Initialize Recipients email address successful.");

			/*
			 * if (!"".equalsIgnoreCase(PropertiesUtil.MAILBCC)) { String[]
			 * bccStrings = PropertiesUtil.MAILBCC.split(","); InternetAddress
			 * bccEamilStrings[] = new InternetAddress[bccStrings.length]; for
			 * (int j = 0; j < bccStrings.length; j++) {
			 * logger.info("Email cc send to address: " + bccStrings[j] +
			 * " -- Subject: " + subject); bccEamilStrings[j] = new
			 * InternetAddress(bccStrings[j]); }
			 * message.addRecipients(Message.RecipientType.BCC,
			 * bccEamilStrings);
			 * 
			 * }
			 */

			logger.debug("Initialize From email address....");
			String from = PropertiesUtil.MAILUSERTITLE + "<" + PropertiesUtil.MAILFROM + ">";
			InternetAddress fromAddress = new InternetAddress(from);
			message.setFrom(fromAddress);
			logger.debug("Initialize From email address successful.");
			logger.debug("Setting subject.");
			message.setSubject(subject, "utf-8");

			logger.debug("Consturct email content.");
			Mail sendMail = new Mail();
			String content = sendMail.consturctMail(templateFile, values);

			logger.debug("Set message content.");
			if (content == null || content.length() <= 0)
			{
				logger.error("Mail Content is null");
				return false;
			}
			message.setContent(content, "text/html; charset=utf-8");
			logger.debug("Sending email.....");

			if (PropertiesUtil.MAILPASS == null || "".equalsIgnoreCase(PropertiesUtil.MAILPASS.trim()))
			{
				Transport.send(message);
			}
			else
			{
				Transport transport = session.getTransport("smtp");
				transport.connect(PropertiesUtil.MAILHOST, PropertiesUtil.MAILUSER, PropertiesUtil.MAILPASS);
				transport.sendMessage(message, message.getAllRecipients());

				transport.close();
			}

			logger.debug("Email Sent.");
		}
		catch (Exception e)
		{
			logger.error(e.getMessage(), e);
			return false;
		}
		finally
		{
		}
		return true;
	}

	//public static boolean SendWithCC(String subject, String to, String templateFile, HashMap<String, String> values, String fileAttachment, String fileAttachment2)
	public static boolean SendWithCC(String subject, String to, String templateFile, HashMap<String, String> values, Map<String, String> imagesMap, List<String> fileAttachments )
	{
		try
		{
			logger.debug("Getting email session.......");

			Properties props = null;

			props = new Properties();
			props.put(hostName, PropertiesUtil.MAILHOST);
			props.put(mailFrom, PropertiesUtil.MAILFROM);

			String receiptPath = PropertiesUtil.getProperty("receiptPath");
			
			Session session = null;
			if (PropertiesUtil.MAILPASS == null || "".equalsIgnoreCase(PropertiesUtil.MAILPASS.trim()))
			{

				session = Session.getInstance(props, null);
			}
			else
			{

				props.put("mail.smtp.auth", "true");

				Authenticator authenticator = new SendMailAuthenticator(PropertiesUtil.MAILUSER, PropertiesUtil.MAILPASS);

				session = Session.getInstance(props, authenticator);
			}

			logger.debug("Got email session.");

			MimeMessage message = new MimeMessage(session);

			StringTokenizer st = new StringTokenizer(to, ",");

			InternetAddress toAdd[] = new InternetAddress[st.countTokens()];

			logger.debug("Initialize Recipients email address....");
			int i = 0;
			while (st.hasMoreTokens())
			{
				String mailAddr = st.nextToken().trim();
				logger.info("Email send to address: " + mailAddr + " -- Subject: " + subject);
				toAdd[i] = new InternetAddress(mailAddr);
			}

			message.addRecipients(Message.RecipientType.TO, toAdd);
			logger.debug("Initialize Recipients email address successful.");

			if (!"".equalsIgnoreCase(PropertiesUtil.MAILBCC))
			{
				String[] bccStrings = PropertiesUtil.MAILBCC.split(",");
				InternetAddress bccEamilStrings[] = new InternetAddress[bccStrings.length];
				for (int j = 0; j < bccStrings.length; j++)
				{
					logger.info("Email cc send to address: " + bccStrings[j] + " -- Subject: " + subject);
					bccEamilStrings[j] = new InternetAddress(bccStrings[j]);
				}
				message.addRecipients(Message.RecipientType.BCC, bccEamilStrings);

			}

			logger.debug("Initialize From email address....");
			String from = PropertiesUtil.MAILUSERTITLE + "<" + PropertiesUtil.MAILFROM + ">";
			InternetAddress fromAddress = new InternetAddress(from);
			message.setFrom(fromAddress);
			logger.debug("Initialize From email address successful.");
			logger.debug("Setting subject.");
			message.setSubject(subject, "utf-8");

			logger.debug("Consturct email content.");
			Mail sendMail = new Mail();
			String content = sendMail.consturctMail(templateFile, values);

			logger.debug("Set message content.");
			if (content == null || content.length() <= 0)
			{
				logger.error("Mail Content is null");
				return false;
			}
			//message.setContent(content, "text/html; charset=utf-8");
			logger.debug("Sending email.....");

			BodyPart messageBodyPart = new MimeBodyPart();	
			
			//messageBodyPart.setText(content);
			messageBodyPart.setContent(content, "text/html;charset=utf-8");
			
		
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
			
			for(String fileAttachment : fileAttachments) {
				if (!"".equals(fileAttachment)) {
					
					File tempFile = new File(receiptPath+fileAttachment);	
					
					messageBodyPart = new MimeBodyPart();
					DataSource source = new FileDataSource(tempFile);
					messageBodyPart.setDataHandler(new DataHandler(source));
					messageBodyPart.setFileName(fileAttachment);
					multipart.addBodyPart(messageBodyPart);		
					
				}
			}
			
			for (Entry<String, String> entry : imagesMap.entrySet()) {  
				  // START HANDLING INLINE IMAGE (WORK FOR GMAIL) 
		          MimeBodyPart imagePart = new MimeBodyPart();
		          imagePart.setHeader("Content-ID", "<" + entry.getKey() + ">");
		          imagePart.setDisposition(MimeBodyPart.INLINE);
		                 
		          String imageFilePath = imagesMap.get(entry.getKey());
		          try {
		              imagePart.attachFile(imageFilePath);
		          } catch (IOException ex) {
		              ex.printStackTrace();
		          }
		          multipart.addBodyPart(imagePart);
		          // END HANDLING INLINE IMAGE (WORK FOR GMAIL) 
		            //}
		          
		          // START HANDLING ATTACHMENT  
		          /*File tempFile = new File(entry.getValue());	
		          messageBodyPart = new MimeBodyPart();
		          DataSource source = new FileDataSource(tempFile);
		          messageBodyPart.setDataHandler(new DataHandler(source));
		          messageBodyPart.setFileName(entry.getKey());	
		          multipart.addBodyPart(messageBodyPart);	*/
		          // END HANDLING ATTACHMENT 
			}
			
			/*if (!"".equals(fileAttachment2)) {
				
				File tempFile = new File(receiptPath+fileAttachment2);	
				
				messageBodyPart = new MimeBodyPart();
				DataSource source = new FileDataSource(tempFile);
				messageBodyPart.setDataHandler(new DataHandler(source));
				messageBodyPart.setFileName(fileAttachment2);
				multipart.addBodyPart(messageBodyPart);		
			}*/


			
			//Put parts in message
			message.setContent(multipart);

			
			
			if (PropertiesUtil.MAILPASS == null || "".equalsIgnoreCase(PropertiesUtil.MAILPASS.trim()))
			{
				Transport.send(message);
			}
			else
			{
				Transport transport = session.getTransport("smtp");
				transport.connect(PropertiesUtil.MAILHOST, PropertiesUtil.MAILUSER, PropertiesUtil.MAILPASS);
				transport.sendMessage(message, message.getAllRecipients());

				transport.close();
			}

			logger.debug("Email Sent.");
		}

		catch (Exception e)
		{
			logger.error(e.getMessage(), e);
			return false;
		}
		finally
		{

		}
		return true;
	}

	public static boolean Send(String subject, String to, String content)
	{
		try
		{
			logger.debug("Getting email session.......");
			Properties props = null;

			props = new Properties();
			props.put(hostName, PropertiesUtil.MAILHOST);
			props.put(mailFrom, PropertiesUtil.MAILFROM);

			Session session = null;
			if (PropertiesUtil.MAILPASS == null || "".equalsIgnoreCase(PropertiesUtil.MAILPASS.trim()))
			{

				session = Session.getInstance(props, null);
			}
			else
			{

				props.put("mail.smtp.auth", "true");

				Authenticator authenticator = new SendMailAuthenticator(PropertiesUtil.MAILUSER, PropertiesUtil.MAILPASS);

				session = Session.getInstance(props, authenticator);
			}

			logger.debug("Got email session.");

			MimeMessage message = new MimeMessage(session);

			StringTokenizer st = new StringTokenizer(to, ",");

			InternetAddress toAdd[] = new InternetAddress[st.countTokens()];

			logger.debug("Initialize Recipients email address....");
			int i = 0;
			while (st.hasMoreTokens())
			{
				String mailAddr = st.nextToken().trim();
				logger.info("Email send to address: " + mailAddr + " -- Subject: " + subject +"  -- Content: "+content);
				toAdd[i] = new InternetAddress(mailAddr);
			}

			message.addRecipients(Message.RecipientType.TO, toAdd);
			logger.debug("Initialize Recipients email address successful.");


			logger.debug("Initialize From email address....");
			String from = PropertiesUtil.MAILUSERTITLE + "<" + PropertiesUtil.MAILFROM + ">";
			InternetAddress fromAddress = new InternetAddress(from);
			message.setFrom(fromAddress);
			logger.debug("Initialize From email address successful.");
			logger.debug("Setting subject.");
			message.setSubject(subject, "utf-8");

			logger.debug("Consturct email content.");
			Mail sendMail = new Mail();

			logger.debug("Set message content.");
			if (content == null || content.length() <= 0)
			{
				logger.error("Mail Content is null");
				return false;
			}
			message.setContent(content, "text/html; charset=utf-8");
			logger.debug("Sending email.....");

			if (PropertiesUtil.MAILPASS == null || "".equalsIgnoreCase(PropertiesUtil.MAILPASS.trim()))
			{
				Transport.send(message);
			}
			else
			{
				Transport transport = session.getTransport("smtp");
				transport.connect(PropertiesUtil.MAILHOST, PropertiesUtil.MAILUSER, PropertiesUtil.MAILPASS);
				transport.sendMessage(message, message.getAllRecipients());

				transport.close();
			}

			logger.debug("Email Sent.");
		}

		catch (Exception e)
		{
			logger.error(e.getMessage(), e);
			return false;
		}
		finally
		{

		}
		return true;
	}

	public static boolean sendMailAttachment(String subject, String to, String bcc, String content, String attachmentPath, String attachmentName)
	{
		try
		{
			//logger.debug("Getting email session.......");

			Properties props = null;

			props = new Properties();
			props.put(hostName, PropertiesUtil.MAILHOST);
			props.put(mailFrom, PropertiesUtil.MAILFROM);

			//String receiptPath = PropertiesUtil.getProperty("offlinePath");
			
			Session session = null;
			if (PropertiesUtil.MAILPASS == null || "".equalsIgnoreCase(PropertiesUtil.MAILPASS.trim()))
			{

				session = Session.getInstance(props, null);
			}
			else
			{

				props.put("mail.smtp.auth", "true");

				Authenticator authenticator = new SendMailAuthenticator(PropertiesUtil.MAILUSER, PropertiesUtil.MAILPASS);

				session = Session.getInstance(props, authenticator);
			}

			//logger.debug("Got email session.");

			MimeMessage message = new MimeMessage(session);

			String[] toStrings = to.split(",");
			InternetAddress toEamilStrings[] = new InternetAddress[toStrings.length];
			for (int j = 0; j < toStrings.length; j++)
			{
				//logger.info("Email cc send to address: " + bccStrings[j] + " -- Subject: " + subject);
				toEamilStrings[j] = new InternetAddress(toStrings[j]);
			}
			message.addRecipients(Message.RecipientType.TO, toEamilStrings);
			
			//logger.debug("Initialize Recipients email address successful.");

			if (!"".equalsIgnoreCase(bcc))
			{
				String[] bccStrings = bcc.split(",");
				InternetAddress bccEamilStrings[] = new InternetAddress[bccStrings.length];
				for (int j = 0; j < bccStrings.length; j++)
				{
					//logger.info("Email cc send to address: " + bccStrings[j] + " -- Subject: " + subject);
					bccEamilStrings[j] = new InternetAddress(bccStrings[j]);
				}
				message.addRecipients(Message.RecipientType.BCC, bccEamilStrings);

			}

			//logger.debug("Initialize From email address....");
			String from = PropertiesUtil.MAILUSERTITLE + "<" + PropertiesUtil.MAILFROM + ">";
			InternetAddress fromAddress = new InternetAddress(from);
			message.setFrom(fromAddress);
			//logger.debug("Initialize From email address successful.");
			//logger.debug("Setting subject.");
			message.setSubject(subject, "utf-8");

			//logger.debug("Consturct email content.");
			/*
			Mail sendMail = new Mail();
			
			String content = sendMail.consturctMail(templateFile, values);

			logger.debug("Set message content.");
			if (content == null || content.length() <= 0)
			{
				logger.error("Mail Content is null");
				return false;
			}
			//message.setContent(content, "text/html; charset=utf-8");
			logger.debug("Sending email.....");
			 */
			BodyPart messageBodyPart = new MimeBodyPart();	
			
			//messageBodyPart.setText(content);
			
			messageBodyPart.setContent(content, "text/html;charset=utf-8");
			
		
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
			
			if (!"".equals(attachmentName)) {
				
				File tempFile = new File(attachmentName);	
				
				messageBodyPart = new MimeBodyPart();
				DataSource source = new FileDataSource(tempFile);
				messageBodyPart.setDataHandler(new DataHandler(source));
				messageBodyPart.setFileName(attachmentName);
				multipart.addBodyPart(messageBodyPart);		
				
			}
			
			
			//Put parts in message
			message.setContent(multipart);

			
			
			if (PropertiesUtil.MAILPASS == null || "".equalsIgnoreCase(PropertiesUtil.MAILPASS.trim()))
			{
				Transport.send(message);
			}
			else
			{
				Transport transport = session.getTransport("smtp");
				transport.connect(PropertiesUtil.MAILHOST, PropertiesUtil.MAILUSER, PropertiesUtil.MAILPASS);
				transport.sendMessage(message, message.getAllRecipients());

				transport.close();
			}
			logger.info("Send email: " + to + " (" + subject + ")");
			
		}

		catch (Exception e)
		{
			logger.info(e.getMessage(), e);
			return false;
		}
		finally
		{

		}
		return true;
	}

}


class SendMailAuthenticator extends Authenticator
{
	private String username;
	private String password;

	public SendMailAuthenticator(String username, String password)
	{
		this.username = username;
		this.password = password;
	}

	public PasswordAuthentication getPasswordAuthentication()
	{
		return new PasswordAuthentication(username, password);
	}
}
