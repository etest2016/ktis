<%
//******************************************************************************
//   프로그램 : user_non_answer.jsp
//   모 듈 명 : 응시자 논술형 답안지
//   설    명 : 응시자 논술형 답안지 다운로드
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.PaperNonExportBean, qmtm.tman.answer.PaperNonExport
//   작 성 일 : 2008-09-01
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=ExamNonPaper.doc");
    response.setHeader("Content-Description", "JSP Generated Data");
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
		
	PaperNonExportBean beans = null;
	
	try {
		beans = PaperNonExport.getBeans(id_exam, Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
	
	if(beans == null) {
%>
	<script language="JavaScript">
		alert("해당시험에 논술형 문제가 없습니다.");
		window.close();
	</script>
<%
		if(true) return;
	}
%>

<link rel="StyleSheet" href="http://elearning.jejunu.ac.kr/etest/css/style.css" type="text/css">

<table border="0" width="980" bgcolor="#CCCCCC" cellpadding="3" cellspacing="1">
	<tr bgcolor="#FFFFFF">
		<td width="50" height="45" align="right" valign="middle">문제 : &nbsp;</td>
		<td width="930" valign="middle">&nbsp;&nbsp;<b><%=beans.getQ()%></b> (문제코드 : <b><%=beans.getId_q()%></b>, 배점 : <b><%=beans.getAllotting()%></b>)</td>
	</tr>
</table>

<table border="0">
	<tr>
		<td height="3" width="980" colspan="2"></td>
	</tr>
</table>

<%	   
	PaperNonExportBean[] beans2 = null;

	try {
		beans2 = PaperNonExport.getAllBeans2(id_exam, Long.parseLong(id_q));
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	for(int j=0; j<beans2.length; j++) {
%> 	

<table border="0" width="980">
	<tr>
		<td width="30" align="right">아이디 : </td>
		<td width="950"><b><%=beans2[j].getUserid()%></b>&nbsp;&nbsp;&nbsp;성명 : <b><%=beans2[j].getName()%></b></td>
	</tr>
	<tr>
		<td width="30" align="right">응시자답안 : </td>
		<td width="950"><%=ComLib.nullChk(beans2[j].getUserans1())%> <%=ComLib.nullChk(beans2[j].getUserans2())%> <%=ComLib.nullChk(beans2[j].getUserans3())%> <%=ComLib.nullChk(beans2[j].getUserans4())%> <%=ComLib.nullChk(beans2[j].getUserans5())%></td>
	</tr>
	<tr>
		<td height="5" width="980" colspan="2"></td>
	</tr>
	<tr>
		<td width="980" colspan="2"><hr size="1"></hr></td>
	</tr>
</table>

<% 
	} 
%>