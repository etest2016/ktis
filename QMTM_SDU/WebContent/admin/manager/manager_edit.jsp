<%
//******************************************************************************
//   ���α׷� : manager_edit.jsp
//   �� �� �� : ����� ����
//   ��    �� : ����� ���� �˾� ������
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, 
//              qmtm.admin.manager.ManagerUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	// ����� ���������
	ManagerBean rst = null;

	try {
		rst = ManagerUtil.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%>
<HTML>
<HEAD>
<TITLE> ����� ���� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Send() {
			var frm = document.frmdata;
			
			if(frm.name.value == "") {
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
				<td id="left" width="100">���̵�</td>
				<td width="300"><%=userid%></td>
			</tr>
			<!--<tr>
				<td id="left">��й�ȣ</td>
				<td><input type="password" name="password" size="21" value=""></td>
			</tr>-->
			<tr>
				<td id="left">����</td>
				<td><input type="text" name="name" size="20"  value="<%=rst.getName()%>" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">�޴���</td>
				<td><input type="text" name="hp" size="20" value="<%=ComLib.nullChk(rst.getHp())%>"></td>
			</tr>
			<tr>
				<td id="left">�̸���</td>
				<td><input type="text" name="email" size="30"  value="<%=ComLib.nullChk(rst.getEmail())%>" style="ime-mode:inactive;"></td>
			</tr>			
			<tr>
				<td id="left">����� �Ҽ�</td>
				<td><textarea name="rmk" cols="35" rows="3" style="ime-mode:active;"><%=rst.getContent1()%></textarea></td>
			</tr>
			<tr>
				<td id="left">�����������</td>
				<td><input type="radio" name="yn_valid" value="Y" <% if(rst.getYn_valid().equals("Y")) { %> checked <% } %>> ���&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <% if(rst.getYn_valid().equals("N")) { %> checked <% } %>> �̻��</td>
			</tr>
	</table>
	</div>

	<div id="button">
		<input type="button" value="�����ϱ�" class="form" onClick="Send();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>