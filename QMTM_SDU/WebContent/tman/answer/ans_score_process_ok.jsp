<%
//******************************************************************************
//   프로그램 : ans_score_process_ok.jsp
//   모 듈 명 : 선택한 응시자 득점가감처리
//   설    명 : 선택한 응시자 득점가감처리
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   작 성 일 : 2008-05-27
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
	
	String add = request.getParameter("add");
	String score_log = request.getParameter("score_log");
	String gubun = request.getParameter("gubun");

	String proc_res = add+score_log+gubun;

	String[] arrUserid;
	arrUserid = userids.split(",");

	double scores = 0;

	ExamAnswerBean ans = null;

	for(int i=0; i<arrUserid.length; i++) {
		
		try {
			ans = ExamAnswer.getBean(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		if(gubun.equals("%")) {
			double score_imp = ans.getScore() / Double.parseDouble(score_log);
			if(add.equals("+")) {
				scores = ans.getScore() + score_imp;
			} else if(add.equals("-")) {
				scores = ans.getScore() - score_imp;
			}
		} else if(gubun.equals("점")) {
			if(add.equals("+")) {
				scores = ans.getScore() + Double.parseDouble(score_log);
			} else if(add.equals("-")) {
				scores = ans.getScore() - Double.parseDouble(score_log);
			}
		}
		
		try {
			ExamAnswer.updateProc(id_exam, arrUserid[i], scores, proc_res);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	}
%>

<script language="javascript">
	window.opener.get_answer_score_proc();
	window.close();
</script>