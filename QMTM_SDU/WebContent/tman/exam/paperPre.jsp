<%
//******************************************************************************
//   ���α׷� : paperPre.jsp
//   �� �� �� : ������������ ��������
//   ��    �� : ������������ ��������
//   �� �� �� : q, q_paper
//   �ڹ����� : 
//   �� �� �� : 2009-08-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // ����� ���̵�
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}
%>

<html>
<head>
	<title>����������������</title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

</head>

	<BODY id="popup2" >
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">����������������</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">		

		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>				
				<td><b>������ ������ ����� �۾��� ����ϰų� �ߴܵǾ��� �۾��� �ֽ��ϴ�.<BR><BR>�̾ �����Ͻ÷��� �Ʒ� ã�� ��ư�� Ŭ���Ͻñ� �ٶ��ϴ�.</b></td>
			</tr>
		</table>
	</div>

	<div id="button">
	<a href="paperPre_ok.jsp?id_exam=<%=id_exam%>"><img src="../../images/bt_q_search_ckwyj1.gif" border="0" ></a>&nbsp;&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt_q_search_closeyj1.gif"></a>
	</div>

</body>

</html>