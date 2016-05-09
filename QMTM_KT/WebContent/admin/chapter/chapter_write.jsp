<%
//******************************************************************************
//   ���α׷� : chapter_write.jsp
//   �� �� �� : �ܿ� ���
//   ��    �� : �ش� ���� �Ʒ� �ܿ�����ϱ�
//   �� �� �� : c_chapter
//   �ڹ����� : qmtm.admin.chapter.ChapterUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.chapter.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // Ʈ�� ID
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	
	
	if (id_node.length() == 0) { 
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%	
	}	

	int chapter_order = 0;

	// ������� ���������
	try {
		chapter_order = 1 + ChapterUtil.getCnt(id_node);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<center>
�ܿ����
<br>
<form name="frmdata" method="post" action="chapter_insert.jsp">
<input type="hidden" name="id_node" value="<%=id_node%>">
<table border="0" width="500" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="40">
		<td width="30%" align="right">�ܿ���&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="subject" size="20"></td>
	</tr>
	<tr height="40">
		<td align="right">���ļ���&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<select name="subject_order">
		<% for(int i = 1; i <= 10; i++) { %>	
			<option value="<%=i%>" <%if(chapter_order == i) {%>selected<% } %>><%=i%></option>
		<% } %>
		</td>
	</tr>
</table>
<p>
<input type="submit" value="�ܿ������ϱ�">

</form>