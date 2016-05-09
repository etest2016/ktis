<%
//******************************************************************************
//   프로그램 : web_path_ok.jsp
//   모 듈 명 : WEB 경로설정
//   설    명 : WEB 경로설정 페이지
//   테 이 블 : qt_settings
//   자바파일 : qtmm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil 
//   작 성 일 : 2008-09-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 :  
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	// 해당 페이지 권한 체크	
	String userid = (String)session.getAttribute("userid");   
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String qmtm_web_home = request.getParameter("qmtm_web_home");
	if (qmtm_web_home == null) { qmtm_web_home = ""; } else { qmtm_web_home = qmtm_web_home.trim(); }

	if (userid.length() == 0 || qmtm_web_home.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	
	
	// WEB 경로 변경
	try {
		EnvUtil.updateWEB(userid, qmtm_web_home);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<script language="JavaScript">
	alert("WEB 경로가 정상적으로 변경되었습니다.");
	location.href="web_path.jsp";
</script>