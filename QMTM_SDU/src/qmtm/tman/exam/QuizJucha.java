package qmtm.tman.exam;

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

public class QuizJucha
{
    public QuizJucha() {
    }

	public static QuizJuchaBean[] getJuchaList(String id_course, String course_year, String course_no) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		String yearHaki = course_year + course_no;

		sql.append("SELECT QC.ID_Q_SUBJECT, ");
		sql.append("       QC.ID_Q_CHAPTER, ");
		sql.append("       YJ.JUCHA, ");
		sql.append("       QC.CHAPTER, ");
		sql.append("       CONVERT(VARCHAR(16), YJ.SDATE, 120) QUIZ_START, ");
		sql.append("       CONVERT(VARCHAR(16), YJ.EDATE, 120) QUIZ_END, ");
		sql.append("       ISNULL(EM.ID_EXAM,'') ID_EXAM, ");
		sql.append("       ISNULL(EM.TITLE,'') TITLE, ");
		sql.append("       ISNULL(EM.QCOUNT,0) QCOUNT, "); 
		sql.append("       ISNULL(EM.ALLOTTING,0) ALLOTTING, "); 
		sql.append("       ISNULL(EM.LIMITTIME,0) LIMITTIME, ");
		sql.append("       COUNT(Q.ID_Q) Q_CNT, ");
		sql.append("       ISNULL(SUM(Q.ALLOTTING),0) Q_ALLOTTING ");
		sql.append("FROM Q_CHAPTER QC INNER JOIN VIEW_YEARHAKI_JUCHA YJ ON QC.CHAPTER_ORDER = YJ.JUCHA ");
		sql.append("     LEFT OUTER JOIN Q Q ON QC.ID_Q_SUBJECT = Q.ID_SUBJECT AND QC.ID_Q_CHAPTER = Q.ID_CHAPTER AND Q.COURSE_YEAR = ? AND Q.COURSE_NO = ? ");
		sql.append("     LEFT OUTER JOIN EXAM_M EM ON QC.ID_Q_SUBJECT = EM.ID_COURSE AND QC.CHAPTER_ORDER = EM.JUCHA AND ");
		sql.append("     EM.COURSE_YEAR = ? AND EM.COURSE_NO = ? ");
		sql.append("WHERE ID_Q_SUBJECT = ? AND YEARHAKI = ? AND YJ.ISOPEN = 1 ");
		sql.append("GROUP BY QC.ID_Q_SUBJECT, ");
		sql.append("         QC.ID_Q_CHAPTER, ");
		sql.append("         YJ.JUCHA, ");
		sql.append("         QC.CHAPTER, ");
		sql.append("         YJ.SDATE, ");
		sql.append("         YJ.EDATE, ");
		sql.append("         EM.ID_EXAM, ");
		sql.append("         EM.TITLE, ");
		sql.append("         EM.QCOUNT, ");
		sql.append("         EM.ALLOTTING, ");
		sql.append("         EM.LIMITTIME ");
		sql.append("ORDER BY YJ.JUCHA ");

