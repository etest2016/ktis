<%
//******************************************************************************
//   프로그램 : auto_score.jsp
//   모 듈 명 : 과락여부설정 정보
//   설    명 : 과락여부설정 정보
//   테 이 블 : exam_ans
//   자바파일 : qmtm.ComLib, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean
//   작 성 일 : 2013-04-25
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

	String success_score1;
	String success_score2;

	if(users == null) {
		success_score1 = "";
		success_score2 = "";
	} else {
		success_score1 = users[0].getSuccess_score1();
		success_score2 = users[0].getSuccess_score2();
	}

%>

<html>
<head>
	<title> :: 과락여부 설정 :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
	<script language="javascript">
		function success_chk() {
			var frm = document.form1;

			if(frm.success_score1.value == "") {
				alert("필기합격점수를 입력하세요");
				return false;
			} else if(frm.success_score2.value == "") {
				alert("실기합격점수를 입력하세요");
				return false;
			} else {
				frm.submit();
			}
		}

		function auto_score_chk() {
			$.posterPopup("ans_score_detail.jsp?id_exam=<%=id_exam%>","auto_view","width=600, height=600, scrollbars=yes, top=0, left=0");
		}
	</script>

</head>

<BODY id="popup2">	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td id="left"></td>
				<Td id="mid"><div class="title">과락여부 설정</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>	
	
	<div id="contents">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" >
			<tr>				
				<td align="right"><input type="button" value="응시자별 과락여부확인" class="form" onClick="auto_score_chk();"></td>
			</tr>
		</table>
		<BR>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableD">
			<form name="form1" method="post" action="auto_score_ok.jsp">
			<input type="hidden" name="id_exam" value="<%=id_exam%>">
			<tr>
				<td id="left" width="100"><li>필기합격점수</td>
				<td>&nbsp;<input type="text" name="success_score1" size="5" value="<%=success_score1%>"> 점</td>
			</tr>
			<tr>
				<td id="left" width="100"><li>실기합격점수</td>
				<td>&nbsp;<input type="text" name="success_score2" size="5" value="<%=success_score2%>"> 점</td>
			</tr>
			
		</table>
	</div>

	<div id="button">
		<input type="button" value="과락여부설정" class="form4" onClick="success_chk();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form4" onClick="window.close();">
	</div>
	</form>
</body>

</html>
