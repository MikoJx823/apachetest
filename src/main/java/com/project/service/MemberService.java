package com.project.service;

import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.MemberInfoBean;
import com.project.dao.MemberDao;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

public class MemberService {
	
	Logger log = Logger.getLogger(MemberService.class);

	private static MemberService instance = null;

	public static synchronized MemberService getInstance(){
		if (instance == null)
			instance = new MemberService();
		return instance;
	}

	private MemberDao dao;
	
	private MemberService(){
		dao = MemberDao.getInstance();
	}
	
	public MemberInfoBean insert(MemberInfoBean bean){
		return dao.insert(bean);
	}
	
	public MemberInfoBean update(MemberInfoBean bean){
		return dao.update(bean);
	}

	public MemberInfoBean getBeanById(int id) {
		return dao.getBeanById(id);
	}
	
	public MemberInfoBean getBeanByIdPassword(String loginid, String password) {
		return dao.getBeanByIdPassword(loginid, StringUtil.encryptString(password));
	}
	
	public List<MemberInfoBean> getListBySqlwhere(String sqlWhere){
		return dao.getListBySqlwhere(sqlWhere);
	}
	
	public List<MemberInfoBean> getListBySqlwhereWithPage(String sqlWhere,int pageIdx){
		return dao.getListBySqlwhereWithPage(sqlWhere, pageIdx);
	}
	
	public boolean delete(MemberInfoBean bean){
		return dao.delete(bean);
	}
	
	public int getTotalPages(int pageIdx,String sqlWhere){
		return dao.getTotalPages(pageIdx, sqlWhere);
	}
}
