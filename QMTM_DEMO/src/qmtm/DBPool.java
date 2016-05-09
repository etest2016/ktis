package qmtm;

import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;

import javax.naming.Context;

public class DBPool {
	// DB_TYPE
	public static final String DB_TYPE = "mssql";

	public static final String NL = "\r\n"; // ����
	// public static final String NL = "\n"; // for Unix

	public static final String FLD_KB = "��"; // field ������ (\u2503) : �� --> ����
												// --> 4 of page 2

	public static final String NON_NL = "��"; // �������� �ٹٲ� (\u2502) : �� --> ����
												// --> 2 of page 1

	public static final boolean PART_POINT = false; // ����������� �κ����� ���� ���� (�ܴ��������� ������� ����)

	public static final String LOG_PATH = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/logs/";
	public static final String XML_PATH = "E:/eclipse/workspace/QMTM_DEMO/WebContent/dhtmlxGrid/xml";

	/////////////////////////////////////////////////////////////////////////////////////////////////////	
    public static final int SAFE_TIME = 10;          // ������� �����ð� [��]
    public static final int ANS_MAX_LEN = 7;         // ������� ǥ���� �ִ� ���ڼ�
    public static final boolean STOP = true;         // ���������н� ������� (�������ô� ������)
	/////////////////////////////////////////////////////////////////////////////////////////////////////

	public DBPool() {
	}

	public static Connection getConnection() throws QmTmException
    {        
        Connection cnn = null;
		Context initContext;
		String url = "";

		try
	    {
			/*initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");

			DataSource ds = (DataSource) envContext.lookup("jdbc/etest");
			
			return ds.getConnection();		*/	
			
			/*
			url="jdbc:jtds:sqlserver://192.168.0.114:1433/kt_v35;useCursors=true";
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			cnn=DriverManager.getConnection(url,"sa","dhdnjf2011!@#");
			*/

			//postgres connection
			url="jdbc:postgresql://192.168.0.228:5432/ktis";
			Class.forName("org.postgresql.Driver");
			String user     = "postgres";
			String password = "etest";
			cnn = DriverManager.getConnection(url, user, password);
			
            return cnn;
			

        } catch (Exception ex) {
            System.out.println("[DBPool.getConnection DB�������]" + ex.getMessage() + " on " + new Timestamp(System.currentTimeMillis()).toString().substring(0, 19));
            throw new QmTmException("[DBPool.getConnection]" + ex.getMessage());
        }
    }
	
	public static void saveFile(String text, String dirName, String fileName,
			boolean append) {
		String fullPathFileName = dirName + "/" + fileName;

		File dir = new File(dirName);
		try {
			if (!dir.exists()) dir.mkdir();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}

		try {
			FileWriter output = new FileWriter(fullPathFileName, append);
			output.write(text, 0, text.length());
			output.flush();
			output.close();
		} catch (Exception ex) {
			System.out.println("saveFile = " + ex);
			System.out.println("[Log.saveFile] : To ��� --> [" + DBPool.LOG_PATH + "] ������ ����� �ּ���...����α׸� ������ �� �����ϴ�.");
		}
	}
}
