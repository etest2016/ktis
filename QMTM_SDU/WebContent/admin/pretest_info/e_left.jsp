<%
//******************************************************************************
//   ���α׷� : e_left.jsp
//   �� �� �� : �α�����Ȯ�� ���� �޴�
//   ��    �� : �α�����Ȯ�� ���� �޴�
//   �� �� �� : 
//   �ڹ����� :  
//   �� �� �� : 2013-02-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>


<%@ page contentType="text/html; charset=EUC-KR" %>
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
			<TD><img src="../img/title_sub_log.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="pretest_list.jsp" target="fraMain">���������</a></div>
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>
		
</body>
</html>
