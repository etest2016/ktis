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
	
    public static int getId_subject(String id_course, String userid) throws QmTmException
	{
    	Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(*) as subject_cnt ");
		sql.append("From t_worker_subj "); 
		sql.append("Where id_course = ? and id_subject = '-1' and userid = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
            stm.setString(2, userid);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("subject_cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("강좌 정보 읽어오는 중 오류가 발생되었습니다. [SubjectTmanUtil.getId_subject] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
    
    public static SubjectTmanBean[] getBeans(String id_course) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT id_subject, subject, subject_order, convert(varchar(10), regdate, 120) regdate, yn_valid, open_year, open_month ");
		sql.append("FROM c_subject ");
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
            throw new QmTmException("시험관리 과목 리스트 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
    
    public static SubjectTmanBean[] getBeans(String id_course, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT a.id_subject, a.subject, a.subject_order, ");
		sql.append("       convert(varchar(10), a.regdate, 120) regdate, ");
		sql.append("       a.yn_valid, a.open_year, a.open_month ");
		sql.append("FROM c_subject a, t_worker_subj b ");
		sql.append("WHERE a.id_course = ? and b.userid = ? and ");
		sql.append("      a.id_course = b.id_course and a.id_subject = b.id_subject ");
		sql.append("Order by a.subject_order ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
			stm.setString(2, userid);
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
            throw new QmTmException("시험관리 과목 리스트 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.getBeans] " + ex.getMessage());
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
			bean.setYn_valid(rst.getString(5));
			bean.setOpen_year(rst.getString(6));
			bean.setOpen_month(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 리스트 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.makeBeans] " + ex.getMessage());
        }
    }

	public static boolean getDownCnt(String id_course) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select id_subject as cnt ");
		sql.append("From c_subject ");
		sql.append("Where id_course = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 과목 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.getDownCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static boolean getDownCnt2(String id_course, String id_subject) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select title ");
		sql.append("From exam_m ");
		sql.append("Where id_course = ? and id_subject = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);
			stm.setString(2, id_subject);

            rst = stm.executeQuery();
            if (rst.next()) { return false; }
            else { return true; }
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 시험 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.getDownCnt2] " + ex.getMessage());
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

        sql.append("INSERT INTO c_subject (id_course, id_subject, subject, subject_order, regdate, yn_valid, open_year, open_month) ");
        sql.append("VALUES (?, ?, ?, ?, getdate(), ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_course());
			stm.setString(2, bean.getId_subject());
            stm.setString(3, bean.getSubject());
			stm.setInt(4, bean.getSubject_order());
			stm.setString(5, bean.getYn_valid());
			stm.setString(6, bean.getOpen_year());
			stm.setString(7, bean.getOpen_month());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 강좌 정보를 등록하는 중 오류가 발생되었습니다.[SubjectTmanUtil.insert] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void update(SubjectTmanBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE c_subject SET subject = ?, subject_order = ?, yn_valid = ?, open_year = ?, open_month = ? ");
        sql.append("WHERE id_course = ? and id_subject = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());            
            stm.setString(1, bean.getSubject());
			stm.setInt(2, bean.getSubject_order());
			stm.setString(3, bean.getYn_valid());
			stm.setString(4, bean.getOpen_year());
			stm.setString(5, bean.getOpen_month());
			stm.setString(6, bean.getId_course());
			stm.setString(7, bean.getId_subject());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("시험관리 강좌 정보를 수정하는 중 오류가 발생되었습니다.[SubjectTmanUtil.update] " + ex.getMessage());
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
            throw new QmTmException("시험관리 강좌 정보를 삭제하는 중 오류가 발생되었습니다.[SubjectTmanUtil.delete] " + ex.getMessage());
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

		sql.append("SELECT subject, subject_order, yn_valid, id_course, convert(varchar(16), regdate, 121) regdate, open_year, open_month ");
		sql.append("FROM c_subject ");
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
			throw new QmTmException("시험관리 강좌 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.getBean] " + ex.getMessage());
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
			bean.setOpen_year(rst.getString(6));
			bean.setOpen_month(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험관리 강좌 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.makeBean] " + ex.getMessage());
        }
    }

	public static int getOrderCnt(String id_course) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select isnull(max(subject_order),0) + 1 as order_cnt ");
		sql.append("From c_subject "); 
		sql.append("Where id_course = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("order_cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("강좌 정렬순서정보 읽어오는 중 오류가 발생되었습니다. [SubjectTmanUtil.getOrderCnt] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static SubjectTmanBean getLectureBean(String id_course, String id_subject) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_category, a.course, b.subject, b.open_year, b.open_month, ");
		sql.append("       b.exam_date, b.exam_start_hour, b.exam_start_minute, ");
		sql.append("       b.exam_end_hour, b.exam_end_minute, b.exam_time ");
		sql.append("FROM c_course a, c_subject b ");
		sql.append("WHERE a.id_course = ? and b.id_subject = ? and a.id_course = b.id_course ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
			stm.setString(2, id_subject);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeLectureBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("강좌 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.getLectureBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static SubjectTmanBean makeLectureBean (ResultSet rst) throws QmTmException
    {
		
		try {
            SubjectTmanBean bean = new SubjectTmanBean();
            bean.setId_category(rst.getString(1));
			bean.setCourse(rst.getString(2));
			bean.setSubject(rst.getString(3));
			bean.setOpen_year(rst.getString(4));
			bean.setOpen_month(rst.getString(5));
			bean.setExam_date(rst.getString(6));
			bean.setExam_start_hour(rst.getString(7));
			bean.setExam_start_minute(rst.getString(8));
			bean.setExam_end_hour(rst.getString(9));
			bean.setExam_end_minute(rst.getString(10));
			bean.setExam_time(rst.getString(11));
			return bean;
        } catch (SQLException ex) {
            throw new QmTmException("강좌 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.makeLectureBean] " + ex.getMessage());
        }
    }
	
	public static SubjectTmanBean getCourseBean(String id_course) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT id_category, course ");
		sql.append("FROM c_course ");
		sql.append("WHERE id_course = ? ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_course);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeCourseBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("과정 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.getCourseBean] " + ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static SubjectTmanBean makeCourseBean (ResultSet rst) throws QmTmException
    {
		
		try {
            SubjectTmanBean bean = new SubjectTmanBean();
            bean.setId_category(rst.getString(1));
			bean.setCourse(rst.getString(2));
			return bean;
        } catch (SQLException ex) {
            throw new QmTmException("과정 정보를 읽어오는 중 오류가 발생되었습니다.[SubjectTmanUtil.makeCourseBean] " + ex.getMessage());
        }
    }
}