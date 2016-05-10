<%
//******************************************************************************
//   프로그램 : group_edit.jsp
//   모 듈 명 : 대영역구분 수정
//   설    명 : 대영역구분 수정 페이지
//   테 이 블 : c_cateogry
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	if (id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	CategoryBean rst = null;

    try {
	    rst = CategoryUtil.getBean(id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: 대영역 수정 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.category.value == "") {
				alert("대영역명을 입력하세요");
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
				<Td id="mid"><div class="title">대영역수정 <span> 대영역 정보수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">대영역코드</td>
				<td width="200"><%=id_category%></td>
			</tr>
			<tr>
				<td id="left">대영역명</td>
				<td><input type="text" class="input" name="category" size="25" value="<%=rst.getCategory()%>" style="ime-mode:active;"></td>
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