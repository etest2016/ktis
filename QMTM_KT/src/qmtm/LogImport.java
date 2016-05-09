package qmtm;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

// Java API Import
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.util.Collection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class LogImport
{
    public LogImport() {
    }

    public static void delete(String id_exam) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Delete From qt_user_log ");
		sql.append("Where id_exam = ? ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("응시자 로그정보 삭제하는 중 인터넷 연결상태가 좋지 않습니다. [LogImport.delete]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	
	public static void insert(String id_exam, String userid, String user_ip, String id_activity_type, String user_browser, Timestamp log_date, String server_no) throws QmTmException {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Insert into qt_user_log ");
		sql.append("Values(?, ?, ?, ?, ?, ?, ?) ");

		try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			stm.setString(2, userid);			
			stm.setString(3, user_ip);
			stm.setString(4, id_activity_type);
			stm.setString(5, user_browser);
			stm.setTimestamp(6, log_date);
			stm.setString(7, server_no);
			stm.execute();
		} catch (SQLException ex) {
			throw new QmTmException("응시자 로그정보 등록하는 중 인터넷 연결상태가 좋지 않습니다. [LogImport.insert]");
		} finally {
			if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
			if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
		}
	}
	
	public static LogImportBean[] getBeans(String id_exam) throws QmTmException {

		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 

		StringBuffer sql = new StringBuffer();

		sql.append("Select b.title, a.userid, c.name, a.user_ip, a.id_activity_type, a.user_browser, a.log_date, a.rmk ");
		sql.append("From qt_user_log a, exam_m b, qt_userid c ");
		sql.append("Where a.id_exam = ? and a.id_exam = b.id_exam and a.userid = c.userid ");
		sql.append("Order by c.name, a.rmk, a.log_date ");

		try {
			Collection beans = new ArrayList();
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, id_exam);
			rst = stm.executeQuery();
			
			LogImportBean bean = null;
			
			while (rst.next()) {
				bean = makeBeans(rst);
				beans.add(bean);
			}
			if (bean == null) {
				return null;
			} else {
				return (LogImportBean[]) beans.toArray(new LogImportBean[0]);
			}
		} catch (SQLException ex) {
			throw new QmTmException("응시자 로그정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [LogImport.getBeans]");
		} finally {
			if (rst != null) 	try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) 	try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) 	try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static LogImportBean makeBeans(ResultSet rst) throws QmTmException {
		try {
			LogImportBean bean = new LogImportBean();
			bean.setTitle(rst.getString("title"));
			bean.setUserid(rst.getString("userid"));
			bean.setName(rst.getString("name"));
			bean.setUser_ip(rst.getString("user_ip"));
			bean.setId_activity_type(rst.getString("id_activity_type"));
			bean.setUser_browser(rst.getString("user_browser"));
			bean.setLog_date(rst.getString("log_date"));
			bean.setServer_no(rst.getString("rmk"));
			return bean;
		} catch (SQLException ex) {
			throw new QmTmException("응시자 로그정보 읽어오는중 인터넷 연결상태가 좋지 않습니다. [LogImport.makeBeans]");
		}
	}
}
