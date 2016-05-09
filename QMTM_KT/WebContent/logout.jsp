<%
//******************************************************************************
//   프로그램 : logout.jsp
//   모 듈 명 : 로그아웃 처리
//   설    명 : 로그아웃 처리
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-06-26
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>     

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	CommonUtil.set_Cookie(response,"userid","");
 %>
<script language="javascript">
	top.window.close();
</script>
