package etest.scorehelp;

import qmtm.*;
import java.sql.*;
import java.util.*;

//for exam/myTest.jsp

public class Score_DanAns2
{

    public Score_DanAns2() {}

    public static Score_DanAnsBean2 getQ(String id_exam, int id_q) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		String q = "";
		String ca = "";

        Statement stm2 = null;
		String sql2 = "";
		int mycnt = 0;

		sql2 = "";
		sql2 = sql2 + "Select count(*) as cnt ";
		sql2 = sql2 + "From ";
		sql2 = sql2 + "( ";
		sql2 = sql2 + "  Select count(answer) as cnt ";
		sql2 = sql2 + "  From imsi_exam_ans_result ";
		sql2 = sql2 + "  Where id_exam = '" + id_exam + "' and id_q = " + Integer.toString(id_q) + " and score_yn = 'N' ";
		sql2 = sql2 + "  and userid in ";
		sql2 = sql2 + "      (Select userid From exam_ans Where id_exam = '" + id_exam + "') ";
		sql2 = sql2 + "  Group by answer ";
		sql2 = sql2 + ") a ";

		Score_DanAnsBean2 bean = null;
		bean = new Score_DanAnsBean2();

		try
        {
            cnn = DBPool.getConnection();
			stm2 = cnn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rst = stm2.executeQuery(sql2);

			if (rst.next()) {
				mycnt = rst.getInt(1);
				bean.setUsercount(mycnt);
			} else {
				bean.setUsercount(0);
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_DanAns.userAnsCount]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm2 != null) try { stm2.close(); } catch (SQLException ex) {}
        }


		sql.append("Select b.q, a.allotting, b.ca ");
		sql.append("From exam_paper2 a, q b ");
		sql.append("Where a.id_q = b.id_q and a.id_exam = ? and a.nr_set = 1 and a.id_q = ? ");

        try
        {
            //cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setInt(2, id_q);
            rst = stm.executeQuery();

			if (rst.next()) {
				//bean = new Score_DanAnsBean();
				q = rst.getString("q").replace("\\<\\B\\R\\>", "");
				q = q.replace("\\<\\/\\B\\R\\>", "");
				q = q.replace("\\<\\P\\>", "");
				q = q.replace("\\<\\/\\P\\>", "");
				bean.setQ(q);
				bean.setAllotting(rst.getDouble("allotting"));
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


	public static Score_DanAnsBean2[] userAns(String id_exam, int id_q, String kwd, int pg, int size, String yn_end) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		String sql = "";
		int i = 0;

		sql = "";

		if (yn_end == "N") {
			sql = sql + "Select nvl(answer, ' ') answer, count(userid) as cnt ";
		} else {
			sql = sql + "Select nvl(answer, ' ') answer, score, count(userid) as cnt ";
		}

		sql = sql + "From imsi_exam_ans_result ";
		sql = sql + "Where id_exam = '" + id_exam + "' and id_q = " + Integer.toString(id_q) + " and score_yn = '" + yn_end + "' ";

		if (kwd != "") {
			sql = sql + " and answer like '%" + kwd + "%' ";
		}

		sql = sql + "and userid in ";
		sql = sql + "    (Select userid From exam_ans Where id_exam = '" + id_exam + "') ";

		if (yn_end == "N") {
			sql = sql + "Group by answer ";
		} else {
			sql = sql + "Group by answer, score ";
		}

		sql = sql + "Order by cnt desc, answer desc ";

        try
        {
            Collection beans = new ArrayList();
			int nowPos = 0;
            cnn = DBPool.getConnection();
			stm = cnn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

            rst = stm.executeQuery(sql);
            Score_DanAnsBean2 bean = null;

			//데이터가 있다면 원하는 행으로 이동 시킨다
			if (rst.next()) {
				nowPos = (pg -1) * size + 1;

				//absolut 로 이동을 시켰기 때문에 bean에 바로 담아야 한다
				rst.absolute(nowPos);
				bean = makeBean(rst, yn_end);
				beans.add(bean);

				if (rst.isLast() == false) {
					for (i=1; i<=size-1; i++) {
						rst.next();
						if (rst.isLast()) {
							bean = makeBean(rst, yn_end);
							beans.add(bean);
							break;
						} else {
							bean = makeBean(rst, yn_end);
							beans.add(bean);
						}
					}
				}
			}

            if (bean == null) {
                return null;
            } else {
                return (Score_DanAnsBean2[]) beans.toArray(new Score_DanAnsBean2[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_DanAns.userAns]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

    private static Score_DanAnsBean2 makeBean (ResultSet rst, String yn_end) throws QmTmException
    {
        try {
            Score_DanAnsBean2 bean = new Score_DanAnsBean2();
            bean.setAnswer(rst.getString("answer"));
            bean.setCnt(rst.getInt("cnt"));
			
			if (yn_end == "Y") {
				bean.setScore(rst.getDouble("score"));
			}

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[Score_DanAns.makeBean]" + ex.getMessage());
        }
    }
}

