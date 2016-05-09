<%
//******************************************************************************
//   프로그램 : exam_kind_edit.jsp
//   모 듈 명 : 그룹구분수정
//   설    명 : 그룹구분수정 팝업 페이지
//   테 이 블 : r_exam_kind
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	if (id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	GroupKindBean rst = null;

    try {
	    rst = GroupKindUtil.getBean(id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: 분야그룹 수정 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.category.value == "") {
				alert("분야명을 입력하세요");
				frm.category.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="group_update.jsp">
<input type="hidden" name="id_category" value="<%=id_category%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">분야그룹수정 <span> 분야그룹 정보수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>


	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">분야코드</td>
				<td width="200"><%=id_category%></td>
			</tr>
			<tr>
				<td id="left">분야명</td>
				<td><input type="text" class="input" name="category" size="25" value="<%=rst.getCategory()%>"></td>
			</tr>
	</table>
</div>

<div id="button">
<img src="../../images/bt5_edit_yj1.gif" border="0" onClick="send();">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>