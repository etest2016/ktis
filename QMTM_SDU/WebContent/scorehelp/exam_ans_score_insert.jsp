<%
//******************************************************************************
//   ���α׷� : ans_non_score.jsp
//   �� �� �� : ����� ä�������
//   ��    �� : ����� ���� ä�� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2009-01-22
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

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

	String adm_userid = (String)session.getAttribute("userid"); // ����� ���̵�
	//������
	if(adm_userid==null){
		adm_userid = "qmtm";
	}

	try {
		Score_AnsNon.DelBasicans(id_exam, id_q, 1);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	
		if(true) return; 
	}

	try {
		Score_AnsNon.InsBasicans(id_exam, id_q, 1, "qmtmEtest", adm_userid);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	
		if(true) return; 
	}

	try {
		Score_AnsNon.InsAresultAll(id_exam, id_q);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	
		if(true) return; 
	}
%>

<Script language="javascript">
	location.href="ans_non_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>";
</Script>