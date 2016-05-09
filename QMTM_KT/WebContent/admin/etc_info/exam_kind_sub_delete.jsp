<%
//******************************************************************************
//   프로그램 : exam_kind_sub_delete.jsp
//   모 듈 명 : 시험구분 삭제
//   설    명 : 시험구분 삭제하기
//   테 이 블 : r_exam_kind_sub
//   자바파일 : qmtm.admin.etc.ExamKindSubBean, qmtm.admin.etc.ExamKindSubUtil
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_exam_kind_sub = request.getParameter("id_exam_kind_sub");
	if (id_exam_kind_sub == null) { id_exam_kind_sub= ""; } else { id_exam_kind_sub = id_exam_kind_sub.trim(); }

	if (id_exam_kind_sub.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	// 시험구분 정보 삭제
	try {
		ExamKindSubUtil.delete(Integer.parseInt(id_exam_kind_sub));
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 삭제되었습니다.");
	window.opener.location.reload();
	window.close();
</script>