<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.DBPool, qmtm.ComLib, qmtm.QmTmException, etest.*, etest.paper.*, java.sql.*" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	// Session Check
	String current_userid = "";

	current_userid = (String)session.getAttribute("current_userid");
	if (current_userid == null) { current_userid= ""; } else { current_userid = current_userid.trim(); }

	if(current_userid.length() == 0 ) {
		StringBuffer str = new StringBuffer();

		str.append("<script>");
		str.append("alert('�ٸ� ���������� ����ڰ� �α����Ͽ����ϴ�.');");
		str.append("top.window.close();");
		str.append("</script>");
		
	    out.println(str.toString());

	    if(true) return;
	}	
%>
<%
	if (request.getMethod().equalsIgnoreCase("get")) {
	  response.sendRedirect("/error/page_error.jsp");    
		
	  if(true) return ;
	}
	if (session.getAttribute("yn_end") != null) {
	  if (session.getAttribute("yn_end").toString().equalsIgnoreCase("Y")) {
		// throw new QmTmException("[����� �̹� �����Ͽ����ϴ�]@close@notice");
	  }
	}
	//out.print("<H3 align=center>����� ���� �ϰ� �ֽ��ϴ�.<br><br>��ø� ��ٷ� �ֽʽÿ�</H3>");
	//out.flush();
%>
<%
	String id_exam = request.getParameter("id_exam");
	String userid = request.getParameter("userid");
	String answers = request.getParameter("answers");
	String nonAns = request.getParameter("newnon");

	String yn_submit = request.getParameter("yn_submit");
	String yn_end = "N";
	if (yn_submit.equalsIgnoreCase("Y")) { yn_end = "Y"; }
	else { yn_end = "N"; }

	String id_q = request.getParameter("id_q");

	String remain_time = request.getParameter("timeLeft");

	if (remain_time.length() == 0) { remain_time = "0"; }

	String yn_open_score_direct = request.getParameter("yn_open_score_direct");
	String moveType = request.getParameter("movetype");
	String nr_q = request.getParameter("nr_q");

	String user_ip = request.getHeader("iv-remote-address");

	if(user_ip == null || user_ip.equals("")) {
		user_ip = request.getRemoteAddr();
	}
	String browser = request.getHeader("user-agent");
%>
<%
	// ������� ���� ���ڿ��� �����·� �����

	answers = answers.replaceAll(User_QmTm.CHAR_PATTERN1, "\"");
	answers = answers.replaceAll(User_QmTm.CHAR_PATTERN2, "\r\n");
	answers = answers.replaceAll(User_QmTm.CHAR_PATTERN3, "\\");
	answers = answers.replaceAll("&#34;", "\"");
	//answers = answers.replaceAll("'", "''"); // �����Ͽ����� (bean or prepared statememt ??)

	nonAns = nonAns.replaceAll(User_QmTm.CHAR_PATTERN1, "\"");
	nonAns = nonAns.replaceAll(User_QmTm.CHAR_PATTERN2, "\r\n");
	nonAns = nonAns.replaceAll(User_QmTm.CHAR_PATTERN3, "\\");
	nonAns = nonAns.replaceAll("&#34;", "\"");
	nonAns = nonAns.replaceAll("'", "''"); // ������� (not prepared statememt)
%>
<%
	 // �α׸� ����� --> �α����� ���нÿ��� ��� ����
	String ansForLog = answers;
	if (nr_q.length() > 0) { ansForLog = nonAns; }
	ansForLog = ansForLog.replaceAll("\r\n", DBPool.NON_NL);

	// answer log
	try {
	  User_Log.saveLogText("2", id_exam, userid, "", "", "", nr_q, id_q, ansForLog, remain_time);
	} catch (Exception ex) {
		throw new QmTmException("[�α����� ����] : ��ڴ� (" + DBPool.LOG_PATH + ") ������ ����� �ּ���@close@error");
	}
