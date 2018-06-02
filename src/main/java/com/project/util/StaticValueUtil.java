package com.project.util;

public class StaticValueUtil
{
	public static final int Pending = 0;
	public static final int Active = 1;
	public static final int Registered = 2;
	public static final int Inactive = -1;
	public static final int Cancel = -2;
	public static final int Delete = -3;
	public static final int Suspend = -4;
	public static final int Locked = -5;
	
	//BANENR POSITION RELATED 
	public static final int BANNER_INDEX_MAIN = 1000;
	public static final int BANNER_INDEX_SUB_L = 1100;
	public static final int BANNER_INDEX_SUB_R_1 = 1101;
	public static final int BANNER_INDEX_SUB_R_2 = 1102;
	public static final int BANNER_INDEX_SUB_R_B = 1103;
	
	
	//OTHER PLATFORM LOGIN RELATED 
	public static final String LOGIN_FROM_APP = "clphk";
	public static final String LOGIN_FROM_EP360 = "ep360";
	public static final String LOGIN_FROM_AMI = "ami";
	public static final String LOGIN_FROM_MCOMMER= "mCommerce";
	
	public static final String LOGIN_SOURCE_WEB = "web";
	public static final String LOGIN_SOURCE_MOBILE = "app";
	
	public static final String LOGIN_TARGET_ODETAIL = "orderdetail";
	public static final String LOGIN_TRAGET_PDETAIL = "productdetail";
	public static final String LOGIN_TARGET_SUBCATEGORY = "subcategory";
	public static final String LOGIN_TARGET_ECOCATEGORY = "ecocategory";
	public static final String LOGIN_TARGET_HOTCATEGORY = "hotcategory";
	public static final String LOGIN_TARGET_SMARTCATEGORY = "smartcategory";
	public static final String LOGIN_TARGET_ELECTRICALCATEGORY = "electricalcategory";
	public static final String LOGIN_TARGET_ECODETAIL = "ecodetail";
	public static final String LOGIN_TARGET_EREDEEM = "eredeem";
	
	public static final String LOGIN_PREFIX_MEMBER = "m";
	public static final String LOGIN_PREFIX_GUEST = "g";
	
	public static final Integer MsgAlertType_Show = 1;   //show in page
	public static final Integer MsgAlertType_Alert = 2;  //js alert
	
	public static final Integer productType_actual=0;
	//public static final Integer productType_coupon=1;
	public static final Integer productType_precontact=1;
	
	public static final Integer respCode_success=1;
	public static final Integer respCode_redirect=2;
	
	public static final int DEFAULT_VALUE = 0;
	public static final String DEFAULT_ALL = "ALL";
	
	//Parent Category List 
	public static final int CAT_ELECTRICAL = -1;
	public static final int CAT_SMART = -2;
	public static final int CAT_ECO = -3;
	public static final int CAT_HOT = -4;
	public static final int PARENT_CAT = -1;
	public static final int CAT_MAKEUP = 1;
	public static final int CAT_SKIN = 2;
	
	//Sorting type 
	public static final int SORT_CLP_RECOMMED = 1;
	public static final int SORT_CUS_POPULAR = 2;
	public static final int SORT_NEW_ITEM = 3; 
	
	public static final String FILTER_ECO_PRICE_1 = "300";//"11";//; 
	public static final String FILTER_ECO_PRICE_2 = "600";//"20";//"600";
	public static final String FILTER_ECO_PRICE_3 = "601";//"29";//"601"; 
	
	public static final String FILTER_PROD_PRICE_1 = "999.99";
	public static final String FILTER_PROD_PRICE_2 = "1000";
	
	public static final String FILTER_ECO_DISCOUNT_Y = "y"; 
	public static final String FILTER_ECO_DISCOUNT_N = "n";

	
	//public static final int PRODUCT_ENABLE_ECO = 1;
	//public static final int PRODUCT_DISABLE_ECO = 0;
	
	public static final int REPORT_DOWNLOADED = 2;
	
	//Default disable and enable 
	public static final int PRODUCT_ENABLE = 1;
	public static final int PRODUCT_DISABLE = 0;
	public static final int STATUS_ENABLE = 1;
	public static final int STATUS_DISABLE = 0;
	public static final String STATUS_YES = "Y";
	public static final String STATUS_NO = "N";
	
	//Product / Eco-Reward 
	public static final int ITEM_PRODUCT = 0;
	public static final int ITEM_ECO = 1;
	
	
	
	public static final String PREFIX_PICKUP="P";
	public static final String PREFIX_DELIVERY ="D";
	public static final String PREFIX_INSTALL="I";
	
	
	//Product Payment Type - With / without eco point payment 
	public static final int PRODUCT_ISECO = 1;
	public static final int PRODUCT_ISNORMAL = 0;
	
	//Product Offline / Online Method Status (Collection Method)
	public static final int COLLECT_NORMAL = 0;
	public static final int COLLECT_INSTALL = 1;
	
	//Product collection type - pickup, delivery, installation 
	public static final Integer product_PickUp=11;
	public static final Integer product_Delivery=12;
	public static final Integer product_Install=13;
	public static final Integer product_No=0;
	
	//Eco reward type - Paper Coupon / eCoupon / email based coupon
	public static final int ECOREWARD_ECOUPON = 22;
	public static final int ECOREWARD_COUPON = 21;
	public static final int ECOREWWARD_EMAIL = 23; 
	public static final int ECOREWARD_BOTH = 24;
	
