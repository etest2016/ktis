<%
//******************************************************************************
//   프로그램 : non_frame.jsp
//   모 듈 명 : 문항별 논술형 채점 프레임
//   설    명 : 문항별 논술형 채점 프레임
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-06-02
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.* " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

%>

<html>
<head>
	<title>논술형문제 채점하기</title>
</head>

<frameset rows="140,*" cols="*" frameborder="NO" border="0" framespacing="0">
	<frame src="non_top.jsp" name="topFrame" scrolling="NO" noresize>
	<frameset rows="*" cols="250,*" framespacing="0" frameborder="no" border="0">
		<frame src="non_user.jsp?id_exam=<%= id_exam %>&id_q=<%= id_q %>" name="fraLeft" scrolling="no" noresize>
		<frame src="non_info.jsp" name="fraMain" scrolling="AUTO">
	</frameset>
</frameset>


