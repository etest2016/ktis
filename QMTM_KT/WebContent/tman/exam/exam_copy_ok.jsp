<%
//******************************************************************************
//   프로그램 : exam_copy.jsp
//   모 듈 명 : 시험지 복사
//   설    명 : 시험지 복사
//   테 이 블 : exam_m, exam_paper2
//   자바파일 : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   작 성 일 : 2008-06-16
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
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
		alert("일괄복사 작업이 완료되었습니다.");
		opener.parent.frames['fraLeft'].location.reload();
		opener.parent.frames['fraMain'].location.reload();
		window.close();
	</script>
	