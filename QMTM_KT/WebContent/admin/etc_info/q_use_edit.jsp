<%
//******************************************************************************
//   프로그램 : q_use_edit.jsp
//   모 듈 명 : 문제용도수정
//   설    명 : 문제용도수정 팝업 페이지
//   테 이 블 : r_q_use
//   자바파일 : qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_use = request.getParameter("id_q_use");
	if (id_q_use == null) { id_q_use= ""; } else { id_q_use = id_q_use.trim(); }

	if (id_q_use.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	QuseBean rst = null;

    try {
	    rst = QuseUtil.getBean(id_q_use);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: 문제용도 수정 :: </title>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.q_use.value == "") {
				alert("문제용도를 입력하세요");
				frm.q_use.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="q_use_update.jsp">
<input type="hidden" name="id_q_use" value="<%=id_q_use%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문제용도 수정 <span> 문제용도 정보수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">코드</td>
				<td width="200"><%=id_q_use%></td>
			</tr>
			<tr>
				<td id="left">문제용도</td>
				<td><input type="text" class="input" name="q_use" size="25" value="<%=rst.getQ_use()%>"></td>
			</tr>
			<tr>
				<td id="left">설명</td>
				<td><textarea name="rmk" rows="3" cols="25"><%=ComLib.nullChk(rst.getRmk())%></textarea></td>
			</tr>
	</table>
	</div>

<div id="button">
<a href="javascript:" onClick="send();" onfocus="this.blur();"><img src="../../images/bt5_edit_yj1.gif" border="0"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>