<%
//******************************************************************************
//   ���α׷� : q_use_insert.jsp
//   �� �� �� : �����뵵���
//   ��    �� : �����뵵��� �˾� ������
//   �� �� �� : r_q_use
//   �ڹ����� : qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
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
%>
<html>
<head>
	<title>:: �����뵵 ��� :: </title>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.id_q_use.value == "") {
				alert("�ڵ带 �Է��ϼ���");
				frm.id_q_use.focus();
				return false;
			} else if(frm.q_use.value == "") {
				alert("�����뵵�� �Է��ϼ���");
				frm.q_use.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

	<form name="frmdata" method="post" action="q_use_insert_ok.jsp">
	<div id="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<Td id="left"></td>
					<Td id="mid"><div class="title">�����뵵 ��� <span> �����뵵 ����մϴ�.</span></div></td>
					<Td id="right"></td>
				</tr>
			</table>
		</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left">�ڵ�</td>
					<td><input type="text" class="input" name="id_q_use" size="10"></td>
				</tr>
				<tr>
					<td id="left">�����뵵</td>
					<td><input type="text" class="input" name="q_use" size="25"></td>
				</tr>
				<tr>
					<td id="left">����</td>
					<td><textarea name="rmk" rows="3" cols="25"></textarea></td>
				</tr>
		</table>

	</div>

	<div id="button">
	<a href="javascript:" onClick="send();" onfocus="this.blur();"><img src="../../../images/bt5_make_yj1_1.gif" border="0"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
	</div>

	</form>

</BODY>
</HTML>