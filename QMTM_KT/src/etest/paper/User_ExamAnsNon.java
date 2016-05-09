package etest.paper;

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

public class User_ExamAnsNon
{
    public User_ExamAnsNon() {
    }

    private static User_ExamAnsNonBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            User_ExamAnsNonBean bean = new User_ExamAnsNonBean();
            bean.setCorrection1(rst.getString("correction1"));
            bean.setCorrection2(rst.getString("correction2"));
            bean.setCorrection3(rst.getString("correction3"));
            bean.setId_exam(rst.getString("id_exam"));
            bean.setId_q(rst.getLong("id_q"));
            bean.setNr_set(rst.getInt("nr_set"));
            bean.setScore(rst.getDouble("score"));
            bean.setScore_comment(rst.getString("score_comment"));
            bean.setScoredate(rst.getTimestamp("score_date"));
            bean.setUserans1(rst.getString("userans1"));
            bean.setUserans2(rst.getString("userans2"));
            bean.setUserans3(rst.getString("userans3"));
            bean.setUserid(rst.getString("userid"));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_ExamAnsNon.makeBean]");
        }
    }

    public static User_ExamAnsNonBean getBean(long id_q, String userid, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		String sql = "";

        sql = "SELECT * FROM exam_ans_non WHERE id_q = ? AND userid = ? AND id_exam = ? ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setLong(1, id_q);
            stm.setString(2, userid);
            stm.setString(3, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return makeBean(rst); }
            else { return null; }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [User_ExamAnsNon.getBean]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static void insert(User_ExamAnsNonBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO exam_ans_non (id_q, userid, id_exam, ");
        sql.append("       nr_set, userans1, userans2, userans3, ");
        sql.append("       correction1, correction2, correction3, score, score_date, score_comment ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setLong(1, bean.getId_q());
            stm.setString(2, bean.getUserid());
            stm.setString(3, bean.getId_exam());
            stm.setInt(4, bean.getNr_set());
            stm.setString(5, bean.getUserans1());
            stm.setString(6, bean.getUserans2());
            stm.setString(7, bean.getUserans3());
            stm.setString(8, bean.getCorrection1());
            stm.setString(9, bean.getCorrection2());
            stm.setString(10, bean.getCorrection3());
            stm.setDouble(11, bean.getScore());
            stm.setTimestamp(12, bean.getScoredate());
            stm.setString(13, bean.getScore_comment());
            stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 논술형 답안 등록하는중 인터넷 연결상태가 좋지 않습니다. [User_ExamAnsNon.insert]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static void update(User_ExamAnsNonBean bean) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE EXAM_ANS_NON SET ");
        sql.append("       NR_SET = " + bean.getNr_set() + ", ");
        sql.append("       USERANS1 = '" + bean.getUserans1() + "', ");
        sql.append("       USERANS2 = '" + bean.getUserans2() + "', ");
        sql.append("       USERANS3 = '" + bean.getUserans3() + "', ");
        sql.append("       CORRECTION1 = '" + bean.getCorrection1() + "', ");
        sql.append("       CORRECTION2 = '" + bean.getCorrection2() + "', ");
        sql.append("       CORRECTION3 = '" + bean.getCorrection3() + "', ");
        sql.append("       SCORE = " + bean.getScore() + ", ");
        sql.append("       SCORE_DATE = " + bean.getScoredate() + ", ");
        sql.append("       SCORE_COMMENT = '" + bean.getScore_comment() + "' ");
        sql.append(" WHERE ID_Q = " + bean.getId_q() + " ");
        sql.append("   AND USERID = '" + bean.getUserid() + "' ");
        sql.append("   AND ID_EXAM = '" + bean.getId_exam() + "' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();
            stm.executeUpdate(sql.toString());
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 논술형 답안 수정하는중 인터넷 연결상태가 좋지 않습니다. [User_ExamAnsNon.update]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static void delete(long id_q, String userid, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM EXAM_ANS_NON ");
        sql.append("WHERE (ID_Q = ? ) AND (USERID = ?) AND (ID_EXAM = ?) ");

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setLong(1, id_q);
            stm.setString(2, userid);
            stm.setString(3, id_exam);
            stm.executeUpdate();
        } catch (SQLException ex) {
            throw new QmTmException("응시자 논술형 답안 삭제하는중 인터넷 연결상태가 좋지 않습니다. [User_ExamAnsNon.delete]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static void insertBlanks(String userid, String id_exam, int nr_set) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO exam_ans_non ");
        sql.append("      (id_q, userid, id_exam, nr_set, userans1, userans2, userans3) ");
        sql.append("SELECT a.id_q, '" + userid + "', '" + id_exam + "', " + nr_set + ", '', '', '' ");
        sql.append("FROM exam_paper2 a, q b ");
        sql.append("WHERE a.id_exam = ? AND a.nr_set = ? ");
        sql.append("      AND a.id_q = b.id_q AND b.id_qtype = 5 ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setInt(2, nr_set);
            stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 논술형 답안 등록하는중 인터넷 연결상태가 좋지 않습니다. [User_ExamAnsNon.insertBlanks]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static void deleteForBlanks(String userid, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM EXAM_ANS_NON ");
        sql.append("WHERE (USERID = ?) AND (ID_EXAM = ?) ");

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            stm.setString(2, id_exam);
            stm.executeUpdate();
        } catch (SQLException ex) {
            throw new QmTmException("응시자 논술형 답안 삭제하는중 인터넷 연결상태가 좋지 않습니다. [User_ExamAnsNon.deleteForBlanks]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
