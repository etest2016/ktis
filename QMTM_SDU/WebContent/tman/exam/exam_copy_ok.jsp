<%
//******************************************************************************
//   프로그램 : exam_copy.jsp
//   모 듈 명 : 시험지 복사
//   설    명 : 시험지 복사
//   테 이 블 : exam_m, exam_paper2
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamList, qmtm.tman.exam.ExamUtil
//   작 성 일 : 2013-02-12
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
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
	logbean.setGubun("시험일괄복사");
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
		alert("일괄복사 작업이 완료되었습니다.");
		opener.parent.fraLeft.location.reload();
		opener.parent.fraMain.location.reload();
		window.close();
	</script>
	