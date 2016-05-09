<%
//******************************************************************************
//   프로그램 : save_qs_lists.jsp
//   모 듈 명 : 시험지 생성 대상 문제 등록(추출옵션이 아닐경우)
//   설    명 : 시험지 생성 대상 문제 등록
//   테 이 블 : 
//   자바파일 : qmtm.tman.exam.ExamPaperQ
//   작 성 일 : 2008-05-09
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
		
	String extend_time = request.getParameter("extend_time");
	if (extend_time == null) { extend_time = ""; } else { extend_time = extend_time.trim(); }

	if (id_exam.length() == 0 || extend_time.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	try {
		ExtendTime.allDelete(id_exam, Integer.parseInt(extend_time));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>