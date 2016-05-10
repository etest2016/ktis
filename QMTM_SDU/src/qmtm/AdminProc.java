package qmtm;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;
import qmtm.ComLib;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class AdminProc
{
    public AdminProc() {
    }
		
	public static String getLoginChk(String userid, String passwd) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select name ");
		sql.append("From qt_adminid ");
		sql.append("Where userid = ? and (PWDCOMPARE (?, password) = 1) and yn_valid = 'Y' ");
		
	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, passwd);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("name");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("관리자 이름 정보를 읽어오는 중 오류가 발생되었습니다. [AdminProc.getLoginChk] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getLoginName(String userid) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select name ");
		sql.append("From qt_adminid ");
		sql.append("Where userid = ? and yn_valid = 'Y' ");
		
	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("name");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("관리자 이름 정보를 읽어오는 중 오류가 발생되었습니다. [AdminProc.getLoginName] " +ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

}
