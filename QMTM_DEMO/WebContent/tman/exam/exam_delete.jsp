<%
//******************************************************************************
//   프로그램 : exam_delete.jsp
//   모 듈 명 : 시험지 삭제
//   설    명 : 시험지 삭제
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-05-15
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

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	try {
		ExamPaperUtil.makecntMinus(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<script language="JavaScript">
	alert("시험지가 정상적으로 삭제되었습니다.");
	parent.location.reload();
</script>