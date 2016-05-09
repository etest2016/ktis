<%
//******************************************************************************
//   프로그램 : db_error.jsp
//   모 듈 명 : sql문 관련오류
//   설    명 : sql문 관련오류 설정 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-09-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String error_msg = request.getParameter("err_msg");
%>

<HTML>
 <HEAD>
  <TITLE> Error </TITLE>
 </HEAD>

 <BODY>
<%
	out.println("데이터베이스 연결에 문제가 발생했습니다.<BR><BR>관리자에게 문의하시기 바랍니다.!!!!");
%>
 </BODY>
</HTML>
