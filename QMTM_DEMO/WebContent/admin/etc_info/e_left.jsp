<%
//******************************************************************************
//   ���α׷� : e_left.jsp
//   �� �� �� : ��Ÿ�������� ���ʸ޴�
//   ��    �� : ��Ÿ�������� ���ʸ޴�
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
			<TD><img src="../img/title_sub_etc.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<!--<div><a href="q_use_list.jsp" target="fraMain">�����뵵�ڵ����</a></div>-->			
				<div><a href="group_list.jsp" target="fraMain">�о߱׷��ڵ����</a></div>
				<div><a href="exam_kind_list.jsp" target="fraMain">�׷챸���ڵ����</a></div>
				<!--<div><a href="member_relation.jsp" target="fraMain">������������</a></div>-->
			</TD>    
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>

	
</body>
</html>
