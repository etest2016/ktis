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
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (id_exam.length() == 0 || id_course.length() == 0) {
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
	} else {
		try {
			ExamList.exam_deletes(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}
%>
	
	<script language="JavaScript">		
		opener.parent.frames['fraLeft'].location.reload();
		alert("������ ���������� �����Ǿ����ϴ�.");
		opener.parent.frames['fraMain'].location.href="../course_list.jsp?id_course=<%=id_course%>";
		opener.parent.frames['fraLeft'].oc('<%=id_course%>',0,'C1');		
		window.close();
	</script>

<%
	}
%>