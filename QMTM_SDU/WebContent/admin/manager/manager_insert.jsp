<%
//******************************************************************************
//   ���α׷� : manager_insert.jsp
//   �� �� �� : ����� ���
//   ��    �� : ����� ��� �˾� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ include file = "/common/admin_chk.jsp" %>

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
			//} else if(frm.password.value == "") {
			//	alert("��й�ȣ�� �Է��ϼ���");
			//	frm.password.focus();
			//	return false;
			} else if(frm.name.value == "") {
				alert("������ �Է��ϼ���");
				frm.name.focus();
				return false;
			} else {
				frm.submit();
			}
		}

		function trim(str) {
			return str.replace(/(^\s*)|(\s*$)/g,"");
		}
		
		// �ߺ� ���̵� ���� ����������
		function get_id_chk() {			

			var frm = document.frmdata;
			
			if(frm.userid.value == "") {
				alert("���̵� �Է��ϼ���");
				frm.userid.focus();
				return false;
			}

			var input_id = frm.userid.value;

			chks = new ActiveXObject("Microsoft.XMLHTTP");
			chks.onreadystatechange = get_id_chk_callback;
			chks.open("GET", "id_chk.jsp?input_id="+input_id, true);
			chks.send();
		}

		function get_id_chk_callback() {			
			
			var frm = document.frmdata;
			
			if(chks.readyState == 4) {
				if(chks.status == 200) {
					if(trim(chks.responseText) == "true") {
						alert("�̹� ��ϵ� ���̵��Դϴ�.");
						frm.userid.value = "";
						frm.userid.focus();
						return;
					} else {
						alert("��� ������ ���̵��Դϴ�.");
						frm.name.focus();
					}
				}
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
					<td id="left" width="100">���̵�</td>
					<td width="300"><input type="text" name="userid" size="20">&nbsp;&nbsp;<input type="button" value="���̵��ߺ�üũ" class="form3" onClick="get_id_chk();"></td>
				</tr>
				<!--<tr>
					<td id="left">��й�ȣ</td>
					<td><input type="password" name="password" size="21"></td>
				</tr>-->
				<tr>
					<td id="left">����</td>
					<td><input type="text" name="name" size="20" style="ime-mode:active;"></td>
				</tr>
				<tr>
					<td id="left">�޴���</td>
					<td><input type="text" name="hp" size="20" ></td>
				</tr>
				<tr>
					<td id="left">�̸���</td>
					<td><input type="text" name="email" size="30" style="ime-mode:inactive;"></td>
				</tr>
				<tr>
					<td id="left">����� �Ҽ�</td>
					<td><textarea name="rmk" cols="35" rows="3" style="ime-mode:active;"></textarea></td>
				</tr>
				<tr>
					<td id="left">�����������</td>
					<td><input type="radio" name="yn_valid" value="Y" checked> ���&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N"> �̻��</td>
				</tr>
		</table>
	</div>

	<div id="button">
		<input type="button" value="����ϱ�" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>