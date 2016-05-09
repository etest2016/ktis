<%
//******************************************************************************
//   프로그램 : ftp_path_ok.jsp
//   모 듈 명 : FTP 경로설정
//   설    명 : FTP 경로설정 페이지
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

	String http_files_url = request.getParameter("http_files_url");
	if (http_files_url == null) { http_files_url= ""; } else { http_files_url = http_files_url.trim(); }

	if (userid.length() == 0 || http_files_url.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	
	
	// FTP 경로 변경
	try {
		EnvUtil.updateFTP(userid, http_files_url);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<script language="JavaScript">
	alert("FTP 경로가 정상적으로 변경되었습니다.");
	location.href="ftp_path.jsp";
</script>