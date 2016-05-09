<%
//******************************************************************************
//   프로그램 : pwd_change.jsp
//   모 듈 명 : 비밀번호 변경
//   설    명 : 비밀번호 변경 페이지
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

	String qmtm_password = request.getParameter("qmtm_password");
	if (qmtm_password == null) { qmtm_password= ""; } else { qmtm_password = qmtm_password.trim(); }

	if (userid.length() == 0 || qmtm_password.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	

	// 변경할 비밀번호 암호화.
	try {
		qmtm_password = CommonUtil.encrypt(qmtm_password);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// 암호 변경
	try {
		EnvUtil.update(userid, qmtm_password);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<script language="JavaScript">
	alert("비밀번호가 정상적으로 변경되었습니다.");
	location.href="pwd_list.jsp";
</script>