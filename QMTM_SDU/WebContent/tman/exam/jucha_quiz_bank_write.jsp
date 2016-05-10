<%
//******************************************************************************
//   프로 그램 : jucha_quiz_bank_write.jsp
//   모 듈 명 : 주차별 문제은행 퀴즈등록 페이지
//   설   명 : 주차별 문제은행 퀴즈등록 페이지
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

    
%>

<html>
<head>
	<title> :: 문제은행 방식 퀴즈 등록 :: </title>
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

		function id_randomtypes(types) {

			var frm = document.form1;

			if(types == "NN") {
				frm.configs.value = "문제와 보기 순서를 섞지 않고 지정한 순서로 출제합니다.";
			} else if(types == "NQ") {
				frm.configs.value = "문제 순서를 섞어서 출제자가 지정한 수만큼 각각 다른 시험지를 만듭니다.";
			} else if(types == "NT") {
				frm.configs.value = "문제와 보기 순서를 섞어서 출제자가 지정한 수만큼 각각 다른 시험지를 만듭니다.";		
			} else if(types == "YQ") {			
				frm.configs.value = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에  따라 검색한 문제 그룹에서 문제를 추출해서  각각 다른 시험지를 만듭니다.";
			} else if(types == "YT") {			
				frm.configs.value = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에  따라 검색한 문제 그룹에서 문제를 추출해서 각 문제의 보기 순서를 섞어서  각각 다른 시험지를 만듭니다.";
			} 
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
				<Td id="mid"><div class="title">문제은행방식 퀴즈등록 <span>주차별 퀴즈를 등록합니다.</span></div></td>
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
				<td>&nbsp;2016-05-01 06:00 ~ 2016-05-03 23:59</td>
			</tr>

			<tr>
				<td id="left">&nbsp;등록문항수</td>
				<td>&nbsp;5 문항&nbsp;&nbsp; <input type="button" value="출제문항미리보기" class="form" onClick="preview();"></td>
				<td id="left">&nbsp;등록총배점</td>
				<td>&nbsp;30 점</td>
			</tr>
				
			<tr>
				<td id="left">&nbsp;퀴즈명</td>
				<td colspan="3">&nbsp;<input type="text" class="input" name="title" size="80" value="<%=course_name%> <%=jucha%>주차 퀴즈">
				</td>
			</tr>

			<tr>
				<td id="left">&nbsp;출제문항수</td>
				<td>&nbsp;<input type="text" class="input" name="limittime" size="3" value="5"> 문항</td>
				<td id="left">&nbsp;화면당문항수</td>
				<td>&nbsp;<input type="text" class="input" name="qcntperpage" value="1" size="3"> 문항</td>
			</tr>

			<tr>
				<td id="left">&nbsp;제한시간</td>
				<td>&nbsp;<input type="text" class="input" name="limittime" size="4" value="20"> 분</td>
				<td id="left">&nbsp;배점</td>
				<td>&nbsp;<input type="text" class="input" name="allotting" size="4" value="30"> 점</td>				
			</tr>			

			<tr>
				<td id="left">&nbsp;출제유형</td>
				<td colspan="3">&nbsp;<input type="radio" name="id_randomtype" value="NN" checked onClick="id_randomtypes(this.value)">섞지않음<br>
						<input type="radio" name="id_randomtype" value="NQ" onClick="id_randomtypes(this.value)">문제섞기&nbsp;&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NT" onClick="id_randomtypes(this.value)">문제 및 보기섞기<br>
						<input type="radio" name="id_randomtype" value="YQ" onClick="id_randomtypes(this.value)">문제추출 => 문제섞기&nbsp;&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="YT" onClick="id_randomtypes(this.value)">문제추출 => 문제 및 보기섞기<hr>
						&nbsp;<textarea name="configs" cols="80" rows="4" readonly></textarea></td>
			</tr>

			<tr>
				<td id="left">&nbsp;공개여부</td>
				<td colspan="3">&nbsp;<input type="radio" name="yn_enable" value="Y" checked> 공개&nbsp;&nbsp;<input type="radio" name="yn_enable" value="N"> 비공개</td>
			</tr>
						
		</table>

	</div>
	<div id="button">
		<input type="button" value="등록하기" class="form6" onClick="checks();">&nbsp;&nbsp;&nbsp;<input type="button" value="취소하기" class="form6" onClick="window.close();">
	</div>	

	</form>
</BODY>