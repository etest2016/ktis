<%
//******************************************************************************
//   ���α׷� : ans_score_process_ok.jsp
//   �� �� �� : ������ ������ ��������ó��
//   ��    �� : ������ ������ ��������ó��
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   �� �� �� : 2008-05-27
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
		} else if(gubun.equals("��")) {
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