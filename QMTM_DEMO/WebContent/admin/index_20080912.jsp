<%@ page contentType="text/html; charset=EUC-KR" %>

<%
response.setDateHeader("Expires", 0);
request.setCharacterEncoding("EUC-KR");
%>

<html>
<head>

<title>QMTM Web V5</title>

<frameset rows="90, *" frameborder="NO" border="0" framespacing="0">
	<frame name="fraTop" src="f_top.jsp" scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0" noresize>

	<frameset cols="230, *" frameborder="NO" border="0" framespacing="0">
    <frame name="fraLeft" src="q_tree/f_left.jsp" scrolling="auto" frameborder="NO" marginwidth="0" marginheight="0">
	<frame name="fraMain" src="q_tree/f_main.jsp" scrolling="auto" frameborder="NO" marginwidth="0" marginheight="0">
  </frameset>
</frameset>