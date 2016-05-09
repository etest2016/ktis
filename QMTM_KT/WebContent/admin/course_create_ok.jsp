<%
//******************************************************************************
//   프로그램 : course_create_ok.jsp
//   모 듈 명 : 과정 등록
//   설    명 : 과정등록하기
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
<%@ page import="qmtm.*, qmtm.admin.course.CourseUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String course = request.getParameter("course");
    String yn_valid = request.getParameter("yn_valid");

    String id_course = CommonUtil.getMakeID("C1");

    CourseBean bean = new CourseBean();

	bean.setId_course(id_course);
	bean.setCourse(course);
	bean.setYn_valid(yn_valid);
	
    // 과정등록
	try {
	    CourseUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("과정이 정상적으로 등록되었습니다.");
	window.opener.location.reload();
	window.close();
</script>