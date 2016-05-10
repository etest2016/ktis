<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // 사용자 아이디
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	int qcnt = Integer.parseInt(request.getParameter("qcnt"));
	int tcnt = Integer.parseInt(request.getParameter("tcnt"));
%>

<html>
<head>

<title>온라인 평가시스템 </title>

<frameset rows="40, *" frameborder="NO" border="0" framespacing="0">
	<frame id="fraTop" name="fraTop" src="f_top.jsp?userid=<%=userid%>&qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" frameborder="NO" marginwidth="0" marginheight="0" noresize scrolling="no">

	<frameset cols="400, *" frameborder="NO" border="0" framespacing="0">
    <frame id="fraLeft" name="fraLeft" src="f_left.jsp?userid=<%=userid%>&gubun=question" scrolling="No" frameborder="NO" marginwidth="0" marginheight="0">
	<frame id="fraMain" name="fraMain" src="f_main.jsp?userid=<%=userid%>" scrolling="auto" frameborder="NO" marginwidth="0" marginheight="0">
  </frameset>
</frameset>