<%
//******************************************************************************
//   프로그램 : chapter.jsp
//   모 듈 명 : 모듈1 리스트 페이지
//   설    명 : 해당 과목 아래에 모듈 1 정보 가지고 오기
//   테 이 블 : q_chapter
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/login_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String cpt1 = request.getParameter("cpt1");

	String selects = request.getParameter("selects");

	// 단원 1 가지고 오기
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt1Beans(cpt1);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>
<select name="chapter1" style="width:300" onChange="get_standarda_list(this.value);">
<% if(cpts == null) { %>
	<option value="" <%if(selects.equals("")) {%>selected<%}%>></a>
<%
	} else {
%>
	<option value=" " <%if(selects.equals("")) {%>selected<%}%>>단원을 선택하세요</option>
<%
		for(int i=0; i<cpts.length; i++) {
%>
	<option value="<%=cpts[i].getId_q_chapter()%>" <%if(selects.equals(cpts[i].getId_q_chapter())) {%>selected<%}%>><%=cpts[i].getChapter()%></option>
<%
		}
	}
%>
</select>