<%
//******************************************************************************
//   프로그램 : exam_write.jsp
//   모 듈 명 : 시험등록
//   설    명 : 시험등록 페이지
//   테 이 블 : r_exlabel
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.RexlabelBean, 
//              qmtm.admin.tman.SubjectTmanUtil, qmtm.admin.tman.SubjectTmanBean, 
//              qmtm.tman.exam.ExamUtil, qmtm.tman.exam.RexlabelUtil, java.sql.Timestamp
//   작 성 일 : 2013-02-12
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil, java.sql.Timestamp, java.util.Calendar" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");	
%>

<html>
<head>
<title> :: 퀴즈응시 메시지 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script type="text/javascript">	
	
</script>

</head>

<body id="popup2">
	
	<form name="form1" action="exam_insert.jsp" method="post">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">퀴즈응시 메시지등록 <span>퀴즈응시 관련 메시지를 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 500px;">		

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>시험입장메시지</b></td>
				<td align="right"><input type="button" value="등록하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>시험입장메시지</td>
				<td>&nbsp;<textarea name="QUIZ_START_MESSAGE" rows="5" cols="85"></textarea></td>				
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>시험종료메시지</b></td>
				<td align="right"><input type="button" value="등록하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>시험종료메시지</td>
				<td>&nbsp;<textarea name="QUIZ_START_MESSAGE" rows="5" cols="85"></textarea></td>				
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>부정행위경고메시지</b></td>
				<td align="right"><input type="button" value="등록하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>부정행위경고메시지</td>
				<td>&nbsp;<textarea name="CHEAT_ALERT_MESSAGE" rows="5" cols="85"></textarea></td>				
			</tr>
		</table><br>
		
	</div>	
	
	</form>
	
 </BODY>
</HTML>