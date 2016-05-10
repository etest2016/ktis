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
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.paper.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	try {
		ExamPaperUtil.makecntMinus(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(userid);
	logbean.setGubun("����������");
	logbean.setId_q("");
	logbean.setBigo("");

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>

<script language="JavaScript">
	alert("�������� ���������� �����Ǿ����ϴ�.");
	parent.location.reload();
</script>