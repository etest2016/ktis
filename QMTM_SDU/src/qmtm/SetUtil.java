package qmtm;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class SetUtil {
	// DB_TYPE
	public static final String DB_TYPE = "oracle";

	// public static final String NL = "\r\n"; // 개발
	public static final String NL = "\n"; // for Unix

	public static final String FLD_KB = "┃"; // field 구분자 (\u2503) : ㅂ --> 한자
												// --> 4 of page 2

	public static final String NON_NL = "│"; // 논술답안의 줄바꿈 (\u2502) : ㅂ --> 한자
												// --> 2 of page 1

	public static final boolean PART_POINT = false; // 복수답안형의 부분점수 적용 여부 (단답형에서는 적용되지 않음)

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
            System.out.println("[SetUtil.getConnection DB연결실패]" + ex.getMessage() + " on " + new Timestamp(System.currentTimeMillis()).toString().substring(0, 19));
            throw new QmTmException("[SetUtil.getConnection]" + ex.getMessage());
        }
    }	
}