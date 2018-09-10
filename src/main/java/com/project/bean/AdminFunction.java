package com.project.bean;

import java.util.ArrayList;
import java.util.List;


@SuppressWarnings("serial")
public class AdminFunction
{	
	public static String Product = "Product";
	public static String Order = "Order";
	public static String ImportExport = "Import / Export";
	public static String System = "System";
	public static String Report = "Report";
	public static String Recommend = "Recommend Item";
	public static String WhatsHot = "Hot Item";
	public static String Index = "Index";
	public static String Banner = "Banner";
	
	public static String Add = "Add";
	public static String View ="View";
	public static String Edit = "Edit";
	public static String Delete = "Delete";
	public static String UpdateStatus = "Batch Update";
	public static String AddItem = "Add Items";
	public static String ResetPwd = "ResetPwd";
	public static String ResendEmail = "ResendEmail";
	public static String Export = "Export";
	public static String RatingEdit = "Rating Edit";
	public static String RatingView = "Rating View";
	public static String None = "------";
	
	public static String ReportOrder = "Order";
	public static String ReportPayment = "Payment";
	
	public static final String haveRight = "Y";
	
	private static final String [][] functions = {
		{""},
		{System,Add,View,Edit,ResetPwd},
		{Product,Add,View,Edit,Export},
		{Order,View,Edit,ResendEmail,UpdateStatus},
		{Report,ReportOrder,},
		{ImportExport,Edit},
		{Index,Add,View,Edit,Delete},
		{Banner,Add,View,Edit}
	};
	
	public static int getFunctionId(String module,String function){
		int result = 0;
		for (int i=1;i<functions.length;i++){
			if (functions[i][0].equals(module)){
				for (int j=0;j<functions[i].length;j++)
					if (functions[i][j].equals(function)){						
						result = i * 100 + j;
					}						
			}
		}
		return result;
	}
	
	public static String [] getAllModules(){
		List<String> tmp = new ArrayList<String>();
		for (int i=0;i<functions.length;i++)
			tmp.add(functions[i][0]);
		return tmp.toArray(new String[0]);
	}
	
	public static String [] getAllFunctions(String module){
		int index = 0;
		for (int i=1;i<functions.length;i++){
			if (functions[i][0].equals(module)){
				index = i;
			}
		}
		return functions[index];
	}
}
