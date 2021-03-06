<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*" %>

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
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	String scores = request.getParameter("scores");
	if (scores == null) { scores = ""; } else { scores = scores.trim(); }

	if (scores.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}


	try {
		Score_NonScore.saveScore(id_exam, Integer.parseInt(id_q), userid, Double.parseDouble(scores));
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println("0." + ex.getMessage());
		if(true) return;
	}

%>

<script language="javascript">
	window.close();
	window.opener.location.href="ans_non_score2.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>";
</script>