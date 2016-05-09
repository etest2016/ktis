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
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String qs = request.getParameter("qs1");
	String allott = request.getParameter("allotts1");
	String id_exam = request.getParameter("id_exam");

	qs = qs.trim();
	allott = allott.trim();

	String[] Arr_qs;
	String[] Arr_allott;

	Arr_qs = qs.split(",");
	Arr_allott = allott.split(",");

	try {
		ExamPaperQ.delete(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	for(int i=0; i<Arr_qs.length; i++) {

		// 문제 등록하기
  		try {
			ExamPaperQ.saveQ(Arr_qs[i], Arr_allott[i], id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
	}
%>