<%
//******************************************************************************
//   프로그램 : ans_equal_frame.asp
//   모 듈 명 : 모사답안 비교 프레임
//   설    명 : 문제별 모사답안 비교 프레임
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2009-01-21
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_exam = request.getParameter("id_exam");
	String id_q = request.getParameter("id_q");

%>
<html>
<head><title>모사답안 비교</title></head>
<FRAMESET ROWS = "30%,*,20%" frameborder="0">
	<FRAME SRC="ans_equal_start.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>" name="top">
	<FRAME SRC="progress.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>" name="main">
	<FRAME SRC="ans_equal_res.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>" name="bottom">
</FRAMESET>