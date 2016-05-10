<%
//******************************************************************************
//   ���α׷� : lms_score_export.jsp
//   �� �� �� : ������ ����� ä�� �����
//   ��    �� : ������ ����� ä�� �����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-06-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.* " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }
	
	String exam_method = request.getParameter("exam_method");
	if (exam_method == null) { exam_method = ""; } else { exam_method = exam_method.trim(); }
	
	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (id_exam.length() == 0 || id_course.length() == 0 || userid.length() == 0 || id_subject.length() == 0 || exam_method.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	try {
		LmsScoreExport.scoreExport(id_exam, id_course, id_subject, exam_method, userid);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
%>

<script language="javascript">		
	alert("��������Ʈ�� ���� �������Ⱑ �Ϸ�Ǿ����ϴ�.");
	window.close();
</script>
	