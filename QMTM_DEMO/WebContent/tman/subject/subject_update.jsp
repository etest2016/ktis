<%
//******************************************************************************
//   프로그램 : subject_update.jsp
//   모 듈 명 : 과목 수정
//   설    명 : 시험관리 과목정보 수정하기
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course"); // 과정 ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // 과목 ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    String subject = request.getParameter("subject"); // 과목명
	String yn_valid = request.getParameter("yn_valid"); // 공개여부
	
	// 과목정보 수정
    try {
	    SubjectTmanUtil.update(id_course, id_subject, subject, yn_valid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">	
	opener.parent.frames['fraLeft'].location.reload();
	alert("단원이 정상적으로 수정되었습니다.");
	opener.parent.frames['fraLeft'].oc('<%=id_course%>',0,'C1');
	window.close();
</script>