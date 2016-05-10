<%
//******************************************************************************
//   프로그램 : exam_non_answer.jsp
//   모 듈 명 : 시험별 논술형 문제 리스트
//   설    명 : 시험별 논술형 문제 리스트
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   작 성 일 : 2008-06-02
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	AnswerMarkBean[] beans = null;

	try {
		beans = AnswerMark.getBeans2(id_exam);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<html>
<head>
<title> :: 논술형 문제 다운로드 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
<script language="JavaScript">

	function ans_mark_non(id_q) {
		$.posterPopup("user_non_mark.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_non","width=660, height=650, scrollbars=yes");
	}

</script>

</head>

<body id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">논술형 문제 다운로드 및 채점 <span>문제별 응시자 답안을 다운로드하고 채점합니다.</span></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="user_all_non_answer.jsp?id_exam=<%=id_exam%>">[전체문제 다운로드]</a></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="tr" align="center">
				<td width="11%"> 문제코드 </td>
				<td width="14%"> 문제유형&nbsp;&nbsp; </td>
				<td> 문제 </td>
				<td width="18%"> 답안 다운로드 </td>
				<td width="10%">채점하기</td>
			</tr>

			<% if(beans == null) { %>
			<tr>
				<td colspan="5" class="blank">논술형 문제가 없습니다.</td>
			</tr>
			<% } else {
					String qtypes = "";
					for(int i=0; i<beans.length; i++) { 
						qtypes = "<img src='../../images/qlistE.gif'>";
			%>
			<tr id="td" align="center">
				<td id="left"><b><li><%=beans[i].getId_q()%></b>&nbsp;&nbsp;&nbsp;</td>
				<td><%=qtypes%></td>
				<td style="text-align:left; padding: 15px 5px 18px 5px;"><%=beans[i].getQ()%></td>
				<td><a href="user_non_answer.jsp?id_exam=<%=id_exam%>&id_q=<%=beans[i].getId_q()%>">[다운로드]</a></td>
				<td><a href="javascript:ans_mark_non('<%=beans[i].getId_q()%>')"><img src="../../images/bt_check_yj1.gif"></a></td>
			</tr>
			<%
					}
				}
			%>
		</table>

	</div>
	<div id="button">
		
	<img src="../../images/bt5_exit_yj1.gif" style="cursor: pointer;" onclick="window.close();">
		
	</div>

</body>

</html>