<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.ComLib" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>
<%
	// opener 가 없으면
	//out.print("<script language='javascript'> if (!opener) { window.location.href = '/error/page_error.jsp'; }</script>");
%>
<%
	//String userid = request.getParameter("userid");
	String userid = (String)session.getAttribute("current_userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if(userid.equals("")) {
		if(request.getParameter("userid").equals("tman@@2008")) { // 관리자 화면 미리보기 예외처리
			session.setAttribute("current_userid", "tman@@2008");
			
			userid = "tman@@2008";
		}
	}
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

		if(true) return;
	}

	String url = "etest.jsp?id_exam=" + id_exam;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>eTest</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<frameset cols="0, 0, *" border="0" noresize>
	<frame name="fraAction" src="" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>
	<frame name="fraActionEvt" src="" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>
	<frame name="fraTest" src="<%= url %>" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" noresize>
</frameset>
