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

public class AnswerMarkNon
{
    public AnswerMarkNon() {
    }

	public static int getQcount(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

        sql = "Select qcount From exam_m Where id_exam = ? ";

        try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("qcount"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("시험 문항수 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.getQcount]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnswerMarkNonBean[] getBean(String id_exam, String id_q) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("SELECT nr_set, nr_q, allotting ");
		sql.append("FROM exam_paper2 ");
		sql.append("WHERE id_exam = ? AND id_q = ? ");

	    try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, id_q);
			rst = stm.executeQuery();
			AnswerMarkNonBean bean = null;
            while (rst.next()) {
                bean = makeBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnswerMarkNonBean[]) beans.toArray(new AnswerMarkNonBean[0]);
            }
		} catch (SQLException ex) {
			throw new QmTmException("시험지 문항 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.getBean]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static AnswerMarkNonBean makeBean (ResultSet rst) throws QmTmException
    {
		try {
            AnswerMarkNonBean bean = new AnswerMarkNonBean();
            bean.setNr_set(rst.getInt(1));
			bean.setNr_q(rst.getInt(2));
			bean.setAllotting(rst.getDouble(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 문항 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.makeBean]");
        }
    }

	public static AnswerMarkNonBean[] getBeans(String id_exam, String nr_sets) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.nr_set, a.oxs, isnull(a.points,'') points, isnull(a.answers, '') answers, b.name "); 
		sql.append("From exam_ans a, qt_userid b ");
		sql.append("Where a.id_exam = '"+ id_exam +"' and a.nr_set in ("+ nr_sets +") and a.oxs is not null and a.score is not null ");
		sql.append("      and a.userid <> 'tman@@2008' and a.userid = b.userid ");
		sql.append("Order by b.name ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.createStatement();        
	        rst = stm.executeQuery(sql.toString()); 
            AnswerMarkNonBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnswerMarkNonBean[]) beans.toArray(new AnswerMarkNonBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.getBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static AnswerMarkNonBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnswerMarkNonBean bean = new AnswerMarkNonBean();
            bean.setUserid(rst.getString(1));
			bean.setNr_set(rst.getInt(2));
			bean.setOxs(rst.getString(3));
			bean.setPoints(rst.getString(4));
			bean.setAnswers(rst.getString(5));
			bean.setNames(rst.getString(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.makeBeans]");
        }
    }

	public static AnswerMarkNonBean getBean2(String id_q) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "Select q, ca, explain From q Where id_q = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean2(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("시험 문항정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.getBean2]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static AnswerMarkNonBean makeBean2 (ResultSet rst) throws QmTmException
    {
		try {
            AnswerMarkNonBean bean = new AnswerMarkNonBean();
            bean.setQ(rst.getString(1));
			bean.setCa(rst.getString(2));
			bean.setExplain(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험 문항정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.makeBean2]");
        }
    }

	public static AnswerMarkNonBean getAnswer(String id_q, String userid, String id_exam) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		String sql = "Select userans1, userans2, userans3 From exam_ans_non Where id_q = ? and userid = ? and id_exam = ? ";

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q);
			stm.setString(2, userid);
			stm.setString(3, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeAnswer(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("응시자 논술형 답안지 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.getAnswer]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static AnswerMarkNonBean makeAnswer (ResultSet rst) throws QmTmException
    {
		try {
            AnswerMarkNonBean bean = new AnswerMarkNonBean();
            bean.setUserans1(rst.getString(1));
			bean.setUserans2(rst.getString(2));
			bean.setUserans3(rst.getString(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 논술형 답안지 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.makeAnswer]");
        }
    }

	public static AnswerMarkNonBean getBean3(String id_q, String userid, String id_exam) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select distinct a.oxs, a.points, b.nr_q, b.allotting, a.score "); 
		sql.append("From exam_ans a, exam_paper2 b ");
		sql.append("Where b.id_q = ? and a.userid = ? and a.id_exam = ? ");
		sql.append("      and a.id_exam = b.id_exam and a.nr_set = b.nr_set ");

	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_q);
			stm.setString(2, userid);
			stm.setString(3, id_exam);
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean3(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("응시자 답안지 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.getBean3]");
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static AnswerMarkNonBean makeBean3 (ResultSet rst) throws QmTmException
    {
		try {
            AnswerMarkNonBean bean = new AnswerMarkNonBean();
            bean.setOxs(rst.getString(1));
			bean.setPoints(rst.getString(2));
			bean.setNr_q(rst.getInt(3));
			bean.setAllotting(rst.getDouble(4));
			bean.setScore(rst.getDouble(5));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.makeBean3]");
        }
    }

	public static void updateNon(String id_exam, String userid, AnswerMarkNonBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE exam_ans SET oxs = ?, points = ?, score = ? ");
		sql.append("Where id_exam = ? and userid = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getOxs());
			stm.setString(2, bean.getPoints());
			stm.setDouble(3, bean.getScore());
			stm.setString(4, id_exam);
			stm.setString(5, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 답안지 정보 변경하는중 인터넷 연결상태가 좋지 않습니다. [AnswerMarkNon.updateNon]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}