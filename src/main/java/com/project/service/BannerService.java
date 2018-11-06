package com.project.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.BannerInfoBean;
import com.project.bean.CategoryBean;
import com.project.dao.BannerDao;
import com.project.util.StaticValueUtil;

public class BannerService {
	
	Logger log = Logger.getLogger(BannerService.class);

	private static BannerService instance = null;

	public static synchronized BannerService getInstance(){
		if (instance == null)
			instance = new BannerService();
		return instance;
	}

	private BannerDao dao;
	
	private BannerService(){
		dao = BannerDao.getInstance();
	}
	
	public BannerInfoBean insert(BannerInfoBean bean){
		return dao.insert(bean);
	}
	
	public BannerInfoBean update(BannerInfoBean bean){
		return dao.update(bean);
	}
	
	public boolean delete(BannerInfoBean bean){
		return dao.delete(bean);
	}
	
	public BannerInfoBean getBeanById(int id) {
		return dao.getBeanById(id);
	}
	
	public List<BannerInfoBean> getFrontListByPosition(int position){
		String sqlWhere = " where status = " + StaticValueUtil.Active + " and position = " + position + 
						  " order by seq";
		
		return dao.getListBySqlwhere(sqlWhere);
	}
	
	public List<BannerInfoBean> getListBySqlwhere(String sqlWhere){
		return dao.getListBySqlwhere(sqlWhere);
	}
	
	public List<BannerInfoBean> getListBySqlwhereWithPage(String sqlWhere,int pageIdx){
		return dao.getListBySqlwhereWithPage(sqlWhere, pageIdx);
	}
	
	public int getTotalPages(int pageIdx,String sqlWhere){
		return dao.getTotalPages(pageIdx, sqlWhere);
	}
	
	public int getTotalItems(String sqlWhere, String type){
		return dao.getTotalItems(sqlWhere, type);
	}
}
