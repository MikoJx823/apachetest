package com.project.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.ProductBean;
import com.project.bean.ProductVariantBean;
import com.project.dao.OrderDao;
import com.project.dao.ProductDao;
import com.project.util.PropertiesUtil;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;


public class ProductService
{
	Logger log = Logger.getLogger(ProductService.class);

	private static ProductService instance = null;

	public static synchronized ProductService getInstance()
	{
		if (instance == null)
			instance = new ProductService();
		return instance;
	}

	private ProductDao productDao;
	private OrderDao orderDao;

	private ProductService(){
		productDao = ProductDao.getInstance();
		orderDao = OrderDao.getInstance();
	}
	
	public ProductBean insertProduct(ProductBean product){
		ProductBean result = null;
		if (productDao.insert(product) != null){
			for(ProductVariantBean variant: product.getProductVariant()){
				variant.setPid(product.getId());
				productDao.insertProductVariant(variant);
			}
			//product.setProductQty(productQtys);
		}
		log.info(product==null?"product is null":"product is not null");
		result = product;
		return  result;
	}
	
	public ProductBean updateProduct(ProductBean product){
		ProductBean result = null;
		log.info("variant size: " + product.getProductVariant().size());
		if (productDao.update(product) !=null){
			for(ProductVariantBean variant: product.getProductVariant()){
				variant.setPid(product.getId());
				productDao.updateProductVariant(variant);
			}
		}
		
		return  result;
	}
	
	public ProductBean delete(ProductBean product){
		ProductBean result = null;
		log.info("variant size: " + product.getProductVariant().size());
		if (productDao.update(product) !=null){
			for(ProductVariantBean variant: product.getProductVariant()){
				variant.setStatus(StaticValueUtil.Delete);
				productDao.updateProductVariant(variant);
			}
		}
		
		return  result;
	}
	
	public ProductBean getProductById(int pid){
		return productDao.getProductById(pid);
	}
	
	public ProductBean getFrontProductById(int pid){
		String sqlWhere = " where status = " + StaticValueUtil.Active + " and id = " + pid + 
						  " and displaystart < now() and displayend > now() ";
		
		List<ProductBean> products = productDao.getProductBySqlwhere(sqlWhere);
		
		if(products != null && products.size() == 1) {
			List<ProductVariantBean> variants = ProductService.getInstance().getProductVariantListById(pid);
			ProductBean product = products.get(0);
			product.setProductVariant(variants);
			
			return product;
		}else {
			return null;
		} 
	}
	
	public ProductBean getFrontBeanDetailById(int pid){
		String sqlWhere = " where status = " + StaticValueUtil.Active + " and id = " + pid + 
						  " and displaystart < now() and displayend > now() ";
		
		List<ProductBean> products = productDao.getProductBySqlwhere(sqlWhere);
		
		if(products != null && products.size() == 1) {
			List<ProductVariantBean> variants = ProductService.getInstance().getProductVariantListById(pid);
			ProductBean product = products.get(0);
			product.setProductVariant(variants);
			
			return product;
		}else {
			return null;
		} 
	}
	
	public List<ProductBean> getProductBySqlwhere(String sqlWhere){
		return productDao.getProductBySqlwhere(sqlWhere);
	}
	
	public List<ProductBean> getProductBySqlWhereWithPage(String sqlWhere,int pageIdx){
		return productDao.getProductBySqlWhereWithPage(sqlWhere,pageIdx);
	}
	
	public List<ProductBean> getProductFrontBySqlWhereWithPage(String sqlWhere,int pageIdx){
		List<ProductBean> products = productDao.getProductFrontBySqlWhereWithPage(sqlWhere,pageIdx);
		
		for(ProductBean product: products ) {
			List<ProductVariantBean> variant = productDao.getProductVariantListById(product.getId());
			if(variant.size() > 0) {
				List<ProductVariantBean> variants = new ArrayList<ProductVariantBean>();
				variants.add(variant.get(0));
				product.setProductVariant(variants);
			}
		}
		
		return products;
	}
	
	public ProductVariantBean getProductVariantByPvid(int pvid){
		return productDao.getProductVariantByPvid(pvid);
	}
	
	public List<ProductVariantBean> getProductVariantListById(int pid){
		return productDao.getProductVariantListById(pid);
	}
	
	//OTHERS 
	public List<Integer> getProductIdBySqlwhere(String sqlWhere){
		return productDao.getProductIdBySqlwhere(sqlWhere);
	}
	
	public int getTotalPages(int pageIdx, String sqlWhere){
		return productDao.getTotalPages(pageIdx, sqlWhere);
	}
	
	public int getFrontTotalPages(int pageIdx, String sqlWhere){
		return productDao.getFrontTotalPages(pageIdx, sqlWhere);
	}

	public int getTotalItems(String sqlWhere){
		return productDao.getTotalItems(sqlWhere);
	}
	
	public int getProductAvailableQuantity(int pvid){
		int proAllQty =  productDao.getProductAvailableQuantity(pvid);
		int orderholdingQty = orderDao.getHoldingProductQty(pvid);
		int result = proAllQty - orderholdingQty;
		
		log.info("pvid: " + pvid);
		log.info("All Qty : " + proAllQty);
		log.info("Holding : " + orderholdingQty);
		log.info("Available : " + result);
		return result;
	}
	
	public int getHoldProductQty(int pqid){
		return orderDao.getHoldingProductQty(pqid);
	}
	
	public int getSoldOutProductQty(int pqid){
		return orderDao.getSoldOutProductQty(pqid);
	}

	public double getEarlyBirdDiscount(ProductVariantBean variant) {
		Date now = new Date();
		
		if(variant.getEarlybirdend() != null && variant.getEarlybirdstart() != null && 
				variant.getEarlybirddiscount() > 0 && variant.getEarlybirddiscount() <= 100) {
			if(now.after(variant.getEarlybirdstart()) && now.before(variant.getEarlybirdend())) {
				return variant.getPrice() * (1 - variant.getEarlybirddiscount() / 100);
			}
		}
		
		return 0;
	}
	
	public int getCountActiveProdByCategory(String categoryInStr) {
		return productDao.getCountActiveProdByCategory(categoryInStr);
	}
	
	public double calShippping(double amount, String country) {
		double result = 0;
		//PropertiesUtil propUtil = new PropertiesUtil();
		
		if(country.equals("MY")) {
			//double shipping = ConfigService.getInstance().getBeanByName(StaticValueUtil.CONFIG_SHIPPING_FEE_LOCAL);//StringUtil.strToDouble(propUtil.getString("shipping", "shipping.fee.local"));
			//double min = StringUtil.strToDouble(propUtil.getString("shipping", "shipping.local.min.free"));
			result = StringUtil.strToDouble(ConfigService.getInstance().getBeanByName(StaticValueUtil.CONFIG_SHIPPING_FEE_LOCAL).getValue());
			double min = StringUtil.strToDouble(ConfigService.getInstance().getBeanByName(StaticValueUtil.CONFIG_SHIPPING_LIMIT_LOCAL).getValue());
		
			if(amount >= min) {
				return 0;
			}
		}else {
			result = StringUtil.strToDouble(ConfigService.getInstance().getBeanByName(StaticValueUtil.CONFIG_SHIPPING_FEE_OVERSEA).getValue());
		}
		
		return result;
	}
	
	public List<ProductBean> getProductOrderByPrice(int categoryId) {
		return productDao.getProductOrderByPrice(categoryId);
	}
	
}
