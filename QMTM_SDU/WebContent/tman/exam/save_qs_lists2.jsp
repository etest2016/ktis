<%
//******************************************************************************
//   ���α׷� : save_qs_lists2.jsp
//   �� �� �� : ������ ���� ��� ���� ���(����ɼ��� ���)
//   ��    �� : ������ ���� ��� ���� ���
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.exam.ExamPaperQ
//   �� �� �� : 2008-05-09
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String qs = request.getParameter("qs1");
	String id_exam = request.getParameter("id_exam");

	qs = qs.trim();

	try {
		ExamPaperQ.delete(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	// ���� ����ϱ�
	try {
		ExamPaperQ.saveQ2(qs, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>