<%
//******************************************************************************
//   프로그램 : course_update.jsp
//   모 듈 명 : 과정 수정
//   설    명 : 과정수정하기
//   테 이 블 : c_course
//   자바파일 : qmtm.admin.TmanTree
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.TmanTree, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String course = request.getParameter("course");
    String yn_valid = request.getParameter("yn_valid");

    // 과정정보 수정	
	try {
	    TmanTree.update(id_course, course, yn_valid, id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	opener.parent.frames['fraLeft'].location.reload();
	alert("과정이 정상적으로 수정되었습니다.");
	opener.parent.frames['fraMain'].location.reload(); 
	window.close();
</script>