package qmtm.tman.answer;

import qmtm.*;

import java.sql.*;
import java.util.*;

public class LmsScoreExport
{
    public LmsScoreExport() {
    }

	public static void examInfoDel(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

	    sql.append("Delete from t_examinfo ");
		sql.append("Where exam_code = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

			stm.execute();	

			examApplyDel(prof_id, id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("[LmsScoreExport.examInfoDel]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void examApplyDel(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

	    sql.append("Delete from t_exam_apply ");
		sql.append("Where exam_code = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);

			stm.execute();	

			examInfoIns(prof_id, id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("[LmsScoreExport.examApplyDel]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
	public static void examInfoIns(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();

	    sql.append("Insert into t_examinfo(exam_code, exam_title, subject_id, ");
		sql.append("                       lecture_id, term_id, reg_id, exam_type) ");
		sql.append("Select a.id_exam, a.title, b.subject_id, a.id_course, b.term_id, ");
		sql.append("       '"+prof_id+"', ");
		sql.append("        case when a.id_exam_kind = 1 then '001' where a.id_exam_kind = 2 then '002' ");
		sql.append("        when a.id_exam_kind = 3 then '003' end id_exam_kind ");
		sql.append("From exam_m a, q_subject b ");
		sql.append("Where a.id_exam = '"+id_exam+"' and a.id_course = b.id_q_subject ");
		
        try
        {
            cnn = DBPool.getConnection();
			stm = cnn.createStatement();        
            stm.executeUpdate(sql.toString());
			
			examApplyIns(prof_id, id_exam);
        }
        catch (SQLException ex) {
            throw new QmTmException("[LmsScoreExport.examInsIns]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void examApplyIns(String prof_id, String id_exam) throws QmTmException
    {
        Connection cnn = null; Statement stm = null; 
		StringBuffer sql = new StringBuffer();
		
		sql.append("Insert into t_exam_apply(exam_apply_idx, user_id, exam_code, eval_datetime, ");
		sql.append("                         test_end_datetime, apply_datetime, exam_point, ");
		sql.append("          		         user_per_point, status, demerit_mark_point) ");
		sql.append("Select 0, userid, id_exam, getdate(), end_time, start_time, ");
		sql.append("       case when score_bak = '-1' then score else score_bak end score_bak, ");
		sql.append("       score, 'YE', case when score_log = '-1' then 0 else score_log end score_log ");		
		sql.append("From exam_ans ");
		sql.append("Where id_exam = '"+id_exam+"' and userid <> 'tman@@2008' ");
		
        try
        {
            cnn = DBPool.getConnection();
			stm = cnn.createStatement();        
            stm.executeUpdate(sql.toString());
			
        }
        catch (SQLException ex) {
            throw new QmTmException("[LmsScoreExport.examApplyIns]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
}