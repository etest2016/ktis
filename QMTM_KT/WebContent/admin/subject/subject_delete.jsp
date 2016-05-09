<%
//******************************************************************************
//   프로그램 : subject_delete.jsp
//   모 듈 명 : 과목 삭제
//   설    명 : 과목 삭제하기
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

    String id_node = request.getParameter("id_node"); // 트리 ID
    String id_subject = request.getParameter("id_subject"); // 과목 ID

	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	
	
	if (id_subject.length() == 0) { 
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}	

    // 과목정보 삭제
	try {
	    SubjectUtil.delete(id_subject);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("과목이 정상적으로 삭제되었습니다.");
	window.opener.location.reload();
	window.close();
</script>