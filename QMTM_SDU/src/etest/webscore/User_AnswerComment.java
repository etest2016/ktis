package etest.webscore;


//Package Import
import qmtm.DBPool;
import qmtm.QmTm;
import qmtm.ComLib;
import qmtm.QmTmException;
import etest.*;


import java.sql.*;
import java.util.*;


public class User_AnswerComment
{
    public User_AnswerComment() {}
   	
	public static User_AnswerCommentBean getBean(String id_exam, String userid, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "SELECT id_exam, userid, id_q, score_comment, reg_id, up_id "           
            + "FROM exam_ans_comment "
            + "WHERE id_exam = ? AND userid = ? AND id_q = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);  
			stm.setString(2, userid);
			stm.setLong(3, id_q);
            rst = stm.executeQuery();
            if (rst.next()) { return makeBean(rst); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("[AnswerComment.getBean]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static User_AnswerCommentBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            User_AnswerCommentBean bean = new User_AnswerCommentBean();
            bean.setId_exam(rst.getString(1));
            bean.setUserid(rst.getString(2));
            bean.setId_q(rst.getLong(3));
            bean.setScore_comment(rst.getString(4));
            bean.setReg_id(rst.getString(5));
			bean.setUp_id(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[AnswerComment.makeBean]" + ex.getMessage());
        }
    }
	
	public static void insertBlank(String id_exam, String userid, long id_q, String score_comment, String reg_id) throws QmTmException
    {
        
		try {
            User_AnswerCommentBean bean = new User_AnswerCommentBean();
            bean.setId_exam(id_exam);
			bean.setUserid(userid);
            bean.setId_q(id_q);
            bean.setScore_comment(score_comment);
            bean.setReg_id(reg_id);
            insert(bean);            
        } catch (Exception ex) {
            throw new QmTmException("[AnswerComment.insertBlank]" + ex.getMessage());
        }
    }

    public static void insert(User_AnswerCommentBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "INSERT INTO exam_ans_comment (id_exam, userid, "
            + "       id_q, score_comment, reg_id) "
            + "VALUES (?, ?, ?, ?, ?) ";			

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, bean.getId_exam());
			stm.setString(2, bean.getUserid());            
            stm.setLong(3, bean.getId_q());
            stm.setString(4, bean.getScore_comment());
            stm.setString(5, bean.getReg_id());
            stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[AnswerComment.insert]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateBlank(String id_exam, String userid, long id_q, String score_comment, String up_id) throws QmTmException
    {
        try {
            User_AnswerCommentBean bean = new User_AnswerCommentBean();
            bean.setId_exam(id_exam);
			bean.setUserid(userid);
            bean.setId_q(id_q);
            bean.setScore_comment(score_comment);
            bean.setUp_id(up_id);
            update(bean);            
        } catch (Exception ex) {
            throw new QmTmException("[AnswerComment.updateBlank]" + ex.getMessage());
        }
    }

    public static void update(User_AnswerCommentBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; String sql = "";

        sql = "UPDATE EXAM_ANS_COMMENT SET "
            + "       SCORE_COMMENT = ?, UP_ID = ? "
            + " WHERE (ID_EXAM = ?) AND (USERID = ?) AND (ID_Q = ?) ";

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, bean.getScore_comment());
            stm.setString(2, bean.getUp_id());
			stm.setString(3, bean.getId_exam());
            stm.setString(4, bean.getUserid());
			stm.setLong(5, bean.getId_q());

            stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("[AnswerComment.update]"+ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
