<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	int qcnt = Integer.parseInt(request.getParameter("qcnt"));
	int tcnt = Integer.parseInt(request.getParameter("tcnt"));      
%>
<html>
<head>
<title>온라인 평가시스템 </title>


<frameset rows="40, *" frameborder="NO" border="0" framespacing="0">
    <frame id="fraTop" name="fraTop" src="f_top.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0" noresize>
	<frameset cols="400, *" frameborder="NO" border="0" framespacing="0">
		<frame id="fraLeft" name="fraLeft" src="f_left.jsp" frameborder="NO" marginwidth="0" marginheight="0" scrolling="NO">
		<frame id="fraMain" name="fraMain" src="f_main.jsp" scrolling="YES" frameborder="NO" marginwidth="0" marginheight="0">
  </frameset>
</frameset>
