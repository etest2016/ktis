<%
//******************************************************************************
//   ���α׷� : exam_delete.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-05-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
	alert("�������� ���������� �����Ǿ����ϴ�.");
	parent.location.reload();
</script>