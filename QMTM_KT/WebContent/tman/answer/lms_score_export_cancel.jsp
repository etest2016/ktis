<%
//******************************************************************************
//   ���α׷� : lms_score_export_cancel.jsp
//   �� �� �� : ���� ��������
//   ��    �� : LMS�� ���� ��������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-11-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("euc-kr");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	try {
		LmsScoreExportCancel.userScoreDel(userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<Script language="JavaScript">
	alert("LMS�� ������������ �۾��� ��ҵǾ����ϴ�.");
	top.window.close();
</Script>

