<%
//******************************************************************************
//   ���α׷� : subject_edit.jsp
//   �� �� �� : ���� ����
//   ��    �� : �ش� ���� �Ʒ� ���� �����ϱ�
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.admin.subject.SubjectUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.subject.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // Ʈ�� ID
    String id_subject = request.getParameter("id_subject"); // ���� �ڵ�

	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	
	
	if (id_node.length() == 0) { 
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%	
	}	

	SubjectBean rst = null;

	// �������� ���������
	try {
	    rst = SubjectUtil.getBean(id_subject);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<center>
�������
<br>
<form name="frmdata" method="post" action="subject_update.jsp">
<input type="hidden" name="id_node" value="<%=id_node%>">
<input type="hidden" name="id_subject" value="<%=id_subject%>">
<table border="0" width="500" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="40">
		<td width="30%" align="right">�����&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="subject" size="20" value="<%=rst.getSubject()%>"></td>
	</tr>
	<tr height="40">
		<td align="right">���ļ���&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<select name="subject_order">
		<% for(int i = 1; i <= 10; i++) { %>	
			<option value="<%=i%>" <%if(rst.getSubject_order()==i) { %>selected<% } %>><%=i%></option>
		<% } %>
		</td>
	</tr>
	<tr height="40">	
		<td align="right">�������&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> ��밡��&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> ���Ҵ�</td>
	</tr>
</table>
<p>
<input type="submit" value="��������ϱ�">

</form>