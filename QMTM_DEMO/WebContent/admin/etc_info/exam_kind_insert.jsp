<%
//******************************************************************************
//   ���α׷� : exam_kind_insert.jsp
//   �� �� �� : �׷챸�е��
//   ��    �� : �׷챸�е�� �˾� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2010-06-11
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
	<title>:: �׷챸�� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.id_exam_kind.value == "") {
				alert("�׷��ڵ带 �Է��ϼ���");
				frm.id_exam_kind.focus();
				return false;
			} else if(frm.exam_kind.value == "") {
				alert("�׷챸���� �Է��ϼ���");
				frm.exam_kind.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="exam_kind_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�׷챸�� ��� <span> �׷챸���� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�׷��ڵ�</td>
				<td width="200"><input type="text" class="input" name="id_exam_kind" size="25"></td>
			</tr>
			<tr>
				<td id="left">�׷챸��</td>
				<td><input type="text" class="input" name="exam_kind" size="25"></td>
			</tr>
			<tr>
				<td id="left">����&nbsp;</td>
				<td><textarea name="rmk" rows="3" cols="25"></textarea></td>
			</tr>
	</table>
</div>

<div id="button">
<a href="javascript:" onClick="send();" onfocus="this.blur();"><img src="../../images/bt5_make_yj1_1.gif" border="0"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>