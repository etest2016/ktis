<%
//******************************************************************************
//   프로그램 : e_left.jsp
//   모 듈 명 : 기타정보관리 왼쪽메뉴
//   설    명 : 기타정보관리 왼쪽메뉴
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2010-06-08
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

<html>   
<head>
	<title>Admin 관리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link rel="StyleSheet" href="../menu.css" type="text/css">
</head>

<body>

	<TABLE border="0" id="menu" cellpadding="0" cellspacing="0">
		<TR id="Top">
			<TD><img src="../img/title_sub_etc.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<!--<div><a href="q_use_list.jsp" target="fraMain">문제용도코드관리</a></div>-->			
				<div><a href="group_list.jsp" target="fraMain">분야그룹코드관리</a></div>
				<div><a href="exam_kind_list.jsp" target="fraMain">그룹구분코드관리</a></div>
				<!--<div><a href="member_relation.jsp" target="fraMain">정보연동관리</a></div>-->
			</TD>    
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>

	
</body>
</html>
