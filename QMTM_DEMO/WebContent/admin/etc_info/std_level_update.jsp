<%
//******************************************************************************
//   프로그램 : std_level_update.jsp
//   모 듈 명 : 레벨코드 수정
//   설    명 : 레벨코드 수정하기
//   테 이 블 : r_std_level
//   자바파일 : qmtm.admin.etc.StdLevelBean, qmtm.admin.etc.StdLevelUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String std_level = request.getParameter("std_level"); // 레벨코드 코드
	if (std_level == null) { std_level= ""; } else { std_level = std_level.trim(); }

	if (std_level.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

    String level_nm = request.getParameter("level_nm"); // 레벨코드
	
	StdLevelBean bean = new StdLevelBean();

	bean.setStd_level(std_level);
	bean.setLevel_nm(level_nm);
	
	// 레벨코드 수정
    try {
	    StdLevelUtil.update(bean);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 수정되었습니다.");
	window.opener.location.reload();
	window.close();
</script>