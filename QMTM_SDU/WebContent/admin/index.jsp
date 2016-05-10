<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	if ((request.getParameter("qcnt") == null) || (request.getParameter("tcnt") == null)) {
		out.println(ComLib.getAlertMsg("파라미터 정보가 잘못되었습니다.", "back"));
		if ( true ) return;
	} else {
		int qcnt = Integer.parseInt(request.getParameter("qcnt"));
		int tcnt = Integer.parseInt(request.getParameter("tcnt"));
%>

<html>
<head>

<title>온라인 평가시스템 </title>

<frameset rows="40, *" frameborder="NO" border="0" framespacing="0">
	<frame name="fraTop" src="f_top.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0" noresize>

	<frameset cols="400, *" frameborder="NO" border="0" framespacing="0">
    <frame name="fraLeft" src="exam_info/e_left.jsp" scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0">
	<frame name="fraMain" src="exam_info/exam_ing_list.jsp" scrolling="auto" frameborder="NO" marginwidth="0" marginheight="0">
  </frameset>
</frameset>

<%
	}
%>
 