<%
//******************************************************************************
//   프로그램 : course_insert_ok.jsp
//   모 듈 명 : 과정 등록
//   설    명 : 시험관리 과정 등록하기   
//   테 이 블 : c_course
//   자바파일 : qmtm.ComLib, qmtm.admin.TmanTree
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.TmanTree, java.util.Date, java.util.Calendar" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String course = request.getParameter("course");
	if (course == null) { course = ""; } else { course = course.trim(); }
    
	if (id_category.length() == 0 || course.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);

	String years = String.valueOf(year);

	String id_course = CommonUtil.getMakeID("C1");

    // 과정등록
	try {
	    TmanTree.insert(id_course, course, years, id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 등록되었습니다.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.reload(); 
	location.href="course_insert.jsp?id_category=<%=id_category%>";
</script>