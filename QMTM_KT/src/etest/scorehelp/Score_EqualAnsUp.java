package etest.scorehelp;

import qmtm.*;
import java.sql.*;

//for exam/myTest.jsp

public class Score_EqualAnsUp
{

    public Score_EqualAnsUp() {}

	public static void update(String equal_chk, String equal_reason, double score, String equal_list, String id_exam, int id_q, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		//기존 데이터 삭제
		sql.append("update equal_comp_result ");
		sql.append("set equal_chk = ?, equal_reason = ?, score = ?, equal_ans = ? ");
		sql.append("Where id_exam = ? and id_q = ? and o_userid = ? ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, equal_chk);
			stm.setString(2, equal_reason);
			stm.setDouble(3, score);
			stm.setString(4, equal_list);
			stm.setString(5, id_exam);
			stm.setInt(6, id_q);
			stm.setString(7, userid);
			stm.executeQuery();
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualAnsUp.update]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}

	public static void cancel(String id_exam, int id_q, String userid) throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null;
		StringBuffer sql = new StringBuffer();

		//기존 데이터 삭제
		sql.append("Update equal_comp_result ");
		sql.append("Set equal_chk = 'N', equal_reason = null, score = null, equal_ans = null ");
		sql.append("Where id_exam = ? and id_q = ? and o_userid = ? ");

		try	{
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setInt(2, id_q);
			stm.setString(3, userid);
			stm.executeQuery();
		}
        catch (SQLException ex) {
            throw new QmTmException("[Score_EqualAnsUp.cancel]" + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
}
