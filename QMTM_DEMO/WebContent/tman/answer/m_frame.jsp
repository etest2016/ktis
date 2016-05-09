<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");
%>

<%  // opener 가 없으면
// out.print("<script language='javascript'> if (!opener) { window.location.href = '../errorAll.jsp'; }</script>");
%>

<%
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String url = "m_user.jsp?id_exam=" + id_exam;
%>

<script language="javascript">
  self.moveTo(0,0) ;
  self.resizeTo(screen.availWidth,screen.availHeight) ;
</script>

<html><head><title> :: 응시자별 채점 :: </title></head>

<frameset rows="140,*" cols="*" frameborder="NO" border="0" framespacing="0">
	<frame src="m_top.jsp" name="topFrame" scrolling="NO" noresize>
	<frameset rows="*" cols="250,*" framespacing="0" frameborder="no" border="0">
		<frame src="<%= url %>" name="fraLeft" scrolling="no" noresize>
		<frame src="m_info.jsp" name="fraMain" scrolling="AUTO">
	</frameset>
</frameset>

</html>