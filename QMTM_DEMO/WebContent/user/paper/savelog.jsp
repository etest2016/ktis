<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, etest.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");
%>

<%
	String log_type = request.getParameter("log_type");
	if (log_type == null) { log_type = ""; }
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; }
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; }
	String remain_time = request.getParameter("timeLeft");
	if (remain_time == null) { remain_time = ""; }
	String nr_q = request.getParameter("nr_q");
	if (nr_q == null) { nr_q = ""; }
	String id_activity_type = request.getParameter("id_activity_type");
	if (id_activity_type == null) { id_activity_type = ""; }
	String user_ip = request.getRemoteAddr();
	if (user_ip == null) { user_ip = ""; }
	String browser = request.getHeader("user-agent");
	if (browser == null) { browser = ""; }
	String answers = request.getParameter("answers");
	if (answers == null) { answers = ""; }
	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; }
	if (!id_q.equals("")) { answers = request.getParameter("newnon"); }

	if(nr_q.length() > 0) {
		
		answers = answers.replaceAll(QmTm.CHAR_PATTERN1, "\"");
		answers = answers.replaceAll(QmTm.CHAR_PATTERN2, "\r\n");
		answers = answers.replaceAll(QmTm.CHAR_PATTERN3, "\\");
		answers = answers.replaceAll("&#34;", "\"");

	} else {

		answers = answers.replaceAll(QmTm.CHAR_PATTERN1, "\"");
		answers = answers.replaceAll(QmTm.CHAR_PATTERN2, "\r\n");
		answers = answers.replaceAll(QmTm.CHAR_PATTERN3, "\\");
		answers = answers.replaceAll("&#34;", "\"");
		answers = answers.replaceAll("'", "''");

	}

	answers = answers.replaceAll("\r\n", DBPool.NON_NL);

	try {
	  User_Log.saveLogText(log_type, id_exam, userid, id_activity_type, user_ip, browser, nr_q, id_q, answers, remain_time);
	}
	catch (Exception ex) {
	  out.println(ex.getMessage());

	  if(true) return;
	}
%>

