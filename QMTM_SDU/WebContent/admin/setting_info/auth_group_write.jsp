<%
//******************************************************************************
//   ���α׷� : admin_edit.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ���� �˾� ������
//   �� �� �� : qt_adminid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>
<HTML>
<HEAD>
<TITLE> ���ѱ׷� ��� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script type="text/javascript">

		function Send() {
			
		}

	</script>
	
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="auth_group_insert.jsp">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���ѱ׷� ��� <span>���ѱ׷��� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td width="100" id="left">�׷��ڵ�</td>
				<td width="350"><input type="text" name="" class="input" size="10"></td>
			</tr>
			<tr>
				<td id="left">�׷��</td>
				<td><input type="text" name="" class="input" size="40"></td>
			</tr>
			<tr>
				<td id="left">ȭ�����</td>
				<td><input type="checkbox" name="" value="Y"> ������������&nbsp;&nbsp;<input type="checkbox" name="" value="Y"> �����������</td>
			</tr>
			<tr>
				<td id="left">������������</td>
				<td><input type="checkbox" name="" value="Y"> ������������&nbsp;&nbsp;<input type="checkbox" name="" value="Y"> ������������</td>
			</tr>
			<tr>
				<td id="left">�����������</td>
				<td><input type="checkbox" name="" value="Y"> ������������&nbsp;&nbsp;<input type="checkbox" name="" value="Y"> �����������</td>
			</tr>	
			<tr>
				<td id="left">��Ÿ����</td>
				<td><table border=0>
				<tr>
					<td><input type="checkbox" name="" value="Y"> ���������</td><td><input type="checkbox" name="" value="Y"> �����ñ���</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="" value="Y"> ä������</td><td><input type="checkbox" name="" value="Y"> ����������</td>
				</tr>
				</table></td>
			</tr>	
		</table>
	</div>

	<div id="button">
		<input type="button" value="����ϱ�" class="form" onClick="Send();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>