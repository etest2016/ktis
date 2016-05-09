package qmtm.tman;

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

public class TreeUtil {
	
	public TreeUtil() {}

	public static String getDesign() throws QmTmException {

        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select paper_types from qt_settings ";

	    try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            rst = stm.executeQuery();

            if (rst.next()) return rst.getString("paper_types"); 
            else return null; 
        } catch (SQLException ex) {
            throw new QmTmException("시험지 탬플릿 정보 읽어오는 중 인터넷 연결상태가 좋지 않습니다. [TreeUtil.getDesign]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
}
