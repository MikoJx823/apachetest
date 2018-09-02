package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.ProductBean;
import com.project.bean.ProductVariantBean;
import com.project.util.PropertiesUtil;
import com.project.util.StaticValueUtil;


/* Function :
 * Add - Product, ProductQty, ProductPrice, Product Branch
 * Edit - Product, ProductQty, ProductPrice, Product Branch
 * Get single record - getProductById, getProductQtyByPqid, getProductPriceByPpid
 * Get list - listAllProductforSale , getProductBySqlwhere, getProductBySqlWhereWithPage, getProductQtyById, getProductPriceById,
 * 			  getProductBranchByProductId, getProductForReport, getProductOrderByPrice
 * getProductAvailableQuantity, getTotalPages
 * */

public class ProductDao extends GenericDao
{
	private static Logger log = Logger.getLogger(ProductDao.class);

	private ProductDao()
	{
	}

	private static ProductDao instance = null;

	public static synchronized ProductDao getInstance()
	{
		if (instance == null)
			instance = new ProductDao();
		return instance;
	}
	
	public ProductBean insert(ProductBean product){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			Date now = new Date();
			product.setCreatedDate(now);
			conn = ConectionFactory.getConnection();
			sql = "insert into product(" +
					"categoryid, name, productcode, image1, image2, " + 
					"image3, image4, image5, displaystart, displayend, " + 
					"detail, shortdesc, additionaldesc, brandid, descyoutube, " +
					"descimage, listtext, " + 
					"status, createdby, createddate" + 
					") values (" +
					"?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?, ?,?,? " +
					")";
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			
			pstm.setInt(count, product.getCategoryid()); count++;
			pstm.setString(count, product.getName()); count++;
			pstm.setString(count, product.getProductcode()); count++;
			pstm.setString(count,product.getImage1()); count++;
			pstm.setString(count, product.getImage2()); count++;
			
			pstm.setString(count, product.getImage3()); count++;
			pstm.setString(count, product.getImage4()); count++;
			pstm.setString(count, product.getImage5()); count++;
			pstm.setTimestamp(count, getTimestamp(product.getDisplaystart())); count++;
			pstm.setTimestamp(count, getTimestamp(product.getDisplayend())); count++;
			
			pstm.setString(count, product.getDetail()); count++;
			pstm.setString(count, product.getShortdesc()); count++;
			pstm.setString(count, product.getAdditionaldesc()); count++;
			pstm.setInt(count, product.getBrandid()); count++;
			pstm.setString(count, product.getDescyoutube()); count++;
			
			pstm.setString(count, product.getDescimage()); count++;
			pstm.setString(count, product.getListtext()); count++;
			
			pstm.setInt(count, product.getStatus()); count++;
			pstm.setString(count, product.getCreatedBy()); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			//log.info("Executing SQL:" + sql);
			
			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			
			if (rs.next())
			{
				int pid = rs.getInt(1);
				product.setId(pid);

			}
			
		}
		catch (Exception e)
		{
			product = null;
			log.error(e);
		}
		finally
		{
			DbClose.closeAll(rs, pstm, conn);
		}
		return product;
	}

	public ProductBean update(ProductBean product){

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try{
			
			sql = "update product set " +
					"categoryid=?, name=?, productcode=?, image1=?, image2=?," + 
					"image3=?, image4=?, image5=?, displaystart=?, displayend=?, " + 
					"detail=?, shortdesc=?, additionaldesc=?, brandid=?, descyoutube=?," + 
					"descimage=?, listtext=?, " + 
					"status=?, modifiedby=?, modifieddate=?" + 
					"where id=?";
					
			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setInt(count, product.getCategoryid()); count++;
			pstm.setString(count, product.getName()); count++;
			pstm.setString(count, product.getProductcode()); count++;
			pstm.setString(count,product.getImage1()); count++;
			pstm.setString(count, product.getImage2()); count++;
			
			pstm.setString(count, product.getImage3()); count++;
			pstm.setString(count, product.getImage4()); count++;
			pstm.setString(count, product.getImage5()); count++;
			pstm.setTimestamp(count, getTimestamp(product.getDisplaystart())); count++;
			pstm.setTimestamp(count, getTimestamp(product.getDisplayend())); count++;
			
			pstm.setString(count, product.getDetail()); count++;
			pstm.setString(count, product.getShortdesc()); count++;
			pstm.setString(count, product.getAdditionaldesc()); count++;
			pstm.setInt(count, product.getBrandid()); count++;
			pstm.setString(count, product.getDescyoutube()); count++;
			
			pstm.setString(count, product.getDescimage()); count++;
			pstm.setString(count, product.getListtext()); count++;
			
			pstm.setInt(count, product.getStatus()); count++;
			pstm.setString(count, product.getModifiedBy()); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			
			pstm.setInt(count, product.getId()); count++;
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			//log.info("Executing SQL:" + sql);
				
			pstm.executeUpdate();

		}catch (Exception e){
			product = null;
			log.error(sql, e);
		}finally{
			DbClose.close(rs);
			DbClose.close(pstm);
			DbClose.close(conn);

		}
		return product;
	}
	
	public ProductBean updateStatus(ProductBean product){

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try{
			
			sql = "update product set " +
					"status=?, modifieddate=?, modifiedby=?" + 
					"where id=?";
					
			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setInt(count, product.getStatus()); count++;
			pstm.setString(count, product.getModifiedBy()); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			
			pstm.setInt(count, product.getId()); count++;
			//log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			//log.info("Executing SQL:" + sql);
				
			pstm.executeUpdate();

		}catch (Exception e){
			product = null;
			log.error(sql, e);
		}finally{
			DbClose.close(rs);
			DbClose.close(pstm);
			DbClose.close(conn);

		}
		return product;
	}
	
	public ProductBean getProductById(int pid){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ProductBean result = null;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from product where id=? and status != " + StaticValueUtil.Delete;
			pstmt = new LoggableStatement(conn, sql);
			pstmt.setInt(1, pid);

			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			rs = pstmt.executeQuery();
			List<ProductBean> resultlist = getProductFromResultSet(rs);

			if(resultlist.size()==1)
				result = resultlist.get(0);

		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}

	public List<ProductBean> listAllProductforSale()
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<ProductBean> result = new ArrayList<ProductBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from product " + "where status = " + StaticValueUtil.Active + " and displaystartdate < now()" + " and displayenddate > now()" + " order by id";
			pstmt = new LoggableStatement(conn, sql);
			
			rs = pstmt.executeQuery();
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			result = getProductFromResultSet(rs);
			//log.info("listAllProductforSale size:"+result.size());
			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public List<ProductBean> getProductBySqlwhere(String sqlWhere)
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<ProductBean> result = new ArrayList<ProductBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from product " + sqlWhere;
			pstmt = new LoggableStatement(conn, sql);
			
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			rs = pstmt.executeQuery();
			
			result = getProductFromResultSet(rs);
			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}

	public List<Integer> getProductIdBySqlwhere(String sqlWhere)
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Integer> result = new ArrayList<Integer>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select id from product " + sqlWhere;
			pstmt = new LoggableStatement(conn, sql);
			
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			rs = pstmt.executeQuery();
			
			while (rs != null && rs.next()){
				int id = rs.getInt("id");
				result.add(id);
			}
			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public List<ProductBean> getProductBySqlWhereWithPage(String sqlWhere,int pageIdx){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		List<ProductBean> result = new ArrayList<ProductBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from product " + sqlWhere+" order by id desc limit ?,? ";
			pstmt = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstmt.setInt(count, pagingRows * (pageIdx-1));
			count ++;
			pstmt.setInt(count, pagingRows);
			
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			rs = pstmt.executeQuery();
			
			result = getProductFromResultSet(rs);
			
			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public List<ProductBean> getProductFrontBySqlWhereWithPage(String sqlWhere, int pageIdx){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 12;
		List<ProductBean> result = new ArrayList<ProductBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			
			//pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front.web"));

			sql = "select * from product " + sqlWhere+" limit ?,?";
			pstmt = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstmt.setInt(count, pagingRows * (pageIdx-1)); count ++;
			pstmt.setInt(count, pagingRows);
			
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			rs = pstmt.executeQuery();
			
			result = getProductFromResultSet(rs);

			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public List<ProductBean> getFrontSearchBySqlWhereWithPage(String sqlWhere, int pageIdx){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 12;
		List<ProductBean> result = new ArrayList<ProductBean>();
		try{
			conn = ConectionFactory.getConnection();
			//pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front.web"));

			sql = "select * from product " + sqlWhere+" limit ?,?";
			pstmt = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstmt.setInt(count, pagingRows * (pageIdx-1)); count ++;
			pstmt.setInt(count, pagingRows);
			
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			rs = pstmt.executeQuery();
			
			result = getProductFromResultSet(rs);

			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}

	public List<ProductBean> getProductOrderByPrice(int categoryId){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<ProductBean>  result = null;

		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from product a inner join productprice b On (a.id = b.pid and a.categoryid=" + categoryId + ") where a.status ="+ StaticValueUtil.Active + "  and a.displaystartdate < now()" + " and a.displayenddate > now() order by price ";
			pstmt = new LoggableStatement(conn, sql);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			result = getProductFromResultSet(rs);

		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}

	//PRODUCT VARIANT RELATED 
	public ProductVariantBean insertProductVariant(ProductVariantBean variant){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try{

			conn = ConectionFactory.getConnection();
			sql = "insert into productvariant(" + 
					"pid, seq, name, quantity, price, " + 
					"discount, discountstart, discountend, " +
					"status, createddate, createdby" + 
					") values (" + 
					"?,?,?,?,?, ?,?,?, ?,?,? " +
					")";
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			
			pstm.setInt(count, variant.getPid());count++;
			pstm.setInt(count, variant.getSeq());count++;
			pstm.setString(count, variant.getName()); count++;
			pstm.setInt(count, variant.getQuantity());count++;
			pstm.setDouble(count, variant.getPrice()); count++;
			
			pstm.setDouble(count, variant.getDiscount()); count++;
			pstm.setTimestamp(count, getTimestamp(variant.getDiscountstart())); count++;
			pstm.setTimestamp(count, getTimestamp(variant.getDiscountend())); count++;
			
			pstm.setInt(count, variant.getStatus());count++;
			pstm.setTimestamp(count, getTimestamp(new Date()));count++;
			pstm.setString(count, variant.getCreatedBy());count++;
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			//log.info("Executing SQL:" + sql);
			
			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			
			if (rs.next())
			{
				int pqid = rs.getInt(1);
				variant.setPvid(pqid);
			}
			
		}
		catch (Exception e)
		{
			variant = null;
			log.error(e);
		}
		finally
		{
			DbClose.closeAll(rs, pstm, conn);
		}
		return variant;
	}

	public ProductVariantBean updateProductVariant(ProductVariantBean variant){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try{
			conn = ConectionFactory.getConnection();
			sql = "update productvariant set " + 
					"pid=?, seq=?, name=?, quantity=?, price=?,"+
					"discount=?, discountstart=?, discountend=?, " +
					"status=?, modifieddate=?,modifiedby=? " +
					"where pvid=?";
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			
			pstm.setInt(count, variant.getPid());count++;
			pstm.setInt(count, variant.getSeq());count++;
			pstm.setString(count, variant.getName()); count++;
			pstm.setInt(count, variant.getQuantity());count++;
			pstm.setDouble(count, variant.getPrice()); count++;
			
			pstm.setDouble(count, variant.getDiscount()); count++;
			pstm.setTimestamp(count, getTimestamp(variant.getDiscountstart())); count++;
			pstm.setTimestamp(count, getTimestamp(variant.getDiscountend())); count++;
			
			pstm.setInt(count, variant.getStatus());count++;
			pstm.setTimestamp(count, getTimestamp(new Date()));count++;
			pstm.setString(count, variant.getCreatedBy());count++;
			
			pstm.setInt(count, variant.getPvid());
			
			log.info("SQL TEST : " +  ((LoggableStatement) pstm).getQueryString());
			//log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			//log.info("Executing SQL:" + sql);
			
			pstm.executeUpdate();
		}
		catch (Exception e)
		{
			variant = null;
			log.error(e);
			e.printStackTrace();
		}
		finally
		{
			DbClose.closeAll(rs, pstm, conn);
		}
		return variant;
	}
	
	public ProductVariantBean getProductVariantByPvid(int pvid){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		ProductVariantBean result = null;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from productvariant where pvid=?";
			pstmt = new LoggableStatement(conn, sql);
			pstmt.setInt(1, pvid);
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			List<ProductVariantBean>  resultlist = getProductVariantFromResultSet(rs);
			
			if(resultlist.size()==1)
				result = resultlist.get(0);
			
			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}

	public List<ProductVariantBean>  getProductVariantListById(Integer pid){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<ProductVariantBean>  result = null;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from productvariant where pid=? and status =? ";
			pstmt = new LoggableStatement(conn, sql);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, StaticValueUtil.Active);
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			result = getProductVariantFromResultSet(rs);
			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	//OTHERS 
	public int getProductAvailableQuantity(int pvid)
	{
		String sqlcmd = "select quantity from productvariant where pvid="+pvid;
		
		return queryForInt(sqlcmd);
	}
	
	public int getTotalPages(int pageIdx,String sqlWhere){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 15;
		try
		{
			conn = ConectionFactory.getConnection();
			//pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows"));
			
			sql = "select count(*) as count from product "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				result = rs.getInt("count");
				
				if (result % pagingRows == 0)
				{
					result = result / pagingRows;
				}
				else
				{
					result = result / pagingRows + 1;
				}
			}
		}
		catch (Exception e)
		{
			log.error(pstmt, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}
		return result;
	}
	
	public int getFrontTotalPages(int pageIdx,String sqlWhere){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 9;
		try
		{
			conn = ConectionFactory.getConnection();
			//pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front.web"));
			
			sql = "select count(*) as count from product "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			//log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				result = rs.getInt("count");
				
				if (result % pagingRows == 0)
				{
					result = result / pagingRows;
				}
				else
				{
					result = result / pagingRows + 1;
				}
			}
		}
		catch (Exception e)
		{
			log.error(pstmt, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}
		return result;
	}
	
	public int getTotalItems(String sqlWhere){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			conn = ConectionFactory.getConnection();
			
			sql = "select count(*) as count from product "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			//log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next()){
				result = rs.getInt("count");
			}
		}
		catch (Exception e)
		{
			log.error(pstmt, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}
		return result;
	}
	
	public int getCountActiveProdByCategory(String categoryid){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			conn = ConectionFactory.getConnection();
			
			sql = "select count(id) as count from product where categoryid in (" + categoryid + ") " +
				  "and status = " + StaticValueUtil.Active ;//+ " and displaystart < now() and displayend > now()";
			pstmt = new LoggableStatement(conn, sql);	
			
			log.info("Executing SQL: " +  ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next()){
				result = rs.getInt("count");
			}
		}
		catch (Exception e)
		{
			log.error(pstmt, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}
		
		return result;
	}
	
	private List<ProductBean> getProductFromResultSet(ResultSet rs) throws Exception{
		List<ProductBean> result = new ArrayList<ProductBean>();
		while (rs != null && rs.next())
		{
			ProductBean product = new ProductBean();
			product.setId(rs.getInt("id"));
			product.setCategoryid(rs.getInt("categoryid"));
			product.setName(rs.getString("name"));
			product.setProductcode(rs.getString("productcode"));
			product.setImage1(rs.getString("image1"));
			
			product.setImage2(rs.getString("image2"));
			product.setImage3(rs.getString("image3"));
			product.setImage4(rs.getString("image4"));
			product.setImage5(rs.getString("image5"));
			product.setDisplaystart(rs.getTimestamp("displaystart"));
			
			product.setDisplayend(rs.getTimestamp("displayend"));
			product.setDetail(rs.getString("detail"));
			product.setShortdesc(rs.getString("shortdesc"));
			product.setAdditionaldesc(rs.getString("additionaldesc"));
			product.setBrandid(rs.getInt("brandid"));
			
			product.setDescimage(rs.getString("descimage"));
			product.setDescyoutube(rs.getString("descyoutube"));
			product.setListtext(rs.getString("listtext"));
			
			product.setStatus(rs.getInt("status"));
			product.setCreatedDate(rs.getTimestamp("createddate"));
			product.setCreatedBy(rs.getString("createdby"));
			product.setModifiedDate(rs.getTimestamp("modifieddate"));
			product.setModifiedBy(rs.getString("modifiedby"));
			
			result.add(product);
		}
		return result;

	}
	
	private List<ProductVariantBean> getProductVariantFromResultSet(ResultSet rs) throws Exception{
		List<ProductVariantBean> result = new ArrayList<ProductVariantBean>();
		while (rs != null && rs.next())
		{
			ProductVariantBean bean = new ProductVariantBean();
			bean.setPvid(rs.getInt("pvid"));
			bean.setPid(rs.getInt("pid"));
			bean.setSeq(rs.getInt("seq"));
			bean.setName(rs.getString("name"));
			bean.setQuantity(rs.getInt("quantity"));
			
			bean.setPrice(rs.getDouble("price"));
			bean.setDiscount(rs.getDouble("discount"));
			bean.setDiscountstart(rs.getTimestamp("discountstart"));
			bean.setDiscountend(rs.getTimestamp("discountend"));
			
			bean.setStatus(rs.getInt("status"));
			bean.setCreatedDate(rs.getTimestamp("createddate"));
			bean.setCreatedBy(rs.getString("createdby"));
			bean.setModifiedDate(rs.getTimestamp("modifieddate"));
			bean.setModifiedBy(rs.getString("modifiedby"));
			
			result.add(bean);
		}
		return result;
	}
	
}
