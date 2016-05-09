package qmtm.admin.course;

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

public class CourseUtil
{
    public CourseUtil() {
    }
	
	public static void insert(CourseBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO C_COURSE (id_course, course, yn_valid) ");
        sql.append("VALUES (?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_course());
            stm.setString(2, bean.getCourse());
			stm.setString(3, bean.getYn_valid());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과정 등록작업 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(String id_course, String course, String yn_valid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE C_COURSE SET course = ?, yn_valid = ? ");
        sql.append("Where id_course = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, course);
            stm.setString(2, yn_valid);
			stm.setString(3, id_course);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과정 수정작업 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void delete(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "DELETE FROM C_COURSE Where id_course = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_course);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("과정 삭제작업 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static int getSubCnt(String id_course) throws QmTmException
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
            throw new QmTmException("과정 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static CourseBean[] getBeans() throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "SELECT id_course, course, yn_valid, convert(varchar(16), regdate, 120) regdate FROM c_course ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();
            CourseBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (CourseBean[]) beans.toArray(new CourseBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("과정 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static CourseBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            CourseBean bean = new CourseBean();
            bean.setId_course(rst.getString(1));
            bean.setCourse(rst.getString(2));
			bean.setYn_valid(rst.getString(3));
            bean.setRegdate(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과정 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }

	public static CourseBean getBean(String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "SELECT course, yn_valid FROM c_course WHERE id_course = ? ";

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
			throw new QmTmException("과정 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static CourseBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
            CourseBean bean = new CourseBean();
            bean.setCourse(rst.getString(1));
			bean.setYn_valid(rst.getString(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과정 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다.");
        }
    }
}