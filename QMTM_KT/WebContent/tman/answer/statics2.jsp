<%
//******************************************************************************
//   프로그램 : statics2.jsp
//   모 듈 명 : 응시자 현황
//   설    명 : 응시자 현황
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnsInwonList
//   작 성 일 : 2008-05-26
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, qmtm.common.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int ans_y = 0;
	int ans_n = 0;

	try {
		ans_y = AnsInwonList.getAnsY(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	try {
		ans_n = AnsInwonList.getAnsN(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

%>

<input type="text" class="input" size="6" value="<%=ans_y%>">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="input" size="6" value="<%=ans_n%>">