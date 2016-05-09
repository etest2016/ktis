<%
//******************************************************************************
//   프로그램 : subject_insert_ok.jsp
//   모 듈 명 : 과목 등록
//   설    명 : 시험관리 과목 등록하기
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String subject = request.getParameter("subject");

	String id_subject = CommonUtil.getMakeID("S1");

	SubjectTmanBean bean = new SubjectTmanBean();

	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(1);
	bean.setYn_valid("Y");

    // 과목등록
	try {
	    SubjectTmanUtil.insert(bean);
    } catch(Exception ex) {
	    //out.println(ComLib.getExceptionMsg(ex, "back"));
		out.println(ex.getMessage());

	    if(true) return;
    }
%>

<script language="javascript">	
	opener.parent.frames['fraLeft'].location.reload();
	alert("단원이 정상적으로 등록되었습니다.");
	opener.parent.frames['fraLeft'].oc('<%=id_course%>',0,'C1');
	window.close();
</script>