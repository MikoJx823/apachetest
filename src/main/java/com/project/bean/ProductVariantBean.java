package com.project.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProductVariantBean extends GenericBean{
	
	private int pvid;
	private int pid;
	private int seq;
	private String name;
	private int quantity;
	
	private double price;
	private double earlybirddiscount;
	private Date earlybirdstart;
	private Date earlybirdend;
	
	
	public double getEarlybirddiscount() {
		return earlybirddiscount;
	}
	public void setEarlybirddiscount(double earlybirddiscount) {
		this.earlybirddiscount = earlybirddiscount;
	}
	public Date getEarlybirdstart() {
		return earlybirdstart;
	}
	public void setEarlybirdstart(Date earlybirdstart) {
		this.earlybirdstart = earlybirdstart;
	}
	public Date getEarlybirdend() {
		return earlybirdend;
	}
	public void setEarlybirdend(Date earlybirdend) {
		this.earlybirdend = earlybirdend;
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