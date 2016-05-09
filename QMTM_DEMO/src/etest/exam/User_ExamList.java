package etest.exam;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class User_ExamList
{
    public User_ExamList() {}

    public static User_ExamListBean[] getBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.exam_start1, a.exam_end1, c.course ");
		sql.append("FROM exam_m a, qt_course_user b, c_course c ");
		sql.append("WHERE b.userid = ? AND b.yn_valid = 'Y' AND b.id_course = a.id_course ");
		sql.append("       AND b.course_year = a.course_year AND b.course_no = a.course_no ");
		sql.append("       AND a.id_auth_type = '1' AND a.id_course = c.id_course AND a.yn_enable = 'Y' ");
		sql.append("UNION ALL ");
		sql.append("SELECT a.id_exam, a.title, a.exam_start1, a.exam_end1, c.course ");
		sql.append("FROM exam_receipt b, exam_m a, c_course c ");
		sql.append("WHERE b.userid = ? AND b.yn_pay = 'Y' AND b.id_exam = a.id_exam AND ");
		sql.append("      a.id_auth_type = '2' AND a.id_course = c.id_course AND a.yn_enable = 'Y' ");
		sql.append("UNION ALL ");
		sql.append("SELECT a.id_exam, a.title, a.exam_start1, a.exam_end1, b.course ");
		sql.append("FROM exam_m a, c_course b ");
		sql.append("WHERE a.id_auth_type = '0' AND a.yn_enable = 'Y' ");
		sql.append("       AND a.id_course = b.id_course AND a.yn_enable = 'Y' ");
		sql.append("ORDER BY 3 DESC, 4 DESC "); // 3:exam_start1, 4:exam_end1
        
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            stm.setString(2, userid);
            rst = stm.executeQuery();
            User_ExamListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (User_ExamListBean[]) beans.toArray(new User_ExamListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("개설되어진 시험정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_ExamList.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static User_ExamListBean makeBeans (ResultSet rst) throws QmTmException
    {
        try {
            User_ExamListBean bean = new User_ExamListBean();
            bean.setId_exam(rst.getString(1));
            bean.setTitle(rst.getString(2));
            bean.setExam_start(rst.getTimestamp(3));
            bean.setExam_end(rst.getTimestamp(4));
            bean.setCourse(rst.getString(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("개설되어진 시험정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_ExamList.makeBeans]");
        }
    }
}
