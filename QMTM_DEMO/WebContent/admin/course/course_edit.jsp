<%
//******************************************************************************
//   ���α׷� : course_edit.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���������ϱ�
//   �� �� �� : c_course
//   �ڹ����� : qmtm.admin.course.CourseUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.course.*, java.sql.*" %>

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

    CourseBean rst = null;

    // �������� ���������
	try {
	    rst = CourseUtil.getBean(id_node);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<center>

��������
<br>
<form name="frmdata" method="post" action="course_update.jsp">
<input type="hidden" name="id_node" value="<%=id_node%>">
<table border="0" width="450" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="40">
		<td width="30%" align="right">������&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="course" size="20" value="<%=rst.getCourse()%>"></td>
	</tr>
	<tr height="40">
		<td align="right">�������&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> ��밡��&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> ���Ұ�</td>
	</tr>
</table>
<p>
<input type="submit" value="���������ϱ�">

</form>