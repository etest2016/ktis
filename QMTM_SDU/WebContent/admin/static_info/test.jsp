<%
//******************************************************************************
//   ���α׷� : group_insert.jsp
//   �� �� �� : �뿵������ ���
//   ��    �� : �뿵������ ��� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2013-01-21
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib" %>

<html>
<head>
	<title>:: �뿵�� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
	<script src="../../js/jquery-ui-1.10.2/jquery-1.9.1.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( ".date_picker" ).datepicker();
	});
  </script>		

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="group_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�׷�Ҽӿ����<span> �׷쿡 �Ҽӿ��� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			 <tr>
				<td colspan="2" width="200">�׷쿡 �̵�ϵ� ������ ���</td>
				<td width="50"></td>
				<td colspan="2" width="200">�׷쿡 ��ϵ� ������ ���</td>				
			</tr>
			<tr>
				<td width="70">���̵�</td>
				<td width="130">����</td>
				<td width="50"></td>
				<td width="70">���̵�</td>
				<td width="130">����</td>		
			</tr>
			<tr >
				<td colspan="2" width="200"><select multiple width="200"><option>prof1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option><option>prof2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option><option>prof3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option><option>prof4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select></td>
				<td width="50"><input type="button" value="��Ϣ�" class="form4" ><BR><input type="button" value="������" class="form4" ></td>
				<td colspan="2" width="200"><select multiple width="200"><option>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select></td>	
			</tr>
			
	</table>
</div>

<div id="button">
	<input type="button" value="����ϱ�" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>