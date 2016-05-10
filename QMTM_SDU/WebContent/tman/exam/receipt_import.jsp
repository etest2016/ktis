<%
//******************************************************************************
//   프로그램 : receipt_inwons2.jsp
//   모 듈 명 : 대상자인원
//   설    명 : 대상자인원 페이지
//   테 이 블 : exam_receipt, qt_userid
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean
//   작 성 일 : 2013-02-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }	

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_course = request.getParameter("id_course");	
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }	
	
	String course_year = request.getParameter("course_year");	
	if (course_year == null) { course_year= ""; } else { course_year = course_year.trim(); }	
	
	String course_no = request.getParameter("course_no");	
	if (course_no == null) { course_no = ""; } else { course_no = course_no.trim(); }	
	
	if (id_exam.length() == 0 || id_course.length() == 0 || id_subject.length() == 0 || course_year.length() == 0 || course_no.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;	
	}
	
	try {
		ReceiptUtil.receiptImport(id_course, id_subject, course_year, course_no);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
%>	

<Script language="javascript">
	alert("과정대상자가 등록되었습니다.");
	opener.location.reload();
	window.close();
</Script>