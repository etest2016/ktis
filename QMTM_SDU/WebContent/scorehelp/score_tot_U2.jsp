<%@page contentType="text/html; charset=EUC-KR" %>
<%@page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*"%>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_exam = request.getParameter("id_exam");
	String id_num = request.getParameter("id_q");
	int id_q = 0;
	String stot_score = request.getParameter("tot_score");
	String score_yn = request.getParameter("score_yn");
	String[] arrAns = request.getParameterValues("ichecks");
	String answers = "";
	String tmpAns = "";
	int i = 0;
	double dScore = 0;

	if (id_num == "" || id_num == null) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	} else {
		id_q = Integer.parseInt(id_num);
	}

	answers = "";
	for (i=0; i<arrAns.length; i++) {
		tmpAns = arrAns[i].trim().replace("<", "&lt");
		tmpAns = tmpAns.replace(">", "&gt");
		tmpAns = tmpAns.replace("'", "''");
		tmpAns = tmpAns.replace("&#34;", "\"");

		answers = answers + tmpAns + "','";
	}

	answers = answers.substring(0, answers.length() -3);
	dScore = Double.parseDouble(stot_score);

	try {
		Score_DanSave.saveScore(id_exam, id_q, answers, dScore);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println("0." + ex.getMessage());
		if(true) return;
	}
%>

<script language="javascript">	
	var page_move = "<%=score_yn%>"

	if (page_move == "Y")
	{
		alert("점수가 변경되었습니다.");
		location.href="exam_ans_score_end.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>";
	} else {
	    alert("점수가 저장되었습니다.\n점수가 부여된 응시자는\n채점완료자 목록에서 확인할 수 있습니다.");
		location.href="exam_ans_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>";
	}
</script>