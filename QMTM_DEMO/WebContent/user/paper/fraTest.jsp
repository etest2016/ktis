<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.ComLib" %>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");
%>
<%  // opener 가 없으면
	//out.print("<script language='javascript'> if (!opener) { window.location.href = '/error/page_error.jsp'; }</script>");
%>
<%

	//String userid =	get_cookie(request, "userid");
	String userid = request.getParameter("userid");

	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

		if(true) return;
	}

	String url = "etest.jsp?id_exam=" + id_exam+"&userid="+userid;
%>

<frameset cols="0, 0, *" border="0" noresize>
	<frame name="fraAction" src="" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>
	<frame name="fraActionEvt" src="" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>
	<frame name="fraTest" src="<%= url %>" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>
</frameset>
