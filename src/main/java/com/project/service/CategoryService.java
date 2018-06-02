package com.project.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.CategoryBean;
import com.project.dao.CategoryDao;
import com.project.dao.ConectionFactory;
import com.project.dao.DbClose;
import com.project.dao.LoggableStatement;
import com.project.pulldown.CategoryTagPulldown;
import com.project.util.PropertiesUtil;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

public class CategoryService {
	
	Logger log = Logger.getLogger(CategoryService.class);
	
	private static CategoryService instance = null;
	private CategoryDao dao;
	
	private HashMap<Integer, CategoryBean> cachedCategory = null;
	
	public static synchronized CategoryService getInstance()
	{
		if (instance == null)
			instance = new CategoryService();
		return instance;
	}
	private CategoryService(){
		dao = CategoryDao.getInstance();
	}
	
	public CategoryBean insert(CategoryBean bean){
		return dao.insert(bean);
	}

	public CategoryBean update(CategoryBean category){
		return dao.update(category);
	}
	
	public CategoryBean delete(CategoryBean category){
		return dao.update(category);
	}
	
	public CategoryBean getBeanById(int id){
		return dao.getBeanById(id);
	}

	public List<CategoryBean> getListByParentId(int parentId) {
		String sqlWhere = " where status = " + StaticValueUtil.Active + " and " + 
						  "(parentid = " + parentId + " and parentid != " + StaticValueUtil.PARENT_CAT + ")"; 
	
		return dao.getListBySqlwhere(sqlWhere);
	}
	
	public List<CategoryBean> getParentList() {
		String sqlWhere = " where status = " + StaticValueUtil.Active + " and " + 
						  "(parentid = " + StaticValueUtil.PARENT_CAT + ")"; 
	
		return dao.getListBySqlwhere(sqlWhere);
	}
	
	public List<CategoryBean> getListBySqlwhere(String sqlWhere){
		return dao.getListBySqlwhere(sqlWhere);
	}
	
	public List<CategoryBean> getListBySqlwhereWithPage(String sqlWhere,int pageIdx){
		return dao.getListBySqlwhereWithPage(sqlWhere, pageIdx);
	}
	
	public List<CategoryBean> getFrontMenuBySqlwhere(String sqlWhere){
		return dao.getFrontMenuBySqlwhere(sqlWhere);
	}
	
	public int getTotalPages(int pageIdx,String sqlWhere){
		return dao.getTotalPages(pageIdx, sqlWhere);
	}
	
	public int getFrontCategoryBeanTotalPages(int pageIdx,String sqlWhere){
		return dao.getFrontCategoryBeanTotalPages(pageIdx, sqlWhere);
	}
	
	public String getParentSearchPulldown(String parentid){
		String result = "<option value=''>ALL</option>";
		
		if(parentid.equals("1")){
			result += "<option value='-1' selected >Parent Category Only</option>";
		}else {
			result += "<option value='-1'>Parent Category Only</option>";
		}
		
		String sqlWhere = " where parentid = " + StaticValueUtil.PARENT_CAT + " and status != " + StaticValueUtil.Delete + 
						  " order by name ";
		
		List<CategoryBean> list = getListBySqlwhere(sqlWhere);
		
		for(CategoryBean bean: list){
			if(String.valueOf(bean.getId()).equals(parentid)){
				result += "<option value='" + bean.getId() + "' selected >" + StringUtil.filter(bean.getName()) + "</option>";
			}else{
				result += "<option value='" + bean.getId() + "' >" + StringUtil.filter(bean.getName()) + "</option>";
			}
		}
		
		return result;
	}
	
