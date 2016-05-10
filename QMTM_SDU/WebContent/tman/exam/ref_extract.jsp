<%
//******************************************************************************
//   ���α׷� : ref_extract.jsp
//   �� �� �� : ���� �������� ��� ������
//   ��    �� : ���� �������� ������, ���� ��� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-07-24
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	int orders = Integer.parseInt(request.getParameter("orders"));
	int refCnt = Integer.parseInt(request.getParameter("refCnt")); // ������ ���Ե� ������
	int refGroupCnt = Integer.parseInt(request.getParameter("refGroupCnt")); // ���� �׷��
	int orderCnt = Integer.parseInt(request.getParameter("orderCnt")); // �������� Index
	int orderCnt2 = Integer.parseInt(request.getParameter("orderCnt2")); // �Ϲݹ��� Index

	int q_counts = Integer.parseInt(request.getParameter("q_counts"));
	double allots = Double.parseDouble(request.getParameter("allots"));

%>

<html>
<head>
	<title>���� ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">
	function extract_send() {
		var firstWin = window.opener; 
		var frm = document.extract_form;

		var refCnt = <%=refCnt%>;
		var refGroupCnt = <%=refGroupCnt%>;
		var q_counts = <%=q_counts%>;
		var allots = <%=allots%>;
		var orderCnt = <%=orderCnt%>;
		var orderCnt2 = <%=orderCnt2%>;
		var orders = <%=orders%>;

		var all_qcnt = 0;
		var all_score = 0;

		if(frm.refCnt.value == "") {
			alert("������ ���� �׷���� �Է��ϼ���.");
			frm.refCnt.focus();
			return;
		}
		
		for(var i=0; i<orderCnt; i++) {
			if(i != orders) {
				all_qcnt = all_qcnt + (Number(eval("firstWin.document.form1.ref_qs"+i+".value")) * Number(eval("firstWin.document.form1.qs"+i+".value")));
				all_score = all_score + (Number(eval("firstWin.document.form1.ref_score"+i+".value")) * (Number(eval("firstWin.document.form1.ref_qs"+i+".value")) * Number(eval("firstWin.document.form1.qs"+i+".value"))));
			}
		}

		for(var j=0; j<orderCnt2; j++) {
			all_qcnt = all_qcnt + Number(eval("firstWin.document.form1.ch_qs"+j+".value"));
			all_score = all_score + (Number(eval("firstWin.document.form1.ch_score"+j+".value")) * Number(eval("firstWin.document.form1.ch_qs"+j+".value")));
		}

		all_qcnt = all_qcnt + (Number(frm.refCnt.value) * refCnt);
		all_score = all_score + ((Number(frm.refCnt.value) * refCnt) * Number(frm.refAllott.value));

		if(Number(frm.refCnt.value) > refGroupCnt) {
			alert("���Ⱑ���� ���� �׷������ ū �׷���� �Է��ϼ̽��ϴ�. \n\n���Ⱑ���� ���� �׷���� Ȯ���Ͻð� �ٽ� �Է����ּ���.");
			return;
		}

		if(frm.refAllott.value == "") {
			alert("������ ������ �Է��ϼ���.");
			frm.refAllott.focus();
			return;
		}
		
		if(all_qcnt > q_counts) {
			alert("���� �Է��� �� �������� " +all_qcnt+"���� �Դϴ�.\n\n �ش���迡 ������������ " +q_counts+"�������� �մϴ�.");
			frm.refCnt.value = "";
			return;
		}

		if(all_score > allots) {
			alert("���� �Է��� �� ������ " +all_score+"�� �Դϴ�.\n\n�ش���迡 ������ " +allots+"���̾�� �մϴ�.");
			frm.refAllott.value = "";
			return;
		}
		
		firstWin.document.form1.ref_qs<%=orders%>.value = frm.refCnt.value;
		firstWin.document.form1.ref_score<%=orders%>.value = frm.refAllott.value;
		firstWin.document.form1.qcnts4.value = all_qcnt;
		firstWin.document.form1.qcnts5.value = all_score;

		window.close(this);
	}
</script>
</head>

<BODY id="tman">
	<form name="extract_form">
	<table border=0 width="320" height="150" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" valign="middle">
		<tr bgcolor="#FFFFFF" height="40">
			<td align="right" width="70%" valign="middle" bgcolor="#DBDBDB">������ �����׷� ��&nbsp;(���� �׷�� : <b><%=refGroupCnt%></b>)&nbsp;</td>
			<td align="left">&nbsp;&nbsp;<input type="text" class="input" name="refCnt" size="4"> �׷�</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="40">
			<td align="right" width="70%" valign="middle" bgcolor="#DBDBDB">������ ����&nbsp;(���⹮���� ����)&nbsp;</td>
			<td align="left">&nbsp;&nbsp;<input type="text" class="input" name="refAllott" size="4"> ��</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="40">
			<td align="center" valign="middle" colspan="2"><input type="button" value="Ȯ���ϱ�" onClick="extract_send()">&nbsp;&nbsp;<input type="button" value="����ϱ�" onclick="window.close();"></td>
		</tr>
	</table>
	</form>

</body>

</html>
