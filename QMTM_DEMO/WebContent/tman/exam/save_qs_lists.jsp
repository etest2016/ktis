<%
//******************************************************************************
//   ���α׷� : save_qs_lists.jsp
//   �� �� �� : ������ ���� ��� ���� ���(����ɼ��� �ƴҰ��)
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

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String qs = request.getParameter("qs1");
	String allott = request.getParameter("allotts1");
	String id_exam = request.getParameter("id_exam");

	qs = qs.trim();
	allott = allott.trim();

	String[] Arr_qs;
	String[] Arr_allott;

	Arr_qs = qs.split(",");
	Arr_allott = allott.split(",");

	try {
		ExamPaperQ.delete(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	for(int i=0; i<Arr_qs.length; i++) {

		// ���� ����ϱ�
  		try {
			ExamPaperQ.saveQ(Arr_qs[i], Arr_allott[i], id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
	}
%>