<%
//******************************************************************************
//   프로그램 : orderCnt.jsp
//   모 듈 명 : 정렬순서 SelectBox
//   설    명 : 정렬순서 정보 가져오기
//   테 이 블 : c_course
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_midcategory = request.getParameter("id_midcategory");

	// 소영역에 따른 과정 정렬순서
	int order_cnt = 0;

	try {
		order_cnt = CourseKindUtil.getOrderCnt(id_midcategory);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<select name="orders">
	<option value="">선택</option>
<% for(int i = 1; i <= 15; i++) { %>	
	<option value="<%=i%>" <%if(order_cnt == i) {%>selected<% } %>><%=i%></option>
<% } %>