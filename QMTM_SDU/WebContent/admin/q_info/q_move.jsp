<%
//******************************************************************************
//   프로그램 : q_move.jsp
//   모 듈 명 : 문제이동 페이지
//   설    명 : 문제이동 페이지
//   테 이 블 : q_subject, t_worker_subj
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String usergrade = (String)session.getAttribute("usergrade");

	
%>

<html>
<head>
	<title> :: 문제 이동 :: </title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	

</head>

<BODY id="popup2">
	
	<form name="form1" method="post" action="q_move_ok.jsp">


	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문제 복사 <span>해당 과목에 문제를 복사합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		

		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td id="left" width="120" align="center">년도/학기&nbsp;&nbsp;</td>
				<td>
					<select name="">
						<option value="">2016년1학기</option>
					</select>&nbsp;
				</td>
			</tr>
			
			<tr>
				<td id="left" width="120" align="center">과목선택</td>
				<td>					
					<select name="id_subject">
						<option value="">테스트 과목</option>
					</select>					
				</td>
			</tr>
			
		</table>


	</div>
	<div id="button">

		<input type="button" value="문제복사하기" class="form6">&nbsp;&nbsp;<input type="button" value="취소하기" class="form6">

	</div>


	</form>

</body>