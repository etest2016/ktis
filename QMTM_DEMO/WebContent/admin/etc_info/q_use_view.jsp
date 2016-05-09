<%
//******************************************************************************
//   ���α׷� : q_use_view.jsp
//   �� �� �� : �����뵵Ȯ��
//   ��    �� : �����뵵Ȯ�� �˾� ������
//   �� �� �� : r_q_use
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   �� �� �� : 2010-06-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil" %>

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

<script language="javascript">
	function edits() {
		location.href="q_use_edit.jsp?id_q_use=<%=id_q_use%>";
	}
	
	//--  ����üũ
    function deletes()  {
       var st = confirm("*����* �����뵵�� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "q_use_delete.jsp?id_q_use=<%=id_q_use%>";
       }
    }
</script>
<html>
<head>
	<title>:: �����뵵 Ȯ�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����뵵 Ȯ�� <span> �����뵵 ����Ȯ�� �� ����,����</span></div></td>
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
				<td><%=rst.getQ_use()%></td>
			</tr>
			<tr>
				<td id="left">����</td>
				<td><textarea name="rmk" rows="3" cols="25" readonly><%=ComLib.nullChk(rst.getRmk())%></textarea></td>
			</tr>
	</table>
	</div>

<div id="button">
<a href="javascript:edits();" onfocus="this.blur();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();" onfocus="this.blur();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();" onfocus="this.blur();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>