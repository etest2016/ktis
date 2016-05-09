<%
//******************************************************************************
//   ���α׷� : std_level_edit.jsp
//   �� �� �� : �����ڵ����
//   ��    �� : �����ڵ���� �˾� ������
//   �� �� �� : r_std_level
//   �ڹ����� : qmtm.admin.etc.StdLevelBean, qmtm.admin.etc.StdLevelUtil
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String std_level = request.getParameter("std_level");
	if (std_level == null) { std_level= ""; } else { std_level = std_level.trim(); }

	if (std_level.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	StdLevelBean rst = null;

    try {
	    rst = StdLevelUtil.getBean(std_level);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>
<html>
<head>
	<title>:: �����ڵ� ���� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="std_level_update.jsp">
<input type="hidden" name="std_level" value="<%=std_level%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����ڵ� ���� <span> �����ڵ� Ȯ�� �� ������ ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�����ڵ�</td>
				<td width="200"><%=std_level%></td>
			</tr>
			<tr>
				<td id="left">������</td>
				<td><input type="text" class="input" name="level_nm" size="25" value="<%=rst.getLevel_nm()%>"></td>
			</tr>

	</table>
	</div>

<div id="button">
<input type="image" value="�����ϱ�" name="submit" src="../../../images/bt5_edit_yj1.gif">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>