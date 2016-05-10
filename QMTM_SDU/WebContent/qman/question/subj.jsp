<%
//******************************************************************************
//   프로그램 : subj.jsp
//   모 듈 명 : 과목 리스트 페이지
//   설    명 : 해당 과정 아래에 과목 정보 가지고 오기
//   테 이 블 : q_subject
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   작 성 일 : 2013-02-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String subj = request.getParameter("subj");
	if (subj == null) { subj = ""; } else { subj = subj.trim(); }
	
	if (subj.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// 과목 가지고 오기
	ExamUtilBean[] subjs = null;

    try {
	    subjs = ExamUtil.getSubjBeans(subj);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<select name="id_subject" style="width:300" onChange="get_cpt1_list(this.value);" disabled>
<% if(subjs == null) { %>
	<option value="">과목정보 없음</a>
<%
	} else {
%>
	<option value="">과목을 선택하세요.</a>
<%
		for(int i=0; i<subjs.length; i++) {
%>
	<option value="<%=subjs[i].getId_q_subject()%>"><%=subjs[i].getQ_subject()%></option>
<%
		}
	}
%>
</select>