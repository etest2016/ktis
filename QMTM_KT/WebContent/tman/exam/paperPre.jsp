<%
//******************************************************************************
//   프로그램 : paperPre.jsp
//   모 듈 명 : 이전출제문제 가져오기
//   설    명 : 이전출제문제 가져오기
//   테 이 블 : q, q_paper
//   자바파일 : 
//   작 성 일 : 2009-08-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = CommonUtil.get_Cookie(request, "userid"); // 사용자 아이디
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}
%>

<html>
<head>
	<title>출제문제가져오기</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

</head>

	<BODY id="popup2" >
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">출제문제가져오기</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">		

		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>				
				<td><b>이전에 시험지 만들기 작업중 취소하거나 중단되어진 작업이 있습니다.<BR><BR>이어서 진행하시려면 아래 찾기 버튼을 클릭하시기 바랍니다.</b></td>
			</tr>
		</table>
	</div>

	<div id="button">
	<a href="paperPre_ok.jsp?id_exam=<%=id_exam%>"><img src="../../images/bt_q_search_ckwyj1.gif" border="0" ></a>&nbsp;&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt_q_search_closeyj1.gif"></a>
	</div>

</body>

</html>