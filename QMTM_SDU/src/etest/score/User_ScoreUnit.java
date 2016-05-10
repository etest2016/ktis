package etest.score;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

// for score/scoreinfo.jsp

public class User_ScoreUnit
{
    public User_ScoreUnit() {}

    public static User_ScoreUnitBean getBean(String userid, String id_exam) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT b.title, b.exam_start1, b.exam_end1, a.score, a.yn_end, ");
        sql.append("       b.yn_open_score_direct, b.yn_open_qa, b.yn_stat, b.stat_start, ");
        sql.append("       b.stat_end, b.qcount, b.allotting, b.id_exam ");
        sql.append("FROM exam_ans a, exam_m b ");
        sql.append("WHERE a.id_exam = ? ");			
		sql.append("	  and a.userid = ? ");
		sql.append("      and a.id_exam = b.id_exam ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);  
			stm.setString(2, userid);
            rst = stm.executeQuery();
            if (rst.next()) { return makeBean(rst); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("성적조회할 응시자 정보를 읽어오는 중 오류가 발생되었습니다. [User_ScoreUnitBean.getBean] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
		
    private static User_ScoreUnitBean makeBean (ResultSet rst) throws QmTmException
    {        
		try {
			User_ScoreUnitBean bean = new User_ScoreUnitBean();
            bean.setTitle(rst.getString(1));
			bean.setExam_start(rst.getTimestamp(2));
            bean.setExam_end(rst.getTimestamp(3));
			bean.setScore(rst.getDouble(4));
            bean.setYn_end(rst.getString(5));         
            bean.setYn_open_score_direct(rst.getString(6));
            bean.setYn_open_qa(rst.getString(7));
            bean.setYn_stat(rst.getString(8));
            bean.setStat_start(rst.getTimestamp(9));
            bean.setStat_end(rst.getTimestamp(10));
            bean.setQcount(rst.getInt(11));
            bean.setAllotting(rst.getDouble(12));
			bean.setId_exam(rst.getString(13));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("성적조회할 응시자 정보를 읽어오는 중 오류가 발생되었습니다. [User_ScoreUnitBean.makeBean] " +ex.getMessage());
        }
    }
}
