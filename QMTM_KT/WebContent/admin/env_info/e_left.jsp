<%
//******************************************************************************
//   ���α׷� : e_left.jsp
//   �� �� �� : ȯ�漳�� ���ʸ޴�
//   ��    �� : ȯ�漳�� ���ʸ޴�
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2010-06-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

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
			<TD><img src="../img/title_sub_setting.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<!--<div><a href="class_list.jsp" target="fraMain">�з��� ����</a></div>-->
				<div><a href="pwd_list.jsp" target="fraMain">��й�ȣ ����</a></div>
				<!--<div>Web ȯ�漳��</div>-->
			</TD>
		</TR>
		<TR id="Main">
			<TD>
				<!--<div><a href="class_list.jsp" target="fraMain">�з��� ����</a></div>-->
				<div><a href="ftp_path.jsp" target="fraMain">FTP ��� ����</a></div>
				<!--<div>Web ȯ�漳��</div>-->
			</TD>
		</TR>
		<TR id="Main">
			<TD>
				<!--<div><a href="class_list.jsp" target="fraMain">�з��� ����</a></div>-->
				<div><a href="web_path.jsp" target="fraMain">WEB URL ����</a></div>
				<!--<div>Web ȯ�漳��</div>-->
			</TD>
		</TR>		
		<TR id="Bottom">   
			<TD></TD>
		</TR>
	</TABLE>
	
	<jsp:include page="../../quick.jsp"/>

</body>
</html>