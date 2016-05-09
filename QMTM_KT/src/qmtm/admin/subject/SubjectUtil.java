package qmtm.admin.subject;

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

public class SubjectUtil
{
    public SubjectUtil() {
    }
	
	public static void insert(SubjectBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO c_subject (id_course, id_subject, subject, subject_order, yn_valid) ");
        sql.append("VALUES (?, ?, ?, ?, ?) ");

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
			throw new QmTmException("시험관리 과목 정보 등록하는 중 인터넷 연결상태가 좋지 않습니다. [SubjectUtil.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void Update(SubjectBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE c_subject SET subject = ?, subject_order = ?, yn_valid = ? ");
        sql.append("WHERE id_subject = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getSubject());
			stm.setInt(2, bean.getSubject_order());
			stm.setString(3, bean.getYn_valid());
			stm.setString(4, bean.getId_subject());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [SubjectUtil.Update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }



	public static void delete(String id_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM C_SUBJECT Where id_subject = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_subject);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [SubjectUtil.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	//********************************************************************************
	//********************************************************************************
	//********************************************************************************


	public static SubjectBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT id_subject, subject, subject_order, to_char(regdate, 'yyyy-mm-dd hh24:mi') regdate FROM c_subject ");
		sql.append("WHERE id_course = ? ");
		sql.append("Order by subject_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
            rst = stm.executeQuery();
            SubjectBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (SubjectBean[]) beans.toArray(new SubjectBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [SubjectUtil.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static SubjectBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            SubjectBean bean = new SubjectBean();
            bean.setId_subject(rst.getString(1));
            bean.setSubject(rst.getString(2));
			bean.setSubject_order(rst.getInt(3));
            bean.setRegdate(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [SubjectUtil.makeBean]");
        }
    }

	public static int getCnt(String id_course) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select count(id_subject) as cnt from c_subject Where id_course = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_course);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [SubjectUtil.getCnt]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


	//---------------------------------------------------------
	//---------------------------------------------------------
	//---------------------------------------------------------
	//---------------------------------------------------------


	public static SubjectBean getBean(String id_subject) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT subject, subject_order, yn_valid, id_course FROM c_subject WHERE id_subject = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_subject);			
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBeans(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("[SubjectUtil.getBean]" + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static SubjectBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            SubjectBean bean = new SubjectBean();
            bean.setSubject(rst.getString(1));
			bean.setSubject_order(rst.getInt(2));
			bean.setYn_valid(rst.getString(3));
			bean.setId_course(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[SubjectUtil.makeBeans]" + ex.getMessage());
        }
    }

}