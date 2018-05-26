package com.project.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.project.bean.OrderItemBean;

public class OrderBean extends GenericBean{
	
	private int oId = 0 ;
	private String orderRef = "";
	private int memberid;
	private double totalAmount = 0;
	private double orderAmount = 0 ;
	private double deliveryAmount = 0;
	private double discountAmount = 0;
	private double couponamount = 0;
	private double remainAmount;

	private String orderStatus = "";
	private Date transactiondate;
	private String paymentRef = "";
	
	private String buyertitle = "";
	private String buyerfirstname = "";
	private String buyerlastname = "";
	private String buyercompanyname = "";
	private String buyerphone = "";
	private String buyeremail = "";
	private String buyeraddress1 = "";
	private String buyeraddress2 = "";
	private String buyerpostcode = "";
	private String buyertown = "";
	private String buyerstate = "";
	private String buyercountry = "";
	
	//SHIPPING RELATED INFO 
	private String isshipdifferent;
	private String shipfirstname;
	private String shiplastname;
	private String shipcompanyname;
	private String shipaddress1;
	private String shipaddress2;
	private String shippostcode;
	private String shiptown;
	private String shipstate;
	private String shipcountry;
	private String tracknumber;
	
	private String buyerremark;
	private String adminremark;
	
	//CARD RELATED INFO
	private String remark;
	private String payMethod="";
	private String approvalCode = "";
	private String maskedCardNo = "";
	private String holderName = "";
	private String src;
	private String currency;
	private String eci;
	private String sourceip;
	private String ipcountry;
	
	
	private List<OrderItemBean> orderItems = new ArrayList<OrderItemBean>();

	
	public String getIsshipdifferent() {
		return isshipdifferent;
	}


	public void setIsshipdifferent(String isshipdifferent) {
		this.isshipdifferent = isshipdifferent;
	}


	public double getCouponamount() {
		return couponamount;
	}


	public void setCouponamount(double couponamount) {
		this.couponamount = couponamount;
	}


	public int getoId() {
		return oId;
	}


	public void setoId(int oId) {
		this.oId = oId;
	}


	public String getOrderRef() {
		return orderRef;
	}


	public void setOrderRef(String orderRef) {
		this.orderRef = orderRef;
	}


	public int getMemberid() {
		return memberid;
	}


	public void setMemberid(int memberid) {
		this.memberid = memberid;
	}


