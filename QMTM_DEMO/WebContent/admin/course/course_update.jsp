<%
//******************************************************************************
//   프로그램 : course_update.jsp
//   모 듈 명 : 과정 수정
//   설    명 : 과정수정하기
//   테 이 블 : c_course
//   자바파일 : qmtm.admin.course.CourseUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.course.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // 트리 ID
	String course = request.getParameter("course");
    String yn_valid = request.getParameter("yn_valid");

    // 과정정보 수정	
	try {
	    CourseUtil.update(id_node, course, yn_valid);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("과정이 정상적으로 수정되었습니다.");
	window.opener.location.reload();
	window.close();
</script>