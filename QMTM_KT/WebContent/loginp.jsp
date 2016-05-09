<%
//******************************************************************************
//   프로그램 : loginp.jsp
//   모 듈 명 : 
//   설    명 : 
//   테 이 블 : qt_workerid
//   자바파일 : 
//   작 성 일 : 2008-05-27
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
	
	String userid = request.getParameter("userid"); // 사용자 아이디
	String pwd = request.getParameter("pwd"); // 선택 메뉴

	out.println(userid);

	// 사용자 인증
	try {
	    QmanTree.insert(id_q_subject, q_subject);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }

	if(아이디 비밀번호가 존재할 경우){
%>

<script language="javascript">
	location.href = 'default.jsp';
</script>
<%
	}	
%>
