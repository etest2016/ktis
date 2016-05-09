<%
//******************************************************************************
//   프로그램 : subject_update.jsp
//   모 듈 명 : 과목 수정
//   설    명 : 문제은행 과목정보 수정하기
//   테 이 블 : q_subject
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

    String id_q_subject = request.getParameter("id_q_subject"); // 과정코드
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	
	
	if (id_q_subject.length() == 0) { 
		out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}	

    String q_subject = request.getParameter("q_subject"); // 과목명
	String yn_valid = request.getParameter("yn_valid"); // 공개여부
	
	// 과목정보 수정
    try {
	    QmanTree.update(id_q_subject, q_subject, yn_valid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("과목이 정상적으로 수정되었습니다.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.reload(); 
	window.close();
</script>