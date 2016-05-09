package etest.score;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class User_ScoreList
{
    public User_ScoreList() {}

    public static User_ScoreListBean[] getBeans(String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT a.id_exam, a.title, a.yn_sametime, a.stat_start, a.stat_end, ");
        sql.append("       a.yn_open_score_direct, a.yn_open_qa, c.course, a.yn_stat ");
        sql.append("FROM exam_m a, qt_course_user b, c_course c ");
        sql.append("WHERE b.userid = ? AND b.yn_valid = 'Y' ");
        sql.append("      AND b.id_course = a.id_course ");
        sql.append("      AND b.course_year = a.course_year AND b.course_no = a.course_no ");
        sql.append("      AND a.id_auth_type = '1' AND a.yn_enable = 'Y' AND a.id_course = c.id_course ");
        sql.append("UNION ALL ");
        sql.append("SELECT a.id_exam, a.title, a.yn_sametime, a.stat_start, a.stat_end, ");
        sql.append("       a.yn_open_score_direct, a.yn_open_qa, c.course, a.yn_stat ");
        sql.append("FROM exam_m a, exam_receipt b, c_course c ");
        sql.append("WHERE b.userid = ? AND b.yn_pay = 'Y' ");
        sql.append("      AND b.id_exam = a.id_exam  ");
        sql.append("      AND a.id_auth_type = '2' AND a.yn_enable = 'Y' AND a.id_course = c.id_course ");
        sql.append("UNION ALL ");
        sql.append("SELECT a.id_exam, a.title, a.yn_sametime, a.stat_start, a.stat_end, ");
        sql.append("       a.yn_open_score_direct, a.yn_open_qa, c.course, a.yn_stat ");
        sql.append("FROM exam_m a, c_course c ");
        sql.append("WHERE a.id_auth_type = '0' AND a.yn_enable = 'Y' AND a.id_course = c.id_course ");
        sql.append("ORDER BY 2 ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            stm.setString(2, userid);
            rst = stm.executeQuery();
            User_ScoreListBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (User_ScoreListBean[]) beans.toArray(new User_ScoreListBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("성적조회할 시험정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_ScoreList.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static User_ScoreListBean makeBeans (ResultSet rst) throws QmTmException
    {
        try {
            User_ScoreListBean bean = new User_ScoreListBean();
            bean.setId_exam(rst.getString(1));
            bean.setTitle(rst.getString(2));
            bean.setYn_sametime(rst.getString(3));
            bean.setStat_start(rst.getTimestamp(4));
            bean.setStat_end(rst.getTimestamp(5));
            bean.setYn_open_score_direct(rst.getString(6));
            bean.setYn_open_qa(rst.getString(7));
            bean.setCourse(rst.getString(8));
            bean.setYn_stat(rst.getString(9));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("성적조회할 시험정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_ScoreList.makeBeans]");
        }
    }

    public static boolean isOpenScore(Timestamp from, Timestamp to) throws QmTmException
    {
		try {
            Timestamp now = new Timestamp(System.currentTimeMillis());
            if (from != null && to != null && now.after(from) && now.before(to)) { return true; }
            else if (from != null && to == null && now.after(from)) { return true; }
            else if (from == null && to != null && now.before(to)) { return true; }
            else { return true; } // from == null && to == null
        } catch (Exception ex) {
            throw new QmTmException("성적조회기간 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [User_ScoreList.isOpenScore]");
        }
    }
}
