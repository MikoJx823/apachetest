package com.project.bean;


public class CategoryBean extends GenericBean{
	
	private String name;
	private String desc;
	private int parentId;
	private String image;
	private int seq;
	private int tag;
	private int enableguide;
	
	public int getEnableguide() {
		return enableguide;
	}
	public void setEnableguide(int enableguide) {
		this.enableguide = enableguide;
	}
	public int getTag() {
		return tag;
	}
	public void setTag(int tag) {
		this.tag = tag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
}
