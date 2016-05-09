package qmtm.admin;

// Package Import
import qmtm.*; 
import qmtm.admin.qman.*; 

// Java API Import
import java.sql.*;
import java.util.*;

public class QmanTree
{
    public QmanTree() {
    }
	
	public static void insert(String id_category, String id_q_subject, String q_subject, String years, String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
        StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO q_subject (id_q_subject, q_subject, yn_valid, regdate, id_category, years, id_course) ");
        sql.append("VALUES (?, ?, 'Y', getdate(), ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_q_subject);
            stm.setString(2, q_subject);
			stm.setString(3, id_category);
			stm.setString(4, years);
			stm.setString(5, id_course);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[QmanTree.insert]" + ex.getMessage());
        }
        finally { 
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(String id_q_subject, String q_subject, String yn_valid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "UPDATE q_subject SET q_subject = ?, yn_valid = ? Where id_q_subject = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, q_subject);
			stm.setString(2, yn_valid);
			stm.setString(3, id_q_subject);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[QmanTree.update]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_q_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM q_subject Where id_q_subject = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_subject);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[QmanTree.delete]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getSubCnt(String id_q_subject) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select count(id_q_subject) as cnt from q_chapter Where id_q_subject = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_subject);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("[QmanTree.getSubCnt]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownCnt(String id_q_subject) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select id_q_chapter as cnt from q_chapter Where id_q_subject = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_q_subject);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("[QmanTree.getDownCnt]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static QmanTreeBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT id_q_subject, q_subject, yn_valid, convert(varchar(16), regdate, 120) regdate, id_category, years ");
		sql.append("FROM q_subject ");
		sql.append("Where id_course = ? ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);

            rst = stm.executeQuery();
            QmanTreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QmanTreeBean[]) beans.toArray(new QmanTreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[QmanTree.getBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static QmanTreeBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            QmanTreeBean bean = new QmanTreeBean();
            bean.setId_q_subject(rst.getString(1));
            bean.setQ_subject(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
			bean.setId_category(rst.getString(5));
			bean.setYears(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[QmanTree.makeBeans]" + ex.getMessage());
        }
    }

	public static QmanTreeBean getBean(String id_q_subject) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT q_subject, yn_valid, convert(varchar(16), regdate, 120) regdate, id_category, years FROM q_subject WHERE id_q_subject = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_subject);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("[QmanTree.getBean]" + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	public static QmanTreeBean getBean_2(String id_q_subject) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();
		sql.append("SELECT a.q_subject, a.yn_valid, convert(varchar(16), a.regdate, 120) regdate, a.id_category, b.category ");
		sql.append("FROM q_subject a, c_category b ");
		sql.append("WHERE a.id_q_subject = ? and a.id_category = b.id_category ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q_subject);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean_2(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("[QmanTree.getBean_2]" + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static QmanTreeBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            QmanTreeBean bean = new QmanTreeBean();
            bean.setQ_subject(rst.getString(1));
			bean.setYn_valid(rst.getString(2));
			bean.setRegdate(rst.getString(3));
			bean.setId_category(rst.getString(4));
			bean.setYears(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[QmanTree.makeBean]" + ex.getMessage());
        }
    }

	private static QmanTreeBean makeBean_2 (ResultSet rst) throws QmTmException
    {
		
		try {
            QmanTreeBean bean = new QmanTreeBean();
            bean.setQ_subject(rst.getString(1));
			bean.setYn_valid(rst.getString(2));
			bean.setRegdate(rst.getString(3));
			bean.setId_category(rst.getString(4));
			bean.setCategory(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[QmanTree.makeBean_2]" + ex.getMessage());
        }
    }

	public static QmanTreeBean[] getBeans2(String id_q_subject) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT id_q_chapter, chapter FROM q_chapter WHERE id_q_subject = ? ";

		try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_subject);			
            rst = stm.executeQuery();
            QmanTreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans2(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QmanTreeBean[]) beans.toArray(new QmanTreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[QmanTree.getBeans2]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static QmanTreeBean makeBeans2 (ResultSet rst) throws QmTmException
    {
		
		try {
            QmanTreeBean bean = new QmanTreeBean();
            bean.setId_q_chapter(rst.getString(1));
			bean.setChapter(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[QmanTree.makeBeans2]" + ex.getMessage());
        }
    }

}