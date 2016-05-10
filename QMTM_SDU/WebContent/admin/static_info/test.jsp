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

<html>
<head>
	<title>:: 대영역 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
	<script src="../../js/jquery-ui-1.10.2/jquery-1.9.1.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( ".date_picker" ).datepicker();
	});
  </script>		

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="group_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">그룹소속원등록<span> 그룹에 소속원을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			 <tr>
				<td colspan="2" width="200">그룹에 미등록된 교수자 목록</td>
				<td width="50"></td>
				<td colspan="2" width="200">그룹에 등록된 교수자 목록</td>				
			</tr>
			<tr>
				<td width="70">아이디</td>
				<td width="130">성명</td>
				<td width="50"></td>
				<td width="70">아이디</td>
				<td width="130">성명</td>		
			</tr>
			<tr >
				<td colspan="2" width="200"><select multiple width="200"><option>prof1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교수자1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option><option>prof2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교수자2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option><option>prof3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교수자3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option><option>prof4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교수자4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select></td>
				<td width="50"><input type="button" value="등록▶" class="form4" ><BR><input type="button" value="◀삭제" class="form4" ></td>
				<td colspan="2" width="200"><select multiple width="200"><option>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select></td>	
			</tr>
			
	</table>
</div>

<div id="button">
	<input type="button" value="등록하기" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>