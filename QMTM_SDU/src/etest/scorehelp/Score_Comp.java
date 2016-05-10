package etest.scorehelp;

import qmtm.*;

import java.sql.*;
import java.util.*;

public class Score_Comp
{
    public Score_Comp() {
    }

	public static String getBasicAns(String id_exam, String id_q, int icomp) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select search_comp ");
		sql.append("From basic_ans_non ");
		sql.append("Where id_exam = ? and id_q = ? and comp_bigo = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
			stm.setInt(3, icomp);
            rst = stm.executeQuery();
            if (rst.next()) {
				return rst.getString(1);
			} else {
				return "";
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_Comp.getBasicAns]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }


	public static String getAnswers(String id_exam, String id_q, String userid) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;

		StringBuffer sql = new StringBuffer();

		sql.append("Select userans1, nvl(userans2, ' '), nvl(userans3, ' '), nvl(userans4, ' '), nvl(userans5, ' '), nvl(userans6, ' ') ");
		sql.append("From exam_ans_non ");
		sql.append("Where id_exam = ? and id_q = ? and userid = ? and length(userans1) > 0 ");
		sql.append("Order by userid ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
            stm.setString(3, userid);
            rst = stm.executeQuery();

			if (rst.next()) {
				return rst.getString(1) + rst.getString(2) + rst.getString(3) + rst.getString(4) + rst.getString(5) + rst.getString(6);
			} else {
				return "";
			}
        }
        catch (SQLException ex) {
            throw new QmTmException("[Score_Comp.getAnswers]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}