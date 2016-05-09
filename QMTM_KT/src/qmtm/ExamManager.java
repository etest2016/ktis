package qmtm;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class ExamManager
{
    public ExamManager() {
    }
		
	public static String getLoginChk(String userid, String passwd) throws QmTmException {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select name From score_manager Where userid = ? and password = ? ");
		
	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, userid);
			stm.setString(2, passwd);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("name");
            else return null;
        } catch (SQLException ex) {
            throw new QmTmException("ä���� �̸� ������ �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�.");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

}
