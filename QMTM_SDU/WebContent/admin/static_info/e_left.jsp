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

	<TABLE border="0" id="menu" cellpadding="0" cellspacing="0" >
		<TR id="Top">
			<TD><img src="../img/title_sub_time.gif" width="401" ></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="static_all_list.jsp" target="fraMain">��ü����������Ȳ</a></div>
				<!-- <div><a href="static_jucha_list.jsp" target="fraMain">����/������ �����������Ȳ</a></div>-->
				<div><a href="static_subject_list.jsp" target="fraMain">���� �����������Ȳ</a></div>	
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>	
</body>
</html>
