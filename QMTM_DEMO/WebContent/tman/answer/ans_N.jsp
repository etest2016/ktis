<%
//******************************************************************************
//   ���α׷� : ans_N.jsp
//   �� �� �� : ����� [�Ϸ�] -> [�̿Ϸ�]
//   ��    �� : ����� [�Ϸ�] -> [�̿Ϸ�]
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAnswer
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

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String userids = request.getParameter("userids");

	String[] arrUserid;
	arrUserid = userids.split(",");

	for(int i=0; i<arrUserid.length; i++) {

		// [�Ϸ�] -> [�̿Ϸ�]
		try {
			ExamAnswer.ansN(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}
%>

