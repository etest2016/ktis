<%
//******************************************************************************
//   프로그램 : group_insert.jsp
//   모 듈 명 : 대영역구분 등록
//   설    명 : 대영역구분 등록 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2013-01-21
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
	<title>:: 대영역 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Sends() {
			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("대영역코드를 입력하세요");
				frm.id_category.focus();
				return false;
			} else if(frm.category.value == "") {
				alert("대영역명을 입력하세요");
				frm.category.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

		function trim(str) {
			return str.replace(/(^\s*)|(\s*$)/g,"");
		}

		var chks;
		
		// 중복 코드 정보 가지고오기
		function get_code_chk() {			

			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("대영역코드를 입력하세요");
				frm.id_category.focus();
				return false;
			}

			var input_code = frm.id_category.value;

			chks = new ActiveXObject("Microsoft.XMLHTTP");
			chks.onreadystatechange = get_code_chk_callback;
			chks.open("GET", "code_chk.jsp?input_code="+input_code, true);
			chks.send();
		}

		function get_code_chk_callback() {			

			var frm = document.frmdata;
			
			if(chks.readyState == 4) {
				if(chks.status == 200) {					
					if(trim(chks.responseText) == "true") {
						alert("이미 등록된 코드입니다.");
						frm.id_category.value = "";
						frm.id_category.focus();
						return;
					} else {
						alert("등록 가능한 코드입니다.");
						frm.category.focus();
					}
				}
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
				<Td id="mid"><div class="title">대영역 등록 <span> 대영역 코드를 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">대영역코드</td>
				<td width="200"><input type="text" class="input" name="id_category" size="17">&nbsp;&nbsp;<input type="button" value="중복체크" class="form3" onClick="get_code_chk();"></td>
			</tr>
			<tr>
				<td id="left">대영역명</td>
				<td><input type="text" class="input" name="category" size="25" style="ime-mode:active;"></td>
			</tr>			
	</table>
</div>

<div id="button">
	<input type="button" value="등록하기" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>