<%
//******************************************************************************
//   ���α׷� : ans_restore.jsp
//   �� �� �� : ����� ����
//   ��    �� : ����� ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   �� �� �� : 2008-05-21
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

	String[] arrUserid;
	arrUserid = userids.split(",");

	for(int i=0; i<arrUserid.length; i++) {

		// Bak ���̺� ����� ���� 
		try {
			ExamAnswer.bakrestore(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		// Bak ���̺� ����� ����
		try {
			ExamAnswer.bakdelete(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}
%>

<script language="javascript">
	alert("������� ���������� �����Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>