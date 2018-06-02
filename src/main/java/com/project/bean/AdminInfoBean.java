package com.project.bean;

import java.util.Date;
import java.util.List;

public class AdminInfoBean
{
	private Integer aid;
	private Integer gid;
	private Integer bid;
	private String loginId;
	private String password;
	private String status;
	private String name;
	private String email;
	private String createdBy;
	private Date createdDate;
	private String updatedBy;
	private Date updatedDate;
	private Date lastLoginDate;
	
	private List<AdminGroupFunction> adminGroupFunction;
	
	public Integer getAid()
	{
		return aid;
	}
	public void setAid(Integer aid)
	{
		this.aid = aid;
	}
	public Integer getGid()
	{
		return gid;
	}
	public void setGid(Integer gid)
	{
		this.gid = gid;
	}
	
	
	
	public Integer getBid() {
		return bid;
	}
	public void setBid(Integer bid) {
		this.bid = bid;
	}
	public String getLoginId()
	{
		return loginId;
	}
	public void setLoginId(String loginId)
	{
		this.loginId = loginId;
	}
	public String getPassword()
	{
		return password;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getEmail()
	{
		return email;
	}
	public void setEmail(String email)
	{
		this.email = email;
	}
	public String getCreatedBy()
	{
		return createdBy;
	}
	public void setCreatedBy(String createdBy)
	{
		this.createdBy = createdBy;
	}
	public Date getCreatedDate()
	{
		return createdDate;
	}
	public void setCreatedDate(Date createdDate)
	{
		this.createdDate = createdDate;
	}
	public String getUpdatedBy()
	{
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy)
	{
		this.updatedBy = updatedBy;
	}
	public Date getUpdatedDate()
	{
		return updatedDate;
	}
	public void setUpdatedDate(Date updatedDate)
	{
		this.updatedDate = updatedDate;
	}
	public Date getLastLoginDate()
	{
		return lastLoginDate;
	}
	public void setLastLoginDate(Date lastLoginDate)
	{
		this.lastLoginDate = lastLoginDate;
	}
	public List<AdminGroupFunction> getAdminGroupFunction() {
		return adminGroupFunction;
	}
	public void setAdminGroupFunction(List<AdminGroupFunction> adminGroupFunction) {
		this.adminGroupFunction = adminGroupFunction;
	}
	
	
	
}
