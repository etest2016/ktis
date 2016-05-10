<%
//******************************************************************************
//   프로그램 : ans_event_excel.jsp
//   모 듈 명 : 응시자 이벤트 로그 엑셀저장
//   설    명 : 응시자 이벤트 로그 엑셀저장
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-06-20
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="application/vnd.ms-excel; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
    response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=ExamEvent.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	LogImportBean[] rst = null;
	
	// 완료자/미완료자 가지고오기
    try {
	    rst = LogImport.getBeans(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<body>

	<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC"  width="100%">
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center" width="18%" bgcolor="#D9D9D9">시험명</td>
			<td align="center" width="10%" bgcolor="#D9D9D9">아이디</td>
			<td align="center" width="9%" bgcolor="#D9D9D9">성명</td>
			<td align="center" width="10%" bgcolor="#D9D9D9">이벤트</td>
			<td align="center" bgcolor="#D9D9D9">브라우져</td>
			<td align="center" width="12%" bgcolor="#D9D9D9">로그시간</td>
			<td align="center" width="10%" bgcolor="#D9D9D9">응시자 IP</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">서버NO</td>
		</tr>
		<%
			if(rst != null) {
				for(int p = 0; p < rst.length; p++) {
		%>
		<tr bgcolor="#FFFFFF" height="25">
			<td align="center"><%=rst[p].getTitle()%></td>
			<td align="center"><%=rst[p].getUserid()%></td>
			<td align="center"><%=rst[p].getName()%></td>
			<td align="center"><%=Log.getEvent(rst[p].getId_activity_type())%></td>
			<td align="center"><%=rst[p].getUser_browser()%></td>
			<td align="center"><%=rst[p].getLog_date()%></td>
			<td align="center"><%=rst[p].getUser_ip()%></td>
			<td align="center"><%=rst[p].getServer_no()%></td>
		</tr>
		<%
				}
			}
		%>
	</table>

</body>
</html>