<%
//******************************************************************************
//   프로그램 : std_grade_insert.jsp
//   모 듈 명 : 학년코드등록
//   설    명 : 학년코드등록 팝업 페이지
//   테 이 블 : r_std_grade
//   자바파일 : qmtm.admin.etc.StdGradeBean, qmtm.admin.etc.StdGradeUtil
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>
<html>
<head>
	<title>:: 학년코드 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.std_grade.value == "") {
				alert("학년코드를 입력하세요");
				frm.std_grade.focus();
				return false;
			} else if(frm.grade_nm.value == "") {
				alert("학년명을 입력하세요");
				frm.grade_nm.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="std_grade_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">학년코드 등록 <span> 학년코드 등록 합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">학년코드</td>
				<td width="200"><input type="text" class="input" name="std_grade" size="10"></td>
			</tr>
			<tr>
				<td id="left">학년명</td>
				<td><input type="text" class="input" name="grade_nm" size="25"></td>
			</tr>
	</table>
</div>

<div id="button">
<a href="javascript:" onClick="send();" onfocus="this.blur();"><img src="../../../images/bt5_make_yj1_1.gif" border="0"></a>&nbsp;&nbsp;<!--<input type="button" onclick="window.close()" value="창닫기">--><a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>