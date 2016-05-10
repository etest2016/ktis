<%
//******************************************************************************
//   프로그램 : exam_ing_list.jsp
//   모 듈 명 : 시험진행 관리 페이지
//   설    명 : 시험진행 관리 페이지
//   테 이 블 : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon
//   작 성 일 : 2008-06-23
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamSchedule, qmtm.tman.exam.ExamScheduleBean, java.util.Date, java.util.Calendar " %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String exam_start = request.getParameter("exam_start");
	if (exam_start == null) { exam_start = ""; } else { exam_start = exam_start.trim(); }

	String exam_end = request.getParameter("exam_end");
	if (exam_end == null) { exam_end = ""; } else { exam_end = exam_end.trim(); }

	int year, month;

	String months = "";

    Calendar cal = Calendar.getInstance();
    year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;

	if(month > 9) {
		months = String.valueOf(month);
	} else {
		months = "0" + String.valueOf(month);
	}

    cal.set(year, month, 1);

    int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

	if(exam_start.length() == 0 && exam_end.length() == 0) {
		exam_start = String.valueOf(year) + "-" + months +"-01";
		exam_end = String.valueOf(year) + "-" + months +"-"+String.valueOf(lastDay);
	}

	ExamScheduleBean[] rst = null;

	if(exam_start.length() > 0 && exam_end.length() > 0) {

		try {
			rst = ExamSchedule.getInwonRes(exam_start, exam_end);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));		    

		    if(true) return;
		}
	} 
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	
	<link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
	<script src="../../js/jquery-ui-1.10.2/jquery-1.9.1.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript">
		$(function() {
			$.datepicker.setDefaults($.datepicker.regional['ko']);
			$( ".date_picker" ).datepicker();
		});
	</script>
 
	<script language="JavaScript">
		function send() {
			var frm = document.form1;
			
			if(frm.exam_start.value == "") {
				alert("검색일자를 입력하세요");
				frm.exam_start.focus();
				return;
			} else if(frm.exam_end.value == "") {
				alert("검색일자를 입력하세요");
				frm.exam_end.focus();
				return;
			} else {
				frm.submit();
			}
		}

		function schedule() {
			location.href="exam_schedule.jsp";
		}

		function excel_down() {
			location.href="exam_ing_list_excel.jsp?exam_start=<%=exam_start%>&exam_end=<%=exam_end%>";
		}
	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_ing_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">권한그룹 관리 <span></span></div>
			<div class="location">ADMIN ><span> 권한그룹관리 > 권한그룹관리</span></div>
		</div>
		
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="11" ALIGN="right">
					<input type="button" value="그룹등록하기" class="form4">
					</td>
			</tr>
			
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">그룹코드</td>
				<td bgcolor="#D8D8D8">그룹명</td>
				<td bgcolor="#D8D8D8">문제편집</td>
				<td bgcolor="#D8D8D8">문제삭제</td>
				<td bgcolor="#D8D8D8">시험편집</td>
				<td bgcolor="#D8D8D8">시험삭제</td>
				<td bgcolor="#D8D8D8">답안지관리</td>
				<td bgcolor="#D8D8D8">수동채점</td>
				<td bgcolor="#D8D8D8">통계처리</td>
				<td bgcolor="#D8D8D8">담당과목등록</td>
				<td bgcolor="#D8D8D8">소속원등록</td>
			</tr>

			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="center">ABC</td>
				<td align="center">1그룹</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center"><input type="button" value="담당과목등록" class="form"></td>
				<td align="center"><input type="button" value="소속원등록" class="form"></td>				
			</tr>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="center">ABC</td>
				<td align="center">1그룹</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center"><input type="button" value="담당과목등록" class="form"></td>
				<td align="center"><input type="button" value="소속원등록" class="form"></td>				
			</tr>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="center">ABC</td>
				<td align="center">1그룹</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center"><input type="button" value="담당과목등록" class="form"></td>
				<td align="center"><input type="button" value="소속원등록" class="form"></td>				
			</tr>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="center">ABC</td>
				<td align="center">1그룹</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center"><input type="button" value="담당과목등록" class="form"></td>
				<td align="center"><input type="button" value="소속원등록" class="form"></td>				
			</tr>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="center">ABC</td>
				<td align="center">1그룹</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center">Y</td>
				<td align="center"><input type="button" value="담당과목등록" class="form"></td>
				<td align="center"><input type="button" value="소속원등록" class="form"></td>				
			</tr>

		</table>
		
	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>