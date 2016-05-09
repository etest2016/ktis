<%
//******************************************************************************
//   프로그램 : pwd_list.jsp
//   모 듈 명 : 비밀번호 설정
//   설    명 : 비밀번호 설정 페이지
//   테 이 블 : 
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>   

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	// 해당 페이지 권한 체크	
	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	
%>

<HTML>
 <HEAD> 
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--
	function onload() {
		document.form1.qmtm_password.focus();
	}

	function Send() {
		var frm = document.form1;

		if(frm.qmtm_password.value == "") {
			alert("비밀번호를 입력하세요");
			frm.qmtm_password.focus();
			return;
		} else if(frm.qmtm_password.value != frm.qmtm_password2.value) {
			alert("비밀번호가 일치하지 않습니다.");
			frm.qmtm_password2.value = "";
			frm.qmtm_password2.focus();
			return;	
		} else {
			frm.submit();
		}
	}

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onload="javascript: onload();" id="admin">
    <form name="form1" method="post" action="pwd_change.jsp">
	<div id="main">

		<div id="mainTop">
			<div class="title">비밀번호 설정<span></span></div>
			<div class="location">ADMIN > 환경설정 > <span>비밀번호 설정</span></div>
		</div>
		
		<TABLE cellpadding="0" cellspacing="0" border="0" id="tableC" style="width: 540px;">
			<TR id="top">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
			<TR id="middle">
				<TD id="left"></TD>
				<TD id="center" style="font: normal 11px dotum; ">
					&nbsp;&nbsp;비밀번호는 영문자, 특수문자로 구성되어야 하며, <br>
					&nbsp;&nbsp;최고 15자리까지입력가능 합니다. (영문의 대소문자를 구분합니다.)
				</TD>
				<TD id="right"></TD>
			</TR>
			<TR id="bottom">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
		</TABLE>		

		<table border="0" cellpadding ="0" cellspacing="0" id="tableB" style="width: 540px;">
			<tr>
				<td id="left"><li>변경 비밀번호</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="qmtm_password" size="30" maxlength="15" tabindex="1"></td>
			</tr>
			<tr>
				<td id="left"><li>비밀번호 확인</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="qmtm_password2" size="30" maxlength="15" tabindex="2"></td>
			</tr>	
		</table>

		<div class="button" style="text-align: right; width: 540px;"><img src="../../images/bt4_pw.gif" tabindex="3" border="0" onclick="Send()"></div>
		
 	</div>
	<jsp:include page="../../copyright.jsp"/>
	
 </form>	
		
 </BODY>
</HTML>