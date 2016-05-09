<%
//******************************************************************************
//   ���α׷� : subject_edit.jsp
//   �� �� �� : �������
//   ��    �� : �������� ������� ������
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil " %>

<%
	response.setDateHeader("Expires", 0);   
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject= ""; } else { id_q_subject = id_q_subject.trim(); }

	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));
	
		if(true) return ;
	}
	
	// �������� ���������
	QmanTreeBean rst = null;

    try {
	    rst = QmanTree.getBean(id_q_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }
%>
<HTML>
<HEAD>
<TITLE> �������� ���� </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">

	<script language="JavaScript">

		function send() {
			var frm = document.form1;
			
			if(frm.q_subject.value == "") {
				alert("������� �Է��ϼ���");
				frm.q_subject.focus();
				return false;
			} else {
				document.form1.submit();
			}
		}

	</script>
</HEAD>


<BODY id="popup2">

	<form name="form1" method="post" action="subject_update.jsp">
	<input type="hidden" name="id_q_subject" value="<%=id_q_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� ���� <span>����� �� �������� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<!--table border="0" cellpadding ="0" cellspacing="0" id="tablea">
			<tr id="tr">
				<td>�����</td>
				<td>��������</td>
			</tr>
			<tr id="td" align="center" height="50">
				<td><input type="text" class="input" name="q_subject" value="<%=rst.getQ_subject()%>"></td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> ����&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> �����</td>
			</tr>
		</table-->

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td id="left">�����</td>
				<td><input type="text" class="input" name="q_subject" value="<%=rst.getQ_subject()%>" size="30"></td>
			</tr>
			<tr>
				<td id="left">��������</td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> ����&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> �����</td>
			</tr>
		</table>
	</div>


	<div id="button">
		<img src="../../../images/bt5_edit_yj1.gif" border="0" onClick="send();" onfocus="this.blur();" style="cursor:hand">&nbsp;
		<img onclick="window.close();" src="../../../images/bt5_exit_yj1.gif" onfocus="this.blur();" style="cursor:hand">
	</div>

	</form>

</BODY>
</HTML>