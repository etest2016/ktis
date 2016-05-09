<%
//******************************************************************************
//   프로그램 : exam_ing_list_excel.jsp
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
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamSchedule, qmtm.tman.exam.ExamScheduleBean " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=examList.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
	
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
</head>

		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr bgcolor="#FFFFFF" align="center" height="30" >
				<td bgcolor="#D8D8D8">과정명</td>
				<td bgcolor="#D8D8D8">시험명</td>
				<td bgcolor="#D8D8D8">시험시작일</td>
				<td bgcolor="#D8D8D8">시험종료일</td>
				<td bgcolor="#D8D8D8">대상인원</td>
				<td bgcolor="#D8D8D8">응시인원</td>
				<td bgcolor="#D8D8D8">미응시인원</td>		
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td align="center" colspan="7">검색일자를 입력하세요..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {		
%>
			<tr bgcolor="#FFFFFF" height="27" align="center">
				<td align="left">&nbsp;<%=rst[i].getCourse()%></td>
				<td align="left">&nbsp;<%=rst[i].getTitle()%></td>
				<td><%=rst[i].getExam_start()%></td>
				<td><%=rst[i].getExam_end()%></td>
				<td><%=rst[i].getTot_inwon()%> 명</td>
				<td><%=rst[i].getAns_inwon()%> 명</td>
				<td><%=rst[i].getTot_inwon() - rst[i].getAns_inwon()%> 명</td>
			</tr>
<%
		}
	}
%>
		</table>
		
</body>

</html>