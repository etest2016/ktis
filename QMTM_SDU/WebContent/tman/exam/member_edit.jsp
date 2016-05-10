<%
//******************************************************************************
//   프로그램 : member_edit.jsp
//   모 듈 명 : 대상자 개별수정
//   설    명 : 대상자 개별수정 팝업 페이지
//   테 이 블 : 
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.ReceiptBean, qmtm.tman.exam.ReceiptUtil
//   작 성 일 : 2013-02-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ReceiptBean, qmtm.tman.exam.ReceiptUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
		
	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	ReceiptBean rst = null;
	
	try {
		rst = ReceiptUtil.getBean(id_exam, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%>

<html>
<head>
	<title>:: 대상자 수정 :: </title>

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
		
	</script>
</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="member_update.jsp" >
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="userid" value="<%=userid%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">대상자 수정 <span>대상자를 수정합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">아이디</td>
				<td width="270"><%=userid%></td>
			</tr>			
			<tr>
				<td id="left">성명</td>
				<td><input type="text" name="name" size="20" style="ime-mode:active;" value="<%=rst.getName()%>"></td>
			</tr>
			<tr>
				<td id="left">소속1</td>
				<td><input type="text" name="sosok1" size="30" style="ime-mode:active;" value="<%=rst.getSosok1()%>"></td>
			</tr>
			<tr>
				<td id="left">소속2</td>
				<td><input type="text" name="sosok2" size="30" style="ime-mode:active;" value="<%=rst.getSosok2()%>"></td>
			</tr>
			<tr>
				<td id="left">직급</td>
				<td><input type="text" name="level" size="20" style="ime-mode:active;" value="<%=rst.getLevel()%>"></td>
			</tr>
			<tr>
				<td id="left">전화번호</td>
				<td><input type="text" name="home_phone" size="17" value="<%=ComLib.nullChk(rst.getHome_phone())%>"> ex)02-1234-5678</td>
			</tr>
			<tr>
				<td id="left">휴대폰</td>
				<td><input type="text" name="mobile_phone" size="17" value="<%=ComLib.nullChk(rst.getMobile_phone())%>"> ex)010-1234-5678</td>
			</tr>
			<tr>
				<td id="left">이메일</td>
				<td><input type="text" name="email" size="40" style="ime-mode:inactive;" value="<%=ComLib.nullChk(rst.getEmail())%>"></td>
			</tr>				
		</table>
	</div>

	<div id="button">
		<input type="button" value="수정하기" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>