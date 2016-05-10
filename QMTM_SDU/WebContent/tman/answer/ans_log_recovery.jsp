<%
//******************************************************************************
//   ���α׷� : ans_log_recovery.jsp
//   �� �� �� : ��� ����
//   ��    �� : ��� ����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-05-30
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
    response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    String id_q = request.getParameter("id_q");

    if (id_q == null || id_q.equals("")) 
	{ 
		id_q = ""; 
	} else {
		id_q = id_q.trim();
	}

    String answers = request.getParameter("recovery_ans");  

	if(id_q.equals("")) { // ������, �ܴ��� ��� ������..     

        // ������ ��� ����.
	    ExamAnswerBean ans = new ExamAnswerBean();

		ans.setAnswers(answers);

		try {
			ExamAnswer.update(id_exam, userid, ans);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
	    }

    } else { // ����� ��� ������.

        ExamAnswerNonBean non = new ExamAnswerNonBean();

	    StringBuffer buf = new StringBuffer(answers);
		String anstmp1,anstmp2, anstmp3, anstmp4, anstmp5;
		
        answers = answers.replaceAll("��", "\r\n");
        answers = answers.replaceAll(QmTm.CHAR_PATTERN1, "\"");
        answers = answers.replaceAll(QmTm.CHAR_PATTERN2, "\r\n");
        answers = answers.replaceAll(QmTm.CHAR_PATTERN3, "\\");
        answers = answers.replaceAll("&#34;", "\"");
        answers = answers.replaceAll("'", "\'"); // ������� (not prepared statememt)
                    
        
        if (buf.length() <= 1500) {
		    anstmp1 = buf.substring(0); anstmp2 = ""; anstmp3 = "";
		} else if (buf.length() <= 3000) {
		    anstmp1 = buf.substring(0, 1500);
		    anstmp2 = buf.substring(1500);
		    anstmp3 = "";			
		} else {
		    anstmp1 = buf.substring(0, 1500);
		    anstmp2 = buf.substring(1500, 3000);
		    anstmp3 = buf.substring(3000);		
		}
		if (anstmp1.length() > 0) {
		    non.setUserans1(anstmp1);
		    non.setUserans2(anstmp2);
		    non.setUserans3(anstmp3);			
		}

		try {
			ExamAnswerNon.update(id_exam, userid, Long.parseLong(id_q), non);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

    } // ��� ���� ����.        
%>

<br><br><br>
<b>��� ������ ���������� �Ϸ� �Ǿ����ϴ�</b>