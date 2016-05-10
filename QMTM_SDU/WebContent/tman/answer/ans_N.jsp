<%
//******************************************************************************
//   프로그램 : ans_N.jsp
//   모 듈 명 : 답안지 [완료] -> [미완료]
//   설    명 : 답안지 [완료] -> [미완료]
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamAnswer
//   작 성 일 : 2008-05-21
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userids = request.getParameter("userids");

	String[] arrUserid;
	arrUserid = userids.split(",");

	for(int i=0; i<arrUserid.length; i++) {

		// [완료] -> [미완료]
		try {
			ExamAnswer.ansN(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}

	StringBuffer bigos2 = new StringBuffer();

	bigos2.append("응시상태변경 : 완료에서 미완료로 상태변경");
	bigos2.append(", 변경응시자 : ");
	bigos2.append(userids);
	
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("응시상태변경");
	logbean.setId_q("");
	logbean.setBigo(bigos2.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
	    out.println(ex.getMessage());

	    if(true) return;
    }
%>

