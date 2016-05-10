<%
//******************************************************************************
//   프로그램 : module_edit.jsp
//   모 듈 명 : 모듈 수정
//   설    명 : 문제은행 모듈 수정 페이지
//   테 이 블 : q_chapter
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }
	
	String id_module = request.getParameter("id_module");
	if (id_module == null) { id_module= ""; } else { id_module = id_module.trim(); }

	if (id_subject.length() == 0 || id_module.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	ModuleBean rst = null;

    try {
	    rst = ModuleUtil.getBean(id_module);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: 단원 수정 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.q_module.value == "") {
				alert("단원명을 입력하세요");
				frm.q_module.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="module_update.jsp">
<input type="hidden" name="id_subject" value="<%=id_subject%>">
<input type="hidden" name="id_module" value="<%=id_module%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">단원수정 <span> 단원 정보수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents"> 

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">단원코드</td>
				<td width="180"><%=id_module%></td>
			</tr>
			<tr>
				<td id="left">단원명</td>
				<td><input type="text" class="input" name="q_module" size="27" value="<%=rst.getChapter()%>" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">정렬순서</td>
				<td><select name="module_order">
			<% for(int i = 1; i <= 15; i++) { %>	
				<option value="<%=i%>" <%if(rst.getChapter_order() == i) {%>selected<% } %>><%=i%></option>
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