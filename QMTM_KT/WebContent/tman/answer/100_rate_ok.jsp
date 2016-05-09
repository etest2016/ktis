<%
//******************************************************************************
//   프로그램 : 100_score_ok.jsp
//   모 듈 명 : 100점 환산점수 가감처리
//   설    명 : 100점 환산점수 가감처리
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   작 성 일 : 2008-02-26
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String allott = request.getParameter("allott");
	if (allott == null) { allott = ""; } else { allott = allott.trim(); }

	if (id_exam.length() == 0 || allott.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	try {
		ExamUtil.rate100(id_exam, Double.parseDouble(allott));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

%>

<script language="javascript">
	window.opener.rate_100_score_proc();
	window.close();
</script>