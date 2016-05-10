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

	String kwd_rate = request.getParameter("kwd_rate");
	if (kwd_rate == null) { kwd_rate= ""; } else { kwd_rate = kwd_rate.trim(); }
%>

<HTML>
<HEAD>
<TITLE>논술형 모사 답안 비교 채점</TITLE>
</HEAD>

<FRAMESET rows="80,*" frameborder=0>
	<FRAME SRC="exam_ans_non_layout.jsp" name="layout">
	<FRAMESET cols="35%,*" frameborder=0>
		<FRAME SRC="exam_ans_non_left.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid=<%=userid%>&kwd_rate=<%=kwd_rate%>" name="left" scrolling=auto>
		<FRAMESET rows="42%,*" frameborder=0>
			<FRAME SRC="exam_ans_non_top.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid=<%=userid%>" name="tops">
			<FRAME SRC="exam_ans_non_main.jsp" name="main" scrolling=auto>
		</FRAMESET>
	</FRAMESET>
</FRAMESET>

</HTML>