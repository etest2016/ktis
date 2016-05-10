<%
//******************************************************************************
//   ���α׷� : q_standarda_view.jsp
//   �� �� �� : ��з����� Ȯ��
//   ��    �� : ��з����� Ȯ�� ������
//   �� �� �� : q_standard_a
//   �ڹ����� : qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_standarda = request.getParameter("id_standarda");
	if (id_standarda == null) { id_standarda= ""; } else { id_standarda = id_standarda.trim(); }

	if (id_standarda.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	QstandardABean rst = null;

    try {
	    rst = QstandardAUtil.getBean(id_standarda);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="group_edit.jsp?id_standarda=<%=id_standarda%>";
	}
	
	//--  ����üũ
    function deletes()  {
       var st = confirm("*����* �뿵���� �����Ͻðڽ��ϱ�?" );
       if (st == true) {
           document.location = "group_delete.jsp?id_standarda=<%=id_standarda%>";
       }
    }
</script>
<html>
<head>
	<title>:: �뿵�� Ȯ�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�뿵�� Ȯ�� <span> �뿵�� Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�뿵���ڵ�</td>
				<td width="200"><%=id_standarda%></td>
			</tr>
			<tr>
				<td id="left">�뿵����</td>
				<td><%=rst.getStandarda()%></td>
			</tr>
			<tr>
				<td id="left">��������</td>
				<td><%if(rst.getYn_valid().equals("Y")) {%>����<%} else {%>�����<%}%></td>
			</tr>
			<tr>
				<td id="left">�������</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
</div>

<div id="button">
<a href="javascript:edits();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>