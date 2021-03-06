<%
//******************************************************************************
//   프로그램 : cpt1.jsp
//   모 듈 명 : 단원1 리스트 페이지
//   설    명 : 해당 과목 아래에 단원 1 정보 가지고 오기
//   테 이 블 : 
//   자바파일 : qmtm.tman.exam.ExamUtil
//   작 성 일 : 2008-04-22
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String cpt1 = request.getParameter("cpt1");

	// 단원 1 가지고 오기
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt1Beans(cpt1);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>
<select name="chapter1" style="width:300" disabled onChange="get_cpt2_list(this.value);">
<% if(cpts == null) { %>
	<option value=""></a>
<%
	} else {
%>
	<option value=" ">단원을 선택하세요</option>
<%
		for(int i=0; i<cpts.length; i++) {
%>
	<option value="<%=cpts[i].getId_q_chapter()%>"><%=cpts[i].getChapter()%></option>
<%
		}
	}
%>
</select>