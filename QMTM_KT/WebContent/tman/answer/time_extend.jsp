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
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	String extend_time = request.getParameter("extend_time");
	if (extend_time == null) { extend_time = ""; } else { extend_time = extend_time.trim(); }

	if (id_exam.length() == 0 || userid.length() == 0 || extend_time.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	try {
		ExtendTime.delete(id_exam, userid, Integer.parseInt(extend_time));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>