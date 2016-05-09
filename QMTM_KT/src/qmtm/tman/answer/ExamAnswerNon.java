package qmtm.tman.answer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

public class ExamAnswerNon {
	public ExamAnswerNon() {
	}

	private static ExamAnswerNonBean makeBean(ResultSet rst) throws QmTmException {
		try {
			ExamAnswerNonBean bean = new ExamAnswerNonBean();
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
			throw new QmTmException("논술형 답안정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.makeBean]");
		}
	}

	public static ExamAnswerNonBean getBean(long id_q, String userid, String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM exam_ans_non ");
		sql.append("WHERE id_q = ? AND userid = ? AND id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setLong(1, id_q);
			stm.setString(2, userid);
			stm.setString(3, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("논술형 답안정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.getBean]");
		} finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) { }
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void insert(ExamAnswerNonBean bean) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_ans_non (id_exam, userid, id_q, ");
		sql.append("       nr_set, userans1, userans2, userans3 ) ");
		sql.append("VALUES (?, ?, ?, ?, ?, ?, ?) ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getId_exam());
			stm.setString(2, bean.getUserid());
			stm.setLong(3, bean.getId_q());
			stm.setInt(4, bean.getNr_set());
			stm.setString(5, bean.getUserans1());
			stm.setString(6, bean.getUserans2());
			stm.setString(7, bean.getUserans3());
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("논술형 답안을 등록하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.insert]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void update(String id_exam, String userid, long id_q, ExamAnswerNonBean bean) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE EXAM_ANS_NON SET "); 
		sql.append("       USERANS1 = ?, USERANS2 = ?, USERANS3 = ? ");
        sql.append("WHERE ID_Q = ? AND USERID = ? AND ID_EXAM = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, bean.getUserans1());
			stm.setString(2, bean.getUserans2());
			stm.setString(3, bean.getUserans3());
			stm.setLong(4, id_q);
			stm.setString(5, userid);
			stm.setString(6, id_exam);

			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("논술형 답안을 수정하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.update]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void delete(long id_q, String userid, String id_exam) throws QmTmException {
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
			throw new QmTmException("논술형 답안을 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.delete]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void insertBlanks(String userid, String id_exam, int nr_set) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_ans_non ");
		sql.append("      (id_q, userid, id_exam, nr_set, userans1, userans2, userans3) ");
		sql.append("SELECT a.id_q, '" + userid + "', '" + id_exam + "', ");
		sql.append("      " + nr_set + ", '', '', '' " + "  FROM exam_paper2 a, q b ");
		sql.append("WHERE a.id_exam = ? AND a.nr_set = ? ");
		sql.append("      AND a.id_q = b.id_q AND b.id_qtype = 5 ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, nr_set);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("논술형 답안을 등록하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.insertBlanks]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void bakcopy2(String userid, String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From bak_exam_ans_non Where userid = ? and id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("백업테이블에 논술형 답안을 등록하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.bakcopy2]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void bakcopy(String userid, String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO bak_exam_ans_non ");
		sql.append("Select * From exam_ans_non Where userid = ? and id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("백업테이블에 논술형 답안을 등록하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.bakcopy]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void bakrestore(String userid, String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO exam_ans_non ");
		sql.append("Select * From bak_exam_ans_non Where userid = ? and id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("백업테이블에 논술형 답안을 복구하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.bakrestore]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	
	public static void deleteForBlanks(String userid, String id_exam) throws QmTmException {

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
			throw new QmTmException("논술형 답안을 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.deleteForBlanks]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void bakdelete(String userid, String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("DELETE FROM BAK_EXAM_ANS_NON ");
		sql.append("WHERE (USERID = ?) AND (ID_EXAM = ?) ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, userid);
			stm.setString(2, id_exam);
			stm.executeUpdate();
		} catch (SQLException ex) {
			throw new QmTmException("백업테이블에 논술형 답안을 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [ExamAnswerNon.bakdelete]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
}
