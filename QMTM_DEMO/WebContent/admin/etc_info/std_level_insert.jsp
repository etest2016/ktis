<%
//******************************************************************************
//   ���α׷� : std_level_insert.jsp
//   �� �� �� : �����ڵ���
//   ��    �� : �����ڵ��� �˾� ������
//   �� �� �� : r_std_level
//   �ڹ����� : qmtm.admin.etc.StdLevelBean, qmtm.admin.etc.StdLevelUtil
//   �� �� �� : 2008-04-11
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
%>
<html>
<head>
	<title>:: �����ڵ� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="std_level_insert_ok.jsp">
<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����ڵ� ��� <span> �����ڵ� �� �������� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>


	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�����ڵ�</td>
				<td width="200"><input type="text" class="input" name="std_level" size="10"></td>
			</tr>
			<tr>
				<td id="left">������</td>
				<td><input type="text" class="input" name="level_nm" size="25"></td>
			</tr>
	</table>
</div>

<div id="button">
<input type="image" value="�����" name="submit" src="../../../images/bt5_make_yj1_1.gif">&nbsp;&nbsp;<!--<input type="button" onclick="window.close()" value="â�ݱ�">--><a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>