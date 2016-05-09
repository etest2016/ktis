<%
//******************************************************************************
//   프로그램 : ans_restore.jsp
//   모 듈 명 : 답안지 복구
//   설    명 : 답안지 복구
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
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

	String userids = request.getParameter("userids");
	if (userids == null) { userids = ""; } else { userids = userids.trim(); }

	if (id_exam.length() == 0 || userids.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String[] arrUserid;
	arrUserid = userids.split(",");

	for(int i=0; i<arrUserid.length; i++) {

		// Bak 테이블에 답안지 복구 
		try {
			ExamAnswer.bakrestore(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		// Bak 테이블에 답안지 삭제
		try {
			ExamAnswer.bakdelete(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}
%>

<script language="javascript">
	alert("답안지가 정상적으로 복구되었습니다.");
	window.opener.location.reload();
	window.close();
</script>