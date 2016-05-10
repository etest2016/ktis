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

public class GroupKindUtil
{
    public GroupKindUtil() {
    }
	
	public static void insert(GroupKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO c_category (id_category, category, regdate, yn_valid) ");
        sql.append("VALUES (?, ?, getdate(), ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_category());
            stm.setString(2, bean.getCategory());
			stm.setString(3, bean.getYn_valid());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 등록하는 중 오류가 발생되었습니다. [GroupKindUtil.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(GroupKindBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE c_category SET category = ?, yn_valid = ? ");
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
            throw new QmTmException("카테고리구분 정보 수정하는 중 오류가 발생되었습니다. [GroupKindUtil.update] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM c_category Where id_category = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_category);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 삭제하는 중 오류가 발생되었습니다. [GroupKindUtil.delete] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static GroupKindBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select id_category, category, Convert(varchar(16),regdate,120) regdate, yn_valid ");
		sql.append("From c_category ");
		sql.append("Where yn_valid = 'Y' ");
		sql.append("Order by id_category desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            rst = stm.executeQuery();
            GroupKindBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (GroupKindBean[]) beans.toArray(new GroupKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [GroupKindUtil.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static GroupKindBean[] getBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Select distinct a.id_category, a.category, Convert(varchar(16),a.regdate,120) regdate, a.yn_valid ");
		sql.append("From c_category a, c_midcategory b, c_course c, t_worker_subj d ");
		sql.append("Where d.userid = ? and a.yn_valid = 'Y' and b.yn_valid = 'Y' and c.yn_valid = 'Y' and ");
		sql.append("      a.id_category = b.id_category and b.id_midcategory = c.id_category and c.id_course = d.id_course ");
		sql.append("Order by a.id_category desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
            rst = stm.executeQuery();
            GroupKindBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (GroupKindBean[]) beans.toArray(new GroupKindBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [GroupKindUtil.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
		
    private static GroupKindBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            GroupKindBean bean = new GroupKindBean();
            bean.setId_category(rst.getString(1));
            bean.setCategory(rst.getString(2));
            bean.setRegdate(rst.getString(3));
			bean.setYn_valid(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [GroupKindUtil.makeBeans] " +ex.getMessage());
        }
    }

	public static GroupKindBean getBean(String id_category) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT category, Convert(varchar(16),regdate,120), yn_valid ");
		sql.append("FROM c_category ");
		sql.append("WHERE id_category = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [GroupKindUtil.getBean] " +ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static GroupKindBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            GroupKindBean bean = new GroupKindBean();
            bean.setCategory(rst.getString(1));
            bean.setRegdate(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("카테고리구분 정보 읽어오는 중 오류가 발생되었습니다. [GroupKindUtil.makeBean] " +ex.getMessage());
        }
    }
		
}