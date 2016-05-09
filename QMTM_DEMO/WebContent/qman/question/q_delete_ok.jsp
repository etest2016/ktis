<%
//******************************************************************************
//   프로그램 : q_delete_ok.jsp
//   모 듈 명 : 문제 삭제
//   설    명 : 출제되지 않은 문제 삭제
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-07-09
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*" %> 

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
	
	if (id_qs.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%
	}

	try {
		QListUtil.deletes(id_qs);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<script language="JavaScript">
	alert("문항이 정상적으로 삭제되었습니다.");
	window.opener.location.reload();
	window.close();
</script>