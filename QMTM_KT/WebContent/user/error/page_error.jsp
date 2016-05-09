<%
//******************************************************************************
//   프로그램 : page_error.jsp
//   모 듈 명 : 페이지 권한오류
//   설    명 : 페이지 권한오류 설정 페이지
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
%>

<HTML>
 <HEAD>
  <TITLE> Error </TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
 </HEAD>

 <BODY>
  <%
	out.println("해당 화면에 접근할 권한이 없습니다.<BR><BR>관리자에게 문의하시기 바랍니다.!!!");
  %>
 </BODY>
</HTML>
