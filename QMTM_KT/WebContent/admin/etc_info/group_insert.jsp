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
	<title>:: �о߱׷� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Sends() {
			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("�о��ڵ带 �Է��ϼ���");
				frm.id_category.focus();
				return false;
			} else if(frm.category.value == "") {
				alert("�о߸��� �Է��ϼ���");
				frm.category.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="group_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�о߱׷� ��� <span> ī�װ� �о߱׷��� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�о��ڵ�</td>
				<td width="200"><input type="text" class="input" name="id_category" size="25"></td>
			</tr>
			<tr>
				<td id="left">�о߸�</td>
				<td><input type="text" class="input" name="category" size="25"></td>
			</tr>
	</table>
</div>

<div id="button">
<a href="javascript:Sends();" onfocus="this.blur();"><img src="../../images/bt5_make_yj1_1.gif" border="0"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>