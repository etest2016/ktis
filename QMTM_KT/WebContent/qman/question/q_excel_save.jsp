<%
//******************************************************************************
//   ���α׷� : q_excel_save.jsp
//   �� �� �� : ���� ��������
//   ��    �� : ���� ��������
//   �� �� �� : q
//   �ڹ����� : qmtm.ComLib, qmtm.QmTm, qmtm.qman.question.QListGrid, qmtm.qman.question.QListGridBean
//   �� �� �� : 2013-02-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.QmTm, qmtm.qman.question.QListGrid, qmtm.qman.question.QListGridBean, org.apache.commons.lang3.StringEscapeUtils " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=q_excel.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_qs = request.getParameter("q_excels");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
	
	if (id_qs.length() == 0) {
%>
	<script language="javascript">
		alert("������ ���� �� ������ �����ϴ�.");
		window.close();
	</script>
<%	
		if(true) return;
	}

	// ����Ÿ ��������
	QListGridBean[] rst = null;

	try {
		rst = QListGrid.getExcelBeans(id_qs);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
%>	

<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<body>
	
	<table border="1" cellpadding ="0" cellspacing="0" >
		<tr height="40" align="center">
			<td align="center" bgcolor="#9DBFFF">������</td>
			<td align="center" bgcolor="#9DBFFF">�����</td>
			<td align="center" bgcolor="#9DBFFF">�ܿ���</td>
			<td align="center" bgcolor="#9DBFFF">�����ڵ�</td>
			<td align="center" bgcolor="#9DBFFF">����</td>
			<td align="center" bgcolor="#9DBFFF">����1</td>
			<td align="center" bgcolor="#9DBFFF">����2</td>
			<td align="center" bgcolor="#9DBFFF">����3</td>
			<td align="center" bgcolor="#9DBFFF">����4</td>
			<td align="center" bgcolor="#9DBFFF">����5</td>
			<td align="center" bgcolor="#9DBFFF">����</td>
			<td align="center" bgcolor="#9DBFFF">�ؼ�</td>
			<td align="center" bgcolor="#9DBFFF">��������</td>
			<td align="center" bgcolor="#9DBFFF">���ⰹ��</td>
			<td align="center" bgcolor="#9DBFFF">���䰹��</td>
			<td align="center" bgcolor="#9DBFFF">���̵�</td>			
			<td align="center" bgcolor="#9DBFFF">����Ƚ��</td>
			<td align="center" bgcolor="#9DBFFF">�Է���</td>
			<td align="center" bgcolor="#9DBFFF">�������</td>
		</tr>
<%
	if(rst == null) {
%>
		<tr height="40">
			<td colspan="19">&nbsp;</td>
		</tr>
<%
	} else {

		for(int i=0; i<rst.length; i++) { 
			String qtype = rst[i].getQtype();
			String id_valid_type = "";

			if(rst[i].getId_valid_type().equals("0")) {
				id_valid_type = "������";
			} else if(rst[i].getId_valid_type().equals("1")) {
				id_valid_type = "��������";
			} else {
				id_valid_type = "�������ó��";
			}

%>
		<tr bgcolor="#FFFFFF" height="30">
			<td ><%=rst[i].getCourse()%></td>
			<td ><%=rst[i].getQ_subject()%></td>
			<td ><%=rst[i].getChapter()%></td>
			<td ><%=rst[i].getId_q()%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(rst[i].getQ())))%></td>			
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx1()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx2()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx3()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx4()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx5()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getCa()))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getExplain()))%></td>
			<td ><%=qtype%></td>
			<td ><%=rst[i].getExcount()%></td>
			<td ><%=rst[i].getCacount()%></td>
			<td ><%=rst[i].getDifficulty()%></td>
			<td ><%=rst[i].getCnt()%></td>
			<td ><%=rst[i].getUserid()%></td>
			<td ><%=rst[i].getRegdate()%></td>
		</tr>
<%
		}
	}
%>
	</table>

</body>
</html>