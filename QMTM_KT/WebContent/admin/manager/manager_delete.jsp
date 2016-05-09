<%
//******************************************************************************
//   프로그램 : manager_delete.jsp
//   모 듈 명 : 담당자 삭제
//   설    명 : 담당자 삭제하기
//   테 이 블 : qt_workerid
//   자바파일 : qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.manager.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String userid = request.getParameter("userid"); // 과목 ID
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// 담당자 정보 삭제
	try {
		ManagerUtil.delete(userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 삭제되었습니다.");
	window.opener.location.reload();
	window.close();
</script>