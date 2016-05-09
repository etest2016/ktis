<%
//******************************************************************************
//   프로그램 : diff_extract.jsp
//   모 듈 명 : 난이도 설정 등록 페이지
//   설    명 : 
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2009-11-30
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

	String diff0 = new String(request.getParameter("a").getBytes("8859_1"),"EUC-KR");
	String diff1 = new String(request.getParameter("b").getBytes("8859_1"),"EUC-KR");
	String diff2 = new String(request.getParameter("c").getBytes("8859_1"),"EUC-KR");
	String diff3 = new String(request.getParameter("d").getBytes("8859_1"),"EUC-KR");
	String diff4 = new String(request.getParameter("e").getBytes("8859_1"),"EUC-KR");
	String diff5 = new String(request.getParameter("f").getBytes("8859_1"),"EUC-KR");
%>

<html>
<title>난이도 설정</title>
<head>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<script language="JavaScript">

function sends() {
	
	var firstWin = window.opener; 
	var frm = document.diff_form;

	firstWin.document.writeForm.diff0.value = frm.diff0.value;
	firstWin.document.writeForm.diff1.value = frm.diff1.value;
	firstWin.document.writeForm.diff2.value = frm.diff2.value;
	firstWin.document.writeForm.diff3.value = frm.diff3.value;
	firstWin.document.writeForm.diff4.value = frm.diff4.value;
	firstWin.document.writeForm.diff5.value = frm.diff5.value;
	
	self.close();
}

</script>

</head>

<BODY id="popup2">
	<form name="diff_form">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">난이도 설정</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
 
	<div id="contents">	
	
	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
		<tr>
			<td id="left" >유형</td>
			<td>값</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td height="30">난이도 없음</td>
			<td><input type="text" name="diff0" class="input" value="<%=diff0%>" size="8"></td>
		</tr>
		<tr>
			<td height="30">아주 어려움</td>
			<td><input type="text" name="diff1" class="input" value="<%=diff1%>" size="8"></td>
		</tr>
		<tr>
			<td height="30">어려움</td>
			<td><input type="text" name="diff2" class="input" value="<%=diff2%>" size="8"></td>
		</tr>
		<tr>
			<td height="30">보통</td>
			<td><input type="text" name="diff3" class="input" value="<%=diff3%>" size="8"></td>
		</tr>
		<tr>
			<td height="30">쉬움</td>
			<td><input type="text" name="diff4" class="input" value="<%=diff4%>" size="8"></td>
		</tr>
		<tr>
			<td height="30">아주 쉬움</td>
			<td><input type="text" name="diff5" class="input" value="<%=diff5%>" size="8"></td>
		</tr>
			
	</table>
	
	<div>

	<div id="button">
		<img src="../../images/bt_paper_checks_yj1.gif" onfocus="this.blur();" onClick="sends();">&nbsp;
		<img onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

</form>
</body>

</html>