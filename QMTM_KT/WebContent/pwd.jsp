<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>

<%
	response.setDateHeader("Expires", 0);
  request.setCharacterEncoding("EUC-KR");
  
  String password = "lERnmsqI0qU=";
  
  // ��й�ȣ ��ȣȭ.	
	try {
		password = CommonUtil.decrypt(password);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
  }
  
  out.println(password);
%>  

