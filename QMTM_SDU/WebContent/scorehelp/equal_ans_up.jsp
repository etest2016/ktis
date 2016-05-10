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
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String equal_reason = request.getParameter("equal_reason");
	if (equal_reason == null) { equal_reason= ""; } else { equal_reason = equal_reason.trim(); }

	String[] equal_ans_list = request.getParameterValues("equal_ans_list");

	String score = request.getParameter("ans_score");
	if (score == null) { score= ""; } else { score = score.trim(); }


	String equal_list = "";
	for(int i=0; i<equal_ans_list.length; i++) {
		equal_list = equal_list + equal_ans_list[i] + "{|}";
	}

	if (equal_list.length() > 0 ) {
		equal_list = equal_list.substring(0, equal_list.length() -3);
	} else {
		equal_list = " ";
	}

	String equal_chk = "";
	if (equal_reason == "") {
		equal_chk = "N";
		equal_reason = " ";
	} else {
		equal_chk = "Y";
	}

	try {
		Score_EqualAnsUp.update(equal_chk, equal_reason, Double.parseDouble(score), equal_list, id_exam, Integer.parseInt(id_q), userid);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println("모사비교 결과 변경중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요" + ex.getMessage());

		if(true) return;
	}
%>

<script language="javascript">
	top.window.close();
	top.window.opener.location.reload();
</script>