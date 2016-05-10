<%
//******************************************************************************
//   ���α׷� : exam_deletes_ok.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���� ����
//   �� �� �� : exam_m, exam_paper2
//   �ڹ����� : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   �� �� �� : 2008-06-16
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*,  qmtm.tman.exam.*" %>
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

	if (id_exam.length() == 0 || id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	boolean ans_YN = false;

	try {
		ans_YN = ExamList.ans_yn(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	if(ans_YN) {
%>
	<script language="JavaScript">
		alert("�ش� ���迡 �����ڰ� �־ ������ ������ �� �����ϴ�.");
		window.close();
	</script>
<%
		if(true) return;
	} else {
		try {
			ExamList.exam_deletes(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}

		WorkExamLogBean logbean = new WorkExamLogBean();

		logbean.setId_exam(id_exam);
		logbean.setUserid(userid);
		logbean.setGubun("�������");
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
		opener.parent.fraLeft.location.reload();
		alert("������ ���������� �����Ǿ����ϴ�.");
		opener.parent.fraMain.location.href = "../subject_list.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>";
		window.close();
	</script>

<%
	}
%>