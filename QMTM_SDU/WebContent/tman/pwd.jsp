<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	String str = "%qmtm%";

	String result = "";

	try {
		result = CommonUtil.encrypt(str);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	out.println(result);
	out.println("<BR>");
	out.println(CommonUtil.decrypt(result));
%>