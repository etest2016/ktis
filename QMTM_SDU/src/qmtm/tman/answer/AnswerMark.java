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

public class AnswerMark
{
    public AnswerMark() {
    }

	public static AnswerMarkBean[] getBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("Select distinct c.id_q, c.cacount, c.id_qtype, convert(varchar(2000), c.q), c.yn_caorder, c.yn_case, c.yn_blank ");
		sql.append("From exam_m a, exam_paper2 b, q c ");
		sql.append("Where a.id_exam = ? and c.id_qtype in (4,5) ");
		sql.append("      and a.id_exam = b.id_exam and b.id_q = c.id_q ");
		sql.append("Order by c.id_q");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            AnswerMarkBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnswerMarkBean[]) beans.toArray(new AnswerMarkBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 문제 정보 읽어오는중 오류가 발생되었습니다. [AnswerMark.getBeans] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static AnswerMarkBean[] getBeans2(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("Select distinct c.id_q, c.cacount, c.id_qtype, convert(varchar(2000), c.q), c.yn_caorder, c.yn_case, c.yn_blank ");
		sql.append("From exam_m a, exam_paper2 b, q c ");
		sql.append("Where a.id_exam = ? and c.id_qtype = 5 ");
		sql.append("      and a.id_exam = b.id_exam and b.id_q = c.id_q ");
		sql.append("Order by c.id_q");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            AnswerMarkBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (AnswerMarkBean[]) beans.toArray(new AnswerMarkBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("시험지 문제 정보 읽어오는중 오류가 발생되었습니다. [AnswerMark.getBeans2] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static AnswerMarkBean makeBeans (ResultSet rst) throws QmTmException
    {
		try {
            AnswerMarkBean bean = new AnswerMarkBean();

			bean.setId_q(rst.getLong(1));
            bean.setCacount(rst.getInt(2));
			bean.setId_qtype(rst.getInt(3));
            bean.setQ(rst.getString(4));
			bean.setYn_caorder(rst.getString(5));
			bean.setYn_case(rst.getString(6));
			bean.setYn_blank(rst.getString(7));			
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("시험지 문제 정보 읽어오는중 오류가 발생되었습니다. [AnswerMark.makeBeans] " + ex.getMessage());
        }
    }

	public static ImsiAnswerMarkBean getScoreInwon(String id_exam, long id_q, int id_qtype) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		if(id_qtype == 4) {
			sql.append("Select count(userid) all_cnt, ");
			sql.append("       (Select count(userid) From imsi_exam_ans_result Where id_exam = ? and id_q = ? and score_yn = 'N') n_score, "); 
			sql.append("       (Select count(userid) From imsi_exam_ans_result Where id_exam = ? and id_q = ? and score_yn = 'Y') y_score ");	
			sql.append("From imsi_exam_ans_result  ");
			sql.append("Where id_exam = ? and id_q = ? ");
		} else {
			sql.append("Select count(userid) all_cnt, ");
			sql.append("       (Select count(userid) From imsi_exam_ans_result Where id_exam = ? and id_q = ? and score_yn = 'N') n_score, "); 
			sql.append("       (Select count(userid) From imsi_exam_ans_result Where id_exam = ? and id_q = ? and score_yn = 'Y') y_score ");	
			sql.append("From exam_ans_non ");
			sql.append("Where id_exam = ? and id_q = ? and userid <> 'tman@@2008' ");
		}

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setLong(2, id_q);
			stm.setString(3, id_exam);
			stm.setLong(4, id_q);
			stm.setString(5, id_exam);
			stm.setLong(6, id_q);
            rst = stm.executeQuery();
            if (rst.next()) {
				return makeScoreInwonBean(rst);
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("단답형 채점인원 정보 읽어오는중 오류가 발생되었습니다. [AnswerMark.getScoreInwon] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static ImsiAnswerMarkBean getAllScoreInwon(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("Select count(id_q) all_cnt, ");
		sql.append("       (select isnull(count(userid),0) from imsi_exam_ans_result where id_exam = ? and score_yn = 'N' and answer is not null and answer <> '') n_score, "); 
		sql.append("       (select isnull(count(userid),0) from imsi_exam_ans_result where id_exam = ? and score_yn = 'Y' and answer is not null and answer <> '') y_score, ");	
		sql.append("       (Select count(distinct a.id_q) from exam_paper2 a, q b Where a.id_exam = ? and b.id_qtype in (4,5) and a.id_q = b.id_q) all_q ");
		sql.append("From exam_ans_mark ");
		sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.setString(3, id_exam);
			stm.setString(4, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) {
				return makeAllScoreInwonBean(rst);
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("단답형 채점인원 정보 읽어오는중 오류가 발생되었습니다. [AnswerMark.getScoreInwon] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ImsiAnswerMarkBean makeAllScoreInwonBean (ResultSet rst) throws QmTmException
    {
		try {
            ImsiAnswerMarkBean bean = new ImsiAnswerMarkBean();

			bean.setAll_score(rst.getInt(1));
			bean.setNo_score(rst.getInt(2));
			bean.setYes_score(rst.getInt(3));
			bean.setAll_q(rst.getInt(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("단답형 채점인원 정보 읽어오는중 오류가 발생되었습니다. [AnswerMark.makeAllScoreInwon] " + ex.getMessage());
        }
    }

	private static ImsiAnswerMarkBean makeScoreInwonBean (ResultSet rst) throws QmTmException
    {
		try {
            ImsiAnswerMarkBean bean = new ImsiAnswerMarkBean();

			bean.setAll_score(rst.getInt(1));
			bean.setNo_score(rst.getInt(2));
			bean.setYes_score(rst.getInt(3));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("단답형 채점인원 정보 읽어오는중 오류가 발생되었습니다. [AnswerMark.makeScoreInwon] " + ex.getMessage());
        }
    }
}