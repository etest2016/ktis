package qmtm;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class SetUtil2 {
	// DB_TYPE
	public static final String DB_TYPE = "oracle";

	public SetUtil2() {
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
            System.out.println("[SetUtil2.getConnection DB연결실패]" + ex.getMessage() + " on " + new Timestamp(System.currentTimeMillis()).toString().substring(0, 19));
            throw new QmTmException("[SetUtil2.getConnection]" + ex.getMessage());
        }
    }	
}