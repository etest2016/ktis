package qmtm.common;

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

public class WorkAdminLog
{
    public WorkAdminLog() {}

    public static void insert(WorkAdminLogBean bean) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("INSERT INTO worker_admin_log(userid, gubun, bigo, regdate) ");
        sql.append("VALUES (?, ?, ?, getdate()) ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, bean.getUserid());
			stm.setString(2, bean.getGubun());
			stm.setString(3, bean.getBigo());

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("Admin관련 로그 등록 중 오류가 발생되었습니다. [WorkAdminLog.insert] " +ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
}