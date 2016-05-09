<%
//******************************************************************************
//   프로그램 : subject_insert.jsp
//   모 듈 명 : 과목 등록
//   설    명 : 해당 과정 아래 과목등록하기
//   테 이 블 : c_subject
//   자바파일 : qmtm.admin.subject.SubjectUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.subject.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // 과정코드
	String subject = request.getParameter("subject"); // 과목명
	int subject_order = Integer.parseInt(request.getParameter("subject_order")); // 과목순서
	String yn_valid = request.getParameter("yn_valid"); // 유효여부
	
    String id_subject = CommonUtil.getMakeID("S1");

	SubjectBean bean = new SubjectBean();

	bean.setId_course(id_node);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(subject_order);
	bean.setYn_valid(yn_valid);
	
	// 과목정보 등록
    try {
	    SubjectUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("과목이 정상적으로 등록되었습니다.");
	window.opener.location.reload();
	window.close();
</script>