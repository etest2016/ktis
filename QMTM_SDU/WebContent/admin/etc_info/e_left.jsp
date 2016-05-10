<%
//******************************************************************************
//   프로그램 : e_left.jsp
//   모 듈 명 : 코드정보관리 왼쪽메뉴
//   설    명 : 코드정보관리 왼쪽메뉴
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2013-02-08
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
			<TD><img src="../img/title_sub_code.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>				
				<div><a href="group_list.jsp" target="fraMain">대영역코드관리</a></div>
				<div><a href="group_list2.jsp" target="fraMain">소영역코드관리</a></div>
				<div><a href="course_list.jsp" target="fraMain">과정코드관리</a></div>
				<div><a href="q_use_list.jsp" target="fraMain">문제용도코드관리</a></div>								
			</TD>    
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>
	
</body>
</html>
