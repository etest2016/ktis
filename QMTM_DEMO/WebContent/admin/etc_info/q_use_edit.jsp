<%
//******************************************************************************
//   ���α׷� : q_use_edit.jsp
//   �� �� �� : �����뵵����
//   ��    �� : �����뵵���� �˾� ������
//   �� �� �� : r_q_use
//   �ڹ����� : qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_use = request.getParameter("id_q_use");
	if (id_q_use == null) { id_q_use= ""; } else { id_q_use = id_q_use.trim(); }

	if (id_q_use.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	QuseBean rst = null;

    try {
	    rst = QuseUtil.getBean(id_q_use);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: �����뵵 ���� :: </title>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.q_use.value == "") {
				alert("�����뵵�� �Է��ϼ���");
				frm.q_use.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="q_use_update.jsp">
<input type="hidden" name="id_q_use" value="<%=id_q_use%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����뵵 ���� <span> �����뵵 ��������</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�ڵ�</td>
				<td width="200"><%=id_q_use%></td>
			</tr>
			<tr>
				<td id="left">�����뵵</td>
				<td><input type="text" class="input" name="q_use" size="25" value="<%=rst.getQ_use()%>"></td>
			</tr>
			<tr>
				<td id="left">����</td>
				<td><textarea name="rmk" rows="3" cols="25"><%=ComLib.nullChk(rst.getRmk())%></textarea></td>
			</tr>
	</table>
	</div>

<div id="button">
<a href="javascript:" onClick="send();" onfocus="this.blur();"><img src="../../images/bt5_edit_yj1.gif" border="0"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>