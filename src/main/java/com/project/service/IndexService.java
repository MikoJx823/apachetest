package com.project.service;

import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.IndexInfoBean;
import com.project.dao.IndexDao;
import com.project.util.StaticValueUtil;

public class IndexService {
	
	Logger log = Logger.getLogger(IndexService.class);
	
	private static IndexService instance = null;
	private IndexDao dao;
	
	public static synchronized IndexService getInstance()
	{
		if (instance == null)
			instance = new IndexService();
		return instance;
	}
	private IndexService(){
		dao = IndexDao.getInstance();
	}
	
	public IndexInfoBean insert(IndexInfoBean bean){
		return dao.insert(bean);
	}
	
	public IndexInfoBean update(IndexInfoBean bean){
		return dao.update(bean);
	}
	
	public IndexInfoBean getBeanById(int id){
		return dao.getBeanById(id);
	}
	
	public List<IndexInfoBean> getListBySqlwhere(String sqlWhere){
		return dao.getListBySqlwhere(sqlWhere);
	}
	
	public List<IndexInfoBean> getListBySqlwhereWithPage(String sqlWhere,int pageIdx){
		return dao.getListBySqlwhereWithPage(sqlWhere, pageIdx);
	}
	
	public int getTotalPages(int pageIdx,String sqlWhere) {
		return dao.getTotalPages(pageIdx, sqlWhere);
	}
}
