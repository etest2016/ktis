<%
//******************************************************************************
//   ���α׷� : non_frame.jsp
//   �� �� �� : ������ ����� ä�� ������
//   ��    �� : ������ ����� ä�� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-06-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.* " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

%>

<html>
<head>
	<title>��������� ä���ϱ�</title>
</head>

<frameset rows="140,*" cols="*" frameborder="NO" border="0" framespacing="0">
	<frame src="non_top.jsp" id="topFrame" name="topFrame" scrolling="NO" noresize>
	<frameset rows="*" cols="250,*" framespacing="0" frameborder="no" border="0">
		<frame src="non_user.jsp?id_exam=<%= id_exam %>&id_q=<%= id_q %>" id="fraLeft" name="fraLeft" scrolling="no" noresize>
		<frame src="non_info.jsp" id="fraMain" name="fraMain" scrolling="AUTO">
	</frameset>
</frameset>


