<%
//******************************************************************************
//   ���α׷� : manager_insert.jsp
//   �� �� �� : ����� ���
//   ��    �� : ����� ��� �˾� ������
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
	<title>:: ����� ��� :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.userid.value == "") {
				alert("���̵� �Է��ϼ���");
				frm.userid.focus();
				return false;
			} else if(frm.password.value == "") {
				alert("��й�ȣ�� �Է��ϼ���");
				frm.password.focus();
				return false;
			} else if(frm.name.value == "") {
				alert("������ �Է��ϼ���");
				frm.name.focus();
				return false;
			} else {
				frm.submit();
			}
		}

	</script>
</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="manager_insert_ok.jsp" >

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�űԴ���� ��� <span>�� ����ڸ� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left">���̵�</td>
					<td width="300"><input type="text" class="input" name="userid" size="20"></td>
				</tr>
				<tr>
					<td id="left">��й�ȣ</td>
					<td><input type="password" name="password" size="20"></td>
				</tr>
				<tr>
					<td id="left">����</td>
					<td><input type="text" class="input" name="name" size="20"></td>
				<tr>
					<td id="left">����� �Ҽ�</td>
					<td><textarea name="rmk" cols="35" rows="3"></textarea></td>
				</tr>
				<tr>
					<td id="left">�������</td>
					<td><input type="radio" name="yn_valid" value="Y" checked> ��밡��&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N"> ���Ҵ�</td>
				</tr>
		</table>
	</div>

	<div id="button">
		<img src="../../images/bt_manager_yj1.gif" onClick="send();">&nbsp;&nbsp;<!--input type="button" value="���" onclick="window.close();"--><a href="javascript:window.close();"><img src="../../images/bt5_exit_yj1_11.gif" border="0" align="adsmiddle"></a>
	</div>

	</form>

</BODY>
</HTML>