package etest.scorehelp;

import qmtm.*;
import java.sql.*;
import java.util.*;

public class Score_NonScore
{

    public Score_NonScore() {}

    public static void saveScore(String id_exam, int id_q, String userid, double dScore) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; PreparedStatement stm2 = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer(); 
		
		int lngQCount = 0;

		//시험의 문제수 체크
		sql.append("Select qcount ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

			if (rst.next()) {
				lngQCount = rst.getInt("qcount");
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_NonScore.saveScore]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
        }

		//문제코드의 같은 정답을 입력한 응시자 목록 가져오기
		sql.setLength(0);
		sql.append("Select a.oxs, nvl(a.points, ' ') points, a.score, b.nr_q, b.allotting ");
		sql.append("From exam_ans a, exam_paper2 b ");
		sql.append("Where a.id_exam = b.id_exam and a.nr_set = b.nr_set and a.id_exam = ? and ");
		sql.append("      a.userid = ? and b.id_q = ? ");

        try
        {
			int nr_q = 0;
			double allotting = 0;
			String strMark = "";
			String oldPoint = "";
			double dPoint = 0;
			double aPoint = 0;
			double nScore = 0;
			String sOxs = "";
			String sPoints = "";

            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setString(2, userid);
			stm.setInt(3, id_q);

            rst = stm.executeQuery();

            while (rst.next()) {
				//같은 답안을 입력한 응시자 목록을 루프돌면서 채점표 및 부분점수를 업데이트
				String[] tmpPoints = new String[lngQCount];
				String[] tmpOxs = new String[lngQCount];

				nr_q = rst.getInt("nr_q");
				allotting = rst.getDouble("allotting");

				if (allotting == dScore) {
					strMark = "O";
				} else if (dScore == 0) {
					strMark = "X";
				} else {
					strMark = "P";
				}

				//수동 채점을 한번도 하지 않은 경우는 split할 필요가 없다
				if (rst.getString("points").trim().length() != 0) {
					tmpPoints = rst.getString("points").split(QmTm.Q_GUBUN_re, -1);
				}

				tmpOxs = rst.getString("oxs").split(QmTm.Q_GUBUN_re, -1);
				oldPoint = tmpPoints[nr_q - 1];
				dPoint = 0;

				//수동채점을 한번도 하지 않은 경우 null값이 들어오므로 체크
				if (oldPoint != null) {
					//해당 문제에 이전에 한번도 부분점수를 주지 않았다면 이전 점수에
					//스페이스가 들어오므로 체크
					if (oldPoint.length() != 0) {
						dPoint = Double.parseDouble(oldPoint);
					}
				}

				tmpOxs[nr_q - 1] = strMark;
				tmpPoints[nr_q - 1] = Double.toString(dScore);

				aPoint = 0;
				if (dPoint > dScore) {
					aPoint = (dPoint - dScore) * -1;
				} else {
					aPoint = dScore - dPoint;
				}

				nScore = 0;
				nScore = rst.getDouble("score") + aPoint;

				sOxs = "";
				sPoints = "";
				sOxs = QmTm.join(tmpOxs, QmTm.Q_GUBUN);
				sPoints = QmTm.join(tmpPoints, QmTm.Q_GUBUN);

				//총점을 업데이트 한다
				sql.setLength(0);
				sql.append("Update exam_ans ");
				sql.append("Set oxs = ?, points = ?, score = ? ");
				sql.append("Where id_exam = ? and userid = ? ");

				try
				{
					stm2 = cnn.prepareStatement(sql.toString());
					stm2.setString(1, sOxs);
					stm2.setString(2, sPoints);
					stm2.setDouble(3, nScore);
					stm2.setString(4, id_exam);
					stm2.setString(5, userid);

					stm2.executeUpdate();
				}
				catch (SQLException ex) {
					throw new QmTmException("[Score_NonScore.saveScore]" + ex.getMessage());
				}
				finally {
					if (stm2 != null) try { stm2.close(); } catch (SQLException ex) {}
				}

				stm2 = null;

				//문제별 점수 항목을 업데이트 한다
				sql.setLength(0);
				sql.append("Update equal_test_result2 ");
				sql.append("Set score_yn = 'Y' ");
				sql.append("Where id_exam = ? and id_q = ? and userid = ? ");

				try
				{
					stm2 = cnn.prepareStatement(sql.toString());
					stm2.setString(1, id_exam);
					stm2.setInt(2, id_q);
					stm2.setString(3, userid);

					stm2.executeUpdate();
				}
				catch (SQLException ex) {
					throw new QmTmException("[Score_NonScore.saveScore]" + ex.getMessage());
				}
				finally {
					if (stm2 != null) try { stm2.close(); } catch (SQLException ex) {}
				}
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_NonScore.saveScore]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


    public static void saveScore2(String id_exam, int id_q, String userids, double dScore) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; PreparedStatement stm2 = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer(); 
		Statement stma = null;
		
		int lngQCount = 0;

		//시험의 문제수 체크
		sql.append("Select qcount ");
		sql.append("From exam_m ");
		sql.append("Where id_exam = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            rst = stm.executeQuery();

			if (rst.next()) {
				lngQCount = rst.getInt("qcount");
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_NonScore.saveScore2]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
        }

		String sql2 = "";
		//문제코드의 같은 정답을 입력한 응시자 목록 가져오기
		/*
		PreparedStatement로 in절에 데이터가 이상하게 들어가지 않아 Statement를 사용함

		sql.setLength(0);
		sql.append("Select a.oxs, nvl(a.points, ' ') points, a.score, b.nr_q, b.allotting, a.userid ");
		sql.append("From exam_ans a, exam_paper2 b ");
		sql.append("Where a.id_exam = b.id_exam and a.nr_set = b.nr_set and a.id_exam = ? and ");
		sql.append("      b.id_q = ? and a.userid in (?)");
		*/

		sql2 = sql2 + "Select a.oxs, nvl(a.points, ' ') points, a.score, b.nr_q, b.allotting, a.userid ";
		sql2 = sql2 + "From exam_ans a, exam_paper2 b ";
		sql2 = sql2 + "Where a.id_exam = b.id_exam and a.nr_set = b.nr_set and a.id_exam = '" + id_exam + "' and ";
		sql2 = sql2 + "      b.id_q = " + Integer.toString(id_q) + " and a.userid in ('" + userids + "') ";

        try
        {
			int nr_q = 0;
			double allotting = 0;
			String strMark = "";
			String oldPoint = "";
			double dPoint = 0;
			double aPoint = 0;
			double nScore = 0;
			String sOxs = "";
			String sPoints = "";

			stma = cnn.createStatement();
            rst = stma.executeQuery(sql2);

			/*

            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, userids);
            rst = stm.executeQuery();
			*/


            while (rst.next()) {
				//같은 답안을 입력한 응시자 목록을 루프돌면서 채점표 및 부분점수를 업데이트
				String[] tmpPoints = new String[lngQCount];
				String[] tmpOxs = new String[lngQCount];

				nr_q = rst.getInt("nr_q");
				allotting = rst.getDouble("allotting");

				if (allotting == dScore) {
					strMark = "O";
				} else if (dScore == 0) {
					strMark = "X";
				} else {
					strMark = "P";
				}

				//수동 채점을 한번도 하지 않은 경우는 split할 필요가 없다
				if (rst.getString("points").trim().length() != 0) {
					tmpPoints = rst.getString("points").split(QmTm.Q_GUBUN_re, -1);
				}

				tmpOxs = rst.getString("oxs").split(QmTm.Q_GUBUN_re, -1);
				oldPoint = tmpPoints[nr_q - 1];
				dPoint = 0;

				//수동채점을 한번도 하지 않은 경우 null값이 들어오므로 체크
				if (oldPoint != null) {
					//해당 문제에 이전에 한번도 부분점수를 주지 않았다면 이전 점수에
					//스페이스가 들어오므로 체크
					if (oldPoint.length() != 0) {
						dPoint = Double.parseDouble(oldPoint);
					}
				}

				tmpOxs[nr_q - 1] = strMark;
				tmpPoints[nr_q - 1] = Double.toString(dScore);

				aPoint = 0;
				if (dPoint > dScore) {
					aPoint = (dPoint - dScore) * -1;
				} else {
					aPoint = dScore - dPoint;
				}

				nScore = 0;
				nScore = rst.getDouble("score") + aPoint;

				sOxs = "";
				sPoints = "";
				sOxs = QmTm.join(tmpOxs, QmTm.Q_GUBUN);
				sPoints = QmTm.join(tmpPoints, QmTm.Q_GUBUN);

				//총점을 업데이트 한다
				sql.setLength(0);
				sql.append("Update exam_ans ");
				sql.append("Set oxs = ?, points = ?, score = ? ");
				sql.append("Where id_exam = ? and userid = ? ");

				try
				{
					stm2 = cnn.prepareStatement(sql.toString());
					stm2.setString(1, sOxs);
					stm2.setString(2, sPoints);
					stm2.setDouble(3, nScore);
					stm2.setString(4, id_exam);
					stm2.setString(5, rst.getString("userid"));

					stm2.executeUpdate();
				}
				catch (SQLException ex) {
					throw new QmTmException("[Score_NonScore.saveScore2]" + ex.getMessage());
				}
				finally {
					if (stm2 != null) try { stm2.close(); } catch (SQLException ex) {}
				}

				stm2 = null;

				//문제별 점수 항목을 업데이트 한다
				sql.setLength(0);
				sql.append("Update equal_test_result2 ");
				sql.append("Set score_yn = 'Y' ");
				sql.append("Where id_exam = ? and id_q = ? and userid = ? ");

				try
				{
					stm2 = cnn.prepareStatement(sql.toString());
					stm2.setString(1, id_exam);
					stm2.setInt(2, id_q);
					stm2.setString(3, rst.getString("userid"));

					stm2.executeUpdate();
				}
				catch (SQLException ex) {
					throw new QmTmException("[Score_NonScore.saveScore2]" + ex.getMessage());
				}
				finally {
					if (stm2 != null) try { stm2.close(); } catch (SQLException ex) {}
				}
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_NonScore.saveScore2]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stma != null) try { stma.close(); } catch (SQLException ex) {}
            //if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

}
