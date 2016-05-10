<
//******************************************************************************
//   프로그램 : static_excel.jsp
//   모 듈 명 : 전체성적통계 엑셀저장
//   설    명 : 전체성적통계 엑셀저장
//   테 이 블 : 
//   자바파일 : qmtm.tman.statics.StaticScoreBean, qmtm.tman.statics.StaticScore
//   작 성 일 : 2008-06-18
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="application/vnd.ms-excel; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.statics.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	response.setHeader("Content-Disposition", "attachment; filename=ExamStatic.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	StaticScoreBean scoreA = null;

	try {
		scoreA = StaticScore.getTList(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;		
	}
%>
 
<html>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<body>

	<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC"  width="100%">
		<tr height="40" bgcolor="#FFFFFF">
			<td align="center" bgcolor="#D9D9D9">평가명</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">문제수</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">배점</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">평균</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">상위 10% 평균</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">최고</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">최저</td>
			<td align="center" width="7%" bgcolor="#D9D9D9">응답자 수</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">0~9</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">10~19</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">20~29</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">30~39</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">40~49</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">50~59</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">60~69</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">70~79</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">80~89</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">90~100</td>
		</tr>
		<% if(scoreA != null) { %>
		<tr bgcolor="#FFFFFF" height="30">
			<td align="center"><%=scoreA.getTitle()%></td>
			<td align="center"><%=scoreA.getQcount()%></td>
			<td align="center"><%=scoreA.getAllotting()%></td>
			<td align="center"><%=scoreA.getAvg_score()%></td>
			<td align="center"><%=scoreA.getTop_score()%></td>
			<td align="center"><%=scoreA.getMax_score()%></td>
			<td align="center"><%=scoreA.getMin_score()%></td>
			<td align="center"><%=scoreA.getAll_inwon()%></td>
			<td align="center"><%=scoreA.getInwon1()%></td>
			<td align="center"><%=scoreA.getInwon2()%></td>
			<td align="center"><%=scoreA.getInwon3()%></td>
			<td align="center"><%=scoreA.getInwon4()%></td>
			<td align="center"><%=scoreA.getInwon5()%></td>
			<td align="center"><%=scoreA.getInwon6()%></td>
			<td align="center"><%=scoreA.getInwon7()%></td>
			<td align="center"><%=scoreA.getInwon8()%></td>
			<td align="center"><%=scoreA.getInwon9()%></td>
			<td align="center"><%=scoreA.getInwon10()%></td>
		</tr>
		<% } %>
	</table>

	</body>
</html>