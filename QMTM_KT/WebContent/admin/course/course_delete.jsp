<%
//******************************************************************************
//   프로그램 : course_delete.jsp
//   모 듈 명 : 과정 삭제
//   설    명 : 과정삭제하기
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
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	
	
	if (id_node.length() == 0) { 
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}	

    // 과정정보 삭제	
	try {
	    CourseUtil.delete(id_node);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("과정이 정상적으로 삭제되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
