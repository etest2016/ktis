package qmtm.tman.statics;

// Package Import
import java.sql.Connection;
// Java API Import
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import qmtm.DBPool;
import qmtm.QmTmException;

public class ExamStatic
{
    public ExamStatic() {
    }

	public static ExamStaticBean[] getQList(String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select f.q_subject, c.chapter, a.id_q, e.qtype, d.difficulty, ");
		sql.append("       sum(o_cnt), sum(x_cnt), sum(ex1_cnt), sum(ex2_cnt), ");
		sql.append("       sum(ex3_cnt), sum(ex4_cnt),sum(ex5_cnt) ");
		sql.append("From exam_q a, q b, q_chapter c, r_difficulty d, r_qtype e, q_subject f "); 
		sql.append("Where a.id_exam in ( "+id_exam+" ) and a.id_q = b.id_q and ");
		sql.append("      b.id_chapter = c.id_q_chapter and b.id_difficulty1 = d.id_difficulty and "); 
		sql.append("      b.id_qtype = e.id_qtype and b.id_subject = f.id_q_subject ");
		sql.append("Group by f.q_subject, c.chapter, a.id_q, e.qtype, d.difficulty ");
		
        try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());
            
			ExamStaticBean bean = null;
			
			while (rst.next()) {
				bean = makeQList(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (ExamStaticBean[]) beans.toArray(new ExamStaticBean[0]);
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamStatic.getQList]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ExamStaticBean makeQList (ResultSet rst) throws QmTmException
    {
		try {
            ExamStaticBean bean = new ExamStaticBean();
			
			bean.setSubject(rst.getString(1));
			bean.setChapter(rst.getString(2));
			bean.setId_q(rst.getInt(3));
			bean.setQtype(rst.getString(4));
			bean.setDifficulty(rst.getString(5));
			bean.setO_cnt(rst.getInt(6));
			bean.setX_cnt(rst.getInt(7));
			bean.setEx1_cnt(rst.getInt(8));
			bean.setEx2_cnt(rst.getInt(9));
			bean.setEx3_cnt(rst.getInt(10));
			bean.setEx4_cnt(rst.getInt(11));
			bean.setEx5_cnt(rst.getInt(12));		

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamStatic.makeQList]");
        }
    }

	public static ExamStaticBean[] getAnsList(String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select c.title, a.userid, b.name, b.sosok1, b.sosok2, '응시', convert(varchar(16), a.start_time, 120) start_time, ");
		sql.append("       convert(varchar(16), a.end_time, 120) end_time, isnull(convert(varchar(10),a.score),'미채점'), ");
		sql.append("       case when convert(varchar(10),a.score_bak) = '-1.00' then '' else convert(varchar(10),a.score_bak) end, ");
		sql.append("       case when a.score_log = '-1' then '' else a.score_log end, a.user_ip ");
		sql.append("From exam_ans a, qt_userid b, exam_m c "); 
		sql.append("Where c.id_exam in ( "+id_exam+" ) and a.userid = b.userid and a.id_exam = c.id_exam ");
		sql.append("Union all "); 
		sql.append("Select c.title, a.userid, b.name, b.sosok1, b.sosok2, '미응시', '', '', '', '', '', '' ");
		sql.append("From exam_receipt a, qt_userid b, exam_m c ");
		sql.append("Where c.id_exam in ( "+id_exam+" ) and a.userid = b.userid and a.id_exam = c.id_exam  ");
		sql.append("Order by c.title, b.name ");
		
        try
        {
            Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
	        stm = cnn.createStatement();        
		    rst = stm.executeQuery(sql.toString());
						
			ExamStaticBean bean = null;
			
			while (rst.next()) {
				bean = makeAnsList(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (ExamStaticBean[]) beans.toArray(new ExamStaticBean[0]);
			}
		}
        catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamStatic.getAnsList]");
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static ExamStaticBean makeAnsList (ResultSet rst) throws QmTmException
    {
		try {
            ExamStaticBean bean = new ExamStaticBean();
			
			bean.setTitle(rst.getString(1));
			bean.setUserid(rst.getString(2));
			bean.setName(rst.getString(3));
			bean.setSosok1(rst.getString(4));
			bean.setSosok2(rst.getString(5));
			bean.setAns_yn(rst.getString(6));
			bean.setStart_time(rst.getString(7));
			bean.setEnd_time(rst.getString(8));
			bean.setScore(rst.getString(9));
			bean.setScore_bak(rst.getString(10));
			bean.setScore_log(rst.getString(11));
			bean.setUser_ip(rst.getString(12));

            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("문제정보를 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [ExamStatic.makeQList]");
        }
    }
	
}