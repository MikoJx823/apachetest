package com.project.bean;

public class MsgAlertBean
{
	private Integer type;//1 show msg on the page ,2 js alert
	private String msg;
	private String focusId;
	
	
	public Integer getType()
	{
		return type;
	}
	public void setType(Integer type)
	{
		this.type = type;
	}
	public String getMsg()
	{
		return msg;
	}
	public void setMsg(String msg)
	{
		this.msg = msg;
	}
	public String getFocusId()
	{
		return focusId;
	}
	public void setFocusId(String focusId)
	{
		this.focusId = focusId;
	}
	
	
}
