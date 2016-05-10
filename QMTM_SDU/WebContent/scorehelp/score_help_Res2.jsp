<%@page contentType="text/html; charset=EUC-KR" %>
<%@page import="qmtm.*, etest.scorehelp.*, java.sql.*"%>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	//String userid =	get_cookie(request, "userid");
	////////////////////////////////////////////////
	String id_exam = request.getParameter("id_exam");
	String id_q = request.getParameter("id_q");

	int id_num = Integer.parseInt(id_q);
	////////////////////////////////////////////////

	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	//if (id_num == null) { id_num = 0; }
	if (id_exam == "") {
%>
<script language="javascript">
	alert("잘못된 시험코드 입니다.");
	window.close();
</script>
<%
}

	if (id_num == 0) {
%>
<script language="javascript">
	alert("잘못된 문제코드 입니다.");
	window.close();
</script>
<%
	if(true) return;
}

	try {
	  Score_Daninit.run_init(id_exam, id_num);
	}
	catch (Exception ex) {
	  //throw new QmTmException("[서버접속 실패]");
	  out.println("1." + ex.getMessage());
	}

%>

<script language="javascript">
	location.href="./exam_ans_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%> "
</script>
