package qmtm.admin;

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

public class TmanTree
{
    public TmanTree() {
    }
	
	public static TmanTreeBean[] getBeans(String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT id_course, course, yn_valid, convert(varchar(10), regdate, 120) regdate, years ");
		sql.append("FROM c_course ");
		sql.append("Where id_category = ? ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_category);
            rst = stm.executeQuery();
            TmanTreeBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TmanTreeBean[]) beans.toArray(new TmanTreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과정 리스트 정보를 읽어오는 중 오류가 발생되었습니다.[TmanTree.getBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static TmanTreeBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            TmanTreeBean bean = new TmanTreeBean();
            bean.setId_course(rst.getString(1));
            bean.setCourse(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
			bean.setYears(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과정 리스트 정보를 읽어오는 중 오류가 발생되었습니다.[TmanTree.makeBeans] " +ex.getMessage());
        }
    }
	
	public static TmanTreeBean getBean(String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT course, yn_valid, convert(varchar(10), regdate, 120) regdate FROM c_course WHERE id_course = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_course);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험관리 과정 정보를 읽어오는 중 오류가 발생되었습니다.[TmanTree.getBean] " +ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	} 

	private static TmanTreeBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            TmanTreeBean bean = new TmanTreeBean();
            bean.setCourse(rst.getString(1));
			bean.setYn_valid(rst.getString(2));
			bean.setRegdate(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과정 정보를 읽어오는 중 오류가 발생되었습니다.[TmanTree.makeBean] " +ex.getMessage());
        }
    }
	
	public static void insert(String id_course, String course, String years, String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO C_COURSE (id_course, course, yn_valid, regdate, id_category, years) ");
        sql.append("VALUES (?, ?, 'Y', getdate(), ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
            stm.setString(2, course);
			stm.setString(3, id_category);
			stm.setString(4, years);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과정 정보를 등록하는 중 오류가 발생되었습니다.[TmanTree.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(String id_course, String course, String yn_valid, String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update c_course Set course = ?, yn_valid = ?, id_category = ? ");
        sql.append("Where id_course = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, course);
            stm.setString(2, yn_valid);
			stm.setString(3, id_category);
			stm.setString(4, id_course);

			stm.execute();

			update2(id_course, id_category);
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과정 정보를 수정하는 중 오류가 발생되었습니다.[TmanTree.update] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update2(String id_course, String id_category) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Update q_subject Set id_category = ? ");
        sql.append("Where id_course = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_category);
			stm.setString(2, id_course);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과정 정보를 수정하는 중 오류가 발생되었습니다.[TmanTree.update2] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "Delete From c_course Where id_course = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_course);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과정 정보를 삭제하는 중 오류가 발생되었습니다.[TmanTree.delete] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static TmanTreeBean[] getAddBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_q_subject, q_subject ");
		sql.append("From q_subject ");
		sql.append("Where id_q_subject not in (Select q_subject From c_subject ");
		sql.append("                           Where id_course = ? ) and yn_valid = 'Y' ");
		sql.append("Order by regdate desc ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
            rst = stm.executeQuery();
            TmanTreeBean bean = null;
            while (rst.next()) {
                bean = makeAddBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (TmanTreeBean[]) beans.toArray(new TmanTreeBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("문제관리 과목 정보를 읽어오는 중 오류가 발생되었습니다.[TmanTree.getAddBeans] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static TmanTreeBean makeAddBeans (ResultSet rst) throws QmTmException
    {
		try {
            TmanTreeBean bean = new TmanTreeBean();
            bean.setId_subject(rst.getString(1));
            bean.setSubject(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제관리 과목 정보를 읽어오는 중 오류가 발생되었습니다.[TmanTree.makeAddBeans] " +ex.getMessage());
        }
    }

	public static void group_insert(String id_course, String id_subject, String q_subject, String subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO c_subject(id_course, id_subject, q_subject, subject, subject_order, regdate, yn_valid) ");
        sql.append("VALUES (?, ?, ?, ?, 1, getdate(), 'N') ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
            stm.setString(2, id_subject);
			stm.setString(3, q_subject);
			stm.setString(4, subject);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[TmanTree.group_insert]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}