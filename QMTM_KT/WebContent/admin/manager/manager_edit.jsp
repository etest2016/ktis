<%
//******************************************************************************
//   ���α׷� : manager_edit.jsp
//   �� �� �� : ����� ����
//   ��    �� : ����� ���� �˾� ������
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, 
//             qmtm.admin.manager.ManagerUtil
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// ����� ���������
	ManagerBean rst = null;

	try {
		rst = ManagerUtil.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	String password = rst.getPassword();
	
%>
<HTML>
<HEAD>
<TITLE> ����� ���� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Send() {
			var frm = document.frmdata;
			
			if(frm.password.value == "") {
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
	
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="manager_update.jsp">
<input type="hidden" name="userid" value="<%=userid%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">����� �������� <span>����� �������� �� ������� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">���̵�</td>
				<td width="300"><%=userid%></td>
			</tr>
			<tr>
				<td id="left">��й�ȣ</td>
				<td><input type="password" class="input" name="password" size="20" value="<%=password%>"></td>
			</tr>
			<tr>
				<td id="left">����</td>
				<td><input type="text" class="input" name="name" size="20"  value="<%=rst.getName()%>"></td>
			</tr>
			<tr>
				<td id="left">����� �Ҽ�</td>
				<td><textarea name="rmk" cols="35" rows="3"><%=rst.getContent1()%></textarea></td>
			</tr>
			<tr>
				<td id="left">�������</td>
				<td><input type="radio" name="yn_valid" value="Y" <% if(rst.getYn_valid().equals("Y")) { %> checked <% } %>> ��밡��&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <% if(rst.getYn_valid().equals("N")) { %> checked <% } %>> ���Ұ���</td>
			</tr>
	</table>
	</div>

<div id="button">
<img src="../../images/bt5_edit_yj1.gif" onClick="Send();">&nbsp;&nbsp;<!--input type="button" onclick="window.close()" value="â�ݱ�"--><a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>