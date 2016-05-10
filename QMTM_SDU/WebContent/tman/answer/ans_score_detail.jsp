<%
//******************************************************************************
//   프로그램 : ans_score_detail.jsp
//   모 듈 명 : 응시자 정보
//   설    명 : 응시자 정보
//   테 이 블 : qt_userid
//   자바파일 : qmtm.ComLib, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean
//   작 성 일 : 2013-02-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	SubjYNChkBean[] users = null;
	
	try {
		users = SubjYNChk.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));
		
		if(true) return;
	}
%>

<html>
<head>
	<title> :: 과락설정여부 확인 :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

</head>

<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td id="left"></td>
				<Td id="mid"><div class="title">과락설정여부 확인 <span>응시자의 과락여부 정보를 확인합니다</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<% if(users != null) {%>
		<table border="0" cellpadding ="0" cellspacing="0" width="100%" style="margin-bottom: 0px;">
			<tr>
				<td align="right"><font color=green><B>필기과락점수 : <%=users[0].getSuccess_score1()%>점, 실기과락점수 : <%=users[0].getSuccess_score2()%>점</B></font></td>
			</tr>
		</table>
		<BR>
		<% } %>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="25%">아이디</td>
				<td width="25%">성명</td>
				<td width="15%">필기점수</td>
				<td width="15%">실기점수</td>
				<td width="20%">과락여부</td>
			</tr>
<% if(users == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="5">과락설정을 실행한 후 확인해주세요</td>
			</tr>
<% 
	} else { 
	
		for(int i=0; i<users.length; i++) {		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="center"><%=users[i].getUserid()%></td>
				<td align="center"><%=users[i].getName()%></td>
				<td align="center"><%=users[i].getScore1()%></td>
				<td align="center"><%=users[i].getScore2()%></td>
				<td align="center"><%=users[i].getSuccess_yn()%></td>				
			</tr>
<%
		}
	}
%>
		</table>

	</div>
	<div id="button">

		<img src="../../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: pointer;">
	</div>

</body>

</html>
