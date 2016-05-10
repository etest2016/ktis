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
            throw new QmTmException("응시자 답안지 정보 읽어오는중 오류가 발생되었습니다. [User_ExamAnsNon.makeBean] " +ex.getMessage());
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
            throw new QmTmException("응시자 답안지 정보 읽어오는중 오류가 발생되었습니다. [User_ExamAnsNon.getBean] " +ex.getMessage());
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
            throw new QmTmException("응시자 논술형 답안 등록하는중 오류가 발생되었습니다. [User_ExamAnsNon.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    public static void update(User_ExamAnsNonBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE EXAM_ANS_NON SET ");
        sql.append("       NR_SET = ?, ");
        sql.append("       USERANS1 = ?, ");
        sql.append("       USERANS2 = ?, ");
        sql.append("       USERANS3 = ?, ");
        sql.append("       CORRECTION1 = ?, ");
        sql.append("       CORRECTION2 = ?, ");
        sql.append("       CORRECTION3 = ?, ");
        sql.append("       SCORE = ?, ");
        sql.append("       SCORE_DATE = ?, ");
        sql.append("       SCORE_COMMENT = ? ");
        sql.append(" WHERE ID_Q = ? ");
        sql.append("   AND USERID = ? ");
        sql.append("   AND ID_EXAM = ? ");

        try
        {
            cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setInt(1, bean.getNr_set());
			stm.setString(2, bean.getUserans1());
			stm.setString(3, bean.getUserans2());
			stm.setString(4, bean.getUserans3());
			stm.setString(5, bean.getCorrection1());
			stm.setString(6, bean.getCorrection2());
			stm.setString(7, bean.getCorrection3());
			stm.setDouble(8, bean.getScore());
			stm.setTimestamp(9, bean.getScoredate());
			stm.setString(10, bean.getScore_comment());
			stm.setLong(11, bean.getId_q());
			stm.setString(12, bean.getUserid());
			stm.setString(13, bean.getId_exam());
			stm.executeUpdate();
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 논술형 답안 수정하는중 오류가 발생되었습니다. [User_ExamAnsNon.update] " +ex.getMessage());
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
            throw new QmTmException("응시자 논술형 답안 삭제하는중 오류가 발생되었습니다. [User_ExamAnsNon.delete] " +ex.getMessage());
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
            throw new QmTmException("응시자 논술형 답안 등록하는중 오류가 발생되었습니다. [User_ExamAnsNon.insertBlanks] " +ex.getMessage());
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
            throw new QmTmException("응시자 논술형 답안 삭제하는중 오류가 발생되었습니다. [User_ExamAnsNon.deleteForBlanks] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
