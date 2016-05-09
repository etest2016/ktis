<%
//******************************************************************************
//   프로그램 : std_grade_insert_ok.jsp
//   모 듈 명 : 학년코드 등록
//   설    명 : 학년코드 등록하기
//   테 이 블 : r_std_grade
//   자바파일 : qmtm.admin.etc.StdGradeBean, qmtm.admin.etc.StdGradeUtil
//   작 성 일 : 2008-04-11
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

    String std_grade = request.getParameter("std_grade");
	if (std_grade == null) { std_grade= ""; } else { std_grade = std_grade.trim(); }

	if (std_grade.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	String grade_nm = request.getParameter("grade_nm");

	StdGradeBean bean = new StdGradeBean();

	bean.setStd_grade(std_grade);
	bean.setGrade_nm(grade_nm);

    // 학년코드등록
	try {
	    StdGradeUtil.insert(bean);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 등록되었습니다.");
	window.opener.location.reload();
	window.close();
</script>