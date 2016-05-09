<%
//******************************************************************************
//   ���α׷� : exam_kind_edit.jsp
//   �� �� �� : �׷챸�м���
//   ��    �� : �׷챸�м��� �˾� ������
//   �� �� �� : r_exam_kind
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String param_exam_kind = request.getParameter("id_exam_kind");
	if (param_exam_kind == null) { param_exam_kind= ""; } else { param_exam_kind = param_exam_kind.trim(); }

	if (param_exam_kind.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	int id_exam_kind = Integer.parseInt(param_exam_kind);

	ExamKindBean rst = null;

    try {
	    rst = ExamKindUtil.getBean(id_exam_kind);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: �׷챸�� ���� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script type="text/JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.exam_kind.value == "") {
				alert("�׷챸���� �Է��ϼ���");
				frm.exam_kind.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="exam_kind_update.jsp">
<input type="hidden" name="id_exam_kind" value="<%=id_exam_kind%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�׷챸�� ���� <span> �׷챸�� ��������</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>


	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�ڵ�</td>
				<td width="200"><%=id_exam_kind%></td>
			</tr>
			<tr>
				<td id="left">�׷챸��</td>
				<td><input type="text" class="input" name="exam_kind" size="25" value="<%=rst.getExam_kind()%>"></td>
			</tr>
			<tr>
				<td id="left">����</td>
				<td><textarea name="rmk" rows="3" cols="25"><%=ComLib.nullChk(rst.getRmk())%></textarea></td>
			</tr>
	</table>
</div>

<div id="button">
<img src="../../images/bt5_edit_yj1.gif" border="0" onClick="send();">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>