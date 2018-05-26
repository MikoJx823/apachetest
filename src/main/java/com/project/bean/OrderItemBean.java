package com.project.bean;

import java.util.Date;


public class OrderItemBean extends GenericBean{
	
	private int orderId;
	private int pid;
	private int pvid;
	private int categoryid;
	private double price;
	private double discount;
	private int quantity;
	private String productname;
	private String productimage;
	private String productcode; 
	private String variantname;
	
	private ProductBean product;
	private CategoryBean category;
	private ProductVariantBean variant; 
	
	
	public ProductVariantBean getVariant() {
		return variant;
	}
	public void setVariant(ProductVariantBean variant) {
		this.variant = variant;
	}
	public int getCategoryid() {
		return categoryid;
	}
	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getPvid() {
		return pvid;
	}
	public void setPvid(int pvid) {
		this.pvid = pvid;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getProductimage() {
		return productimage;
	}
	public void setProductimage(String productimage) {
		this.productimage = productimage;
	}
	public String getProductcode() {
		return productcode;
	}
	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}
	public String getVariantname() {
		return variantname;
	}
	public void setVariantname(String variantname) {
		this.variantname = variantname;
	}
	public ProductBean getProduct() {
		return product;
	}
	public void setProduct(ProductBean product) {
		this.product = product;
	}
	public CategoryBean getCategory() {
		return category;
	}
	public void setCategory(CategoryBean category) {
		this.category = category;
	}
}
