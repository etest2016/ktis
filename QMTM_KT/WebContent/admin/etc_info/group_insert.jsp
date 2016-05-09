<%
//******************************************************************************
//   프로그램 : exam_kind_insert.jsp
//   모 듈 명 : 그룹구분등록
//   설    명 : 그룹구분등록 팝업 페이지
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

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>
<html>
<head>
	<title>:: 분야그룹 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Sends() {
			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("분야코드를 입력하세요");
				frm.id_category.focus();
				return false;
			} else if(frm.category.value == "") {
				alert("분야명을 입력하세요");
				frm.category.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="group_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">분야그룹 등록 <span> 카테고리 분야그룹을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">분야코드</td>
				<td width="200"><input type="text" class="input" name="id_category" size="25"></td>
			</tr>
			<tr>
				<td id="left">분야명</td>
				<td><input type="text" class="input" name="category" size="25"></td>
			</tr>
	</table>
</div>

<div id="button">
<a href="javascript:Sends();" onfocus="this.blur();"><img src="../../images/bt5_make_yj1_1.gif" border="0"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>