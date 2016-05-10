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
import java.sql.Statement;
import java.sql.PreparedStatement;

public class UserQScore
{
    public UserQScore() {
    }

	public static UserQScoreBean getExamInfo(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select title, qcount ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeExamInfo(rst);
            } else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [UserQScore.getExamInfo] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static UserQScoreBean makeExamInfo (ResultSet rst) throws QmTmException
    {
		try {
            UserQScoreBean bean = new UserQScoreBean();
            bean.setTitle(rst.getString(1));
            bean.setQcount(rst.getInt(2));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 정보 읽어오는 중 오류가 발생되었습니다. [UserQScore.makeExamInfo] " + ex.getMessage());
        }
    }
	
	public static UserQScoreBean[] getOxs(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.nr_set, a.answers, a.oxs, a.points, b.name ");
		sql.append("From exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid and a.oxs is not null and a.answers is not null and a.userid <> 'tman@@2008' ");
		sql.append("Order by nr_set ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            UserQScoreBean bean = null;
            while (rst.next()) {
                bean = makeOxs(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (UserQScoreBean[]) beans.toArray(new UserQScoreBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안을 읽어오는 중 오류가 발생되었습니다. [UserQScore.getOxs] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static UserQScoreBean makeOxs (ResultSet rst) throws QmTmException
    {
		try {
            UserQScoreBean bean = new UserQScoreBean();
            bean.setUserid(rst.getString(1));
			bean.setNr_set(rst.getInt(2));
            bean.setAnswers(rst.getString(3));
			bean.setOxs(rst.getString(4));
			bean.setPoints(rst.getString(5));
			bean.setName(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안을 읽어오는 중 오류가 발생되었습니다. [UserQScore.makeOxs] " + ex.getMessage());
        }
    }
	
	public static UserQScoreBean[] getQinfo(String id_exam, int nr_set) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.id_q, a.nr_q, a.allotting ");
		sql.append("From exam_paper2 a, q b ");
		sql.append("Where a.id_exam = ? and a.nr_set = ? and a.id_q = b.id_q ");
		sql.append("Order by a.nr_q ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setInt(2, nr_set);
            rst = stm.executeQuery();
            UserQScoreBean bean = null;
            while (rst.next()) {
                bean = makeQinfo(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (UserQScoreBean[]) beans.toArray(new UserQScoreBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 문제 정보를 읽어오는 중 오류가 발생되었습니다. [UserQScore.getQinfo] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static UserQScoreBean makeQinfo (ResultSet rst) throws QmTmException
    {
		try {
            UserQScoreBean bean = new UserQScoreBean();
            bean.setId_q(rst.getLong(1));
			bean.setNr_q(rst.getInt(2));
			bean.setAllotting(rst.getDouble(3));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 문제를 읽어오는 중 오류가 발생되었습니다. [UserQScore.makeQinfo] " + ex.getMessage());
        }
    }
	
}