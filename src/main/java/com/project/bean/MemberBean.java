package com.project.bean;

public class MemberBean extends GenericBean{
	
	private String loginFrom;
	private String sourceType;
	private String CANo;
	private String loginLevel;
	private String timestamp; 
	private int userType;
	private String errorMsg;
	private String errorMsgC;
	
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getErrorMsgC() {
		return errorMsgC;
	}
	public void setErrorMsgC(String errorMsgC) {
		this.errorMsgC = errorMsgC;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}
	public String getCANo() {
		return CANo;
	}
	public void setCANo(String cANo) {
		CANo = cANo;
	}
	public String getLoginLevel() {
		return loginLevel;
	}
	public void setLoginLevel(String loginLevel) {
		this.loginLevel = loginLevel;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getLoginFrom() {
		return loginFrom;
	}
	public void setLoginFrom(String loginFrom) {
		this.loginFrom = loginFrom;
	}
	
}
