<%
//******************************************************************************
//   ���α׷� : 100_score_reset.jsp
//   �� �� �� : 100�� ȯ������ ����ó��
//   ��    �� : 100�� ȯ������ ����ó��
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   �� �� �� : 2008-02-26
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String allott = request.getParameter("allott");
	if (allott == null) { allott = ""; } else { allott = allott.trim(); }

	if (id_exam.length() == 0 || allott.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	try {
		ExamUtil.score100_reset(id_exam, Double.parseDouble(allott));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

%>

<script language="javascript">
	window.opener.get_100_score_reset();
	location.href="100_score.jsp?id_exam=<%=id_exam%>";
</script>