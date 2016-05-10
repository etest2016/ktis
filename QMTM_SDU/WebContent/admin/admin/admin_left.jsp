<%
//******************************************************************************
//   프로그램 : admin_left.jsp
//   모 듈 명 : 관리자 왼쪽 메뉴
//   설    명 : 관리자 왼쪽 메뉴
//   테 이 블 : 
//   자바파일 :  
//   작 성 일 : 2013-02-01
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
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
			<TD><img src="../img/title_sub_admin.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="admin_list.jsp" target="fraMain">관리자 관리</a></div>
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>

	
</body>
</html>
