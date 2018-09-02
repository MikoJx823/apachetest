package com.project.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProductBean extends GenericBean{
	
	private int categoryid;	
	private String name;
	private String productcode; 
	
	private String image1;
	private String image2;
	private String image3;
	private String image4;
	private String image5;

	private Date displaystart;
	private Date displayend;
	
	private String shortdesc;
	private String descimage;
	private String descyoutube;
	private String detail;
	
	private String fulldesc;
	private String additionaldesc;
	private String listtext;
	
	//private int isrecommend;
	//private int merchantCode;
	//private String materialNumber;
	//private int hotPick;
	
	private int brandid;
	
	private int pqid;
	private int ppid;
	private List<ProductVariantBean> productVariant;
	
	public String getListtext() {
		return listtext;
	}
	public void setListtext(String listtext) {
		this.listtext = listtext;
	}
	public String getDescyoutube() {
		return descyoutube;
	}
	public void setDescyoutube(String descyoutube) {
		this.descyoutube = descyoutube;
	}
	public String getFulldesc() {
		return fulldesc;
	}
	public void setFulldesc(String fulldesc) {
		this.fulldesc = fulldesc;
	}
	public String getAdditionaldesc() {
		return additionaldesc;
	}
	public void setAdditionaldesc(String additionaldesc) {
		this.additionaldesc = additionaldesc;
	}
	public int getCategoryid() {
		return categoryid;
	}
	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProductcode() {
		return productcode;
	}
	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
	public String getImage4() {
		return image4;
	}
	public void setImage4(String image4) {
		this.image4 = image4;
	}
	public String getImage5() {
		return image5;
	}
	public void setImage5(String image5) {
		this.image5 = image5;
	}
	public Date getDisplaystart() {
		return displaystart;
	}
	public void setDisplaystart(Date displaystart) {
		this.displaystart = displaystart;
	}
	public Date getDisplayend() {
		return displayend;
	}
	public void setDisplayend(Date displayend) {
		this.displayend = displayend;
	}
	public String getShortdesc() {
		return shortdesc;
	}
	public void setShortdesc(String shortdesc) {
		this.shortdesc = shortdesc;
	}
	public String getDescimage() {
		return descimage;
	}
	public void setDescimage(String descimage) {
		this.descimage = descimage;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public int getBrandid() {
		return brandid;
	}
	public void setBrandid(int brandid) {
		this.brandid = brandid;
	}
	public int getPqid() {
		return pqid;
	}
	public void setPqid(int pqid) {
		this.pqid = pqid;
	}
	public int getPpid() {
		return ppid;
	}
	public void setPpid(int ppid) {
		this.ppid = ppid;
	}
	public List<ProductVariantBean> getProductVariant() {
		return productVariant;
	}
	public void setProductVariant(List<ProductVariantBean> productVariant) {
		this.productVariant = productVariant;
	}
}