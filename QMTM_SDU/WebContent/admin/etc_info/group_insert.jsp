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
	<title>:: �뿵�� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Sends() {
			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("�뿵���ڵ带 �Է��ϼ���");
				frm.id_category.focus();
				return false;
			} else if(frm.category.value == "") {
				alert("�뿵������ �Է��ϼ���");
				frm.category.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

		function trim(str) {
			return str.replace(/(^\s*)|(\s*$)/g,"");
		}

		var chks;
		
		// �ߺ� �ڵ� ���� ���������
		function get_code_chk() {			

			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("�뿵���ڵ带 �Է��ϼ���");
				frm.id_category.focus();
				return false;
			}

			var input_code = frm.id_category.value;

			chks = new ActiveXObject("Microsoft.XMLHTTP");
			chks.onreadystatechange = get_code_chk_callback;
			chks.open("GET", "code_chk.jsp?input_code="+input_code, true);
			chks.send();
		}

		function get_code_chk_callback() {			

			var frm = document.frmdata;
			
			if(chks.readyState == 4) {
				if(chks.status == 200) {					
					if(trim(chks.responseText) == "true") {
						alert("�̹� ��ϵ� �ڵ��Դϴ�.");
						frm.id_category.value = "";
						frm.id_category.focus();
						return;
					} else {
						alert("��� ������ �ڵ��Դϴ�.");
						frm.category.focus();
					}
				}
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
				<Td id="mid"><div class="title">�뿵�� ��� <span> �뿵�� �ڵ带 ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�뿵���ڵ�</td>
				<td width="200"><input type="text" class="input" name="id_category" size="17">&nbsp;&nbsp;<input type="button" value="�ߺ�üũ" class="form3" onClick="get_code_chk();"></td>
			</tr>
			<tr>
				<td id="left">�뿵����</td>
				<td><input type="text" class="input" name="category" size="25" style="ime-mode:active;"></td>
			</tr>			
	</table>
</div>

<div id="button">
	<input type="button" value="����ϱ�" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>