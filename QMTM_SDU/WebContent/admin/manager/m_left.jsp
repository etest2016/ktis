<%
//******************************************************************************
//   ���α׷� : m_left.jsp
//   �� �� �� : ����� ���� �޴�
//   ��    �� : ����� ���� �޴�
//   �� �� �� : 
//   �ڹ����� :  
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
%>   

<html>
<head>
	<title>Admin ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="StyleSheet" href="../menu.css" type="text/css">
</head>

<body>

	<TABLE border="0" id="menu" cellpadding="0" cellspacing="0">
		<TR id="Top">
			<TD><img src="../img/title_sub_manager.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="m_list.jsp" target="fraMain">����� ����</a></div>
				<!--<div><a href="receipt_inwons.jsp" target="fraMain">�����ο�����</a></div>-->				
				<!--<div><a href="q_list.jsp" target="fraMain">QMAN �����</a></div>
				<div><a href="t_list.jsp" target="fraMain">TMAN �����</a></div>-->
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>

	
</body>
</html>
