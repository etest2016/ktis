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

	<TABLE border="0" id="menu" cellpadding="0" cellspacing="0" >
		<TR id="Top">
			<TD><img src="../img/title_sub_time.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>
				<div><a href="../exam_info/exam_ing_list.jsp" target="fraMain">���� ����ǥ</a></div>
				<!--<div><a href="http://utest.kt.com/admin_bbs2/time_list_admin.asp" target="fraMain">���� ���ΰ���</a></div>-->
				<!--<div><a href="../manager/member_static_list.jsp" target="fraMain">�����ڼ�������������</a></div>-->
			</TD>
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>	
</body>
</html>
