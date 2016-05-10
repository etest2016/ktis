<%
//******************************************************************************
//   프로그램 : q_standarda_edit.jsp
//   모 듈 명 : 대분류구분 수정
//   설    명 : 대분류구분 수정 페이지
//   테 이 블 : q_standard_a
//   자바파일 : qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	

	String id_chapter = request.getParameter("id_chapter"); 
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }
	
	String id_standarda = request.getParameter("id_standarda");
	if (id_standarda == null) { id_standarda= ""; } else { id_standarda = id_standarda.trim(); }

	if (id_subject.length() == 0 || id_chapter.length() == 0 || id_standarda.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	QstandardABean rst = null;

    try {
	    rst = QstandardAUtil.getBean(id_standarda);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: 대분류 수정 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.standarda.value == "") {
				alert("대분류명을 입력하세요");
				frm.standarda.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="q_standarda_update.jsp">
<input type="hidden" name="id_subject" value="<%=id_subject%>">
<input type="hidden" name="id_chapter" value="<%=id_chapter%>">
<input type="hidden" name="id_standarda" value="<%=id_standarda%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">대분류수정 <span> 대분류 정보수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="120">대분류코드</td>
				<td width="240"><%=id_standarda%></td>
			</tr>
			<tr>
				<td id="left">대분류명</td>
				<td><input type="text" class="input" name="standarda" size="32" value="<%=rst.getStandarda()%>" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">공개여부</td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) {%>checked<%}%>> 공개&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) {%>checked<%}%>> 비공개</td>
			</tr>
	</table>
</div>

<div id="button">
<img src="../../images/bt5_edit_yj1.gif" border="0" onClick="send();">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>