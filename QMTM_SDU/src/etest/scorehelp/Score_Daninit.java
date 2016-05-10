package etest.scorehelp;

import qmtm.QmTm;
import qmtm.DBPool;
import qmtm.QmTmException;
import java.sql.*;
import java.util.*;

// for exam/myTest.jsp

public class Score_Daninit
{
    public Score_Daninit() {}

    public static void run_init(String id_exam, int id_q) throws QmTmException
    {
		//Step 1
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();
		
		int qcount = 0;
		int setcount = 0;

		String sUserid = "";
		String sAns = "";
		String user_ans = "";
		int cnt_yn = 0;
		int rowCnt = 0;

		sql.append("Select qcount, setcount ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");
        
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

			if (rst.next()) {
				qcount = rst.getInt(1);
				setcount = rst.getInt(2);

				userAns(id_exam, id_q, qcount, cnn);
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[ScoreDaninit->run_init]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


	private static void userAns(String id_exam, int id_q, int qcount, Connection cnn) throws QmTmException
    {

		PreparedStatement stm2 = null; ResultSet rst2 = null; 
		StringBuffer sql2 = new StringBuffer();

		// 변수 선언
		String sUserid = "";
		String sAns = "";
		String sOxs = "";
		String user_ans = "";
		int cnt_yn = 0;

		sql2.append("Select a.userid, a.answers, a.oxs, b.nr_q ");
		sql2.append("From exam_ans a, exam_paper2 b ");
		sql2.append("Where a.id_exam = ? and  b.id_q = ? and ");
		sql2.append("      a.id_exam = b.id_exam and a.nr_set = b.nr_set and a.userid <> 'tman@@2008' ");

        try
        {
            //cnn = DBPool.getConnection();
            stm2 = cnn.prepareStatement(sql2.toString());
            stm2.setString(1, id_exam);
			stm2.setInt(2, id_q);
            rst2 = stm2.executeQuery();

            while (rst2.next()) {
				sUserid = rst2.getString(1);
				sAns = rst2.getString(2);
				sOxs = rst2.getString(3);

				String[] tmpAnswers = new String[qcount];
				String[] tmpOxs = new String[qcount];
			

				if (sAns == "")  // 응시자 답안이 없을 경우 빈 답안을 만든다.
				{
					sAns = QmTm.join(tmpAnswers, "{:}");
				}

				tmpAnswers = sAns.split(QmTm.Q_GUBUN_re, -1);
				user_ans = tmpAnswers[rst2.getInt(4)-1].toString().replace("'", "''");
				cnt_yn = userCnt(id_exam, id_q, sUserid, cnn);

				tmpOxs = sOxs.split(QmTm.Q_GUBUN_re, -1);

				if(tmpOxs[rst2.getInt(4)-1].equals("X")) { // 일괄채점 후 오답일경우만 적용한다.
			
					if(cnt_yn > 0) {
						ansUpdate(user_ans, id_exam, id_q, sUserid, cnn);
					} else {
						ansInsert(user_ans, id_exam, id_q, sUserid, cnn);
					}

				}				
			}
		}
		catch (SQLException ex) {
			throw new QmTmException("[ScoreDaninit->userAns]" + ex.getMessage());
		}
		finally {
			if (rst2 != null) try { rst2.close(); } catch (SQLException ex) {}
			if (stm2 != null) try { stm2.close(); } catch (SQLException ex) {}
		}
	}
				
	private static int userCnt(String id_exam, int id_q, String sUserid, Connection cnn) throws QmTmException
    {
			
		PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		int cnt_yn = 0;
			
		sql.append("Select count(userid) ");
		sql.append("From imsi_exam_ans_result ");
		sql.append("Where id_exam = ? and id_q = ? and userid = ? ");
				
		try
		{
            //cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, sUserid);

			rst = stm.executeQuery();

			if (rst.next()) {
				cnt_yn = rst.getInt(1);
			} 

			return cnt_yn;
		}
		catch (SQLException ex) {	
            throw new QmTmException("[ScoreDaninit->userCnt]" + ex.getMessage());
		}
		finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
		}
	}					
				
	private static void ansUpdate(String user_ans, String id_exam, int id_q, String sUserid, Connection cnn) throws QmTmException
    {
		PreparedStatement stm = null;  
		StringBuffer sql = new StringBuffer();	
			
		sql.append("Update imsi_exam_ans_result ");
		sql.append("Set answer = ?, reg_date = getdate() ");
		sql.append("Where id_exam = ? and id_q = ? and userid = ? ");

		try {
			//cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, user_ans);
			stm.setString(2, id_exam);
			stm.setInt(3, id_q);
			stm.setString(4, sUserid);

			stm.execute();
		}
		catch (SQLException ex) {
            throw new QmTmException("[ScoreDaninit->ansUpdate]" + ex.getMessage());
		}
		finally {
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
		}
	}
			
	private static void ansInsert(String user_ans, String id_exam, int id_q, String sUserid, Connection cnn) throws QmTmException
    {				
		PreparedStatement stm = null;  
		StringBuffer sql = new StringBuffer();	
			
		sql.append("Insert into imsi_exam_ans_result(id_exam, id_q, userid, answer, reg_date) ");
		sql.append("values(?, ?, ?, ?, getdate()) ");

		try	{
            //cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, sUserid);

			if (user_ans.trim().length() == 0) {
				user_ans = " ";
			}
			stm.setString(4, user_ans);
						
			stm.execute();
		}
		catch (SQLException ex) {						
            throw new QmTmException("[ScoreDaninit->ansInsert]" + ex.getMessage());
		}
		finally {
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
		}
	}
}
  