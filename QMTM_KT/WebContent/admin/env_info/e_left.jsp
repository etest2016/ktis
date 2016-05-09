<%
//******************************************************************************
//   프로그램 : e_left.jsp
//   모 듈 명 : 환경설정 왼쪽메뉴
//   설    명 : 환경설정 왼쪽메뉴
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
			<TD><img src="../img/title_sub_setting.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<!--<div><a href="class_list.jsp" target="fraMain">분류명 설정</a></div>-->
				<div><a href="pwd_list.jsp" target="fraMain">비밀번호 설정</a></div>
				<!--<div>Web 환경설정</div>-->
			</TD>
		</TR>
		<TR id="Main">
			<TD>
				<!--<div><a href="class_list.jsp" target="fraMain">분류명 설정</a></div>-->
				<div><a href="ftp_path.jsp" target="fraMain">FTP 경로 설정</a></div>
				<!--<div>Web 환경설정</div>-->
			</TD>
		</TR>
		<TR id="Main">
			<TD>
				<!--<div><a href="class_list.jsp" target="fraMain">분류명 설정</a></div>-->
				<div><a href="web_path.jsp" target="fraMain">WEB URL 설정</a></div>
				<!--<div>Web 환경설정</div>-->
			</TD>
		</TR>		
		<TR id="Bottom">   
			<TD></TD>
		</TR>
	</TABLE>
	
	<jsp:include page="../../quick.jsp"/>

</body>
</html>
