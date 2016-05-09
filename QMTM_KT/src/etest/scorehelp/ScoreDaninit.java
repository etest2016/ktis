package etest.scorehelp;

import qmtm.*;

import java.sql.*;
import java.util.*;

// for exam/myTest.jsp

public class ScoreDaninit
{
    public ScoreDaninit() {}

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

		//System.out.println(id_course);
		//System.out.println(sql.toString());
        
        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

			if (rst.next()) {
				qcount = rst.getInt(1);
				setcount = rst.getInt(2);

				userAns(id_exam, id_q, qcount);
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[ScoreDaninit->Step1]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


	private static void userAns(String id_exam, int id_q, int qcount) throws QmTmException
    {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		// 변수 선언
		String sUserid = "";
		String sAns = "";
		String user_ans = "";
		int cnt_yn = 0;

		sql.append("Select a.userid, a.answers, a.oxs, b.nr_q ");
		sql.append("From exam_ans a, exam_paper2 b ");
		sql.append("Where a.id_exam = ? and  b.id_q = ? and ");
		sql.append("      a.id_exam = b.id_exam and a.nr_set = b.nr_set ");

        try
        {
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setInt(2, id_q);
            rst = stm.executeQuery();

            while (rst.next()) {
				sUserid = rst.getString(1);
				sAns = rst.getString(2);

				sAns = sAns.replace("{|}",",");

				String[] tmpAnswers = new String[qcount];

				//System.out.println("변경 후 : " +sAns);

				
				if (sAns == "")  // 응시자 답안이 없을 경우 빈 답안을 만든다.
				{
					for(int k = 0; k<qcount; k++) {
						QmTm.join(tmpAnswers, QmTm.Q_GUBUN);
					}
				}
				
				StringTokenizer st = new StringTokenizer(sAns, QmTm.Q_GUBUN);
				
				if(st.hasMoreElements()) {
					for(int k = 0; k<qcount; k++) {
						tmpAnswers[k] = st.nextToken();
					}
				} else {
					for(int k = 0; k<qcount; k++) {
						QmTm.join(tmpAnswers, QmTm.Q_GUBUN);
					}
				}
				
				//String[] tmpAnswers = sAns.trim().split("||", -1);
								
				user_ans = tmpAnswers[rst.getInt(4)-1].toString().replace("'", "''");

				cnt_yn = userCnt(id_exam, id_q, sUserid);

				if(cnt_yn > 0) {
					ansUpdate(user_ans, id_exam, id_q, sUserid);
				} else {
					ansInsert(user_ans, id_exam, id_q, sUserid);
				}
			}
		}
		catch (SQLException ex) {
			throw new QmTmException("[ScoreDaninit.userAns]" + ex.getMessage());			
		}
		finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}
				
	private static int userCnt(String id_exam, int id_q, String sUserid) throws QmTmException
    {
			
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		int cnt_yn = 0;
			
		sql.append("Select count(userid) ");
		sql.append("From imsi_exam_ans_result ");
		sql.append("Where id_exam = ? and id_q = ? and userid = ? ");
				
		try
		{
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
			throw new QmTmException("[ScoreDaninit.userCnt]" + ex.getMessage());			
		}
		finally {
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}					
				
	private static void ansUpdate(String user_ans, String id_exam, int id_q, String sUserid) throws QmTmException
    {
		Connection cnn = null; PreparedStatement stm = null;  
		StringBuffer sql = new StringBuffer();	
			
		sql.append("Update imsi_exam_ans_result ");
		sql.append("Set answer = ?, reg_date = sysdate ");
		sql.append("Where id_exam = ? and id_q = ? and userid = ? ");

		try {
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, user_ans);
			stm.setString(2, id_exam);
			stm.setInt(3, id_q);
			stm.setString(4, sUserid);

			stm.executeUpdate();
		}
		catch (SQLException ex) {
			throw new QmTmException("[ScoreDaninit.ansUpdate]" + ex.getMessage());
		}
		finally {
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}
			
	private static void ansInsert(String user_ans, String id_exam, int id_q, String sUserid) throws QmTmException
    {				
		Connection cnn = null; PreparedStatement stm = null;  
		StringBuffer sql = new StringBuffer();	
			
		sql.append("Insert into imsi_exam_ans_result(id_exam, id_q, userid, answer, reg_date) ");
		sql.append("values(?, ?, ?, ?, sysdate) ");

		try	{
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, sUserid);
			stm.setString(4, user_ans);
						
			stm.executeUpdate();
		}
		catch (SQLException ex) {						
			throw new QmTmException("[ScoreDaninit.ansInsert]" + ex.getMessage());
		}
		finally {
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}
}
  