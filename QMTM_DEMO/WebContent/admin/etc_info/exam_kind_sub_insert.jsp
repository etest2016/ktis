<%
//******************************************************************************
//   ���α׷� : exam_kind_sub_insert.jsp
//   �� �� �� : ���豸�е��
//   ��    �� : ���豸�е�� �˾� ������
//   �� �� �� : r_exam_kind_sub
//   �ڹ����� : qmtm.admin.etc.StdLevelBean, qmtm.admin.etc.StdLevelUtil
//   �� �� �� : 2008-04-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	// �׷챸�и�� ���������
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>
<html>
<head>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">
	function Send() {

		var frm = document.frmdata;

		if(frm.id_exam_kind_sub.value == 0) {
			alert("�����ڵ带 �Է��ϼ���");
			return;
		} else if(frm.exam_kind_sub.value == 0) {
			alert("������� �Է��ϼ���");
			return;
		} else {
			frm.submit();
		}
	}
</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="exam_kind_sub_insert_ok.jsp">
<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���豸���ڵ���<span> ���豸���� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�׷챸�м���</td>
				<td width="200"><select name="id_exam_kind">
				<% if(rst == null) { %>
				<option value="">�׷챸�� ����</option>
				<% 
					} else { 
						for(int i=0; i<rst.length; i++) {
				%>
				<option value="<%=rst[i].getId_exam_kind()%>"><%=rst[i].getExam_kind()%></option>

				<% 
						}
					} 
				%>
				</select>
				</td>
			</tr>
			<tr>
				<td id="left">�����ڵ�</td>
				<td width="200"><input type="text" class="input" name="id_exam_kind_sub" size="10"></td>
			</tr>
			<tr>
				<td id="left">�����</td>
				<td><input type="text" class="input" name="exam_kind_sub" size="25"></td>
			</tr>
	</table>
</div>

<div id="button">
<img src="../../../images/bt5_make_yj1_1.gif" onclick="Send();">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>