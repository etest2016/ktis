package qmtm;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class SetUtil {
	// DB_TYPE
	public static final String DB_TYPE = "oracle";

	// public static final String NL = "\r\n"; // ����
	public static final String NL = "\n"; // for Unix

	public static final String FLD_KB = "��"; // field ������ (\u2503) : �� --> ����
												// --> 4 of page 2

	public static final String NON_NL = "��"; // �������� �ٹٲ� (\u2502) : �� --> ����
												// --> 2 of page 1

	public static final boolean PART_POINT = false; // ����������� �κ����� ���� ���� (�ܴ��������� ������� ����)

	public static final String LOG_PATH = "C:/Program Files/Apache Software Foundation/Tomcat 5.5/webapps/ROOT/logs/";

	public SetUtil() {
	}

	public static Connection getConnection() throws QmTmException
    {        
        Connection cnn = null;
		Context initContext;

		try
	    {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");

			DataSource ds = (DataSource) envContext.lookup("jdbc/myOralce");
            
            return ds.getConnection();

        } catch (Exception ex) {
            System.out.println("[SetUtil.getConnection DB�������]" + ex.getMessage() + " on " + new Timestamp(System.currentTimeMillis()).toString().substring(0, 19));
            throw new QmTmException("[SetUtil.getConnection]" + ex.getMessage());
        }
    }	
}