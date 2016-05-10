<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}
%>
<HTML>
<HEAD>
<TITLE>모사판정 근거답안 확인</TITLE>
</HEAD>
<FRAMESET cols="35%,*" frameborder=0>
<FRAME SRC="exam_ans_non_left2.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid=<%=userid%>" name="left" scrolling=auto>
<FRAMESET rows="40%,*" frameborder=0>
<FRAME SRC="exam_ans_non_top2.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid=<%=userid%>" name="tops">
<FRAME SRC="exam_ans_non_main2.jsp" name="main" scrolling=auto>
</FRAMESET>
</FRAMESET> 
</HTML>