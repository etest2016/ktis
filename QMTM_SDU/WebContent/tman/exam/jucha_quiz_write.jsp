<%
//******************************************************************************
//   프로 그램 : jucha_quiz_write.jsp
//   모 듈 명 : 주차별 퀴즈등록 페이지
//   설   명 : 주차별 퀴즈등록 페이지
//   테 이 블 : q
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, 
//           qmtm.tman.exam.QuizJuchaBean, qmtm.tman.exam.QuizJucha 
//   작 성 일 : 2016-04-29
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.QuizJuchaBean, qmtm.tman.exam.QuizJucha" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String term_id = request.getParameter("term_id");
	if (term_id == null) { term_id = ""; } else { term_id = term_id.trim(); }	
	
	String jucha = request.getParameter("jucha");
	if (jucha == null) { jucha = ""; } else { jucha = jucha.trim(); }	
	
	if (id_course.length() == 0 || term_id.length() == 0 || jucha.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String course_name = "";

    // 과정명 가지고오기
	try {
		course_name = ExamUtil.getCourseName(id_course);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	String[] arrTerm_id;
	arrTerm_id = term_id.split("-");	
	
	String course_year = arrTerm_id[0];
	String course_no = arrTerm_id[1];	

    /* 해당 년도 학기 과정별 주차 퀴즈정보 가지고오기 */
	QuizJuchaBean rst = null;

	try {
		rst = QuizJucha.getJuchaInfo(id_course, course_year, course_no, Integer.parseInt(jucha));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
%>

<html>
<head>
	<title> :: 퀴즈 등록 :: </title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	<script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript" src="../js/jquery.etest.poster.js"></script>

	<script type="text/javascript">
		
		function checks() {
			var frm = document.form1;

			if(frm.title.value == "") {
				alert("퀴즈명을 입력하세요.");
				frm.title.focus();
				return false;				
			} else if(frm.limittime.value == "") {
				alert("제한시간을 입력하세요.");
				frm.limittime.focus();
				return false;
			} else if(frm.qcntperpage.value == "") {
				alert("화면당 문항수를 입력하세요.");
				frm.qcntperpage.focus();
				return false;
			} else {
				frm.submit();
			}
		}

		function preview() {
			$.posterPopup("jucha_q_preview.jsp?id_course=<%=id_course%>&course_year=<%=course_year%>&course_no=<%=course_no%>&jucha=<%=jucha%>","jqp","width=1000, height=750, scrollbars=yes");
		}
		
	</script>

</head>

<BODY id="popup2">
	
	<form name="form1" method="post" action="jucha_quiz_insert_ok.jsp">

	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="term_id" value="<%=term_id%>">
	<input type="hidden" name="jucha" value="<%=jucha%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">퀴즈등록 <span>주차별 퀴즈를 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">&nbsp;주차</td>
				<td>&nbsp;<%=jucha%> 주차</td>
				<td id="left">&nbsp;응시기간</td>
				<td>&nbsp;<%=rst.getQuiz_start()%> ~ <%=rst.getQuiz_end() %></td>
			</tr>

			<tr>
				<td id="left">&nbsp;출제문항수</td>
				<td>
					&nbsp;<%=rst.getJucha_cnt()%> 문항&nbsp;&nbsp; 
					<% if (rst.getJucha_cnt() != 0) { %>
					<input type="button" value="출제문항미리보기" class="form" onClick="preview();">
					<% } else { %>
					<input type="button" value="출제문항미리보기" class="form" onClick="alert('등록된 문항이 없습니다.');">
					<% } %>
				</td>
				<td id="left">&nbsp;총배점</td>
				<td>&nbsp;<%=rst.getJucha_allotting()%> 점</td>
			</tr>
				
			<tr>
				<td id="left">&nbsp;퀴즈명</td>
				<td colspan="3">&nbsp;<input type="text" class="input" name="title" size="80" value="<%=course_name%> <%=jucha%>주차 퀴즈">
				</td>
			</tr>

			<tr>
				<td id="left">&nbsp;제한시간</td>
				<td>&nbsp;<input type="text" class="input" name="limittime" size="4" value="20"> 분</td>
				<td id="left">&nbsp;화면당문항수</td>
				<td>&nbsp;<input type="text" class="input" name="qcntperpage" value="1" size="3"> 문항</td>
			</tr>

			<tr>
				<td id="left">&nbsp;공개여부</td>
				<td colspan="3">&nbsp;<input type="radio" name="yn_enable" value="Y" checked> 공개&nbsp;&nbsp;<input type="radio" name="yn_enable" value="N"> 비공개</td>
			</tr>
						
		</table>

	</div>
	<div id="button">
		<% if (rst.getJucha_cnt() != 0) { %>
		<input type="button" value="등록하기" class="form6" onClick="checks();">&nbsp;&nbsp;&nbsp;
		<% } else { %>
		<input type="button" value="등록하기" class="form6" onClick="alert('등록된 문항이 없습니다.');">&nbsp;&nbsp;&nbsp;
		<% } %>
		<input type="button" value="취소하기" class="form6" onClick="window.close();">
	</div>	

	</form>
</BODY>