	public double getTotalAmount() {
		return totalAmount;
	}


	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}


	public double getOrderAmount() {
		return orderAmount;
	}


	public void setOrderAmount(double orderAmount) {
		this.orderAmount = orderAmount;
	}


	public double getDeliveryAmount() {
		return deliveryAmount;
	}


	public void setDeliveryAmount(double deliveryAmount) {
		this.deliveryAmount = deliveryAmount;
	}


	public double getDiscountAmount() {
		return discountAmount;
	}


	public void setDiscountAmount(double discountAmount) {
		this.discountAmount = discountAmount;
	}


	public double getRemainAmount() {
		return remainAmount;
	}


	public void setRemainAmount(double remainAmount) {
		this.remainAmount = remainAmount;
	}


	public String getOrderStatus() {
		return orderStatus;
	}


	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}


	public Date getTransactiondate() {
		return transactiondate;
	}


	public void setTransactiondate(Date transactiondate) {
		this.transactiondate = transactiondate;
	}


	public String getPaymentRef() {
		return paymentRef;
	}


	public void setPaymentRef(String paymentRef) {
		this.paymentRef = paymentRef;
	}


	public String getBuyertitle() {
		return buyertitle;
	}


	public void setBuyertitle(String buyertitle) {
		this.buyertitle = buyertitle;
	}


	public String getBuyerfirstname() {
		return buyerfirstname;
	}


	public void setBuyerfirstname(String buyerfirstname) {
		this.buyerfirstname = buyerfirstname;
	}


	public String getBuyerlastname() {
		return buyerlastname;
	}


	public void setBuyerlastname(String buyerlastname) {
		this.buyerlastname = buyerlastname;
	}


	public String getBuyercompanyname() {
		return buyercompanyname;
	}


	public void setBuyercompanyname(String buyercompanyname) {
		this.buyercompanyname = buyercompanyname;
	}


	public String getBuyerphone() {
		return buyerphone;
	}


	public void setBuyerphone(String buyerphone) {
		this.buyerphone = buyerphone;
	}


	public String getBuyeremail() {
		return buyeremail;
	}


	public void setBuyeremail(String buyeremail) {
		this.buyeremail = buyeremail;
	}


	public String getBuyeraddress1() {
		return buyeraddress1;
	}


	public void setBuyeraddress1(String buyeraddress1) {
		this.buyeraddress1 = buyeraddress1;
	}


	public String getBuyeraddress2() {
		return buyeraddress2;
	}


	public void setBuyeraddress2(String buyeraddress2) {
		this.buyeraddress2 = buyeraddress2;
	}


	public String getBuyerpostcode() {
		return buyerpostcode;
	}


	public void setBuyerpostcode(String buyerpostcode) {
		this.buyerpostcode = buyerpostcode;
	}


	public String getBuyertown() {
		return buyertown;
	}


	public void setBuyertown(String buyertown) {
		this.buyertown = buyertown;
	}


	public String getBuyerstate() {
		return buyerstate;
	}


	public void setBuyerstate(String buyerstate) {
		this.buyerstate = buyerstate;
	}


	public String getBuyercountry() {
		return buyercountry;
	}


	public void setBuyercountry(String buyercountry) {
		this.buyercountry = buyercountry;
	}


	public String getShipfirstname() {
		return shipfirstname;
	}


	public void setShipfirstname(String shipfirstname) {
		this.shipfirstname = shipfirstname;
	}


	public String getShiplastname() {
		return shiplastname;
	}


	public void setShiplastname(String shiplastname) {
		this.shiplastname = shiplastname;
	}


	public String getShipcompanyname() {
		return shipcompanyname;
	}


	public void setShipcompanyname(String shipcompanyname) {
		this.shipcompanyname = shipcompanyname;
	}

	public String getShipaddress1() {
		return shipaddress1;
	}


	public void setShipaddress1(String shipaddress1) {
		this.shipaddress1 = shipaddress1;
	}


	public String getShipaddress2() {
		return shipaddress2;
	}


	public void setShipaddress2(String shipaddress2) {
		this.shipaddress2 = shipaddress2;
	}


	public String getShippostcode() {
		return shippostcode;
	}


	public void setShippostcode(String shippostcode) {
		this.shippostcode = shippostcode;
	}


	public String getShiptown() {
		return shiptown;
	}


	public void setShiptown(String shiptown) {
		this.shiptown = shiptown;
	}


	public String getShipstate() {
		return shipstate;
	}


	public void setShipstate(String shipstate) {
		this.shipstate = shipstate;
	}


	public String getShipcountry() {
		return shipcountry;
	}


	public void setShipcountry(String shipcountry) {
		this.shipcountry = shipcountry;
	}


	public String getTracknumber() {
		return tracknumber;
	}


	public void setTracknumber(String tracknumber) {
		this.tracknumber = tracknumber;
	}


	public String getBuyerremark() {
		return buyerremark;
	}


	public void setBuyerremark(String buyerremark) {
		this.buyerremark = buyerremark;
	}


	public String getAdminremark() {
		return adminremark;
	}


	public void setAdminremark(String adminremark) {
		this.adminremark = adminremark;
	}

	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public String getPayMethod() {
		return payMethod;
	}


	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}


	public String getApprovalCode() {
		return approvalCode;
	}


	public void setApprovalCode(String approvalCode) {
		this.approvalCode = approvalCode;
	}


	public String getMaskedCardNo() {
		return maskedCardNo;
	}


	public void setMaskedCardNo(String maskedCardNo) {
		this.maskedCardNo = maskedCardNo;
	}


	public String getHolderName() {
		return holderName;
	}


	public void setHolderName(String holderName) {
		this.holderName = holderName;
	}


	public String getSrc() {
		return src;
	}


	public void setSrc(String src) {
		this.src = src;
	}


	public String getCurrency() {
		return currency;
	}


	public void setCurrency(String currency) {
		this.currency = currency;
	}


	public String getEci() {
		return eci;
	}


	public void setEci(String eci) {
		this.eci = eci;
	}


	public String getSourceip() {
		return sourceip;
	}


	public void setSourceip(String sourceip) {
		this.sourceip = sourceip;
	}


	public String getIpcountry() {
		return ipcountry;
	}


	public void setIpcountry(String ipcountry) {
		this.ipcountry = ipcountry;
	}


	public List<OrderItemBean> getOrderItems() {
		return orderItems;
	}


	public void setOrderItems(List<OrderItemBean> orderItems) {
		this.orderItems = orderItems;
	}

}
