package etest.scorehelp;

import qmtm.*;
import java.sql.*;
import java.util.*;

//for exam/myTest.jsp

public class Score_DanAns
{

    public Score_DanAns() {}

    public static Score_DanAnsBean getQ(String id_exam, int id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		String q = "";
		String ca = "";

		sql.append("Select top 1 b.q, a.allotting, b.cacount, b.ca ");
		sql.append("From exam_paper2 a, q b ");
		sql.append("Where a.id_q = b.id_q and a.id_exam = ? and a.id_q = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setInt(2, id_q);
            rst = stm.executeQuery();
            Score_DanAnsBean bean = null;

			if (rst.next()) {
				bean = new Score_DanAnsBean();
				q = rst.getString("q").replace("\\<\\B\\R\\>", "");
				q = q.replace("\\<\\/\\B\\R\\>", "");
				q = q.replace("\\<\\P\\>", "");
				q = q.replace("\\<\\/\\P\\>", "");
				bean.setQ(q);
				bean.setAllotting(rst.getDouble("allotting"));
				bean.setCacount(rst.getInt("cacount"));
				ca = rst.getString("ca");
				ca = ca.replace(QmTm.LIKE_GUBUN_re, " 또는 ");
				ca = ca.replace(QmTm.OR_GUBUN_re, ", ");
				bean.setCa(ca);

				return bean;
			} else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_DanAns.getQ]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static Score_DanAnsBean[] userAns(int list_cnt, int lists, String id_exam, int id_q, String kwd, String yn_end) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select top " + list_cnt + "  isnull(answer, ' ') answer, score, count(userid) as cnt ");
		sql.append("From imsi_exam_ans_result ");
		sql.append("Where userid not in ");
		sql.append("      (Select top " + lists + " userid ");
		sql.append("       From imsi_exam_ans_result ");
		sql.append("       Where id_exam = ? and id_q = ? and score_yn = ? "); 
		if (kwd != "") {
			sql.append("         and answer like '%'+?+'%' ");
		}
		sql.append("       ) ");
		sql.append("      and id_exam = ? and id_q = ? and score_yn = ? "); 
		if (kwd != "") {
			sql.append("  and answer like '%'+?+'%' ");
		}
		sql.append("Group by answer, score ");
		sql.append("Order by cnt desc, answer desc ");

        try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, yn_end);
			
			int i = 3;
			if (kwd != "") {
				i = i + 1;
				stm.setString(i, kwd);
			}
			i = i + 1;
			stm.setString(i, id_exam);
			i = i + 1;
			stm.setInt(i, id_q);
			i = i + 1;
			stm.setString(i, yn_end);
			if (kwd != "") {
				i = i + 1;
				stm.setString(i, kwd);
			}

			rst = stm.executeQuery();

			Score_DanAnsBean bean2 = null;
            while(rst.next()) {
				bean2 = makeBean(rst);
                beans.add(bean2);
            }
            if (bean2 == null) {
                return null;
            } else {
                return (Score_DanAnsBean[]) beans.toArray(new Score_DanAnsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("오답자 정보 읽어오는 중 오류가 발생되었습니다. [Score_DanAns.userAns] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

    private static Score_DanAnsBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            Score_DanAnsBean bean = new Score_DanAnsBean();
            bean.setAnswer(rst.getString("answer"));
            bean.setScore(rst.getDouble("score"));
			bean.setCnt(rst.getInt("cnt"));
						
            return bean;
        } catch (SQLException ex) {
			throw new QmTmException("오답자 정보 읽어오는 중 오류가 발생되었습니다. [Score_DanAns.makeBean] " +ex.getMessage());
        }
    }

	public static Score_DanAnsBean[] userScoreDanAns(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name, b.score ");
		sql.append("From qt_userid a, exam_ans b ");
		sql.append("Where b.id_exam = ? and b.userid <> 'tman@@2008' and a.userid = b.userid ");
		sql.append("Order by a.name ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            Score_DanAnsBean bean = null;

            while (rst.next()) {
                bean = makeUserBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (Score_DanAnsBean[]) beans.toArray(new Score_DanAnsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 점수 정보 읽어오는 중 오류가 발생되었습니다. [Score_DanAns.userScoreDanAns] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static Score_DanAnsBean[] userScoreAns(String id_exam, int id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, a.name, b.score ");
		sql.append("From qt_userid a, exam_ans b, exam_ans_non c ");
		sql.append("Where b.id_exam = ? and c.id_q = ? and b.userid <> 'tman@@2008' and ");
		sql.append("      a.userid = b.userid and b.userid = c.userid and b.id_exam = c.id_exam ");
		sql.append("Order by a.name ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setInt(2, id_q);
            rst = stm.executeQuery();
            Score_DanAnsBean bean = null;

            while (rst.next()) {
                bean = makeUserBean(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (Score_DanAnsBean[]) beans.toArray(new Score_DanAnsBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("응시자 인원 점수 정보 읽어오는 중 오류가 발생되었습니다. [Score_DanAns.userScoreAns] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

    private static Score_DanAnsBean makeUserBean (ResultSet rst) throws QmTmException
    {
        try {
            Score_DanAnsBean bean = new Score_DanAnsBean();
            bean.setUserid(rst.getString("userid"));
			bean.setName(rst.getString("name"));
			bean.setScore(rst.getDouble("score"));
			            									
            return bean;
        } catch (SQLException ex) {
			throw new QmTmException("응시자 인원 점수 정보 읽어오는 중 오류가 발생되었습니다. [Score_DanAns.makeUserBean] " +ex.getMessage());
        }
    }

	public static int userAnsCount(String id_exam, int id_q, String kwd, String yn_end) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(*) as cnts ");
		sql.append("From ");
		sql.append("( Select count(answer) as cnts ");
		sql.append("From imsi_exam_ans_result ");
		sql.append("Where id_exam = ? and id_q = ? and score_yn = ? ");
		if (kwd != "") {
			sql.append(   " and answer like '%'+?+'%' ");
		}
		sql.append("Group by answer ");
		sql.append(") a ");

		try
        {
            cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, yn_end);
			if (kwd != "") {
				stm.setString(4, kwd);
			}
			rst = stm.executeQuery();

			if (rst.next()) {
				return rst.getInt("cnts");
			} else {
				return 0;
			}
        }
        catch (SQLException ex) {
			throw new QmTmException("오답자 정보 읽어오는 중 오류가 발생되었습니다. [Score_DanAns.userAnsCount] " +ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
}

