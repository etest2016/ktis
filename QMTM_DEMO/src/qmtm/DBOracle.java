package qmtm;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class DBOracle {
	
	public DBOracle() {
	}

	public static Connection getConnection() throws QmTmException
    {        
        Connection cnn = null;
		String url = "";

		try
	    {
			//url="jdbc:oracle:thin:@182.252.0.173:1521:xe";
			url="jdbc:oracle:thin:@10.18.152.22:30002:h2orcl";
		
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//cnn = DriverManager.getConnection(url,"kt","kt");
			cnn = DriverManager.getConnection(url,"wifipo","wifipo");

            return cnn;
			
        } catch (Exception ex) {
            throw new QmTmException("[DBOracle.getConnection]" + ex.getMessage());
        }
    }
	
}
