<%
//******************************************************************************
//   프로그램 : static_excel2.jsp
//   모 듈 명 : 개인성적통계 엑셀저장
//   설    명 : 개인성적통계 엑셀저장
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

	response.setHeader("Content-Disposition", "attachment; filename=ExamStatic2.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String search_gubun = request.getParameter("search_gubun");
	if (search_gubun == null) { search_gubun= ""; } else { search_gubun = search_gubun.trim(); }

	String areas1 = request.getParameter("area1");
	String areas2 = request.getParameter("area2");

	StaticScoreBean[] scoreP = null;

	try {
		scoreP = StaticScore.getPList(id_exam, search_gubun, Double.parseDouble(areas1), Double.parseDouble(areas2));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<body>

	<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC"  width="100%">
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center" bgcolor="#D9D9D9">응시자 아이디</td>
			<td align="center" width="15%" bgcolor="#D9D9D9">성명</td>
			<td align="center" width="12%" bgcolor="#D9D9D9">득점</td>
			<td align="center" width="15%" bgcolor="#D9D9D9">환산점수(/100)</td>
			<td align="center" width="12%" bgcolor="#D9D9D9">석차</td>
			<td align="center" width="15%" bgcolor="#D9D9D9">백분위(%)</td>
		</tr>
		<%
			if(scoreP != null) {
				for(int p = 0; p < scoreP.length; p++) {
		%>
		<tr bgcolor="#FFFFFF" height="25">
			<td align="center"><%=scoreP[p].getUserid()%></td>
			<td align="center"><%=scoreP[p].getName()%></td>
			<td align="center"><%=scoreP[p].getScore()%></td>
			<td align="center"><%=scoreP[p].getPct_score()%></td>
			<td align="center"><%=scoreP[p].getU_rank()%></td>
			<td align="center"><%=scoreP[p].getPct_rank()%></td>
		</tr>
		<%
				}
			}
		%>
	</table>

	</body>
</html>