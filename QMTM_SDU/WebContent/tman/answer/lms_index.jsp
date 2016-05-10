<%
//******************************************************************************
//   프로그램 : lms_index.jsp
//   모 듈 명 : 성적 내보내기
//   설    명 : LMS로 성적 내보내기
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-11-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<html>
<head><title>LMS 성적내보내기</title></head>
<FRAMESET ROWS = 50%,* frameborder=0>
   <FRAME SRC="process.jsp" name="top">
   <FRAME SRC="lms_score_export.jsp?id_exam=<%=id_exam%>" name="main">
</FRAMESET>

