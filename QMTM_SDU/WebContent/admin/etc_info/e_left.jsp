<%
//******************************************************************************
//   ���α׷� : e_left.jsp
//   �� �� �� : �ڵ��������� ���ʸ޴�
//   ��    �� : �ڵ��������� ���ʸ޴�
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2013-02-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib" %> 
<%@ include file = "/common/admin_chk.jsp" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
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
			<TD><img src="../img/title_sub_code.gif"></TD>
		</TR>
		<TR id="Main">
			<TD>				
				<div><a href="group_list.jsp" target="fraMain">�뿵���ڵ����</a></div>
				<div><a href="group_list2.jsp" target="fraMain">�ҿ����ڵ����</a></div>
				<div><a href="course_list.jsp" target="fraMain">�����ڵ����</a></div>
				<div><a href="q_use_list.jsp" target="fraMain">�����뵵�ڵ����</a></div>								
			</TD>    
		</TR>
		<TR id="Bottom">
			<TD></TD>
		</TR>
	</TABLE>
	
</body>
</html>
