<%
//******************************************************************************
//   ���α׷� : b_left.jsp
//   �� �� �� : �Խ��� ���� �޴�
//   ��    �� : �Խ��� ���� �޴�
//   �� �� �� : 
//   �ڹ����� :  
//   �� �� �� : 2011-08-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
%>

<html>
<head>
	<title>Admin ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link rel="StyleSheet" href="../menu.css" type="text/css">
</head>

<body>

	<TABLE border="0" id="menu" cellpadding="0" cellspacing="0">
		<TR id="Top">
			<TD><img src="../img/title_sub_bbs.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="http://147.6.87.17:8089/admin_bbs2/notice_list.asp" target="fraMain">�������� ����</a></div>
				<div><a href="http://utest.kt.com/admin_bbs2/qna_list.asp" target="fraMain">Q&A ����</a></div>
				<div><a href="http://utest.kt.com/admin_bbs2/faq_list.asp" target="fraMain">FAQ ����</a></div>
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>

	
</body>
</html>
