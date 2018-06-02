package com.project.service;

import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.ConfigBean;
import com.project.dao.ConfigDao;

public class ConfigService {
	
	Logger log = Logger.getLogger(ConfigService.class);
	
	private static ConfigService instance = null;
	private ConfigDao dao;
	
	public static synchronized ConfigService getInstance()
	{
		if (instance == null)
			instance = new ConfigService();
		return instance;
	}
	private ConfigService(){
		dao = ConfigDao.getInstance();
	}
	
	public ConfigBean getBeanById(int id){
		return dao.getBeanById(id);
	}
	
	public ConfigBean getBeanByName(String name){
		return dao.getBeanByName(name);
	}
	
	public List<ConfigBean> getListBySqlwhere(String sqlWhere){
		return dao.getListBySqlwhere(sqlWhere);
	}
}
