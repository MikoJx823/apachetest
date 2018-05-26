package com.project.util;

import java.util.Random;

public class RandomNumber {
    private static final int LENGTH = 8;  
   
    private static void swap(int i, int j, int[] nums) {  
        int temp = nums[i];  
        nums[i] = nums[j];  
        nums[j] = temp;  
    }  
       
    public static String generateNumber() {  
        String no="";  
        int num[]=new int[8];  
        int c=0;  
        for (int i = 0; i < 8; i++) {  
            num[i] = new Random().nextInt(10);  
            c = num[i];  
            for (int j = 0; j < i; j++) {  
                if (num[j] == c) {  
                    i--;  
                    break;  
                }  
            }  
        }  
        if (num.length>0) {  
            for (int i = 0; i < num.length; i++) {  
                no+=num[i];  
            }  
        }  
        return no;  
    }  
    
    public static String genRandomNum(int pwd_len){
    	  
    	  final int  maxNum = 36;
    	  int i;  
    	  int count = 0; 
    	  char[] str = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
    	    'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
    	    'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
    	  
    	  StringBuffer pwd = new StringBuffer("");
    	  Random r = new Random();
    	  while(count < pwd_len){
    	  
    	   
    	   i = Math.abs(r.nextInt(maxNum));  
    	   
    	   if (i >= 0 && i < str.length) {
    	    pwd.append(str[i]);
    	    count ++;
    	   }
    	  }
    	  
    	  return pwd.toString();
    	 }
   

}
