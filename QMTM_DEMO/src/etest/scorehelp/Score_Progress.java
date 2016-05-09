package etest.scorehelp;

import qmtm.*;

import java.sql.*;
import java.util.*;

public class Score_Progress
{
    public Score_Progress() {
    }

	public static int getCnta(String id_exam, String id_q) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(userid) as cnta ");
		sql.append("From exam_ans_non ");
		sql.append("Where id_exam = ? and id_q = ? ");
		sql.append("	and Length(userans1) > 0 ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getInt(1);
            else return 0; 
            
        } catch (SQLException ex) {
            throw new QmTmException("[Score_Progress.getCnta]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }


	public static int getCntb(String id_exam, String id_q) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("Select count(o_userid) as cntb ");
		sql.append("From equal_comp_result ");
		sql.append("Where id_exam = ? and id_q = ? ");

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id_exam);
            stm.setString(2, id_q);
            rst = stm.executeQuery();
            
            if (rst.next()) return rst.getInt(1);
            else return 0; 
            
        } catch (SQLException ex) {
            throw new QmTmException("[Score_Progress.getCntb]" + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

}