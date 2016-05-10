package qmtm.admin.etc;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class CategoryUtil
{
    public CategoryUtil() {
    }
	
	public static void insert(CategoryBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO c_category (id_category, category, regdate, yn_valid) ");
        sql.append("VALUES (?, ?, getdate(),'Y') ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_category());
            stm.setString(2, bean.getCategory());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 등록하는 중 오류가 발생되었습니다. [CategoryUtil.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(CategoryBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE c_category ");
		sql.append("       SET category = ?, yn_valid = ? ");
        sql.append("Where id_category = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getCategory());
			stm.setString(2, bean.getYn_valid());
			stm.setString(3, bean.getId_category());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 수정하는 중 오류가 발생되었습니다. [CategoryUtil.update] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM c_category ");
		sql.append("Where id_category = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 삭제하는 중 오류가 발생되었습니다. [CategoryUtil.delete] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static CategoryBean getBean(String id_category) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT category, regdate, yn_valid FROM c_category WHERE id_category = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_category);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [CategoryUtil.getBean] " +ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static CategoryBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            CategoryBean bean = new CategoryBean();
            bean.setCategory(rst.getString(1));
            bean.setRegdate(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [CategoryUtil.makeBean] " +ex.getMessage());
        }
    }
	
	public static CategoryBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT id_category, category, Convert(varchar(10),regdate,120), yn_valid ");
		sql.append("FROM c_category ");
		sql.append("Order by category ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            CategoryBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (CategoryBean[]) beans.toArray(new CategoryBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [CategoryUtil.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static CategoryBean makeBeans (ResultSet rst) throws QmTmException
    {		
		try {
            CategoryBean bean = new CategoryBean();
            bean.setId_category(rst.getString(1));
            bean.setCategory(rst.getString(2));
            bean.setRegdate(rst.getString(3));
			bean.setYn_valid(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [CategoryUtil.makeBeans] " +ex.getMessage());
        }
    }

	public static CategoryBean[] getParentCategory() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT id_category, category ");
		sql.append("FROM c_category ");
		sql.append("Order by regdate ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            CategoryBean bean = null;
            while (rst.next()) {
                bean = makeParentCategory(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (CategoryBean[]) beans.toArray(new CategoryBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [CategoryUtil.getParentCategory] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static CategoryBean makeParentCategory (ResultSet rst) throws QmTmException
    {
		
		try {
            CategoryBean bean = new CategoryBean();
            bean.setId_category(rst.getString(1));
            bean.setCategory(rst.getString(2));
           
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [CategoryUtil.makeParentCategory] " +ex.getMessage());
        }
    }

	public static int getCnt(String id_category) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(id_category) as cnt ");
		sql.append("From c_midcategory ");
		sql.append("Where id_category = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_category);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("소영역정보 존재여부 읽어오는 중 오류가 발생되었습니다. [CategoryUtil.getCnt] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static String getCodeChk(String input_code) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_category ");
		sql.append("From c_category ");
		sql.append("Where id_category = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, input_code);

            rst = stm.executeQuery();
            if (rst.next()) { return "true"; }
            else { return "false"; }
        } catch (SQLException ex) {
            throw new QmTmException("대영역 코드 중복 체크작업 중 오류가 발생되었습니다. [CategoryUtil.getCodeChk] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

}