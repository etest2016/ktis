<%
//******************************************************************************
//   ���α׷� : std_grade_insert.jsp
//   �� �� �� : �г��ڵ���
//   ��    �� : �г��ڵ��� �˾� ������
//   �� �� �� : r_std_grade
//   �ڹ����� : qmtm.admin.etc.StdGradeBean, qmtm.admin.etc.StdGradeUtil
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
	<title>:: �г��ڵ� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.std_grade.value == "") {
				alert("�г��ڵ带 �Է��ϼ���");
				frm.std_grade.focus();
				return false;
			} else if(frm.grade_nm.value == "") {
				alert("�г���� �Է��ϼ���");
				frm.grade_nm.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="std_grade_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�г��ڵ� ��� <span> �г��ڵ� ��� �մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�г��ڵ�</td>
				<td width="200"><input type="text" class="input" name="std_grade" size="10"></td>
			</tr>
			<tr>
				<td id="left">�г��</td>
				<td><input type="text" class="input" name="grade_nm" size="25"></td>
			</tr>
	</table>
</div>

<div id="button">
<a href="javascript:" onClick="send();" onfocus="this.blur();"><img src="../../../images/bt5_make_yj1_1.gif" border="0"></a>&nbsp;&nbsp;<!--<input type="button" onclick="window.close()" value="â�ݱ�">--><a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>