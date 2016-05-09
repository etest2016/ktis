<%
//******************************************************************************
//   프로그램 : q_move_ok.jsp
//   모 듈 명 : 문제이동 완료페이지
//   설    명 : 문제이동 완료페이지
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.tman.exam.*
//   작 성 일 : 2008-07-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String id_subject = request.getParameter("subjects");

	String id_chapter1 = request.getParameter("chapter1");
	if (id_chapter1 == null || id_chapter1.equals("") || id_chapter1.equals(" ")) { id_chapter1 = "0"; } else { id_chapter1 = id_chapter1.trim(); }

	String id_chapter2 = request.getParameter("chapter2");
	if (id_chapter2 == null || id_chapter2.equals("") || id_chapter2.equals(" ")) { id_chapter2 = "-1"; } else { id_chapter2 = id_chapter2.trim(); }

	String id_chapter3 = request.getParameter("chapter3");
	if (id_chapter3 == null || id_chapter3.equals("") || id_chapter3.equals(" ")) { id_chapter3 = "-1"; } else { id_chapter3 = id_chapter3.trim(); }

	String id_chapter4 = request.getParameter("chapter4");
	if (id_chapter4 == null || id_chapter4.equals("") || id_chapter4.equals(" ")) { id_chapter4 = "-1"; } else { id_chapter4 = id_chapter4.trim(); }

	try {
		QListUtil.qmoves(id_qs, id_subject, id_chapter1, id_chapter2, id_chapter3, id_chapter4);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

	<script language="javascript">
		alert("문항이동 작업이 완료되었습니다.");
		window.opener.location.reload();
		window.close();
	</script>
