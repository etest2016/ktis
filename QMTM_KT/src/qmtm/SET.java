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

	public static final String NL = "\r\n"; // 개발
	// public static final String NL = "\n"; // for Unix

	public static final String FLD_KB = "┃"; // field 구분자 (\u2503) : ㅂ --> 한자
												// --> 4 of page 2

	public static final String NON_NL = "│"; // 논술답안의 줄바꿈 (\u2502) : ㅂ --> 한자
												// --> 2 of page 1

	public static final boolean PART_POINT = false; // 복수답안형의 부분점수 적용 여부 (단답형에서는 적용되지 않음)

	public static final String PAPER_HTML_PATH = "C:/QMTMADMIN/paper_file/";

	/////////////////////////////////////////////////////////////////////////////////////////////////////	
    public static final int SAFE_TIME = 10;          // 재입장시 여유시간 [분]
    public static final int ANS_MAX_LEN = 7;         // 답안지에 표시할 최대 문자수
    public static final boolean STOP = true;         // 답안저장실패시 진행멈춤 (답안제출시는 재제출)
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
            System.out.println("[SET.getConnection DB연결실패]" + ex.getMessage() + " on " + new Timestamp(System.currentTimeMillis()).toString().substring(0, 19));
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
			System.out.println("[SET.saveFile] : To 운영자 --> [" + DBPool.LOG_PATH + "] 폴더를 만들어 주세요...시험로그를 저장할 수 없습니다.");
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
			System.out.println("[SET.saveFile] : To 운영자 --> [" + DBPool.LOG_PATH + "] 폴더를 만들어 주세요...시험로그를 저장할 수 없습니다.");
		}
	}
}
