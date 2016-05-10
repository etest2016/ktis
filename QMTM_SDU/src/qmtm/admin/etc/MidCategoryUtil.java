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

public class MidCategoryUtil
{
    public MidCategoryUtil() {
    }
	
	public static void insert(MidCategoryBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO c_midcategory (id_midcategory, midcategory, yn_valid, orders, regdate, id_category) ");
        sql.append("VALUES (?, ?, 'Y', ?, getdate(), ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_midcategory());
            stm.setString(2, bean.getMidcategory());
			stm.setInt(3, bean.getOrders());
			stm.setString(4, bean.getId_category());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 등록하는 중 오류가 발생되었습니다. [MidCategoryUtil.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(MidCategoryBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE c_midcategory ");
		sql.append("       SET midcategory = ?, yn_valid = ?, orders = ?, id_category = ? ");
        sql.append("Where id_midcategory = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getMidcategory());
			stm.setString(2, bean.getYn_valid());
			stm.setInt(3, bean.getOrders());
			stm.setString(4, bean.getId_category());
			stm.setString(5, bean.getId_midcategory());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 수정하는 중 오류가 발생되었습니다. [MidCategoryUtil.update] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_midcategory) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM c_midcategory ");
		sql.append("Where id_midcategory = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_midcategory);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 삭제하는 중 오류가 발생되었습니다. [MidCategoryUtil.delete] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static MidCategoryBean getBean(String id_midcategory) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.midcategory, a.yn_valid, a.orders, Convert(varchar(10),a.regdate,120), a.id_category, b.category ");
		sql.append("From c_midcategory a, c_category b ");
		sql.append("Where a.id_midcategory = ? and a.id_category = b.id_category ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_midcategory);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidCategoryUtil.getBean] " +ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static MidCategoryBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            MidCategoryBean bean = new MidCategoryBean();
            bean.setMidcategory(rst.getString(1));
            bean.setYn_valid(rst.getString(2));
			bean.setOrders(rst.getInt(3));
			bean.setRegdate(rst.getString(4));
			bean.setId_category(rst.getString(5));
			bean.setCategory(rst.getString(6));
			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidCategoryUtil.makeBean] " +ex.getMessage());
        }
    }
	
	public static MidCategoryBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select a.id_category, a.category, b.id_midcategory, b.midcategory, b.yn_valid, b.orders, Convert(varchar(10),b.regdate,120) regdate ");
		sql.append("From c_category a, c_midcategory b ");
		sql.append("Where a.id_category = b.id_category ");
		sql.append("Order by a.category, b.midcategory ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            MidCategoryBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (MidCategoryBean[]) beans.toArray(new MidCategoryBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidCategoryUtil.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static MidCategoryBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            MidCategoryBean bean = new MidCategoryBean();
            bean.setId_category(rst.getString(1));
            bean.setCategory(rst.getString(2));
			bean.setId_midcategory(rst.getString(3));
            bean.setMidcategory(rst.getString(4));
            bean.setYn_valid(rst.getString(5));
			bean.setOrders(rst.getInt(6));
			bean.setRegdate(rst.getString(7));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidCategoryUtil.makeBeans] " +ex.getMessage());
        }
    }

	public static MidCategoryBean[] getSubCategory(String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_midcategory, midcategory ");
		sql.append("From c_midcategory ");
		sql.append("Where id_category = ? ");
		sql.append("Order by regdate ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);			
            rst = stm.executeQuery();
            MidCategoryBean bean = null;
            while (rst.next()) {
                bean = makeSubCategory(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (MidCategoryBean[]) beans.toArray(new MidCategoryBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidCategoryUtil.getSubCategory] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	private static MidCategoryBean makeSubCategory (ResultSet rst) throws QmTmException
    {
		
		try {
            MidCategoryBean bean = new MidCategoryBean();
           	bean.setId_midcategory(rst.getString(1));
            bean.setMidcategory(rst.getString(2));
           
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidCategoryUtil.makeSubCategory] " +ex.getMessage());
        }
    }

	public static int getCnt(String id_midcategory) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(id_course) as cnt ");
		sql.append("From c_course ");
		sql.append("Where id_category = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_midcategory);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("과정정보 존재여부 읽어오는 중 오류가 발생되었습니다. [MidCategoryUtil.getCnt] " +ex.getMessage());
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

		sql.append("Select id_midcategory ");
		sql.append("From c_midcategory ");
		sql.append("Where id_midcategory = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, input_code);

            rst = stm.executeQuery();
            if (rst.next()) { return "true"; }
            else { return "false"; }
        } catch (SQLException ex) {
            throw new QmTmException("소영역 코드 중복 체크작업 중 오류가 발생되었습니다. [MidCategoryUtil.getCodeChk] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

}