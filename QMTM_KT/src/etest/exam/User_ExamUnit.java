package etest.exam;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
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
        sql.append("       a.id_exam_type, a.limittime, a.guide ");
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
            throw new QmTmException("개설되어진 시험정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_ExamUnit.getBean]");
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
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("개설되어진 시험정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_ExamUnit.makeBean]");
        }
    }
}
