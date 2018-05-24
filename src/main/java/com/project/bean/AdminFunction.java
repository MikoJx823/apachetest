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
	public static String Category= "Category";
	/*public static String Sort = "Sort";
	public static String Filter = "Filter"; */
	public static String Recommend = "Recommend Item";
	public static String WhatsHot = "Hot Item";
	public static String Branch = "Branch";
	public static String EcoReward = "Eco Reward";
	public static String EcoPoint = "Eco Points";
	public static String Merchant = "Merchant";
	public static String Index = "Index";
	public static String Discount = "Promotion Discount";
	public static String Survey = "Survey";
	public static String CustomStock = "CustomStock";
	//public static String Banner = "Banner";
	
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
	public static String ReportPrintHouse = "Print House";
	public static String ReportERedeem = "E-Redeem";
	public static String ReportSurvey = "Survey";
	public static String ReportPageView = "Page View";
	public static String ReportPurchasedProduct = "Purchased Product";
	public static String ReportCartTrack = "Cart Track";
	public static String ReportLoginMethod = "Login Method";
	
	public static final String haveRight = "Y";
	
	private static final String [][] functions = {
		{""},
		{Product,Add,View,Edit,Export},
		{EcoReward,Add,View,Edit,Export},
		{Category,Add,View,Edit},
		{Branch,Add,View,Edit},
		{EcoPoint,Add,View,Edit},
		{Merchant,Add,View,Edit,Delete},
		{Order,View,Edit,ResendEmail,UpdateStatus},
		{Report,ReportOrder,ReportPayment,ReportPrintHouse,ReportERedeem,
			ReportSurvey,ReportPageView,ReportPurchasedProduct,ReportCartTrack,
			ReportLoginMethod},
		{ImportExport,Edit},
		{Recommend,Add,View,Edit,Delete},
		{WhatsHot,Add,View,Edit,Delete},
		{Index,Add,View,Edit,Delete},
		{System,Add,View,Edit,ResetPwd},
		{Discount,View,Edit},
		{Survey,View,Edit,RatingView,RatingEdit },
		{CustomStock,Add,View,Edit}
		//{Banner,Add,View,Edit}
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
