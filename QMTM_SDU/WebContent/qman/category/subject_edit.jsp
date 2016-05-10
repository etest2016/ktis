<%
//******************************************************************************
//   프로그램 : subject_edit.jsp
//   모 듈 명 : 과목 수정
//   설    명 : 문제은행 과목 수정 페이지
//   테 이 블 : q_subject
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.SubjectBean, 
//              qmtm.qman.category.SubjectUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }

	if (id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	SubjectBean rst = null;

    try {
	    rst = SubjectUtil.getBean(id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: 과목 수정 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.q_subject.value == "") {
				alert("과목명을 입력하세요");
				frm.q_subject.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="subject_update.jsp">
<input type="hidden" name="id_subject" value="<%=id_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">과목수정 <span> 과목 정보수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">과목코드</td>
				<td width="180"><%=id_subject%></td>
			</tr>
			<tr>
				<td id="left">과목명</td>
				<td><input type="text" class="input" name="q_subject" size="27" value="<%=rst.getSubject()%>" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">정렬순서</td>
				<td><select name="subject_order">
			<% for(int i = 1; i <= 15; i++) { %>	
				<option value="<%=i%>" <%if(rst.getSubject_order() == i) {%>selected<% } %>><%=i%></option>
			<% } %></td>
			</tr>
			<tr>
				<td id="left">공개여부</td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) {%>checked<%}%>> 공개&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) {%>checked<%}%>> 비공개</td>
			</tr>
	</table>
</div>

<div id="button">
	<input type="button" value="수정하기" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>