package qmtm.tman.answer;

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

public class PracticeUtil
{
    public PracticeUtil() {
    }
	
	public static int getCnt(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(b.id_q) as cnt ");
		sql.append("From exam_paper2 a, q b ");
		sql.append("Where a.id_exam = ? and a.nr_set = 1 and a.id_q = b.id_q and b.yn_practice = 'N' ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("실기형 문제정보를 읽어오는 중 오류가 발생되었습니다. [PracticeUtil.getCnt]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static int getAnsCnt(String id_exam) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as ans_cnt ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("ans_cnt"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("실기형 응시자 정보를 읽어오는 중 오류가 발생되었습니다. [PracticeUtil.getAnsCnt]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
		
	public static void insertAns(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO EXAM_ANS(ID_EXAM, USERID, NR_SET, START_TIME, END_TIME, REMAIN_TIME, YN_END, USER_IP) ");
        sql.append("SELECT A.ID_EXAM, A.USERID, '1', GETDATE(), GETDATE(), B.LIMITTIME, 'Y', '127.0.0.1' ");
		sql.append("FROM EXAM_RECEIPT A, EXAM_M B ");
		sql.append("WHERE A.ID_EXAM = ? AND A.ID_EXAM = B.ID_EXAM ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

			stm.execute();

			insertAnsNon(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("실기형 시험 답안지 등록하는 중 오류가 발생되었습니다. [PracticeUtil.insertAns] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void deleteAns(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("Delete From exam_ans ");
		sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);

			stm.execute();

			deleteAnsNon(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("실기형 시험 답안지 삭제하는 중 오류가 발생되었습니다. [PracticeUtil.deleteAns] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void insertAnsNon(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO EXAM_ANS_NON(ID_EXAM, USERID, ID_Q, NR_SET) ");
        sql.append("SELECT A.ID_EXAM, C.USERID, A.ID_Q, A.NR_SET ");
		sql.append("FROM EXAM_PAPER2 A, Q B, EXAM_RECEIPT C ");
		sql.append("WHERE A.ID_EXAM = ? AND A.NR_SET = 1 AND B.YN_PRACTICE = 'Y' AND A.ID_Q = B.ID_Q AND A.ID_EXAM = C.ID_EXAM ");
		sql.append("ORDER BY C.USERID, A.NR_Q ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("실기형 시험 논술형 답안지 등록하는 중 오류가 발생되었습니다. [PracticeUtil.insertAnsNon] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void deleteAnsNon(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("DELETE FROM exam_ans_non ");
		sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);

			stm.execute();

			insertAns(id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("실기형 시험 논술형 답안지 삭제하는 중 오류가 발생되었습니다. [PracticeUtil.deleteAnsNon] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	
}