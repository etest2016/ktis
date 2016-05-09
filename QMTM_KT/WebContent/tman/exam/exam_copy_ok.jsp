<%
//******************************************************************************
//   ���α׷� : exam_copy.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ����
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

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	
	
	if (id_course.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;	
	}
	
	String id_subject = request.getParameter("id_subject");
	String id_exam = request.getParameter("id_exam");

	String[] arrExam;

	arrExam = id_exam.split("-");

	String org_id_exam = arrExam[0];
	String title = arrExam[1];

	String copy_id_exam = "";
	String copy_title = "";

	int paper_cnt = Integer.parseInt(request.getParameter("paper_cnt"));

	for(int i = 0; i < paper_cnt; i++) {
		copy_id_exam = CommonUtil.getMakeID("E");

		copy_title = title + "(" + String.valueOf(i+1) + ")";

		try {
			ExamList.exam_copy(org_id_exam, copy_id_exam, copy_title);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}
	}
%>
	<script language="JavaScript">
		alert("�ϰ����� �۾��� �Ϸ�Ǿ����ϴ�.");
		opener.parent.frames['fraLeft'].location.reload();
		opener.parent.frames['fraMain'].location.reload();
		window.close();
	</script>
	