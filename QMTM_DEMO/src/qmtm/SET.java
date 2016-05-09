package qmtm;

import java.io.File;
import java.io.FileWriter;
import java.io.FileOutputStream;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class SET {
	// DB_TYPE
	public static final String DB_TYPE = "mssql";

	public static final String NL = "\r\n"; // ����
	// public static final String NL = "\n"; // for Unix

	public static final String FLD_KB = "��"; // field ������ (\u2503) : �� --> ����
												// --> 4 of page 2

	public static final String NON_NL = "��"; // �������� �ٹٲ� (\u2502) : �� --> ����
												// --> 2 of page 1

	public static final boolean PART_POINT = false; // ����������� �κ����� ���� ���� (�ܴ��������� ������� ����)

	public static final String PAPER_HTML_PATH = "C:/QMTMADMIN/paper_file/";

	/////////////////////////////////////////////////////////////////////////////////////////////////////	
    public static final int SAFE_TIME = 10;          // ������� �����ð� [��]
    public static final int ANS_MAX_LEN = 7;         // ������� ǥ���� �ִ� ���ڼ�
    public static final boolean STOP = true;         // ���������н� ������� (�������ô� ������)
	/////////////////////////////////////////////////////////////////////////////////////////////////////

	public SET() {
	}

	public static Connection getConnection() throws QmTmException
    {        
        Connection cnn = null;
		Context initContext;
		String url = "";

		try
	    {
			url="jdbc:jtds:sqlserver://61.100.1.244:1433/wooribank_v350;useCursors=true";
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			cnn=DriverManager.getConnection(url,"sa","dkaghdlqfur2");

            return cnn;
			
        } catch (Exception ex) {
            System.out.println("[SET.getConnection DB�������]" + ex.getMessage() + " on " + new Timestamp(System.currentTimeMillis()).toString().substring(0, 19));
            throw new QmTmException("[SET.getConnection]" + ex.getMessage());
        }
    }
	
	public static void saveFile(String text, String dirName, String fileName,
			boolean append) {
		String fullPathFileName = dirName + "/" + fileName;

		File dir = new File(dirName);

		File delFile = new File(fullPathFileName);
		
		try {
			delFile.delete();
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
			System.out.println("[SET.saveFile] : To ��� --> [" + DBPool.LOG_PATH + "] ������ ����� �ּ���...����α׸� ������ �� �����ϴ�.");
		}
	}

	public static void saveFile2(byte[] text, String dirName, String fileName, boolean append) {
		String fullPathFileName = dirName + "/" + fileName;

		File dir = new File(dirName);

		File delFile = new File(fullPathFileName);
		
		try {
			delFile.delete();
			if (!dir.exists()) dir.mkdir();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}

		try {
			FileOutputStream output = new FileOutputStream(fullPathFileName, append);
			output.write(text);
			output.close();
		} catch (Exception ex) {
			System.out.println("saveFile2 = " + ex);
			System.out.println("[SET.saveFile] : To ��� --> [" + DBPool.LOG_PATH + "] ������ ����� �ּ���...����α׸� ������ �� �����ϴ�.");
		}
	}
}
