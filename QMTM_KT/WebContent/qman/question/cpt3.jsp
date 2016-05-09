<%
//******************************************************************************
//   프로그램 : cpt3.jsp
//   모 듈 명 : 단원3 리스트 페이지
//   설    명 : 해당 단원2 아래에 단원 3 정보 가지고 오기
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

	String cpt3 = request.getParameter("cpt3");

	// 단원 3 정보 가지고 오기
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt3Beans(cpt3);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>
<select name="chapter3" style="width:300" disabled onChange="get_cpt4_list(this.value);">
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