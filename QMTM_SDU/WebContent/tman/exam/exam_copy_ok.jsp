<%
//******************************************************************************
//   ���α׷� : exam_copy.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ����
//   �� �� �� : exam_m, exam_paper2
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamList, qmtm.tman.exam.ExamUtil
//   �� �� �� : 2013-02-12
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.common.*, qmtm.CommonUtil, qmtm.tman.exam.ExamList, qmtm.tman.exam.ExamUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%   
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	
	
	String open_year = request.getParameter("open_year");
	if (open_year == null) { open_year = ""; } else { open_year = open_year.trim(); }

	String open_month = request.getParameter("open_month");
	if (open_month == null) { open_month = ""; } else { open_month = open_month.trim(); }
	
	if (id_course.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;	
	}

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String id_subject = request.getParameter("id_subject");
	String id_exam = request.getParameter("id_exam");

	String[] arrExam;

	arrExam = id_exam.split("@");

	String org_id_exam = arrExam[0];
	String title = arrExam[1];

	String copy_id_exam = "";
	String copy_title = "";
	String all_copy_id_exam = "";

	int paper_cnt = Integer.parseInt(request.getParameter("paper_cnt"));

	int course_no = 1;

	try {
		course_no = ExamUtil.getOrderCnt(id_course, id_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	for(int i = 0; i < paper_cnt; i++) {
		copy_id_exam = CommonUtil.getMakeID("E");

		copy_title = title + "(" + String.valueOf(i+1) + ")";

		course_no = course_no + i;

		try {
			ExamList.exam_copy(org_id_exam, copy_id_exam, copy_title, open_year, open_month, id_course, id_subject);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		all_copy_id_exam = all_copy_id_exam + copy_id_exam + ", ";
	}

	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(org_id_exam);	
	logbean.setUserid(userid);
	logbean.setGubun("�����ϰ�����");
	logbean.setId_q("");
	logbean.setBigo(all_copy_id_exam);

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>
	<script language="JavaScript">
		alert("�ϰ����� �۾��� �Ϸ�Ǿ����ϴ�.");
		opener.parent.fraLeft.location.reload();
		opener.parent.fraMain.location.reload();
		window.close();
	</script>
	