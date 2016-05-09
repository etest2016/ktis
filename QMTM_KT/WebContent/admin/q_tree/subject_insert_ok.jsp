<%
//******************************************************************************
//   프로그램 : subject_insert_ok.jsp
//   모 듈 명 : 과목 등록
//   설    명 : 문제은행 과목 등록하기
//   테 이 블 : q_subject
//   자바파일 : qmtm.admin.course.CourseUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*, java.util.Date, java.util.Calendar " %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String q_subject = request.getParameter("q_subject");
	if (q_subject == null) { q_subject= ""; } else { q_subject = q_subject.trim(); }

	if (q_subject.length() == 0 || id_category.length() == 0 || id_course.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);

	String years = String.valueOf(year);
 	
	String id_q_subject = CommonUtil.getMakeID("S1");

    // 과정등록
	try {
	    QmanTree.insert(id_category, id_q_subject, q_subject, years, id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("과목이 정상적으로 등록되었습니다.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.reload(); 
	location.href="subject_insert.jsp?id_category=<%=id_category%>&id_course=<%=id_course%>";
</script>