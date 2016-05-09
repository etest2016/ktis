<%
//******************************************************************************
//   프로그램 : subject_delete.jsp
//   모 듈 명 : 과목 삭제
//   설    명 : 문제은행 과목 삭제하기
//   테 이 블 : q_subject, q_chapter
//   자바파일 : qmtm.admin.QmanTree
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);     
    request.setCharacterEncoding("EUC-KR");

    String id_q_subject = request.getParameter("id_q_subject"); // 과목 ID
	if (id_q_subject == null) { id_q_subject= ""; } else { id_q_subject = id_q_subject.trim(); }

	if (id_q_subject.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

    // 하위단원 유무 체크
	boolean down_YN = false;

	try {
	    down_YN = QmanTree.getDownCnt(id_q_subject);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
	
	if(down_YN) {
	
		// 과목정보 삭제
		try {
			QmanTree.delete(id_q_subject);
	    } catch(Exception ex) {
		    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

			if(true) return;
	    }
%>

<script language="javascript">
	alert("과목이 정상적으로 삭제되었습니다.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.href="../f_main.jsp"; 
	window.close();
</script>

<%
	} else {
%>
<script language="javascript">
	alert("하위에 단원이 있어서 삭제할 수 없습니다. \n\n하위 단원을 삭제 후 진행해 주시기 바랍니다.");	
	window.close();
</script>
<%
	}
%>