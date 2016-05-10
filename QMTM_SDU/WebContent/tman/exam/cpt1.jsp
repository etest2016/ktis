<%
//******************************************************************************
//   프로그램 : cpt1.jsp
//   모 듈 명 : 모듈 리스트 페이지
//   설    명 : 해당 과목 아래에 모듈 정보 가지고 오기
//   테 이 블 : q_chapter
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

	String cpt1 = request.getParameter("cpt1");
	if (cpt1 == null) { cpt1= ""; } else { cpt1 = cpt1.trim(); }
	
	if (cpt1.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// 모듈 가지고 오기
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt1Beans(cpt1);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
&nbsp;&nbsp;<select name="chapter1" style="width:300" disabled>
<% if(cpts == null) { %>
	<option value="">단원정보 없음</a>
<%
	} else {
%>
	<option value="">단원을 선택하세요.</a>
<%
		for(int i=0; i<cpts.length; i++) {
%>
	<option value="<%=cpts[i].getId_q_chapter()%>"><%=cpts[i].getChapter()%></option>
<%
		}
	}
%>
</select>