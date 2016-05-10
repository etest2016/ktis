package etest.exam;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.PreparedStatement;

// for exam/etst.jsp

public class User_ExamUnit
{
    public User_ExamUnit() {}

    public static User_ExamUnitBean getBean(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT a.title, b.course, a.exam_start1, a.exam_end1, ");
        sql.append("       a.id_exam_type, a.limittime, a.guide, a.exam_pwd_yn, a.web_window_mode, a.yn_sametime ");
        sql.append("FROM exam_m a, c_course b ");
        sql.append("WHERE a.id_exam = ? AND a.id_course = b.id_course ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return makeBean(rst); }
            else { return null; }
        }
        catch (SQLException ex) {
            throw new QmTmException("개설되어진 시험정보를 읽어오는 중 오류가 발생되었습니다. [User_ExamUnit.getBean] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static User_ExamUnitBean getPersonalBean(String id_exam, Timestamp exam_start1, Timestamp exam_end1, String yn_sametimes) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("SELECT a.title, b.course, ?, ?, ");
        sql.append("       a.id_exam_type, a.limittime, a.guide, a.exam_pwd_yn, a.web_window_mode, ? ");
        sql.append("FROM exam_m a, c_course b ");
        sql.append("WHERE a.id_exam = ? AND a.id_course = b.id_course ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setTimestamp(1, exam_start1);
			stm.setTimestamp(2, exam_end1);
			stm.setString(3, yn_sametimes);
			stm.setString(4, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return makeBean(rst); }
            else { return null; }
        }
        catch (SQLException ex) {
            throw new QmTmException("개설되어진 시험정보를 읽어오는 중 오류가 발생되었습니다. [User_ExamUnit.getPersonalBean] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static User_ExamUnitBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            User_ExamUnitBean bean = new User_ExamUnitBean();
            bean.setTitle(rst.getString(1));
            bean.setCourse(rst.getString(2));
            bean.setExam_start(rst.getTimestamp(3));
            bean.setExam_end(rst.getTimestamp(4));
            bean.setId_exam_type(rst.getString(5));
            bean.setLimitTime(rst.getLong(6));
            bean.setGuide(rst.getString(7));
            bean.setExam_pwd_yn(rst.getString(8));
            bean.setWeb_window_mode(rst.getInt(9));
            bean.setYn_sametime(rst.getString(10));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("개설되어진 시험정보를 읽어오는 중 오류가 발생되었습니다. [User_ExamUnit.makeBean] " +ex.getMessage());
        }
    }
}
