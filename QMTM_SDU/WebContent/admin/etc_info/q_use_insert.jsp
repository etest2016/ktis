<%
//******************************************************************************
//   ���α׷� : q_use_insert.jsp
//   �� �� �� : �����뵵���
//   ��    �� : �����뵵��� �˾� ������
//   �� �� �� : r_q_use
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   �� �� �� : 2013-02-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil" %>
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
					<td width="200"><input type="text" class="input" name="id_q_use" size="10"></td>
				</tr>
				<tr>
					<td id="left">�����뵵</td>
					<td><input type="text" class="input" name="q_use" size="25" style="ime-mode:active;"></td>
				</tr>
				<tr>
					<td id="left">����</td>
					<td><textarea name="rmk" rows="3" cols="25" style="ime-mode:active;"></textarea></td>
				</tr>
		</table>

	</div>

	<div id="button">
		<input type="button" value="����ϱ�" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">	
	</div>

	</form>

</BODY>
</HTML>