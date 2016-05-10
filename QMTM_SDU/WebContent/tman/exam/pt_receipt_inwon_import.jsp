<%
//******************************************************************************
//   프로그램 : pt_receipt_inwon_import.jsp
//   모 듈 명 : 파트너캠퍼스 대상자인원
//   설    명 : 파트너캠퍼스 대상자인원 페이지
//   테 이 블 : exam_receipt, qt_userid
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean
//   작 성 일 : 2013-03-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean, qmtm.*, qmtm.common.*" %>
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

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_course = request.getParameter("id_course");	
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");	
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }	
		
	try {
		ReceiptUtil.getPCBeans(id_course, id_subject, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}	

	// 엑셀파일 대상자 등록 로그저장 시작
	StringBuffer bigos = new StringBuffer();

	bigos.append("등록방식 : ");
	bigos.append("교육시스템대상자등록");
			
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("대상자등록");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// 엑셀파일 대상자 등록 로그저장 종료
%>

<Script language="javascript">
	alert("대상자가 등록되었습니다.");
	opener.location.reload();
	window.close();
</Script>