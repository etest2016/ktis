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
				<div><a href="auth_group_list.jsp" target="fraMain">���ѱ׷켳��</a></div>
				<div><a href="admin_list.jsp" target="fraMain">�ý��۰����ڼ���</a></div>
				<div><a href="admin_quiz_setting.jsp" target="fraMain">������ɼ���</a></div>	
				<div><a href="paper_message_setting.jsp" target="fraMain">���ø޽�������</a></div>				
				<div><a href="pwd_list.jsp" target="fraMain">��й�ȣ����</a></div>
				<div><a href="ftp_path.jsp" target="fraMain">FTP��μ���</a></div>
				<div><a href="cdn_path.jsp" target="fraMain">CDN��μ���</a></div>
				<div><a href="web_path.jsp" target="fraMain">WEB URL��μ���</a></div>		
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>	
</body>
</html>
