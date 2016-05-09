<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*, qmtm.*"%>
<%	  
	  // Declare the JDBC objects.
	  Connection cnn = null;

	  try {
		 
		 cnn = DBOracle.getConnection();
		 out.println("¼º°ø");
	  }catch (Exception e) {
		 out.println(e.getMessage());
	  }
	  finally {
		 if (cnn != null) try { cnn.close(); } catch(Exception e) {}
	  }
%>