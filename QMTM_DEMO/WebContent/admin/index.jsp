<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	int qcnt = Integer.parseInt(request.getParameter("qcnt"));
	int tcnt = Integer.parseInt(request.getParameter("tcnt"));
%>
 
<html>
<head>

<title> KT 인재개발원 온라인 평가시스템 </title>

<frameset rows="40, *" frameborder="NO" border="0" framespacing="0">
	<frame name="fraTop" src="f_top.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0" noresize>

	<frameset cols="250, *" frameborder="NO" border="0" framespacing="0">
    <frame name="fraLeft" src="q_tree/f_left.jsp" scrolling="auto" frameborder="NO" marginwidth="0" marginheight="0">
	<frame name="fraMain" src="q_tree/f_main.jsp" scrolling="auto" frameborder="NO" marginwidth="0" marginheight="0">
  </frameset>
</frameset>    