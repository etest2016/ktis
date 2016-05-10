<%
//******************************************************************************
//   프로그램 : member_insert.jsp
//   모 듈 명 : 대상자 개별등록
//   설    명 : 대상자 개별등록 팝업 페이지
//   테 이 블 : 
//   자바파일 : qmtm.ComLib
//   작 성 일 : 2013-02-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ page import="qmtm.ComLib" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
		
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
%>

<html>
<head>
	<title>:: 대상자 등록 :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">
		
		function send() {
			var frm = document.frmdata;
			
			if(frm.userid.value == "") {
				alert("아이디를 입력하세요");
				frm.userid.focus();
				return false;			
			} else if(frm.name.value == "") {
				alert("성명을 입력하세요");
				frm.name.focus();
				return false;
			} else {
				frm.submit();
			}
		}

		function trim(str) {
			return str.replace(/(^\s*)|(\s*$)/g,"");
		}
		
		var chks;
		
		// 중복 아이디 정보 가지고오기
		function get_id_chk() {			
			
			var frm = document.frmdata;
			
			if(frm.userid.value == "") {
				alert("아이디를 입력하세요");
				frm.userid.focus();
				return false;
			}

			var input_id = frm.userid.value;

			chks = new ActiveXObject("Microsoft.XMLHTTP");
			chks.onreadystatechange = get_id_chk_callback;
			chks.open("GET", "id_chk.jsp?input_id="+input_id, true);
			chks.send();
		}

		function get_id_chk_callback() {			
			
			var frm = document.frmdata;

			if(chks.readyState == 4) {
				if(chks.status == 200) {
					if(trim(chks.responseText) == "true") {
						alert("이미 등록된 아이디입니다.");
						frm.userid.value = "";
						frm.userid.focus();
						return;
					} else {
						alert("등록 가능한 아이디입니다.");
						frm.password.focus();
					}
				}
			}
		}

	</script>
</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="member_insert_ok.jsp" >
<input type="hidden" name="id_exam" value="<%=id_exam%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">대상자 개별등록 <span>대상자를 개별 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">아이디</td>
				<td width="270"><input type="text" name="userid" size="20">&nbsp;&nbsp;<input type="button" value="아이디중복체크" class="form3" onClick="get_id_chk();"></td>
			</tr>			
			<tr>
				<td id="left">성명</td>
				<td><input type="text" name="name" size="20" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">소속1</td>
				<td><input type="text" name="sosok1" size="30" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">소속2</td>
				<td><input type="text" name="sosok2" size="30" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">직급</td>
				<td><input type="text" name="level" size="20" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">전화번호</td>
				<td><input type="text" name="home_phone" size="17" > ex)02-1234-5678</td>
			</tr>
			<tr>
				<td id="left">휴대폰</td>
				<td><input type="text" name="mobile_phone" size="17" > ex)010-1234-5678</td>
			</tr>
			<tr>
				<td id="left">이메일</td>
				<td><input type="text" name="email" size="40" style="ime-mode:inactive;"></td>
			</tr>				
		</table>
	</div>

	<div id="button">
		<input type="button" value="등록하기" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>