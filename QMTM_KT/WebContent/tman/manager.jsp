<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>
<html>
<head>
<title> KT 인재개발원 온라인 평가시스템 </title>


<frameset rows="40, *" frameborder="NO" border="0" framespacing="0">
    <frame name="fraTop" src="m_top.jsp" scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0" noresize>
	<frameset cols="250, *" frameborder="NO" border="0" framespacing="0">
		<frame name="fraLeft" src="m_left.jsp" frameborder="NO" marginwidth="0" marginheight="0">
		<frame name="fraMain" src="m_main.jsp" scrolling="YES" frameborder="NO" marginwidth="0" marginheight="0">
  </frameset>
</frameset>