	public String getParentSelectPulldown(int parentid){
		String result = "<option value=''>--- Please select ---</option>";
		
		String sqlWhere = " where parentid = " + StaticValueUtil.PARENT_CAT + " and status != " + StaticValueUtil.Delete + 
						  " order by name ";
		
		List<CategoryBean> list = getListBySqlwhere(sqlWhere);
		
		for(CategoryBean bean: list){
			if(bean.getId() == parentid){
				result += "<option value='" + bean.getId() + "' selected >" + StringUtil.filter(bean.getName()) + "</option>";
			}else{
				result += "<option value='" + bean.getId() + "' >" + StringUtil.filter(bean.getName()) + "</option>";
			}
		}
		
		return result;
	}
	
	public String getCategoryPulldown(int categoryid){
		String result = "<option value=''>--- Please select ---</option>";
		
		String sqlWhere = " where parentid = " + StaticValueUtil.PARENT_CAT + " and status != " + StaticValueUtil.Delete + 
						  " order by name ";
		
		List<CategoryBean> parents = getListBySqlwhere(sqlWhere);
		
		for(CategoryBean parent: parents ){
			result += "<option value='' disable>" + StringUtil.filter(parent.getName()) + "</option>";
			
			sqlWhere = " where parentid = " + parent.getId() + " and status != " + StaticValueUtil.Delete + 
					  " order by tag, name ";
			List<CategoryBean> subcats = getListBySqlwhere(sqlWhere);
			
			int currenttag = 0;
			for(CategoryBean subcat: subcats){
				
				if(currenttag != subcat.getTag() && subcat.getParentId() == 1){
					currenttag = subcat.getTag();
					result += "<option disable >&nbsp;&nbsp;" + StringUtil.filter(CategoryTagPulldown.getText(subcat.getTag())) + "</option>";
				}
				
				if(subcat.getId() == categoryid){
					result += "<option value='" + subcat.getId() + "' selected >&nbsp;&nbsp;&nbsp;" + StringUtil.filter(subcat.getName()) + "</option>";
				}else{
					result += "<option value='" + subcat.getId() + "' >&nbsp;&nbsp;&nbsp;" + StringUtil.filter(subcat.getName()) + "</option>";
				}
			}
		}
		
		
		return result;
	}
	
	public String getFrontCatFilter(int categoryid){
		String result = "";
		
		String basePath = StringUtil.getHostAddress(); 
		CategoryBean category = getBeanById(categoryid);
		
		
		if(category != null) {
			String sqlWhere = " where status = " + StaticValueUtil.Active;
					  		 
			if(category.getParentId() == StaticValueUtil.PARENT_CAT) {
				sqlWhere += " and parentid = " + category.getId();
			}else {
				sqlWhere += " and parentid = " + category.getParentId();
			}
			sqlWhere += " order by tag,name ";
			
			List<CategoryBean> categories = CategoryService.getInstance().getListBySqlwhere(sqlWhere);
			
			int tag = 0;
			String tagStr = "";
			String catStr = "";
			for(int i = 0; i < categories.size() ; i ++) {
				CategoryBean cat = categories.get(i);
				
				
				if(tag != cat.getTag() && cat.getParentId() == StaticValueUtil.CAT_MAKEUP) {
					tag = cat.getTag();
					tagStr = "<span>" + CategoryTagPulldown.getText(tag) + "</span>";
				}
				
				int count = ProductService.getInstance().getCountActiveProdByCategory(cat.getId() + "");
				
				catStr += "<li><a href=\""+ basePath + "products?categoryid=" + cat.getId() +"\">" + cat.getName() + "<span class=\"count\">(" + count + ")</span></a></li>";
				
				if(!tagStr.equals("")) {
					if(i + 1 == categories.size() || (i + 1 < categories.size() && categories.get(i + 1).getTag() != tag )) {
						tagStr += "<li><ul class=\"children\">" + catStr + "</ul></li>";
						result += tagStr;
						tag = 0;
						catStr = "";
					}
				}else {
					result += catStr;
					catStr = "";
				}
			}
			
			if(!result.equals("")) {
				result = "<ul>" + result + "</ul>";
			}
			
		}
		
		return result;
	}
}
