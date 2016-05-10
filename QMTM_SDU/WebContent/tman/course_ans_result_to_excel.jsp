<%
//******************************************************************************
//   프로그램 : course_and_result_to_excel.jsp
//   모 듈 명 : 과정별 응시자 목록 및 점수 엑셀다운로드
//   설    명 : 시험관리 트리에서 과정 선택시 과정별 응시자 점수 엑셀다운로드 탭
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2013-03-14
//   작 성 자 : 이테스트 이범재
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamSchedule, qmtm.tman.exam.ExamScheduleBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");	
	String usergrade = (String)session.getAttribute("usergrade"); // 권한

    String course_name = "";

    // 과정명 가지고오기
	try {
		course_name = ExamUtil.getCourseName(id_course);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	ExamScheduleBean[] rst = null;

	try {
		rst = ExamSchedule.getInwonRes3(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));		    

		if(true) return;
	}

%>

<HTML>
 <HEAD>
  <TITLE> Tman Main </TITLE>
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="../js/jquery.js"></script>
  <script type="text/javascript">
	function go_to_course_list() {
		location.href = "course_list.jsp?id_course=<%=id_course%>";
	}

	function go_to_course_ans_result_to_excel() {
		location.href = "course_ans_result_to_excel.jsp?id_course=<%=id_course%>";
	}

	function excel_down() {
		location.href="course_ans_result_to_excel_download.jsp?id_course=<%=id_course%>";
	}

	var mygrid;

	$(document).ready(function(){

	});
 </script>
 </HEAD>

 <BODY id="admin">	

	<div id="main">
		<div class="tab"><a href="javascript:go_to_course_list();" onfocus="this.blur();"><img src="../images/tabtA01.gif"></a><a href="javascript:go_to_course_ans_result_to_excel();" onfocus="this.blur();"><img src="../images/tabtA02_.gif"></a></div>		
		<div id="mainTop">
			<div class="title">과정별 응시결과 <span>: 과정의 응시자 결과를 엑셀로 다운 받을 수 있습니다.</span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../images/icon_location.gif"> 과정명 : <%=course_name%></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">			
			<tr id="bt">
				<Td colspan="6"><input type="button" value="엑셀다운로드" class="form6" onClick="excel_down();"></td>				
			</tr>
			<tr id="tr">
				<td width="20%">과정명</td>
				<td width="20%">시험명</td>
				<td>시험기간</td>
				<td width="10%">대상인원</td>
				<td width="10%">응시인원</td>
				<td width="10%">미응시인원</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="6">조회할 응시 결과가 없습니다.</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td>&nbsp;<%=rst[i].getCourse()%></td>
				<td>&nbsp;<%=rst[i].getTitle()%></td>
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
		
 </BODY>
</HTML>