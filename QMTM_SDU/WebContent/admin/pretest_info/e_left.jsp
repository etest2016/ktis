<%
//******************************************************************************
//   프로그램 : e_left.jsp
//   모 듈 명 : 로그정보확인 왼쪽 메뉴
//   설    명 : 로그정보확인 왼쪽 메뉴
//   테 이 블 : 
//   자바파일 :  
//   작 성 일 : 2013-02-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>


<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
%>   

<html>
<head>
	<title>Admin 관리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="StyleSheet" href="../menu.css" type="text/css">
</head>

<body>

	<TABLE border="0" id="menu" cellpadding="0" cellspacing="0">
		<TR id="Top">
			<TD><img src="../img/title_sub_log.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="pretest_list.jsp" target="fraMain">모의퀴즈설정</a></div>
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>
		
</body>
</html>
