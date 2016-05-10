package qmtm;

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

public class LogFind
{
    public LogFind() {
    }

    public static LogFindBean[] getBeans(String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 

		StringBuffer sql = new StringBuffer();

		sql.append("Select userid, null(answers, '') answer, nr_set ");
		sql.append("From exam_ans ");
		sql.append("Where id_exam = ? ");
		
		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();

			LogFindBean bean = null;
			
			while (rst.next()) {
				bean = makeBeans(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (LogFindBean[]) beans.toArray(new LogFindBean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("응시자 답안정보 읽어오는 중 오류가 발생되었습니다. [LogFind.getBeans] " + ex.getMessage());
		} finally {
			if (rst != null) 	try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) 	try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) 	try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static LogFindBean makeBeans(ResultSet rst) throws QmTmException {
		try {
			LogFindBean bean = new LogFindBean();
			bean.setUserid(rst.getString(1));
			bean.setAnswer(rst.getString(2));
			bean.setNr_set(rst.getInt(3));
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("응시자 답안정보 읽어오는 중 오류가 발생되었습니다. [LogFind.makeBeans] " + ex.getMessage());
		}
	}

	public static LogFindBean[] getNonBeans(String id_exam, String userid, int nr_set) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 

		StringBuffer sql = new StringBuffer();

		sql.append("Select b.nr_q, null(a.userans1, '') userans1, null(a.userans2, '') userans2, ");
		sql.append("       null(a.userans3, '') userans3, null(a.userans4, '') userans4, null(a.userans5, '') userans5  ");
		sql.append("From exam_ans_non a, exam_paper2 b ");
		sql.append("Where a.id_exam = ? and a.userid = ? and a.nr_set = ? and ");
		sql.append("      a.id_exam = b.id_exam and a.id_q = b.id_q and a.nr_set = b.nr_set ");
		sql.append("Order by b.nr_q ");
		
		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, userid);
			stm.setInt(3, nr_set);
			rst = stm.executeQuery();

			LogFindBean bean = null;
			
			while (rst.next()) {
				bean = makeBeans(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (LogFindBean[]) beans.toArray(new LogFindBean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("응시자 논술형 답안정보 읽어오는 중 오류가 발생되었습니다. [LogFind.getNonBeans] " + ex.getMessage());
		} finally {
			if (rst != null) 	try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) 	try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) 	try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static LogFindBean makeNonBeans(ResultSet rst) throws QmTmException {
		try {
			LogFindBean bean = new LogFindBean();
			bean.setNr_q(rst.getString(1));
			bean.setUserans1(rst.getString(2));
			bean.setUserans2(rst.getString(3));
			bean.setUserans3(rst.getString(4));
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("응시자 논술형 답안정보 읽어오는 중 오류가 발생되었습니다. [LogFind.makeNonBeans] " + ex.getMessage());
		}
	}
}