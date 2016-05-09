<%
//******************************************************************************
//   ���α׷� : q_extract.jsp
//   �� �� �� : ���� ���� ��� ������
//   ��    �� : ���� ���� ���׼�, ���� ��� ������
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

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	int orders = Integer.parseInt(request.getParameter("orders"));
	int qCnt = Integer.parseInt(request.getParameter("qCnt"));
	int orderCnt = Integer.parseInt(request.getParameter("orderCnt"));
	int orderCnt2 = Integer.parseInt(request.getParameter("orderCnt2"));

	int q_counts = Integer.parseInt(request.getParameter("q_counts"));
	double allots = Double.parseDouble(request.getParameter("allots"));
%>

<html>
<head>
	<title>���� ����</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">
	function extract_send() {
		var firstWin = window.opener; 
		var frm = document.extract_form;

		var qCnt = <%=qCnt%>;
		var q_counts = <%=q_counts%>;
		var allots = <%=allots%>;
		var orderCnt = <%=orderCnt%>;
		var orderCnt2 = <%=orderCnt2%>;
		var orders = <%=orders%>;

		var all_qcnt = 0;
		var all_score = 0;

		if(frm.qCnt.value == "") {
			alert("������ ���׼��� �Է��ϼ���.");
			frm.qCnt.focus();
			return;
		}
		
		for(var i=0; i<orderCnt; i++) {
			if(i != orders) {
				all_qcnt = all_qcnt + Number(eval("firstWin.document.form1.ch_qs"+i+".value"));
				all_score = all_score + (Number(eval("firstWin.document.form1.ch_score"+i+".value")) * Number(eval("firstWin.document.form1.ch_qs"+i+".value")));
			}
		}

		for(var j=0; j<orderCnt2; j++) {
			all_qcnt = all_qcnt + (Number(eval("firstWin.document.form1.ref_qs"+j+".value")) * Number(eval("firstWin.document.form1.qs"+j+".value")));
			all_score = all_score + (Number(eval("firstWin.document.form1.ref_score"+j+".value")) * (Number(eval("firstWin.document.form1.ref_qs"+j+".value")) * Number(eval("firstWin.document.form1.qs"+j+".value"))));
		}

		all_qcnt = all_qcnt + Number(frm.qCnt.value);
		all_score = all_score + (Number(frm.qCnt.value) * Number(frm.qAllott.value));

		if(Number(frm.qCnt.value) > qCnt) {
			alert("���Ⱑ���� ���׼����� ū ���׼��� �Է��ϼ̽��ϴ�. \n\n���Ⱑ���� ���׼��� Ȯ���Ͻð� �ٽ� �Է����ּ���.");
			return;
		}

		if(frm.qAllott.value == "") {
			alert("������ �Է��ϼ���.");
			frm.qAllott.focus();
			return;
		}
		
		if(all_qcnt > q_counts) {
			alert("���� �Է��� �� ���׼��� " +all_qcnt+"���� �Դϴ�.\n\n �ش���迡 �������׼��� " +q_counts+"�����̾�� �մϴ�.");
			frm.qCnt.value = "";
			return;
		}

		if(all_score > allots) {
			alert("���� �Է��� �� ������ " +all_score+"�� �Դϴ�.\n\n�ش���迡 ������ " +allots+"���̾�� �մϴ�.");
			frm.qAllott.value = "";
			return;
		}
		
		firstWin.document.form1.ch_qs<%=orders%>.value = frm.qCnt.value;
		firstWin.document.form1.ch_score<%=orders%>.value = frm.qAllott.value;
		firstWin.document.form1.qcnts4.value = all_qcnt;
		firstWin.document.form1.qcnts5.value = all_score;

		window.close(this);
	}
</script>
</head>

<BODY id="popup2">
	<form name="extract_form">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ���� </div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
 
	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td width="65%" id="left">���� ���׼�&nbsp;(�� ���׼� : <b><%=qCnt%></b>)&nbsp;</td>
				<td >&nbsp;&nbsp;<input type="text" class="input" name="qCnt" size="4"> ����</td>
			</tr>
			<tr>
				<td width="65%" id="left">����&nbsp;(���⹮�׺� ����)&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="qAllott" size="4"> ��</td>
			</tr>
		</table>
	<div>

	<div id="button">
		<img src="../../images/bt_exam_list_yj1.gif" onfocus="this.blur();" onClick="extract_send();" style="cursor:hand">&nbsp;
		<img onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();" style="cursor:hand">
	</div>
		
	</form>
	
</body>

</html>
