package com.project.util;

import java.security.MessageDigest;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import net.sf.json.JSONObject;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;


public class AESCrypt {
	
	 Logger log = Logger.getLogger(AESCrypt.class);
	 private Cipher cipher;
	 private SecretKeySpec key;
	 private AlgorithmParameterSpec spec;
	 
	public AESCrypt(String password) throws Exception{
	        // hash password with SHA-256 and crop the output to 128-bit for key
	    	MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        digest.update(password.getBytes("UTF-8"));
	        byte[] keyBytes = new byte[32];
	        System.arraycopy(digest.digest(), 0, keyBytes, 0, keyBytes.length);
	 
	        cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");//Cipher.getInstance("AES/CBC/PKCS7Padding");
	        
	        key = new SecretKeySpec(keyBytes, "AES");
	        spec = getIV();
	}
	 
	public AlgorithmParameterSpec getIV(){
		byte[] iv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	    IvParameterSpec ivParameterSpec;
	    ivParameterSpec = new IvParameterSpec(iv);
	 
	    return ivParameterSpec;
	}
	 
	public String encrypt(String plainText) throws Exception{
		cipher.init(Cipher.ENCRYPT_MODE, key, spec);
	    byte[] encrypted = cipher.doFinal(plainText.getBytes("UTF-8"));
	    //String encryptedText = new String(Base64.encode(encrypted, Base64.DEFAULT), "UTF-8");
	    String encryptedText =  new String(Base64.encodeBase64(Base64.encodeBase64(encrypted)), "UTF-8");

	    //new String(Base64.encodeBase64(encrypted),"UTF-8");
	    
	    log.info("Encrypt Data " + encryptedText);
	    //System.out.println("Encrypt Data"+ encryptedText);
	    return encryptedText;
	}
	 
	public String decrypt(String cryptedText) throws Exception{
	    cipher.init(Cipher.DECRYPT_MODE, key, spec);
	    //byte[] bytes = Base64.decode(cryptedText, Base64.DEFAULT);
	    byte[] bytes = Base64.decodeBase64(new String(Base64.decodeBase64(cryptedText)));
	    //byte[] bytes = Base64.decodeBase64(cryptedText);
	    byte[] decrypted = cipher.doFinal(bytes);
	    String decryptedText = new String(decrypted, "UTF-8");
	    //log.info("Encrypt Date " + decryptedText);
	    System.out.println("Encrypt Data"+ decryptedText);
	    return decryptedText;
	}
	
	
	public static void main(String[] args){	
		 JSONObject json = new JSONObject();
		 json.put("CANo", "11722262");
		 json.put("accessToken", "HayGaFE81U0wvHAIN1KgtzL8IGyl");
		 json.put("refreshToken", "XlGjt5ohM06jnrINGC69L9YAKtwA18VS");
		 json.put("loginLevel", "H");
		 json.put("timestamp", "20170412125553");//"20170309142333");

		String key = "1234567891234567";
		String value = json.toString();
		
		//String data = new String(Base64.decodeBase64("c29OZXN2UHF2cW5FUzYxenJNVHJ3RGZla2JoY2g3LzIxRVR4akYxNjBWdXo2Rzc4Nzh3M1VXVTJlQXdyUTlTdFZWVzBhejhpdjVYR1JrWWJYc2Rsa3ZnSTZkNXdKME1RODBKYklubkticXVOQW9SaTdOa25BbTJqNVNXSzVaeFNlbmllcjJ6ZFFXa0pNaytZTVFqTldmZGltaitFNG56VFpzczdONGRzK1piWHN0anZrdzVyTEppVnY4MS81WUhDNGRBb0VEVy9xeEhxNEdOZHdjalh3QmFNQmZqSXlSTUVybUwxMktQVm5vND0="));  
		
		//String data = "dUNGV2kzOWVZYllIV3dEdjRicWZOL0RyV3BDb21oL0pzZi9TektjSHFmMFJzVzFJcE82NllPcGZCSldNRmYweG9mV3o5S1ZBM2xVdG0zam1IaGN6TEI3SlR0V3dPbWlLcUxLS2Y4bWRUWG82SWxkTlVYNi96RGNVNTFUejd2Yk1UWnVKZERKKys3YVNENGk0Tzhrc1lBaE8yRDNHUi8weEtjRzNLaXRiVXRWQVYybG11cEwrQVF0b0VUUkRjbkpYRCtuU3pZNzk5QyttVFIycjVERkhoSUY0WENhRGloR2NER01jQ1ZkODR4ND0";
		String data = "c29OZXN2UHF2cW5FUzYxenJNVHJ3RTlWRGhHWnF6WEQ3QlMwMmhTMThNcDBLTHo2VGNHNW1vR0FiU2N0c1lFeDlwQXBrUnZTRXAweXJYSFpLYVJUOWZKd0l2ZGpwcHlWSFdBSHpuM0dNUzUwYnA1aU55bi9IN2F0MTlWaDI5Q0psMENCcHJzTkpTd1J6SENJT1l0VTZUREp6SzRCTGd3L0VaWGVIYXRIQUhkR2xqVFVWRWxreHdORXlNMWliZHQvbW9IUjR0NnJZbW9ORXREblJtVnVGYjQ3MGIxMFNtWDR4RmNVTkFXZlozQT0=";
		//String data ="uCFWi39eYbYHWwDv4bqfN/DrWpComh/Jsf/SzKcHqf0RsW1IpO66YOpfBJWMFf0xofWz9KVA3lUtm3jmHhczLB7JTtWwOmiKqLKKf8mdTXo6IldNUX6/zDcU51Tz7vbMTZuJdDJ++7aSD4i4O8ksYAhO2D3GR/0xKcG3KitbUtVAV2lmupL+AQtoETRDcnJXD+nSzY799C+mTR2r5DFHhIF4XCaDihGcDGMcCVd84x4=";
		  //String data = "soNesvPqvqnES61zrMTrwDfekbhch7/21ETxjF160Vuz6G7878w3UWU2eAwrQ9StVVW0az8iv5XGRkYbXsdlkvgI6d5wJ0MQ80JbInnKbquNAoRi7NknAm2j5SWK5ZxSenier2zdQWkJMk+YMQjNWfdimj+E4nzTZss7N4ds+ZbXstjvkw5rLJiVv81/5YHC4dAoEDW/qxHq4GNdwcjXwBaMBfjIyRMErmL12KPVno4=";
		  
		  String decrypted = "";
		  String encrypted = "";
		  try {
			  AESCrypt aesCrypt = new AESCrypt(key);
			  	encrypted = aesCrypt.encrypt(value);
		  		decrypted = aesCrypt.decrypt(data);
		  		System.out.println("encrypted " + encrypted);
		  		System.out.println("descrtyted " + decrypted);
		  } catch (Exception e) {
		   e.printStackTrace();
		  }
		  
		 // {"CANo":"82841861744","accessToken":"wlGBBIbw4CGWJo0vSTVYJtG9hr6z","refreshToken":"gqGGMhTcKcscoGmIxymlJscR7i56LNMe","loginLevel":"H","timestamp":20170413122632}

		  
		  
	}
	
}
