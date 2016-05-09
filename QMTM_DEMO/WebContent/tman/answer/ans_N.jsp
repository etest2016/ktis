<%
//******************************************************************************
//   프로그램 : ans_N.jsp
//   모 듈 명 : 답안지 [완료] -> [미완료]
//   설    명 : 답안지 [완료] -> [미완료]
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamAnswer
//   작 성 일 : 2008-05-21
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String userids = request.getParameter("userids");

	String[] arrUserid;
	arrUserid = userids.split(",");

	for(int i=0; i<arrUserid.length; i++) {

		// [완료] -> [미완료]
		try {
			ExamAnswer.ansN(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}
%>