	//Eco reward tag 
	public static final int ECOREWARD_TAG_CLOTH = 1;
	public static final int ECOREWARD_TAG_DINE = 2;
	public static final int ECOREWARD_TAG_HOME = 3;
	public static final int ECOREWARD_TAG_LIFE = 4;

	//Product & Eco Reward Collection Status 
	public static final int COLLECT_PENDING = 0;
	public static final int COLLECT_DELIVERED = 1;
	public static final int COLLECT_REDEEMED = 2; 
	public static final int COLLECT_INSTALLED = 3;
	public static final int COLLECT_EXPIRED = 4;
	
	//OrderType Payment Online / Offline
	//public static final int ORDERTYPE_ONLINE=0;
	//public static final int ORDERTYPE_OFFLINE=1;
	
	public static final int ORDERTYPE_NORMAL = 0;
	public static final int ORDERTYPE_INSTALL = 1;
	public static final int ORDERTYPE_ECO = 2;
	
	//Sort By Selection 
	public static final int SORTBY_CREATE_DATE = 0;
	public static final int SORTCBY_PRICE = 1;
	public static final int SORTBY_NAME = 2;
	
	//Display Platform 
	public static final int DISPLAY_ALL = 0;
	public static final int DISPLAY_WEB = 1;
	public static final int DISPLAY_APPS = 2;
	public static final String DISPLAY_TEXT_ALL = "ALL";
	public static final String DISPLAY_TEXT_WEB = "WEB";
	public static final String DISPLAY_TEXT_APPS = "APP";
	
	
	//API Related Status
	public static final String API_UPDATE_ECO_SUCCESS ="S";
	public static final String API_UPDATE_ECO_FAIL="F";
	public static final String API_UPDETE_ECO_NEGATIVE="NEGATIVE_POINT";
	public static final String API_LOGIN_LEVEL_H="H";
	public static final String API_LOGIN_LEVEL_L="L";
	public static final String API_TOKEN_GRANTTYPE_LOGIN="password";
	public static final String API_TOKEN_GRANTTYPE_REFRESH="refresh_token";
	
	//User Type
	public static final int USER_MEMBER = 1;
	public static final int USER_GUEST = 0;
	
	//Account Related Info
	public static final String ACC_RATE_CAT_NORMAL = "DOMESTIC";
	public static final String ACC_RATE_CAT_STAFF = "STAFF";
	public static final String ACC_RATE_CAT_MERCHANT = "GST";
	public static final String ACC_RATE_CAT_ELDERLY = "ELDERLY";
	
	public static final String ACC_MOVEOUT_NORMAL = "9999";
	
	//BATCH UPLOAD KEY 
	public static final String BATCH_MOVEMENT_RESTOCK = "RESTOCK";
	public static final String BATCH_MOVEMENT_DEDUCT = "DEDUCT";
	
	//PAGE VIEW 
	public static final String PAGE_PRODUCTLIST = "PLIST";
	public static final String PAGE_PRODUCTDETAIL = "PDETAIL";
	public static final String PAGE_ECOREWARDLIST = "ELIST";
	public static final String PAGE_ECOREWARDDETAIL = "EDETAIL";
	public static final String PAGE_HOTLIST = "HLIST";
	public static final String PAGE_HISTORYLIST = "HISLIST";
	public static final String PAGE_HISTORYDETAIL = "HISDETAIL";
	public static final String PAGE_HISTORYSEARCH = "HISSEARCH";
	public static final String PAGE_SEARCH = "SEARCH";
	public static final String PAGE_EVOUCHERLIST = "EVLIST";
	public static final String PAGE_EVOUCHERDETAIL = "EVDETAIL";
	public static final String PAGE_CHECKOUT = "CHECKOUT";
	
	
	//CART TRACK RELATED 
	public static final int CART_ADD = 1;
	public static final int CART_REMOVE = 2;
	public static final int CART_CHANGE_ADD = 3;
	public static final int CART_CHANGE_DEDUCT = 4;
	
	public static final int GAEE_PROD_IMPRESSION = 1;
	public static final int GAEE_PROD_CLICK = 2;
	public static final int GAEE_DETAIL_IMPRESSION = 3;
	public static final int GAEE_ATD = 4;
	public static final int GAEE_RFC = 5;
	public static final int GAEE_PROM_IMPRESSION = 6;
	public static final int GAEE_PROM_CLICK = 7;
	public static final int GAEE_PURCHASE = 8;
	public static final int GAEE_CHECKOUT = 9;
	
	public static final String GAEE_LIST_INDEX = "Index List";
	public static final String GAEE_LIST_SEARCH = "Search List"; 
	
	
	public static final int DISCOUNT_PERCENT = 1;
	public static final int DISCOUNT_FIX = 2;
	
	//CATEGORY TAG 
	public static final int TAG_FACE = 1;
	public static final int TAG_EYE = 2;
	public static final int TAG_CHEEKS = 3;
	public static final int TAG_LIPS = 4;
	public static final int TAG_TOOLS = 5;
	
	//ENVIROMENT 
	public static final String ENV_LOCAL = "L";
	public static final String ENV_UAT = "U";
	public static final String ENV_PROD = "P";
}
