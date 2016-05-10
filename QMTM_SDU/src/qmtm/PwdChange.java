package qmtm;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class PwdChange
{
    public PwdChange() {
    }	
	
	public static int getPwdChange(String id) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select datediff(dd,convert(varchar(10), passwd_date, 120),convert(varchar(10), getdate(), 120)) as day_diff ");
		sql.append("From qt_settings ");
		sql.append("Where id = ? ");
		sql.append("Union All ");
		sql.append("Select datediff(dd,convert(varchar(10), passwd_date, 120),convert(varchar(10), getdate(), 120)) as day_diff ");
		sql.append("From qt_adminid ");
		sql.append("Where userid = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id);
			stm.setString(2, id);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getInt("day_diff"); }
            else { return 0; }
        } catch (SQLException ex) {
            throw new QmTmException("비밀번호 변경일자를 읽어오는 중 오류가 발생되었습니다. [PwdChange.getPwdChange] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
}