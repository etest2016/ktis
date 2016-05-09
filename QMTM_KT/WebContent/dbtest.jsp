<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*, qmtm.*"%>

<%	  
	  // Declare the JDBC objects.
	  Connection cnn = null;
	  Context initContext;
	  String url = "";

	  try {
		 
		  url="jdbc:postgresql://localhost/ktis";
		  Class.forName("org.postgresql.Driver");
		  cnn=DriverManager.getConnection(url,"postgres","etest");
		  
		 out.println("¼º°ø");
	  }catch (Exception e) {
		 out.println(e.getMessage());
	  }
	  finally {
		 if (cnn != null) try { cnn.close(); } catch(Exception e) {}
	  }
%>