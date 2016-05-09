<%
//******************************************************************************
//   프로그램 : b_left.jsp
//   모 듈 명 : 게시판 왼쪽 메뉴
//   설    명 : 게시판 왼쪽 메뉴
//   테 이 블 : 
//   자바파일 :  
//   작 성 일 : 2011-08-11
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
%>

<html>
<head>
	<title>Admin 관리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link rel="StyleSheet" href="../menu.css" type="text/css">
</head>

<body>

	<TABLE border="0" id="menu" cellpadding="0" cellspacing="0" >
		<TR id="Top">
			<TD><img src="../img/title_sub_time.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="../exam_info/exam_ing_list.jsp" target="fraMain">시험 일정표</a></div>
				<!--<div><a href="http://utest.kt.com/admin_bbs2/time_list_admin.asp" target="fraMain">시험 승인관리</a></div>-->
				<!--<div><a href="../manager/member_static_list.jsp" target="fraMain">응시자성적누적통계관리</a></div>-->
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>	
</body>
</html>
