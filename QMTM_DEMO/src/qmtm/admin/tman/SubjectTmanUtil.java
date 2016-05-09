package qmtm.admin.tman;

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

public class SubjectTmanUtil
{
    public SubjectTmanUtil() {
    }
	
	public static SubjectTmanBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		//sql.append("SELECT id_subject, subject, subject_order, convert(varchar(10), regdate, 120) regdate FROM c_subject ");
		sql.append("SELECT id_subject, subject, subject_order, to_char(regdate, 'YYYY-MM-DD') regdate FROM c_subject ");
		sql.append("WHERE id_course = ? ");
		sql.append("Order by subject_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
            rst = stm.executeQuery();
            SubjectTmanBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (SubjectTmanBean[]) beans.toArray(new SubjectTmanBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 리스트 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.[SubjectTman.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static SubjectTmanBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            SubjectTmanBean bean = new SubjectTmanBean();
            bean.setId_subject(rst.getString(1));
            bean.setSubject(rst.getString(2));
			bean.setSubject_order(rst.getInt(3));
            bean.setRegdate(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 리스트 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.[SubjectTman.makeBeans]");
        }
    }

	public static boolean getDownCnt(String id_course) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select id_subject as cnt from c_subject Where id_course = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_course);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.[SubjectTman.getDownCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownCnt2(String id_course, String id_subject) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select title from exam_m Where id_course = ? and id_subject = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_course);
			stm.setString(2, id_subject);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 시험 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.[SubjectTman.getDownCnt2]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void insert(SubjectTmanBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO c_subject (id_course, id_subject, q_subject, subject, subject_order, yn_valid) ");
        sql.append("VALUES (?, ?, '-1', ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_course());
			stm.setString(2, bean.getId_subject());
            stm.setString(3, bean.getSubject());
			stm.setInt(4, bean.getSubject_order());
			stm.setString(5, bean.getYn_valid());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException(ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(String id_course, String id_subject, String subject, String yn_valid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE c_subject SET subject = ?, yn_valid = ? ");
        sql.append("WHERE id_course = ? and id_subject = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, subject);
			stm.setString(2, yn_valid);
			stm.setString(3, id_course);
			stm.setString(4, id_subject);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보를 수정하는 중 인터넷 연결상태가 좋지 않습니다.[SubjectTman.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_course, String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM C_SUBJECT ");
        sql.append("Where id_course = ? and id_subject = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
			stm.setString(2, id_subject);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보를 삭제하는 중 인터넷 연결상태가 좋지 않습니다.[SubjectTman.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static SubjectTmanBean getBean(String id_course, String id_subject) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		//sql.append("SELECT subject, subject_order, yn_valid, id_course, convert(varchar(16), regdate, 121) regdate FROM c_subject ");
		sql.append("SELECT subject, subject_order, yn_valid, id_course, to_char(regdate, 'YYYY-MM-DD HH24:MI') regdate FROM c_subject ");
		sql.append("WHERE id_course = ? and id_subject = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
			stm.setString(2, id_subject);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험관리 과목 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.[SubjectTman.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static SubjectTmanBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            SubjectTmanBean bean = new SubjectTmanBean();
            bean.setSubject(rst.getString(1));
			bean.setSubject_order(rst.getInt(2));
			bean.setYn_valid(rst.getString(3));
			bean.setId_course(rst.getString(4));
			bean.setRegdate(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다.[SubjectTman.makeBean]");
        }
    }
}