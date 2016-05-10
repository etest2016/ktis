package qmtm;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import java.io.FileWriter;
import java.io.File;
import java.util.ResourceBundle;

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
	
	public static final String LOG_PATH = ComLib.getConfig("LOG_PATH");
	public static final String XML_PATH = ComLib.getConfig("XML_PATH");

	/////////////////////////////////////////////////////////////////////////////////////////////////////	
    public static final int SAFE_TIME = 10;          // ������� �����ð� [��]
    public static final int ANS_MAX_LEN = 7;         // ������� ǥ���� �ִ� ���ڼ�
    public static final boolean STOP = true;         // ���������н� ������� (�������ô� ������)
	/////////////////////////////////////////////////////////////////////////////////////////////////////

	public static ResourceBundle configBundle = null;

	public DBPool() {
	}

	public static Connection getConnection() throws QmTmException
    {        
        Connection cnn = null;
		Context initContext;
		Context envContext;
		DataSource ds;
		String url = "";
		String runMode = "";
		
		try
	    {
			url="jdbc:jtds:sqlserver://117.17.126.47:1433/SDU_ETEST;useCursors=true";
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			cnn=DriverManager.getConnection(url,"etest","etest@123");
			
			return cnn;			
			
        } catch (Exception ex) {
            System.out.println("[DBPool.getConnection DB�������]" + ex.getMessage() + " on " + new Timestamp(System.currentTimeMillis()).toString().substring(0, 19));
            throw new QmTmException("[DBPool.getConnection]" + ex.getMessage());
        }
    }	
	
	public static void saveFile(String text, String dirName, String fileName, boolean append)
    {
        String fullPathFileName = dirName + "/" + fileName;

        File dir = new File(dirName);
        try {
            if (!dir.exists()) {
                dir.mkdir();
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

        try {
            FileWriter output = new FileWriter(fullPathFileName, append);
            output.write(text, 0, text.length());
            output.flush();
            output.close();
        } catch (Exception ex) {
            System.out.println("[User_Log.saveFile] : To ��� --> [" + DBPool.LOG_PATH + "] ������ ����� �ּ���...����α׸� ������ �� �����ϴ�.");
        }
    }	
}
