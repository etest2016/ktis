<%
//******************************************************************************
//   프로그램 : std_level_edit.jsp
//   모 듈 명 : 레벨코드수정
//   설    명 : 레벨코드수정 팝업 페이지
//   테 이 블 : r_std_level
//   자바파일 : qmtm.admin.etc.StdLevelBean, qmtm.admin.etc.StdLevelUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String std_level = request.getParameter("std_level");
	if (std_level == null) { std_level= ""; } else { std_level = std_level.trim(); }

	if (std_level.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	StdLevelBean rst = null;

    try {
	    rst = StdLevelUtil.getBean(std_level);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>
<html>
<head>
	<title>:: 레벨코드 수정 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="std_level_update.jsp">
<input type="hidden" name="std_level" value="<%=std_level%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">레벨코드 수정 <span> 레벨코드 확인 및 레벨명 수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">레벨코드</td>
				<td width="200"><%=std_level%></td>
			</tr>
			<tr>
				<td id="left">레벨명</td>
				<td><input type="text" class="input" name="level_nm" size="25" value="<%=rst.getLevel_nm()%>"></td>
			</tr>

	</table>
	</div>

<div id="button">
<input type="image" value="수정하기" name="submit" src="../../../images/bt5_edit_yj1.gif">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>