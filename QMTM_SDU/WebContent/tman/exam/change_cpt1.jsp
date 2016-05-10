<%
//******************************************************************************
//   프로그램 : change_cpt1.jsp
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

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }
	
	if (id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null || id_chapter.equals("")) { id_chapter= ""; } else { id_chapter = id_chapter.trim(); }

	// 모듈 가지고 오기
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt1Beans(id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<select name="id_chapter" style="width:300" >
<% if(cpts == null) { %>
	<option value="0" <% if(id_chapter.equals("0")) { %>selected<% } %>>단원정보 없음</a>
<%
	} else {
%>
	<option value="0" <% if(id_chapter.equals("0")) { %>selected<% } %>>단원을 선택하세요.</a>
<%
		for(int i=0; i<cpts.length; i++) {
%>
	<option value="<%=cpts[i].getId_q_chapter()%>" <% if(id_chapter.equals(cpts[i].getId_q_chapter())) { %>selected<% } %>><%=cpts[i].getChapter()%></option>
<%
		}
	}
%>
</select>