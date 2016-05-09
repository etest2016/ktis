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

public class AnswerMarkDan
{
    public AnswerMarkDan() {
    }

	public static AnswerMarkDanBean[] getBeans(String id_exam, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("Select a.nr_q, a.allotting, b.q, b.ca, c.answers, c.oxs, c.points, c.userid ");
		sql.append("From exam_paper2 a, q b, exam_ans c ");
		sql.append("Where a.id_exam = ? and a.id_q = ? and a.id_q = b.id_q ");
		sql.append("      and a.id_exam = c.id_exam and a.nr_set = c.nr_set and c.userid <> 'tman@@2008' ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setLong(2, id_q);
            rst = stm.executeQuery();
            AnswerMarkDanBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnswerMarkDanBean[]) beans.toArray(new AnswerMarkDanBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkDan.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnswerMarkDanBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnswerMarkDanBean bean = new AnswerMarkDanBean();

			bean.setNr_q(rst.getInt(1));
            bean.setAllotting(rst.getDouble(2));
			bean.setQ(rst.getString(3));
            bean.setCa(rst.getString(4));
			bean.setAnswers(rst.getString(5));
			bean.setOxs(rst.getString(6));
			bean.setPoints(rst.getString(7));
			bean.setUserid(rst.getString(8));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkDan.makeBeans]");
        }
    }

	public static AnswerMarkDanBean getBean(String id_exam, String userid, long id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("Select distinct a.oxs, a.points, b.nr_q, b.allotting, a.score ");
		sql.append("From exam_ans a, exam_paper2 b ");
		sql.append("Where a.id_exam = ? and a.userid = ? and b.id_q = ? ");
		sql.append("      and a.id_exam = b.id_exam and a.nr_set = b.nr_set and a.userid <> 'tman@@2008' ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);
			stm.setLong(3, id_q);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeBean(rst);
            } else {
				return null;
			}
            
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkDan.getBean]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnswerMarkDanBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            AnswerMarkDanBean bean = new AnswerMarkDanBean();
			bean.setOxs(rst.getString(1));
            bean.setPoints(rst.getString(2));
			bean.setNr_q(rst.getInt(3));
            bean.setAllotting(rst.getDouble(4));
			bean.setScore(rst.getDouble(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkDan.makeBean]");
        }
    }

	public static void update(String id_exam, String userid, String oxs, String points, double score) throws QmTmException {
	
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer(); 

		sql.append("Update exam_ans Set ");
		sql.append("       oxs = ?, points = ?, score = ? ");
		sql.append("Where (userid = ?) and (id_exam = ?) ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());

			stm.setString(1, oxs);
			stm.setString(2, points);
			stm.setDouble(3, score);
			stm.setString(4, userid);
			stm.setString(5, id_exam);

			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("응시자 답안지 정보 수정하는 중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkDan.update]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
}