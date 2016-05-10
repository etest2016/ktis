<%
//******************************************************************************
//   ���α׷� : q_ref_select.jsp
//   �� �� �� : ���� ���� ����
//   ��    �� : ���� ���� ����
//   �� �� �� : 
//   �ڹ����� : qmtm.qman.editor.QUtil
//   �� �� �� : 2008-08-26
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.exam.*, qmtm.qman.editor.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_q_subject = request.getParameter("id_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	QRefBean[] rst = null;

	try {
		rst = QUtil.getBeans(id_q_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

<html>
	<head>
	<title>�������� ����</title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	<style>
		#q_view { }
		#q_view table { width: 500px; border: 10px solid red; }
	</style>
	
	<script language="javascript">
		function Ref_reg(k) {
			var frm = document.form1;

			var firstWin = window.opener ; 

			firstWin.document.writeForm.id_ref.value = eval("frm.id_refs"+k+".value");
			firstWin.document.writeForm.ref_name.value = eval("frm.reftitles"+k+".value");
			//firstWin.document.writeForm.twe12.HtmlValue = eval("frm.refbodys"+k+".value");

			window.close(this);
		}

	</script>
	</head>

	<BODY id="popup2">
	
	<form name="form1" method="post">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����˻�<span>����� ������ �����ϼ���.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">	
	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="tr">
			<td>�����ڵ�</td>
			<td>��������</td>
			<td>�������</td>
			<td>����ϱ�</td>
		</tr>
		<% if(rst == null){ %>
		<tr>
			<td class="blank" align="center" colspan="5">�˻��� ������ ������ �����ϴ�.</td>
		</tr>
		<% } else { 
				for(int i = 0; i < rst.length; i++){
					String refbody = rst[i].getRefbody1() + ComLib.nullChk(rst[i].getRefbody2()) + ComLib.nullChk(rst[i].getRefbody3());
		%>
		<input type="hidden" name="id_refs<%=String.valueOf(i)%>" value="<%=rst[i].getId_ref()%>">
		<input type="hidden" name="reftitles<%=String.valueOf(i)%>" value="<%=rst[i].getReftitle()%>">
		<input type="hidden" name="refbodys<%=String.valueOf(i)%>" value="<%=refbody%>">
		<tr id="td" align="center" bgcolor="#ffffff">
			<td width="15%"><%=rst[i].getId_ref()%></td>
			<td align="left"><%=rst[i].getReftitle()%></td>
			<td width="12%"><%=rst[i].getRegdate()%></td>
			<td width="12%" rowspan="2"><input type="button" value="�������" onClick="Ref_reg(<%=i%>);"></td>
		</tr>
		<tr id="td" align="center" bgcolor="#ffffff">
			<td width="15%">��������</td>
			<td align="left" colspan="2"><%=refbody%></td><!--1:ox��, 2:������, 3:���������, 4:�ܴ���, 5:�����-->			
		</tr>
		<% 
				}
			} 
		%>
	</table>

	</div>
	<div id="button">
	<input type="button" value="â�ݱ�" onclick="window.close()">
	</div>

</form>

</body>
</html>