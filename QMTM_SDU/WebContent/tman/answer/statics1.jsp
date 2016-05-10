<%
//******************************************************************************
//   프로그램 : statics1.jsp
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

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, qmtm.common.*, java.sql.*" %>
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

	int tot_inwons = 0;
	int yes_inwons = 0;
	int no_inwons = 0;

	ExamInfoBean info = null;
	
	try {
		info = ExamInfo.getBean(id_exam);
	}
    catch (Exception ex) {
        out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	int id_auth_type = info.getId_auth_type();

	if(id_auth_type > 0) {
		try {
			tot_inwons = AnsInwonList.getTotInwon(id_exam, id_auth_type);
		} catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	} else {
		tot_inwons = 0;
	}

	try {
		yes_inwons = AnsInwonList.getYesInwon(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if(id_auth_type > 0) {
		no_inwons = tot_inwons - yes_inwons;
	} else {
		no_inwons = 0;
	}
%>

<input type="text" class="input" size="6" value="<%=tot_inwons%>">&nbsp;&nbsp;<input type="text" class="input" size="6" value="<%=yes_inwons%>">&nbsp;&nbsp;<input type="text" class="input" size="6" value="<%=no_inwons%>">
