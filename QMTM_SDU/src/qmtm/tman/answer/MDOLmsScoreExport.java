package qmtm.tman.answer;

import qmtm.*;

import java.sql.*;
import java.util.*;

public class MDOLmsScoreExport
{
    public MDOLmsScoreExport() {
    }

	public static void examInfoDel(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

	    sql.append("Delete from lm_std_etest_info ");
		sql.append("Where etest_info_id = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

			stm.execute();	

			examInfoIns(prof_id, id_exam);			
        }
        catch (SQLException ex) {
            throw new QmTmException("[MDOLmsScoreExport.examInfoDel]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void userStatusDel(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

	    sql.append("Delete from lm_std_etest_status ");
		sql.append("Where etest_info_id = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

			stm.execute();	

			examInfoDel(prof_id, id_exam);			
        }
        catch (SQLException ex) {
            throw new QmTmException("[MDOLmsScoreExport.userStatusDel]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void userScoreDel(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

	    sql.append("Delete from lm_std_etest_score ");
		sql.append("Where etest_info_id = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

			stm.execute();	
			
			userStatusDel(prof_id, id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("[MDOLmsScoreExport.userScoreDel]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void examInfoIns(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

	    sql.append("Insert into lm_std_etest_info(etest_info_id, etest_name, etest_type, course_id, start_date, end_date, ");
        sql.append("            retest_ratio, view_score_date, duration_time, apply_num, pass_score, score_yn, view_time_type, ");
        sql.append("            view_question_type, question_set_type, use_yn, reg_id, reg_date, finish_time, disabled_yn, ");
        sql.append("            disabled_time, mod_date, etest_test_type, etest_score_persent, open_score_yn) ");
        sql.append("Select id_exam, title, 'online', id_course, to_char(exam_start1, 'yyyymmddhh24miss') exam_start, to_char(exam_end1, 'yyyymmddhh24miss') exam_end, ");
        sql.append("       100, to_char(stat_start, 'yyyymmddhh24miss') stat_start, limittime/60, 1, 0, 'Y', 'left', ");
        sql.append("       'all', 'random', 'Y', userid, to_char(regdate, 'yyyymmddhh24miss') regdate, 'remainder', 'N', ");
		sql.append("       0, to_char(up_date, 'yyyymmddhh24miss') up_date, decode(id_exam_kind, 1,'MIDDLE', 2,'LAST', 3,'ANY'), 100, decode(yn_open_qa, 'A', 'N', 'Y') ");     
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.executeUpdate();

			
			userStatusIns(prof_id, id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("[MDOLmsScoreExport.examInfoIns]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void userStatusIns(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Insert into lm_std_etest_status ");
		sql.append("Select concat(concat(a.id_exam, '_'),a.userid), a.id_exam, b.id_course, a.userid, to_char(a.start_time, 'yyyymmddhh24miss') start_time, ");
		sql.append("       to_char(a.end_time, 'yyyymmddhh24miss') end_time, 1, b.limittime - a.remain_time, decode(a.yn_end, 'N', 'restore', 'complete'), 'origin', ");
		sql.append("       a.user_ip, to_char(sysdate, 'yyyymmddhh24miss') reg_date, to_char(sysdate, 'yyyymmddhh24miss') mod_date, a.remain_time ");
		sql.append("From exam_ans a, exam_m b ");
		sql.append("Where b.id_exam = ? and a.userid <> 'tman@@2008' and a.id_exam = b.id_exam ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.executeUpdate();

			userScoreIns(prof_id, id_exam);			
        }
        catch (SQLException ex) {
            throw new QmTmException("[MDOLmsScoreExport.userStatusIns]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	

	public static void userScoreIns(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Insert into lm_std_etest_score ");
		sql.append("Select concat(concat(a.id_exam, '_'),a.userid), a.id_exam, b.id_course, a.userid, a.score, a.score, ");
		sql.append("       a.retry_exam, ?, to_char(sysdate, 'yyyymmddhh24miss') reg_date, ?, to_char(sysdate, 'yyyymmddhh24miss') mod_date ");  
		sql.append("From exam_ans a, exam_m b ");
		sql.append("Where b.id_exam = ? and a.userid <> 'tman@@2008' and a.id_exam = b.id_exam ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, prof_id);
            stm.setString(2, prof_id);
            stm.setString(3, id_exam);
            stm.executeUpdate();
        }
        catch (SQLException ex) {
            throw new QmTmException("[MDOLmsScoreExport.userScoreIns]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
}