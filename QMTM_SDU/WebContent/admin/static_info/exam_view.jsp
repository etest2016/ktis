<%
//******************************************************************************
//   ���α׷� : paper_option.jsp
//   �� �� �� : ���������ɼ� ����
//   ��    �� : ���������ɼ� ����
//   �� �� �� : exam_m, q_chapter
//   �ڹ����� : qmtm.tman.exam.ExamPaperGuide, ExamPaperGuideBean
//   �� �� �� : 2008-05-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

	IngInwonBean rst = null;

	try {
		rst = IngInwon.getInwonRe(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));		    

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> ���� ���� Ȯ�� </TITLE>

 <link rel="StyleSheet" href="../../css/style.css" type="text/css">

 </HEAD>

<BODY id="popup2">
   
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ���� Ȯ��</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		
		<div class="subtitle">���� ���� ����</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="20%"><li>�����</td>
				<td width="37%"><%=rst.getTitle()%></td>
				<td id="left" width="23%"><li>�����ڵ�</td>
				<td width="20%"><%=rst.getId_exam()%></td>
			</tr>
			<tr>
				<td id="left"><li>��ü ������</td>
				<td><%=rst.getQcount()%> ����</td>
				<td id="left"><li>����������</td>
				<td><%=rst.getSetcount()%> ��</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td><%=rst.getAllotting()%> ��</td>
				<td id="left"><li>���ѽð�</td>
				<td><%=rst.getLimittime()/60%> ��</td>
			</tr>
			<tr>
				<td id="left"><li>���豸��</td>
				<td colspan="3">&nbsp;<% if(rst.getId_exam_kind() == 1) { %>�Ϲ��� ����<% } else if(rst.getId_exam_kind() ==2) { %>����Ʈ���� ����<% } else { %>�Ϲ�&����Ʈ���� ȥ��<% } %></td>
			</tr>

		</table>
			
		<br>

		<div class="subtitle">���� ��Ȳ</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%">
			<tr id="tr">
				<td width='20%'>����ο�</td>
				<td width='20%'>�����ο�</td>
				<td width='20%'>�������ο�</td>
				<td width='20%'>��ȿϷ�</td>
				<td width='20%'>��ȹ̿Ϸ�</td>
			</tr>
			<% 
				if(rst == null) {
			%>
			<tr height="45">
				<td class="blank" colspan="5">������Ȳ ������ �����ϴ�.</td>
			</tr>
			<%
				} else {
			%>
			<tr id="td" align="center">
				<td><%=rst.getTot_inwon()%> ��</td>
				<td><%=rst.getAns_inwon()%> ��</td>
				<td><%=rst.getNo_inwon()%> ��</td>
				<td><%=rst.getAns_y_inwon()%> ��</td>
				<td><%=rst.getAns_n_inwon()%> ��</td>
			</tr>
			<% 
				}
			%>
		</table>
			
	</div>

	<div id="button">
		<img src="../../images/bt5_exit_yj1_11.gif" onclick="javascript:window.close();" onfocus="this.blur();" style="cursor: pointer;">
	</div>

	</form>

</BODY>
</HTML>