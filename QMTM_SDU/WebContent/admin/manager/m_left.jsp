<%
//******************************************************************************
//   프로그램 : m_left.jsp
//   모 듈 명 : 담당자 왼쪽 메뉴
//   설    명 : 담당자 왼쪽 메뉴
//   테 이 블 : 
//   자바파일 :  
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>
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
			<TD><img src="../img/title_sub_manager.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="m_list.jsp" target="fraMain">담당자 관리</a></div>
				<!--<div><a href="receipt_inwons.jsp" target="fraMain">응시인원관리</a></div>-->				
				<!--<div><a href="q_list.jsp" target="fraMain">QMAN 담당자</a></div>
				<div><a href="t_list.jsp" target="fraMain">TMAN 담당자</a></div>-->
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>

	
</body>
</html>
