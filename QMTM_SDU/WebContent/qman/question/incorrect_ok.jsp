<%
//******************************************************************************
//   ���α׷� : incorrect_ok.jsp
//   �� �� �� : �������� ��� ó��
//   ��    �� : �������� ��� ó��
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2010-06-05
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.qman.editor.*, qmtm.common.* " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }	

	String id_qtype = request.getParameter("id_qtype");
	if (id_qtype == null) { id_qtype = ""; } else { id_qtype = id_qtype.trim(); }	

	String[] ca = request.getParameterValues("ex");
	
	String id_valid_type = request.getParameter("id_valid_type");
	if (id_valid_type == null) { id_valid_type = ""; } else { id_valid_type = id_valid_type.trim(); }	
	
	if (id_q.length() == 0 || id_valid_type.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String arrCA = "";

	if(id_qtype.equals("2")) { // ���������� �������ϰ�� 
		if(id_valid_type.equals("2")) {
		
			try {
				QUtil.updateIncorrect(id_q, Integer.parseInt(id_valid_type));
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		
		} else {
			for(int i=0; i<ca.length; i++) {
				arrCA = arrCA + ca[i] + "{^}";
			}	
		
			try {
				QUtil.updateIncorrect(id_q, arrCA.substring(0, arrCA.length()-3), Integer.parseInt(id_valid_type));
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}	

		}
	} else { // ���������� �������� �ƴҰ��

		try {
			QUtil.updateIncorrect(id_q, Integer.parseInt(id_valid_type));
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	}
%>

<Script language="JavaScript">
	alert("���������� ó���Ǿ����ϴ�.");
	self.close();
	opener.location.reload();
</Script>