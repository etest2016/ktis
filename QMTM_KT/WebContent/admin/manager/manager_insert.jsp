<%
//******************************************************************************
//   프로그램 : manager_insert.jsp
//   모 듈 명 : 담당자 등록
//   설    명 : 담당자 등록 팝업 페이지
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
	<title>:: 담당자 등록 :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.userid.value == "") {
				alert("아이디를 입력하세요");
				frm.userid.focus();
				return false;
			} else if(frm.password.value == "") {
				alert("비밀번호를 입력하세요");
				frm.password.focus();
				return false;
			} else if(frm.name.value == "") {
				alert("성명을 입력하세요");
				frm.name.focus();
				return false;
			} else {
				frm.submit();
			}
		}

	</script>
</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="manager_insert_ok.jsp" >

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">신규담당자 등록 <span>새 담당자를 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left">아이디</td>
					<td width="300"><input type="text" class="input" name="userid" size="20"></td>
				</tr>
				<tr>
					<td id="left">비밀번호</td>
					<td><input type="password" name="password" size="20"></td>
				</tr>
				<tr>
					<td id="left">성명</td>
					<td><input type="text" class="input" name="name" size="20"></td>
				<tr>
					<td id="left">담당자 소속</td>
					<td><textarea name="rmk" cols="35" rows="3"></textarea></td>
				</tr>
				<tr>
					<td id="left">사용유무</td>
					<td><input type="radio" name="yn_valid" value="Y" checked> 사용가능&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N"> 사용불능</td>
				</tr>
		</table>
	</div>

	<div id="button">
		<img src="../../images/bt_manager_yj1.gif" onClick="send();">&nbsp;&nbsp;<!--input type="button" value="취소" onclick="window.close();"--><a href="javascript:window.close();"><img src="../../images/bt5_exit_yj1_11.gif" border="0" align="adsmiddle"></a>
	</div>

	</form>

</BODY>
</HTML>