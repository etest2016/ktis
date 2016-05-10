package qmtm.tman.statics;
      
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

public class StaticScore
{
    public StaticScore() {
    }

	public static StaticScoreBean[] getPList(String id_exam, String search, double start, double end) throws QmTmException
    { 
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.userid, b.name, a.p_score, a.p_score_pct, a.p_rank, a.p_rank_pct ");
		sql.append("From s_p_result a, qt_userid b ");
		sql.append("Where a.id_exam = ? and a.userid = b.userid ");
		
		if(search.equals("A")) {
			sql.append("      and p_score_pct >= ? and p_score_pct <= ? ");
		} else {
			sql.append("      and p_rank_pct >= ? and p_rank_pct <= ? ");
		}

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setDouble(2, start);
			stm.setDouble(3, end);
            rst = stm.executeQuery();
            
			StaticScoreBean bean = null;
			
			while (rst.next()) {
				bean = makePList(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (StaticScoreBean[]) beans.toArray(new StaticScoreBean[0]);
			}
		}
        catch (SQLException ex) {
			throw new QmTmException("통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.getPList]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticScoreBean makePList (ResultSet rst) throws QmTmException
    {
		try {
            StaticScoreBean bean = new StaticScoreBean();
            bean.setUserid(rst.getString(1));
			bean.setName(rst.getString(2));
			bean.setScore(rst.getDouble(3));
			bean.setPct_score(rst.getDouble(4));
			bean.setU_rank(rst.getInt(5));
			bean.setPct_rank(rst.getDouble(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.makePList]");
        }
    }
	
	public static StaticScoreBean getTList(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select b.title, a.qcount, a.allotting, a.t_avg, a.t_u_avg, a.t_max, a.t_min, ");
		sql.append("       a.t_user_cnt, a.a, a.b, a.c, a.d, a.e, a.f, a.g, a.h, a.i, a.j ");
		sql.append("From s_t_result a, exam_m b ");
		sql.append("Where a.id_exam = ? and a.id_exam = b.id_exam ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeTList(rst);
            } else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.getTList]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticScoreBean makeTList (ResultSet rst) throws QmTmException
    {
		try {
            StaticScoreBean bean = new StaticScoreBean();
            bean.setTitle(rst.getString(1));
			bean.setQcount(rst.getInt(2));
			bean.setAllotting(rst.getDouble(3));
			bean.setAvg_score(rst.getDouble(4));
			bean.setTop_score(rst.getDouble(5));
			bean.setMax_score(rst.getDouble(6));
			bean.setMin_score(rst.getDouble(7));
			bean.setAll_inwon(rst.getInt(8));
			bean.setInwon1(rst.getInt(9));
			bean.setInwon2(rst.getInt(10));
			bean.setInwon3(rst.getInt(11));
			bean.setInwon4(rst.getInt(12));
			bean.setInwon5(rst.getInt(13));
			bean.setInwon6(rst.getInt(14));
			bean.setInwon7(rst.getInt(15));
			bean.setInwon8(rst.getInt(16));
			bean.setInwon9(rst.getInt(17));
			bean.setInwon10(rst.getInt(18));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.makeTList]");
        }
    }

	public static StaticScoreBean getTBeans(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select a.allotting, a.qcount, count(b.userid) as all_inwon, avg(score) as avg_score, max(score) as max_score, min(score) as min_score ");
		sql.append("From exam_m a, exam_ans b ");
		sql.append("Where a.id_exam = ? and a.id_exam = b.id_exam and b.score is not null and b.userid <> 'tman@@2008' ");
		sql.append("Group by a.allotting, a.qcount ");

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeTBeans(rst);
            } else {
				return null;
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.getTBeans]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static StaticScoreBean makeTBeans (ResultSet rst) throws QmTmException
    {
		try {
            StaticScoreBean bean = new StaticScoreBean();
            bean.setAllotting(rst.getDouble(1));
            bean.setQcount(rst.getInt(2));
			bean.setAll_inwon(rst.getInt(3));
            bean.setAvg_score(rst.getDouble(4));
			bean.setMax_score(rst.getDouble(5));
			bean.setMin_score(rst.getDouble(6));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[StaticScore.makeTBeans]" + ex.getMessage());
        }
    }

	public static StaticScoreBean getTBean(String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("Select top 1 (select count(userid) from exam_ans where id_exam = ? and score between 0 and 9 and userid <> 'tman@@2008') as inwon1, ");
		sql.append("       (select count(userid) from exam_ans where id_exam = ? and score between 10 and 19 and userid <> 'tman@@2008') as inwon2, ");
		sql.append("	   (select count(userid) from exam_ans where id_exam = ? and score between 20 and 29 and userid <> 'tman@@2008') as inwon3, ");
        sql.append("       (select count(userid) from exam_ans where id_exam = ? and score between 30 and 39 and userid <> 'tman@@2008') as inwon4, ");
        sql.append("       (select count(userid) from exam_ans where id_exam = ? and score between 40 and 49 and userid <> 'tman@@2008') as inwon5, ");
        sql.append("       (select count(userid) from exam_ans where id_exam = ? and score between 50 and 59 and userid <> 'tman@@2008') as inwon6, ");
        sql.append("       (select count(userid) from exam_ans where id_exam = ? and score between 60 and 69 and userid <> 'tman@@2008') as inwon7, ");
        sql.append("       (select count(userid) from exam_ans where id_exam = ? and score between 70 and 79 and userid <> 'tman@@2008') as inwon8, ");
        sql.append("       (select count(userid) from exam_ans where id_exam = ? and score between 80 and 89 and userid <> 'tman@@2008') as inwon9, ");
        sql.append("       (select count(userid) from exam_ans where id_exam = ? and score between 90 and 100 and userid <> 'tman@@2008') as inwon10 ");
		sql.append("From exam_ans "); 

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.setString(3, id_exam);
			stm.setString(4, id_exam);
			stm.setString(5, id_exam);
			stm.setString(6, id_exam);
			stm.setString(7, id_exam);
			stm.setString(8, id_exam);
			stm.setString(9, id_exam);
			stm.setString(10, id_exam);
            rst = stm.executeQuery();
            if (rst.next()) {
                return makeTBean(rst);
            } else {
				return null;
			}
            
        } catch (SQLException ex) {
            throw new QmTmException("통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.getTBean]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

    private static StaticScoreBean makeTBean (ResultSet rst) throws QmTmException
    {
		try {
            StaticScoreBean bean = new StaticScoreBean();
			bean.setInwon1(rst.getInt(1));
			bean.setInwon2(rst.getInt(2));
			bean.setInwon3(rst.getInt(3));
			bean.setInwon4(rst.getInt(4));
			bean.setInwon5(rst.getInt(5));
			bean.setInwon6(rst.getInt(6));
			bean.setInwon7(rst.getInt(7));
			bean.setInwon8(rst.getInt(8));
			bean.setInwon9(rst.getInt(9));
			bean.setInwon10(rst.getInt(10));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.makeTBean]");
        }
    }

	public static double getTop_score(String id_exam) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select avg(score) as top_score From exam_ans where score in ");
		sql.append("(Select TOP 10 PERCENT WITH TIES score From exam_ans Where id_exam = ? Order by score Desc) ");
		sql.append("       and id_exam = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, id_exam);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getDouble("top_score"); 
            else return 0; 
        } catch (SQLException ex) {
            throw new QmTmException("통계 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.getTop_score]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void insert_T(StaticScoreBean bean, String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO s_t_result(id_exam, qcount, allotting, t_avg, t_u_avg, t_max, ");
		sql.append("                       t_min, t_user_cnt, a, b, c, d, e, f, g, h, i, j) ");
		sql.append("            values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");  

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, bean.getQcount());
			stm.setDouble(3, bean.getAllotting());
			stm.setDouble(4, bean.getAvg_score());
			stm.setDouble(5, bean.getTop_score());
			stm.setDouble(6, bean.getMax_score());
			stm.setDouble(7, bean.getMin_score());
			stm.setInt(8, bean.getAll_inwon());
			stm.setInt(9, bean.getInwon1());
			stm.setInt(10, bean.getInwon2());
			stm.setInt(11, bean.getInwon3());
			stm.setInt(12, bean.getInwon4());
			stm.setInt(13, bean.getInwon5());
			stm.setInt(14, bean.getInwon6());
			stm.setInt(15, bean.getInwon7());
			stm.setInt(16, bean.getInwon8());
			stm.setInt(17, bean.getInwon9());
			stm.setInt(18, bean.getInwon10());
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("통계 정보 등록하는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.insert_T]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void delete_T(String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From s_t_result Where id_exam = ? ");

		try {
			// 전체 성적 통계 삭제
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.executeUpdate();
			// 개인 성적 통계 삭제
			delete_P(id_exam);
			// 문항 분석 통계 삭제
			delete_Q(id_exam);
		} catch (SQLException ex) {
			throw new QmTmException("통계 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.delete_T]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void delete_P(String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From s_p_result Where id_exam = ? ");

		try {
			// 개인 성적 통계 삭제
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.executeUpdate();
		} catch (SQLException ex) {
			throw new QmTmException("통계 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.delete_P]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}

	public static void delete_Q(String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From exam_q Where id_exam = ? ");

		try {
			// 문항 분석 통계 삭제
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.executeUpdate();
		} catch (SQLException ex) {
			throw new QmTmException("통계 정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.delete_Q]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
  
	public static void insert_P(String id_exam, int users) throws QmTmException {
		Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("INSERT INTO s_p_result(id_exam, userid, p_score, p_score_pct, p_rank, p_rank_pct) ");
		sql.append("Select d.id_exam, c.userid, c.score, convert(float,(round(((c.score / d.allotting) * 100),2))) as p_score_pct, ");
		sql.append("( ");
		sql.append(" Select count(*) + 1 ");
		sql.append(" From exam_ans a, exam_m b ");
		sql.append(" Where a.id_exam = '"+ id_exam +"' and a.score is not null and a.userid <> 'tman@@2008' "); 
		sql.append("       and a.id_exam = b.id_exam and c.score < a.score "); 
		sql.append(") as ranking, convert(float, (round(((1 / "+ users +" ) * 100),2))) as p_rank_pct ");
		sql.append("From exam_ans c, exam_m d ");
		sql.append("Where d.id_exam = '"+ id_exam +"' and c.score is not null and c.userid <> 'tman@@2008' and c.id_exam = d.id_exam ");
		sql.append("Order by ranking ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.createStatement();
			stm.executeUpdate(sql.toString());

		} catch (SQLException ex) {
			throw new QmTmException("통계 정보 입력하는 중 인터넷 연결상태가 좋지 않습니다. [StaticScore.insert_P]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	 
	public static void update_correct_ratio(String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Update q ");
		sql.append("       Set correct_pct = c.correct_ratio ");
		sql.append("From q a, exam_q b, ");
		sql.append("( ");
		sql.append("   Select id_q, (convert(float, sum(o_cnt)) / (case when sum(o_cnt) + sum(x_cnt) = 0 then 1 else sum(o_cnt) + sum(x_cnt) end)) * 100 as correct_ratio ");
		sql.append("   From exam_q");
		sql.append("   Where id_q in ");
		sql.append("   ( ");
		sql.append("      Select id_q ");
		sql.append("      From exam_q ");
		sql.append("      Where id_exam = ? ");
		sql.append("   ) ");
		sql.append("   Group by id_q ");
		sql.append(") c ");
		sql.append("Where b.id_exam = ? and a.id_q = b.id_q and a.id_q = c.id_q and b.id_q = c.id_q ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, id_exam);
			stm.execute();

		} catch (SQLException ex) {
			throw new QmTmException("문제은행 정답율 정보 수정하는 중 오류가 발생되었습니다. [StaticScore.update_correct_ratio] " + ex.getMessage());
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
}