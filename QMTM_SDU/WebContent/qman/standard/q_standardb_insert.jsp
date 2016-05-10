<%
//******************************************************************************
//   프로그램 : q_standardb_insert.jsp
//   모 듈 명 : 소분류구분 등록
//   설    명 : 소분류구분 등록 페이지
//   테 이 블 : 
//   자바파일 : qmtm.ComLib
//   작 성 일 : 2013-02-04
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

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	
	
	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }

	String id_standarda = request.getParameter("id_standarda"); // 분류구분 코드
	if (id_standarda == null) { id_standarda= ""; } else { id_standarda = id_standarda.trim(); }

	if (id_subject.length() == 0 || id_chapter.length() == 0 || id_standarda.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
%>

<html>
<head>
	<title>:: 소분류 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Sends() {
			var frm = document.frmdata;
			
			if(frm.standardb.value == "") {
				alert("소분류명을 입력하세요");
				frm.standardb.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="q_standardb_insert_ok.jsp">
<input type="hidden" name="id_subject" value="<%=id_subject%>">
<input type="hidden" name="id_chapter" value="<%=id_chapter%>">
<input type="hidden" name="id_standarda" value="<%=id_standarda%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">소분류 등록 <span> 소분류 코드를 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="100">소분류명</td>
				<td width="250"><input type="text" class="input" name="standardb" size="32" style="ime-mode:active;"></td>
			</tr>			
	</table>
</div>

<div id="button">
<a href="javascript:Sends();" onfocus="this.blur();"><img src="../../images/bt5_make_yj1_1.gif" border="0"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>