		//System.out.println(sql.toString());
		
        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, course_year);
            stm.setString(2, course_no);
			stm.setString(3, course_year);
            stm.setString(4, course_no);
            stm.setString(5, id_course);
			stm.setString(6, yearHaki);
            rst = stm.executeQuery();
            
            QuizJuchaBean bean = null;
            while (rst.next()) {
                bean = makeJuchaListBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (QuizJuchaBean[]) beans.toArray(new QuizJuchaBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("주차별 퀴즈정보 읽어오는 중 오류가 발생되었습니다. [QuizJucha.getJuchaList] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	private static QuizJuchaBean makeJuchaListBeans (ResultSet rst) throws QmTmException
    {
		try {
			QuizJuchaBean bean = new QuizJuchaBean();		
			bean.setId_q_subject(rst.getString(1));
            bean.setId_q_chapter(rst.getString(2));
            bean.setJucha(rst.getInt(3));
			bean.setChapter(rst.getString(4));
			bean.setQuiz_start(rst.getString(5));
			bean.setQuiz_end(rst.getString(6));
			bean.setId_exam(rst.getString(7));
			bean.setTitle(rst.getString(8));
			bean.setQcount(rst.getInt(9));
			bean.setAllotting(rst.getDouble(10));
			bean.setLimittime(rst.getLong(11));
			bean.setJucha_cnt(rst.getInt(12));
			bean.setJucha_allotting(rst.getDouble(13));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("주차별 퀴즈정보 읽어오는 중 오류가 발생되었습니다. [QuizJucha.makeJuchaListBeans] " + ex.getMessage());
     	}
    }	
	
	public static QuizJuchaBean getJuchaInfo(String id_course, String course_year, String course_no, int jucha) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		String yearHaki = course_year + course_no;

		sql.append("SELECT QC.ID_Q_SUBJECT, ");
		sql.append("       QC.ID_Q_CHAPTER, ");
		sql.append("       YJ.JUCHA, ");
		sql.append("       QC.CHAPTER, ");
		sql.append("       CONVERT(VARCHAR(16), YJ.SDATE, 120) QUIZ_START, ");
		sql.append("       CONVERT(VARCHAR(16), YJ.EDATE, 120) QUIZ_END, ");
		sql.append("       ISNULL(EM.ID_EXAM,'') ID_EXAM, ");
		sql.append("       ISNULL(EM.TITLE,'') TITLE, ");
		sql.append("       ISNULL(EM.QCOUNT,0) QCOUNT, "); 
		sql.append("       ISNULL(EM.ALLOTTING,0) ALLOTTING, "); 
		sql.append("       ISNULL(EM.LIMITTIME,0) LIMITTIME, ");
		sql.append("       COUNT(Q.ID_Q) Q_CNT, ");
		sql.append("       ISNULL(SUM(Q.ALLOTTING),0) Q_ALLOTTING ");
		sql.append("FROM Q_CHAPTER QC INNER JOIN VIEW_YEARHAKI_JUCHA YJ ON QC.CHAPTER_ORDER = YJ.JUCHA ");
		sql.append("     LEFT OUTER JOIN Q Q ON QC.ID_Q_SUBJECT = Q.ID_SUBJECT AND QC.ID_Q_CHAPTER = Q.ID_CHAPTER AND Q.COURSE_YEAR = ? AND Q.COURSE_NO = ? ");
		sql.append("     LEFT OUTER JOIN EXAM_M EM ON QC.ID_Q_SUBJECT = EM.ID_COURSE AND EM.COURSE_YEAR = ? AND EM.COURSE_NO = ? ");
		sql.append("WHERE ID_Q_SUBJECT = ? AND YEARHAKI = ? AND YJ.JUCHA = ? ");
		sql.append("GROUP BY QC.ID_Q_SUBJECT, ");
		sql.append("         QC.ID_Q_CHAPTER, ");
		sql.append("         YJ.JUCHA, ");
		sql.append("         QC.CHAPTER, ");
		sql.append("         YJ.SDATE, ");
		sql.append("         YJ.EDATE, ");
		sql.append("         EM.ID_EXAM, ");
		sql.append("         EM.TITLE, ");
		sql.append("         EM.QCOUNT, ");
		sql.append("         EM.ALLOTTING, ");
		sql.append("         EM.LIMITTIME ");
		sql.append("ORDER BY YJ.JUCHA ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, course_year);
            stm.setString(2, course_no);
            stm.setString(3, course_year);
            stm.setString(4, course_no);
            stm.setString(5, id_course);
			stm.setString(6, yearHaki);
			stm.setInt(7, jucha);
            rst = stm.executeQuery();
            if (rst.next()) {
				return makeJuchaListBeans(rst);
			} else {
				return null;
			}			
        }
        catch (SQLException ex) {
            throw new QmTmException("주차별 퀴즈정보 읽어오는 중 오류가 발생되었습니다. [QuizJucha.getJuchaInfo] " + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	
	public static void saveSimpleExam(QuizSimpleBean bean) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; 
        PreparedStatement stm2 = null; PreparedStatement stm3 = null;
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer(); StringBuffer sql3 = new StringBuffer();
		
        sql.append("INSERT INTO exam_m (");
        sql.append("                   id_exam, id_course, id_subject, course_year, course_no, jucha, title, ");
        sql.append("                   limittime, qcntperpage, userid, yn_enable, qcount, allotting, ");
        sql.append("                   guide, exam_start1, exam_end1, id_auth_type, ");
		sql.append("                   yn_stat, stat_start, stat_end, yn_open_qa, yn_open_score_direct, ");
		sql.append("                   log_option, yn_sametime, id_randomtype, id_ltimetype, id_movepage, yn_viewas, ");
		sql.append("                   fontname, fontsize) ");
		sql.append("Select ?, ?, ?, ?, ?, ?, ?, ");
		sql.append("         ?, ?, ?, ?, b.qcnt, b.allotting,  ");
		sql.append("         '', sdate, edate, 1, ");
		sql.append("         'N', dateadd(day, 1, edate), dateadd(year, 1, edate), 'E', 'Y', ");
		sql.append("         'B', 'N', 'NN', 'T', 'F', 'Y',  ");
		sql.append("         '굴림', '11' ");
		sql.append("From view_yearhaki_jucha a, ");
		sql.append("       (Select count(*) qcnt, sum(allotting) allotting ");
		sql.append("        From q ");
		sql.append("        Where id_chapter = ?) b ");
		sql.append("Where yearhaki = ? and jucha = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, bean.getId_exam());
            stm.setString(2, bean.getId_course());
            stm.setString(3, bean.getId_course());
            stm.setString(4, bean.getCourse_year());
            stm.setString(5, bean.getCourse_no());
            stm.setInt(6, bean.getJucha());
            stm.setString(7, bean.getTitle());
            stm.setInt(8, bean.getLimittime());
            stm.setInt(9, bean.getQcntperpage());
            stm.setString(10,  bean.getUserid());
            stm.setString(11, bean.getYn_enable());
            stm.setString(12, bean.getId_course() + "_" + bean.getJucha());
            stm.setString(13, bean.getCourse_year() + bean.getCourse_no());
            stm.setInt(14, bean.getJucha());
			
			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("퀴즈 등록 중 오류가 발생되었습니다. [QuizJucha.saveSimpleExam1] " + ex.getMessage());	
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
        }		
        
        try
        {
        //exam_q 테이블에 insert 한다
        sql2.append("INSERT INTO exam_q ");
        sql2.append("(id_exam, id_q) ");
        sql2.append("Select ?, id_q ");
        sql2.append("From q ");
        sql2.append("Where id_chapter = ? ");

        stm2 = cnn.prepareStatement(sql2.toString());
        stm2.setString(1, bean.getId_exam());
        stm2.setString(2, bean.getId_course() + "_" + bean.getJucha());
        stm2.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("퀴즈 등록 중 오류가 발생되었습니다. [QuizJucha.saveSimpleExam2] " + ex.getMessage());	
        }
        finally {
            if (stm2 != null) try { stm2.close(); } catch (SQLException ex) {}
        }		
        
        
        try
        {
        //exam_q 테이블에 insert 한다
        sql3.append("INSERT INTO exam_paper2 ");
        sql3.append("(id_exam, nr_set, nr_q, id_q, ex_order, allotting, page, q_no1, q_no2) ");
        sql3.append("Select ?, 1, row_number() over(order by id_q) as nr_q, id_q, ");
        sql3.append("         case excount ");
        sql3.append("         when 2 then '1,2' when 3 then '1,2,3'  ");
        sql3.append("         when 4 then '1,2,3,4' when 5 then '1,2,3,4,5' ");
        sql3.append("         else '' end, ");
        sql3.append("         allotting,  (row_number() over(order by id_q) + ?) / ?, ");
        sql3.append("         0, 0 ");
        sql3.append("From q ");
        sql3.append("Where id_chapter = ? ");

        stm3 = cnn.prepareStatement(sql3.toString());
        stm3.setString(1, bean.getId_exam());
        stm3.setInt(2, bean.getQcntperpage()-1);
        stm3.setInt(3, bean.getQcntperpage());
        stm3.setString(4, bean.getId_course() + "_" + bean.getJucha());
        stm3.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("퀴즈 등록 중 오류가 발생되었습니다. [QuizJucha.saveSimpleExam3] " + ex.getMessage());	
        }
        finally {
            if (stm3 != null) try { stm3.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }		
	}
	
}

