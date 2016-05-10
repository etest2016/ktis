<%
//******************************************************************************
//   프로그램 : code_chk.jsp
//   모 듈 명 : 대영역 코드 중복체크
//   설    명 : 대영역 코드 중복체크 페이지
//   테 이 블 : c_category
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CategoryUtil
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String input_code = request.getParameter("input_code");

	// 코드 중복체크
	String codeChk_res = "flase";

    try {
	    codeChk_res = CategoryUtil.getCodeChk(input_code);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
<%=codeChk_res.trim()%>