%>
<%
	// �������
	User_ExamAnsBean ans;
	User_ExamAnsNonBean non;
	try {
	  ans = User_ExamAns.getBean(userid, id_exam);
	} catch (Exception ex) {
	  out.print(User_QmTm.setMoveY()); out.close();
	  response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

	  if(true) return;
	}

	// �������� ���� : �̹� ����� ����� ���� or ������ �ۼ��� ���

	String yn_end_curr = ans.getYn_end();
	long remain_time_curr = ans.getRemain_time();
	boolean isSave = true;
	if (yn_end_curr.equalsIgnoreCase("Y") || remain_time_curr < Long.parseLong(remain_time)) {
	  isSave = false;
	}

	// �������

	if (isSave)
	{
	  // exam_ans update (remain_time, end_time ������ ���� �׻� ����)

	  Timestamp system_now = new Timestamp(System.currentTimeMillis());
	  if (answers.replaceAll(User_QmTm.Q_GUBUN_re, "").length() != 0) {
		ans.setAnswers(answers);
	  }
	  if (ans.getRemain_time() > Long.parseLong(remain_time)) {
		ans.setRemain_time(Long.parseLong(remain_time));
	  }
	  ans.setEnd_time(system_now);
	  ans.setYn_end(yn_end);
	  try {
		User_ExamAns.update(ans);
	  } catch (Exception ex) {
		out.print(User_QmTm.setMoveY()); out.close();
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	  }
	}

	// exam_ans_non update
	// ������� ����� ���� ���
	if (id_q.length() > 0)
	{
	  try {
		non = User_ExamAnsNon.getBean(Long.parseLong(id_q), userid, id_exam);
	  } catch (Exception ex) {
		out.print(User_QmTm.setMoveY()); out.close();
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	  }

	  StringBuffer buf = new StringBuffer(nonAns);
	  String anstmp1,anstmp2, anstmp3;

	  if (buf.length() <= 1500) {
		anstmp1 = buf.substring(0); anstmp2 = ""; anstmp3 = "";
	  } else if (buf.length() <= 3000) {
		anstmp1 = buf.substring(0, 1500);
		anstmp2 = buf.substring(1500);
		anstmp3 = "";
	  } else {
		anstmp1 = buf.substring(0, 1500);
		anstmp2 = buf.substring(1500, 3000);
		anstmp3 = buf.substring(3000); // �ִ� 6000 �� ����
	  }
	  if (anstmp1.length() > 0) {
		non.setUserans1(anstmp1);
		non.setUserans2(anstmp2);
		non.setUserans3(anstmp3);
	  }
	  try {
		User_ExamAnsNon.update(non);
	  } catch (Exception ex) {
		out.print(User_QmTm.setMoveY()); out.close();
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	  }
	}

	// ä�� (������� and �����ٷΰ���)

	double userScore = 0.0;
	double allot = 0.0;

	if (yn_end.equalsIgnoreCase("Y") && yn_open_score_direct.equalsIgnoreCase("Y"))
	{
	  // ä���� �ϰ� ����
	  try {
		User_ExamAns.setScoreOxs(ans);
	  } catch (Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	  }

	  // ä�����
	  try {
		ans = User_ExamAns.getBean(userid, id_exam);
		try {
		  User_Log.saveLogText("1", id_exam, userid, "8", user_ip, browser, "", "", "", ""); // 8:�ڵ�ä��:��������
		} catch (Exception ex) {
		   //Log ���� ���� : continue
		}
	  } catch (Exception ex) {
		out.print(User_QmTm.setMoveY()); out.close();
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	  }
	  userScore = ans.getScore();
%>

<%
  // ����
  User_ExamInfoBean info;
  try {
   info = User_ExamInfo.getBean(id_exam);
   allot = info.getAllotting();
  } catch (Exception ex) {
   out.print(User_QmTm.setMoveY()); out.close();
   response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

   if(true) return;
  }
}
%>

<%
if (yn_end.equalsIgnoreCase("N"))
{
  if (moveType.equalsIgnoreCase("N")) {
%>
      <script type="text/javascript">top.fraTest.GetNext();</script>
<%
  } else if (moveType.equalsIgnoreCase("P")) {
%>
      <script type="text/javascript">top.fraTest.GetPrevious();</script>
<%
  } else if (moveType.equalsIgnoreCase("C")) {
%>
      <script type="text/javascript">top.fraTest.GetQ();</script>
<%
  } else {
      // ������ �ٽ� �о�� �ʿ䰡 ���� ��� : nothing todo
  }
}
else if (yn_end.equalsIgnoreCase("Y"))
{
 //Event Log : ��������⼺�� = 7
try {
    User_Log.saveLogText("1", id_exam, userid, "7", user_ip, browser, "", "", "", "");
}
catch (Exception ex) {}
%>
<script type="text/javascript">

  if (window.name == "fraAction") {
    <% if (yn_open_score_direct.equalsIgnoreCase("Y")) { %>
    top.fraTest.document.all.end_score.innerHTML = "<font size=6 color=red><b><i><%= userScore %></i></b></font>";
    <% } %>
    top.fraTest.End_Msg();
  }
  else { <% /* called by retrySubmit */ %>
    <% if (yn_open_score_direct.equalsIgnoreCase("Y")) { %>
    opener.top.fraTest.document.all.end_score.innerHTML = "<font size=6 color=red><b><i><%= userScore %></i></b></font>";
    <% } %>
    opener.top.fraTest.End_Msg();
    close();
  }

</script>
<%
}
%>
