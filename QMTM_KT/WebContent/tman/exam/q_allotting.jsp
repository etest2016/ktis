<%
//******************************************************************************
//   프로그램 : q_allotting.jsp
//   모 듈 명 : 문제 배점 등록 페이지
//   설    명 : 문제 배점 등록 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-04-30
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

<html>
<head>
	<title>배점 등록</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">
	function allott_send() {
		var frm = document.allott_form;

		var allott = Number(frm.allottings.value)*1.0;

		opener.allott_insert(allott.toFixed(1));
		window.close();
	}
</script>
</head>

<BODY id="popup2">

	<form name="allott_form">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">배점 등록<span>배점을 설정합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">
			<tr align="center">
				<td id="left" width="60">배점&nbsp;&nbsp;</td>
				<td><input type="text" class="input" name="allottings" size="7"> 점</td>
			</tr>
		</table>
	</div>
	<div id="button">
		<!--<input type="button" value="확인하기" onClick="allott_send()">--><a href="javascript:allott_send();"><img src="../../images/user_static_yj1_1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="취소하기" onclick="window.close();">--><a href="javascript:window.close();"><img src="../../images/user_static_yj1_2.gif"></a></div>

	</form>

</BODY>
</HTML>
