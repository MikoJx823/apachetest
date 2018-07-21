package com.project.bean;

public class BannerInfoBean extends GenericBean{
	
	private String name;
	private String link;
	private int position;
	private String image;
	private String appimage;
	private int seq;
	
	
	public String getAppimage() {
		return appimage;
	}
	public void setAppimage(String appimage) {
		this.appimage = appimage;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public int getPosition() {
		return position;
	}
	public void setPosition(int position) {
		this.position = position;
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
