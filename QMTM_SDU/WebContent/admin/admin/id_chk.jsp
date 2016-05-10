<%
//******************************************************************************
//   프로그램 : id_chk.jsp
//   모 듈 명 : 괸리자 아이디 중복체크
//   설    명 : 관리자 아이디 중복체크 페이지
//   테 이 블 : qt_adminid
//   자바파일 : qmtm.admin.admin.AdminUtil
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.admin.AdminUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String input_id = request.getParameter("input_id");

	// 아이디 중복체크
	String idChk_res = "flase";

    try {
	    idChk_res = AdminUtil.getIdChk(input_id);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
<%=idChk_res.trim()%>