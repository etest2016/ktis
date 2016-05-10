package qmtm.admin.etc;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;
import qmtm.ComLib;


// Java API Import
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class EnvUtil
{
    public EnvUtil() {
    }
	
	public static void update(String userid, String pwd) throws QmTmException
    {
		Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("UPDATE qt_settings SET qmtm_password = PWDENCRYPT(?), passwd_date = getdate() ");
		sql.append("Where id = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, pwd);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("관리자 비밀번호 수정하는 중 오류가 발생되었습니다. [EnvUtil.update] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static void updateFTP(String userid, String ftp_path) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE qt_settings SET http_files_url = ? ");
		sql.append("Where id = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, ftp_path);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("FTP 경로 수정하는 중 오류가 발생되었습니다. [EnvUtil.updateFTP] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getFTP(String id) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select http_files_url ");
		sql.append("From qt_settings ");
		sql.append("Where id = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("http_files_url"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("FTP 경로를 읽어오는 중 오류가 발생되었습니다. [EnvUtil.getFTP] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}


	public static void updateWEB(String userid, String web_path) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; 
		StringBuffer sql = new StringBuffer();

        sql.append("UPDATE qt_settings SET qmtm_web_home = ? ");
		sql.append("Where id = ? ");

        try
        {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
			stm.setString(1, web_path);
			stm.setString(2, userid);

			stm.execute();
        }
        catch (SQLException ex) {
            throw new QmTmException("WEB 경로 수정하는 중 오류가 발생되었습니다. [EnvUtil.updateWEB] " + ex.getMessage());
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getWEB(String id) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
		StringBuffer sql = new StringBuffer();

		sql.append("Select qmtm_web_home ");
		sql.append("From qt_settings ");
		sql.append("Where id = ? ");

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql.toString());
            stm.setString(1, id);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("qmtm_web_home"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("WEB 경로를 읽어오는 중 오류가 발생되었습니다. [EnvUtil.getWEB] " + ex.getMessage());
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
	
	public static EnvUtilBean getSetInfo() throws QmTmException 
	{
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null;
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT ftp_host_ip, ftp_port, ftp_id, ftp_password, ftp_files_dir, http_files_url, qmtm_web_home ");
		sql.append("FROM qt_settings ");
		
	    try {
			cnn = DBPool.getConnection();
			stm = cnn.prepareStatement(sql.toString());						
			rst = stm.executeQuery();
			if (rst.next()) {
				return makeBean(rst);
			} else {
				return null;
			}
		} catch (SQLException ex) {
			throw new QmTmException("셋팅 정보 읽어오는 중 오류가 발생되었습니다. [EnvUtil.getBean] " +ex.getMessage());
		} finally { 
			if (rst != null) try { rst.close(); } catch (SQLException ex) {}
			if (stm != null) try { stm.close(); } catch (SQLException ex) {}
			if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
		}
	}

	private static EnvUtilBean makeBean (ResultSet rst) throws QmTmException
    {
		
		try {
			EnvUtilBean bean = new EnvUtilBean();
            bean.setFtp_host_ip(rst.getString(1));
            bean.setFtp_port(rst.getString(2));
			bean.setFtp_id(rst.getString(3));
			bean.setFtp_password(rst.getString(4));
			bean.setFtp_files_dir(rst.getString(5));
			bean.setHttp_files_url(rst.getString(6));
			bean.setQmtm_web_home(rst.getString(7));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("셋팅 정보 읽어오는 중 오류가 발생되었습니다. [EnvUtilBean.makeBean] " +ex.getMessage());
        }
    }
}