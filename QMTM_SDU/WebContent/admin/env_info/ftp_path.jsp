<%
//******************************************************************************
//   프로그램 : ftp_path.jsp
//   모 듈 명 : FTP 경로설정
//   설    명 : FTP 경로설정 페이지
//   테 이 블 : qt_settings
//   자바파일 : qtmm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil 
//   작 성 일 : 2008-09-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 :  
//	 수정사항 : 
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

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

	String ftp_path = "";
	
	// FTP 경로 변경
	try {
		ftp_path = EnvUtil.getFTP(userid);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

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
		document.form1.http_files_url.focus();
	}

	function Send() {
		var frm = document.form1;

		if(frm.http_files_url.value == "") {
			alert("FTP 경로를 입력하세요.");
			frm.http_files_url.focus();
			return;
		} else {
			frm.submit();
		}
	}

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onload="javascript: onload();" id="admin">
    <form name="form1" method="post" action="ftp_path_ok.jsp">
	<div id="main">

		<div id="mainTop">
			<div class="title">FTP 경로 설정<span></span></div>
			<div class="location">ADMIN > 환경설정 > <span>FTP 경로 설정</span></div>
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
					&nbsp;&nbsp;문제 등록시 멀티미디어 파일이 저장되는 경로를 지정해 줍니다.
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
				<td id="left"><li>FTP 경로</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="http_files_url" size="50" tabindex="1" value="<%=ComLib.nullChk(ftp_path)%>">
				<BR><BR>&nbsp;&nbsp;(<B>ex) D:/etest/files/</B>)
				</td>
			</tr>
		</table>

		<div class="button" style="text-align: right; width: 540px;"><input type="button" value="FTP경로설정" onclick="Send()"></div>
		
 	</div>
	<jsp:include page="../../copyright.jsp"/>
	
 </form>	
		
 </BODY>
</HTML>