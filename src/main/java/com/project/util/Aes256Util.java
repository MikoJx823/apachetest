package com.project.util;

import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

//import org.apache.commons.codec.binary.Base64;
//import org.springframework.context.ApplicationContext;

public class Aes256Util
{
	//private static ApplicationContext ctx = null;
	private static final byte[] sal = parseHexStr2Byte("00010203040506070809");
	private static final byte[] iv = parseHexStr2Byte("000102030405060708090A0B0C0D0E0F");


	private static byte[] parseHexStr2Byte(String hexStr)
	{
		if (hexStr.length() < 1)
			return null;
		byte[] result = new byte[hexStr.length() / 2];
		for (int i = 0; i < hexStr.length() / 2; i++)
		{
			int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
			int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
			result[i] = (byte) (high * 16 + low);
		}
		return result;
	}

	
	private static String parseByte2HexStr(byte buf[])
	{
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < buf.length; i++)
		{
			String hex = Integer.toHexString(buf[i] & 0xFF);
			if (hex.length() == 1)
			{
				hex = '0' + hex;
			}
			sb.append(hex.toUpperCase());
		}
		return sb.toString();
	}


	public static String encrypt(String password, String clearText)
	{
		try
		{
			SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			KeySpec spec = new PBEKeySpec(password.toCharArray(), sal, 1000, 256);
			SecretKey tmp = factory.generateSecret(spec);
			SecretKey secret = new SecretKeySpec(tmp.getEncoded(), "AES");

			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			IvParameterSpec iv2 = new IvParameterSpec(iv);
			cipher.init(Cipher.ENCRYPT_MODE, secret, iv2);
			byte[] encodeByte = cipher.doFinal(clearText.getBytes("UTF-8"));
			String encodeText = new String(Base64.encodeBase64(encodeByte), "UTF-8");
			//String ciphertext = URLEncoder.encode(encodeText, "utf-8");

			return encodeText;
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}


	public static String decrypt(String password, String cipherText)
	{
		try
		{
			//String decodeText = URLDecoder.decode(cipherText);
			byte[] content = Base64.decodeBase64(cipherText);
			SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			KeySpec spec = new PBEKeySpec(password.toCharArray(), sal, 1000, 256);
			SecretKey tmp = factory.generateSecret(spec);
			SecretKey secret = new SecretKeySpec(tmp.getEncoded(), "AES");
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, secret, new IvParameterSpec(iv));
			
			//cipher.init(Cipher.DECRYPT_MODE, secret, getIV());
			return new String(cipher.doFinal(content), "UTF-8");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}
	
	
	public static AlgorithmParameterSpec getIV(){
		byte[] iv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	    IvParameterSpec ivParameterSpec;
	    ivParameterSpec = new IvParameterSpec(iv);
	 
	    return ivParameterSpec;
	}
	
	public static void main(String[] args)
	{

		String str = "candId=2079482&birthDate=20150201&currentTime=20160324160200";
		String pw = "asiapay";
		String str1 = encrypt(pw, str);
		System.out.println("encrypt：" + str1);
		//str1 = decrypt(pw, str1);
		str1 = decrypt("2zVO95tl00YGWFVd", "QUdXaXBoQzV5dFlnTU5HSFhyMDBsTlRDMWxvWTZuU3o6MnpWTzk1dGwwMFlHV0ZWZA==");
		System.out.println("decryption" + str1);
		
		//AGWiphC5ytYgMNGHXr00lNTC1loY6nSz 
		//2zVO95tl00YGWFVd
		//QUdXaXBoQzV5dFlnTU5HSFhyMDBsTlRDMWxvWTZuU3o6MnpWTzk1dGwwMFlHV0ZWZA==


	}
}
