package com.project.bean;

import java.util.Date;

public class ProductVariantBean extends GenericBean{
	
	private int pvid;
	private int pid;
	private int seq;
	private String name;
	private String code;
	
	private int quantity;
	private double price;
	private double discount;
	private Date discountstart;
	private Date discountend;
	
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public Date getDiscountstart() {
		return discountstart;
	}
	public void setDiscountstart(Date discountstart) {
		this.discountstart = discountstart;
	}
	public Date getDiscountend() {
		return discountend;
	}
	public void setDiscountend(Date discountend) {
		this.discountend = discountend;
	}
	public int getPvid() {
		return pvid;
	}
	public void setPvid(int pvid) {
		this.pvid = pvid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
}