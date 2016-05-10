<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="qmtm.ComLib, qmtm.DBPool" %>
<%
	Connection cnn = null;
	Context initContext;
	Context envContext;
	DataSource ds;
	String url = "";
	String runMode = "";
	Statement stm = null; 
	ResultSet rst = null; 
	
	try {
		url="jdbc:jtds:sqlserver://182.252.0.172:1433/SDU_V350;useCursors=true";
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		cnn=DriverManager.getConnection(url,"sdu","dhdnjf2011!@#");
		
		out.println("연결성공");
        
	} catch(Exception e) {
		out.println("<h3>연결에 실패하였습니다.</h3>");
		out.println(e.toString());
		e.printStackTrace();
	}
%>
