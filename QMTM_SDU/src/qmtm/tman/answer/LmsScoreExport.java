package qmtm.tman.answer;

import qmtm.*;

import java.sql.*;
import java.util.*;

public class LmsScoreExport
{
    public LmsScoreExport() {
    }
	
	public static void scoreExport(String id_exam, String id_course, String id_subject, String exam_method, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();
		
		if(userid.equals("qmtm")) {
			userid = "-2";
		}
			
		sql.append("Update TB_EVAL_IN_OFFC_SEQS_APPLY_M ");	
		if(exam_method.equals("exam1")) {	
			sql.append("   Set HEARING_SCORE = a.score, ");
		} else if(exam_method.equals("exam2")) {	
			sql.append("   Set READING_COMPREHENSION_SCORE = a.score, ");
		} else if(exam_method.equals("exam3")) {	
			sql.append("   Set SPEAK_SCORE = a.score, ");
		} else if(exam_method.equals("exam4")) {	
			sql.append("   Set WRITE_SCORE = a.score, ");
		} else if(exam_method.equals("exam5")) {	
			sql.append("   Set GRAMMAR_SCORE = a.score, ");
		}
		sql.append("     TOTAL_EVALUATION_SCORE = a.score, ");
		sql.append("     NG_FLAG = dbo.FN_GET_NGFLAG_FOR_ETEST_RESULT(?, a.score, ''), ");
		sql.append("     TRAIN_EVAL_RESULT_STATUS_CODE = 'A', ");
		sql.append("     LAST_UPDATED_BY = ? ");
		sql.append("From exam_ans a, TB_EVAL_IN_OFFC_SEQS_APPLY_M b, qt_userid c ");
		sql.append("Where a.id_exam = ? and a.userid = c.userid and b.TRAINING_MEMBERSHIP_ID_NO = c.link_userid and ");
		sql.append("      b.TRAINING_EVALUATION_SEQS_ID = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_course.substring(2,id_course.length()));
            stm.setString(2, userid);
            stm.setString(3, id_exam);
            stm.setString(4, id_subject.substring(2,id_subject.length()));
            stm.executeUpdate();
			
            scoreExportUpdate(id_exam, id_subject, userid);
        }
        catch (SQLException ex) {
            throw new QmTmException("[LmsScoreExport.scoreExport]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
	
	public static void scoreExportUpdate(String id_exam, String id_subject, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();
				
		sql.append("Update TB_EVAL_IN_OFFC_SEQS_APPLY_M ");		
		sql.append("       Set TRAIN_EVAL_RESULT_STATUS_CODE = 'B', ");
		sql.append("           LAST_UPDATED_BY = ?, ");
		sql.append("           LAST_UPDATE_TIMESTAMP = GETDATE() ");
		sql.append("Where TOTAL_EVALUATION_SCORE IS NULL and ");
		sql.append("      TRAINING_EVALUATION_SEQS_ID = ? ");
		
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            stm.setString(2, id_subject.substring(2,id_subject.length()));
            stm.executeUpdate();
        }
        catch (SQLException ex) {
            throw new QmTmException("[LmsScoreExport.scoreExportUpdate]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }	
}