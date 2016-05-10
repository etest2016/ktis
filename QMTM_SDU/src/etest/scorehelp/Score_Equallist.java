package etest.scorehelp;

import qmtm.*;
import java.sql.*;
import java.util.*;

//for exam/myTest.jsp

public class Score_Equallist
{

    public Score_Equallist() {}

	public static Score_EquallistBean3 getQ(String id_exam, int id_q) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.qcount, b.allotting, c.q ");
		sql.append("From exam_m a, exam_paper2 b, q c ");
		sql.append("Where a.id_exam = b.id_exam and b.id_q = c.id_q and a.id_exam = ? and b.id_q = ? and ");
		sql.append("      rownum <= 1 ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			rst = stm.executeQuery();
			Score_EquallistBean3 bean = null;

			if (rst.next()) {
				bean = new Score_EquallistBean3();

				bean.setQcount(rst.getInt("qcount"));
				bean.setAllotting(rst.getDouble("allotting"));
				bean.setQ(rst.getString("q"));

				return bean;
			} else {
				return null;
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_Equallist.getQ]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


    public static Score_EquallistBean[] getList(String id_exam, int id_q, String equal_chk) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select b.userid, b.search_resutl_rate, b.ans_result_rate, b.ans_result_rate2, b.userid_ans_len ");
		sql.append("From equal_comp_result a, equal_test_result2 b ");
		sql.append("Where a.id_exam = b.id_exam and a.id_q = b.id_q and a.o_userid = b.userid and ");
		sql.append("      a.id_exam = ? and a.id_q = ? and b.score_yn = 'N' and a.equal_chk = ? ");
		sql.append("Order by b.ans_result_rate desc ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setInt(2, id_q);
            stm.setString(3, equal_chk);
            rst = stm.executeQuery();

			Collection beans = new ArrayList();
            Score_EquallistBean bean = null;

			while (rst.next()) {
				bean = new Score_EquallistBean();

				bean = makeBean(rst);
				beans.add(bean);
			}
            if (bean == null) {
                return null;
            } else {
                return (Score_EquallistBean[]) beans.toArray(new Score_EquallistBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_EquallistBean.getList]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


    private static Score_EquallistBean makeBean (ResultSet rst) throws QmTmException
    {
        try {
            Score_EquallistBean bean = new Score_EquallistBean();

			bean.setUserid(rst.getString("userid"));
			bean.setSearch_result_rate(rst.getDouble("search_resutl_rate"));
			bean.setAns_result_rate(rst.getDouble("ans_result_rate"));
			bean.setAns_result_rate2(rst.getDouble("ans_result_rate2"));
			bean.setUserid_ans_len(rst.getInt("userid_ans_len"));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_Equallist.makeBean]" + ex.getMessage());
        }
    }

    public static Score_EquallistBean2 getUserData(String id_exam, String userid, int id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select nvl(a.points, ' ') points, b.nr_q, b.allotting, c.equal_chk, c.score, c.equal_ans ");
		sql.append("From exam_ans a, exam_paper2 b, equal_comp_result c ");
		sql.append("Where a.id_exam = ? and a.userid = ? and ");
		sql.append("      b.id_q = ? and a.id_exam = b.id_exam and a.nr_set = b.nr_set and ");
		sql.append("      b.id_exam = c.id_exam and b.id_q = c.id_q and a.userid = c.o_userid ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, userid);
            stm.setInt(3, id_q);
            rst = stm.executeQuery();
            Score_EquallistBean2 bean = null;

			if (rst.next()) {
				bean = new Score_EquallistBean2();

				bean = makeBean2(rst);
				return bean;
			} else {
                return null;
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_EquallistBean.getUserData]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


    private static Score_EquallistBean2 makeBean2 (ResultSet rst) throws QmTmException
    {
        try {
            Score_EquallistBean2 bean = new Score_EquallistBean2();

			bean.setPoints(rst.getString("points"));
			bean.setNr_q(rst.getInt("nr_q"));
			bean.setAllotting(rst.getDouble("allotting"));
			bean.setEqual_chk(rst.getString("equal_chk"));
			bean.setScore(rst.getDouble("score"));
			bean.setEqual_ans(rst.getString("equal_ans"));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_Equallist.makeBean2]" + ex.getMessage());
        }
    }

	public static Score_EqualResultBean[] getResult(String id_exam, int id_q, String equal_chk, int pg, int size) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		int i = 0;
		int nowPos = 0;

		sql.append("Select a.o_userid, a.t_userid, nvl(a.o_t_res_rate, ' ') o_t_res_rate, nvl(a.t_o_res_rate, ' ') t_o_res_rate, ");
		sql.append("       nvl(b.userans1, ' ') userans1, nvl(b.userans2, ' ') userans2, nvl(b.userans3, ' ') userans3, ");
		sql.append("       nvl(b.userans4, ' ') userans4, nvl(b.userans5, ' ') userans5, nvl(b.userans6, ' ') userans6, ");
		sql.append("       to_char(c.end_time, 'yyyy-mm-dd hh24:mi:ss') end_time ");
		sql.append("From equal_comp_result a, exam_ans_non b, exam_ans c ");
		sql.append("Where a.id_exam = b.id_exam and a.id_q = b.id_q and a.o_userid = b.userid and ");
		sql.append("      b.id_exam = c.id_exam and b.userid = c.userid and a.id_exam = ? and a.id_q = ? and a.equal_chk = ? ");
		sql.append("order by c.end_time asc ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            stm.setString(1, id_exam);
            stm.setInt(2, id_q);
			stm.setString(3, equal_chk);
            rst = stm.executeQuery();

			Collection beans = new ArrayList();
            Score_EqualResultBean bean = null;

			if (rst.next()) {
				nowPos = (pg -1) * size + 1;

				//absolut 로 이동을 시켰기 때문에 bean에 바로 담아야 한다
				rst.absolute(nowPos);
				bean = makeResult(rst);
				beans.add(bean);

				if (rst.isLast() == false) {
					for (i=1; i<=size-1; i++) {
						rst.next();
						if (rst.isLast()) {
							bean = makeResult(rst);
							beans.add(bean);
							break;
						} else {
							bean = makeResult(rst);
							beans.add(bean);
						}
					}
				}
			}
            if (bean == null) {
                return null;
            } else {
                return (Score_EqualResultBean[]) beans.toArray(new Score_EqualResultBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualResultBean.getResult]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static Score_EqualResultBean makeResult(ResultSet rst) throws QmTmException
	{
		try {
            Score_EqualResultBean bean = new Score_EqualResultBean();
			bean.setO_userid(rst.getString("o_userid"));
			bean.setT_userid(rst.getString("t_userid"));
			bean.setO_t_res_rate(rst.getString("o_t_res_rate"));
			bean.setT_o_res_rate(rst.getString("t_o_res_rate"));
			bean.setUserans(rst.getString("userans1") + rst.getString("userans2")+ rst.getString("userans3")+ rst.getString("userans4")+ rst.getString("userans5")+ rst.getString("userans6"));
			bean.setEnd_time(rst.getString("end_time"));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_EqualResultBean.makeResult]" + ex.getMessage());
        }
	}

	public static int getResultCount(String id_exam, int id_q, String equal_chk) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(o_userid) cnt ");
		sql.append("From equal_comp_result a ");
		sql.append("Where a.id_exam = ? and a.id_q = ? and a.equal_chk = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setInt(2, id_q);
			stm.setString(3, equal_chk);
            rst = stm.executeQuery();

			if (rst.next()) {
				return rst.getInt("cnt");
			}
            else {
                return 0;
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualResultBean.getResultCount]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


	public static Score_EqualUserBean[] getResult2(String id_exam, int id_q, int pg, int size) throws QmTmException
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		int i = 0;
		int nowPos = 0;

		sql.append("Select o_userid, nvl(equal_reason, ' ') equal_reason, score ");
		sql.append("From equal_comp_result ");
		sql.append("Where id_exam = ? and id_q = ? and equal_chk = 'Y' ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
            stm.setString(1, id_exam);
            stm.setInt(2, id_q);
            rst = stm.executeQuery();

			Collection beans = new ArrayList();
            Score_EqualUserBean bean = null;

			if (rst.next()) {
				nowPos = (pg -1) * size + 1;

				//absolut 로 이동을 시켰기 때문에 bean에 바로 담아야 한다
				rst.absolute(nowPos);
				bean = makeResult2(rst);
				beans.add(bean);

				if (rst.isLast() == false) {
					for (i=1; i<=size-1; i++) {
						rst.next();
						if (rst.isLast()) {
							bean = makeResult2(rst);
							beans.add(bean);
							break;
						} else {
							bean = makeResult2(rst);
							beans.add(bean);
						}
					}
				}
			}
            if (bean == null) {
                return null;
            } else {
                return (Score_EqualUserBean[]) beans.toArray(new Score_EqualUserBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualUserBean.getResult2]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	private static Score_EqualUserBean makeResult2(ResultSet rst) throws QmTmException
	{
		try {
            Score_EqualUserBean bean = new Score_EqualUserBean();
			bean.setO_userid(rst.getString("o_userid"));
			bean.setEqual_reason(rst.getString("equal_reason"));
			bean.setScore(rst.getDouble("score"));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_EqualUserBean.makeResult2]" + ex.getMessage());
        }
	}
}
