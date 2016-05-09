<%
//******************************************************************************
//   프로그램 : lms_score_export.jsp
//   모 듈 명 : 성적 내보내기
//   설    명 : LMS로 성적 내보내기
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-11-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("euc-kr");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	try {
		MDOLmsScoreExport.userScoreDel(userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<Script language="JavaScript">
	alert("LMS로 성적내보내기가 완료되었습니다.");
	top.window.close();
</Script>

