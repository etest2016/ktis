<%
//******************************************************************************
//   프로그램 : practice_AutoAns.jsp
//   모 듈 명 : 실기형 답안 일괄생성
//   설    명 : 실기형 답안 일괄생성
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.PracticeUtil
//   작 성 일 : 2013-05-02
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.PracticeUtil" %>
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

	try {
	    PracticeUtil.deleteAns(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

%>

<Script type="text/javascript">
	alert("실기형 답안이 일괄생성되었습니다.");
	window.opener.location.reload();
	window.close();
</Script>