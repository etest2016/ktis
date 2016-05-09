<%
//******************************************************************************
//   프로그램 : manager_update.jsp
//   모 듈 명 : 담당자 수정
//   설    명 : 담당자 수정하기
//   테 이 블 : qt_workerid
//   자바파일 : qmtm.admin.manager.ManagerBean, qmtm.admin.manger.ManagerUtil
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

    String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    String password = request.getParameter("password");
	String name = request.getParameter("name");
	String rmk = request.getParameter("rmk");
	String yn_valid = request.getParameter("yn_valid");

	ManagerBean bean = new ManagerBean();

	bean.setUserid(userid);
	bean.setPassword(password);
	bean.setName(name);
	bean.setContent1(rmk);
	bean.setYn_valid(yn_valid);
	
    // 담당자 수정
	try {
	    ManagerUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 수정되었습니다.");
	window.opener.location.reload();
	window.close();
</script>