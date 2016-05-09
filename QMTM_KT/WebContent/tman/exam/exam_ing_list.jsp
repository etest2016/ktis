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
<%@ include file = "../../common/calendar.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");    
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
			rst = ExamSchedule.getInwonRes2(exam_start, exam_end, userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));		    

		    if(true) return;
		}
	} 
%>

<html>
<head>
	<title></title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
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
			<div class="title">시험 일정표 <span>검색할 시험일자를 입력하면 시험현황을 확인할 수 있습니다.</span></div>
			<div class="location">시험관리 ><span> 시험 일정표</span></div>
		</div>


		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="3">
					<input type="text" class="input" name="exam_start" size="12" readonly onClick="MiniCal(this)" value="<%=exam_start%>"> ~ <input type="text" class="input" name="exam_end" size="12" readonly onClick="MiniCal(this)" value="<%=exam_end%>">&nbsp;&nbsp;<!--<input type="button" value="확인하기" onClick="send();">--><a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
				<td colspan="4" align="right"><input type="button" value="달력으로 보기" class="form5" onClick="schedule();">&nbsp;&nbsp;<input type="button" value="엑셀파일 다운로드" class="form5" onClick="excel_down();"></td>
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">과정명</td>
				<td bgcolor="#D8D8D8">시험명</td>
				<td bgcolor="#D8D8D8">시험기간</td>
				<td bgcolor="#D8D8D8">대상인원</td>
				<td bgcolor="#D8D8D8">응시인원</td>
				<td bgcolor="#D8D8D8">미응시인원</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="6">검색일자를 입력하세요..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="left">&nbsp;<%=rst[i].getCourse()%></td>
				<td align="left">&nbsp;<%=rst[i].getTitle()%></td>
				<td><%=rst[i].getExam_start()%>부터<br><%=rst[i].getExam_end()%>까지</td>
				<td><%=rst[i].getTot_inwon()%> 명</td>
				<td><%=rst[i].getAns_inwon()%> 명</td>
				<td><%=rst[i].getTot_inwon() - rst[i].getAns_inwon()%> 명</td>
			</tr>
<%
		}
	}
%>
		</table>
		
	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>