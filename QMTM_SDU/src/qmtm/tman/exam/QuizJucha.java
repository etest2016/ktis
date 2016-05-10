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
		sql.append("     LEFT OUTER JOIN EXAM_M EM ON QC.ID_Q_SUBJECT = EM.ID_COURSE AND EM.COURSE_YEAR = ? AND EM.COURSE_NO = ? ");
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
            stm.setString(3, id_course);
			stm.setString(4, yearHaki);
			stm.setInt(5, jucha);
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

	
}

