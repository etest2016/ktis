package qmtm.admin.etc;

// Package Import
import qmtm.DBPool;
import qmtm.QmTmException;

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

        sql.append("UPDATE qt_settings SET qmtm_password = ? ");
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
            throw new QmTmException("������ ��й�ȣ �����ϴ� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [EnvUtil.update]");
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
            throw new QmTmException("FTP ��� �����ϴ� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [EnvUtil.updateFTP]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getFTP(String id) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select http_files_url From qt_settings Where id = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("http_files_url"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("FTP ��θ� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [EnvUtil.getFTP]");
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
            throw new QmTmException("WEB ��� �����ϴ� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [EnvUtil.updateWEB]");
        }
        finally {
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }

	public static String getWEB(String id) throws QmTmException
	{
		Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";

		sql = "Select qmtm_web_home From qt_settings Where id = ? ";

		try {
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id);

            rst = stm.executeQuery();
            if (rst.next()) { return rst.getString("qmtm_web_home"); }
            else { return null; }
        } catch (SQLException ex) {
            throw new QmTmException("WEB ��θ� �о���� �� ���ͳ� ������°� ���� �ʽ��ϴ�. [EnvUtil.getWEB]");
        } finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
	}
}