package com.project.bean;

//FOR GA CMS REPORT CAPTURE LOGIN RECORD 
public class LoginMethodBean extends GenericBean{
	
	private String userid;
	private String type; 
	private String ip;
	private String platform;
	
	
	public String getPlatform() {
		return platform;
	}
	public void setPlatform(String platform) {
		this.platform = platform;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	} 
	

}
