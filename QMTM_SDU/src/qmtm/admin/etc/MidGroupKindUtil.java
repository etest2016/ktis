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

public class MidGroupKindUtil
{
    public MidGroupKindUtil() {
    }
	
	public static void insert(MidGroupKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO c_midcategory (id_midcategory, midcategory, yn_valid, orders, regdate, id_category) ");
        sql.append("VALUES (?, ?, ?, ?, getdate(), ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_category());
            stm.setString(2, bean.getMidcategory());
			stm.setString(3, bean.getYn_valid());
			stm.setInt(4, bean.getOrders());
			stm.setString(5, bean.getId_category());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 등록하는 중 오류가 발생되었습니다. [MidGroupKindUtil.insert] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(MidGroupKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE c_midcategory SET midcategory = ?, yn_valid = ?, orders = ?, id_category = ? ");
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
            throw new QmTmException("카테고리구분 정보 수정하는 중 오류가 발생되었습니다. [MidGroupKindUtil.update] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM c_midcategory Where id_midcategory = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_category);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 삭제하는 중 오류가 발생되었습니다. [MidGroupKindUtil.delete] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static MidGroupKindBean[] getBeans(String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT a.id_midcategory, a.midcategory, Convert(varchar(16),a.regdate,120), a.yn_valid, a.orders, b.id_category, b.category ");
		sql.append("FROM c_midcategory a, c_category b ");
		sql.append("Where a.id_category = ? and a.id_category = b.id_category ");
		sql.append("Order by a.midcategory ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
            rst = stm.executeQuery();
            MidGroupKindBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (MidGroupKindBean[]) beans.toArray(new MidGroupKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidGroupKindUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static MidGroupKindBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            MidGroupKindBean bean = new MidGroupKindBean();
            bean.setId_midcategory(rst.getString(1));
            bean.setMidcategory(rst.getString(2));
            bean.setRegdate(rst.getString(3));
			bean.setYn_valid(rst.getString(4));
			bean.setOrders(rst.getInt(5));
			bean.setId_category(rst.getString(6));
			bean.setCategory(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidGroupKindUtil.makeBeans] " + ex.getMessage());
        }
    }

	public static MidGroupKindBean getBean(String id_midcategory) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.midcategory, Convert(varchar(16),a.regdate,120), a.yn_valid, a.a.orders, b.id_category, b.category ");
		sql.append("FROM c_midcategory a, c_category b ");
		sql.append("WHERE id_midcategory = ? and a.id_category = b.id_category ");

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
			throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidGroupKindUtil.getBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static MidGroupKindBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            MidGroupKindBean bean = new MidGroupKindBean();
            bean.setMidcategory(rst.getString(1));			
            bean.setRegdate(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
			bean.setOrders(rst.getInt(4));
			bean.setId_category(rst.getString(5));
			bean.setCategory(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [MidGroupKindUtil.makeBean] " + ex.getMessage());
        }
    }
		
}