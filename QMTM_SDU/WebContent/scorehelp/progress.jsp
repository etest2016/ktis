<%
//******************************************************************************
//   프로그램 : progress.asp
//   모 듈 명 : 모사답안 비교 진행률
//   설    명 : 모사답안 비교 진행률 표시
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 
//   작 성 자 : 
//   수 정 일 : 2009-01-21
//   수 정 자 : 이테스트 강진아
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_exam = request.getParameter("id_exam");
	String id_q = request.getParameter("id_q");
	
	int cnta = 0;
	int cntb = 0;
%>
<%
	//Score_ProgressBean rst = null;

	try {
		cnta = Score_Progress.getCnta(id_exam, id_q);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	try {
		cntb = Score_Progress.getCntb(id_exam, id_q);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
		
	double result = 0.00;

	if (cntb != 0){
		result = (cntb / cnta) * 100;
	}
%>

<html>
<head>
<meta http-equiv="refresh" content=7>
<title>모사 답안 실행 진행률</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>
<body>
<table border="0" width="60%" cellpadding="5" align="center" valign="top">
	<tr>
		<td align="center">

			<img src="../images/ing.gif">

			<!--table border="0" width="100%">
				<tr >
					<td width="100%" align="left"><B>* 모사답안 비교 진행률</B></td>
				</tr>
			</table>
			
			<table border="0">
				<tr>
					<td height="5"></td>
				</tr>
			</table>

			<table border="0" cellpadding="3" cellspacing="0" bgcolor="#CCCCCC" width="100%">
				<tr bgcolor="#FFFFFF">
					<td width="100%" align="center"><img src="../images/ing.gif"><img src="./img/graph.gif" width="%" height="25" align="absmiddle"></td>
				</tr>
			</table>
				
			<table border="0" width="100%">
				<tr >
					<td width="100%" align="right"><B>총 <%=cnta%>명 중 <font color=red></font> <%=cntb%>명 진행중&nbsp;&nbsp; / &nbsp;&nbsp;진행률 : <font color=red><%=result%></font> %</B></td>
				</tr>
			</table-->
		</td>
	</tr>
</table>

</BODY>
</HTML>