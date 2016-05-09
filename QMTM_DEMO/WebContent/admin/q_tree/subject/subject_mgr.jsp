<%
//******************************************************************************
//   ���α׷� : course_mgr.jsp
//   �� �� �� : �������
//   ��    �� : �������� ������� ������
//   �� �� �� : q_subject, q_chapter
//   �ڹ����� : 
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.course.*, qmtm.admin.subject.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);    
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // Ʈ�� ID
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	
	
	if (id_node.length() == 0) { 
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}	

	// �������� ���������
	QmanTreeBean c = null;

    try {
	    c = QmanTree.getBean(id_node);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }

	// �ش� ���� ���� �ܿ�����Ʈ ���������
	Bean[] rst = null;

	try {
		rst = SubjectUtil.getBeans(id_node);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<script language="javascript">
    
	function Subject_insert() {
		window.open("../subject/subject_write.jsp?id_node=<%=id_node%>","insert","width=500, height=270");
	}

	function Subject_edit(id_subject) {
		window.open("../subject/subject_edit.jsp?id_node=<%=id_node%>&id_subject="+id_subject,"edit","width=500, height=270");
	}

	function Course_edit()  {
       window.open("course_edit.jsp?id_node=<%=id_node%>","edit","width=500, height=200");
    }
	
	//--  ���� ����üũ
    function Course_delete()  {
       var st = confirm("*����* ���������� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "course_delete.jsp?id_node=<%=id_node%>";
       }
    }

	//--  ���� ����üũ
    function Subject_delete(id_subject)  {
       var st = confirm("*����* ���������� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "../subject/subject_delete.jsp?id_node=<%=id_node%>&id_subject="+id_subject;
       }
    }

</script>

<center>

<br><br>
���� ����Ʈ&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="�����߰��ϱ�" onClick="Subject_insert()">
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
		<td align="center" bgcolor="#DBDBDB">�����</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">�������</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">�����ϱ�</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">�����ϱ�</td>
	</tr>
	<% if(rst == null) { %>
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center" colspan="5">��ϵǾ��� ������ �����ϴ�.</td>
	</tr>
	<%
	   } else {
		   for(int i = 0; i < rst.length; i++) {
	%>
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center"><%=i+1%></td>
		<td align="center"><%=rst[i].getSubject()%></td>
		<td align="center"><%=rst[i].getRegdate()%></td>
		<td align="center"><input type="button" value="�����ϱ�" onClick="Subject_edit('<%=rst[i].getId_subject()%>')"></td>
		<td align="center"><input type="button" value="�����ϱ�" onClick="Subject_delete('<%=rst[i].getId_subject()%>')"></td>
	</tr>
	<%
		   }
		}
	%>
</table>

<br><br>
��������
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center" bgcolor="#DBDBDB">������</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">��ȿ����</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">�����ϱ�</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">�����ϱ�</td>
	</tr>
	<tr height="30" bgcolor="#FFFFFF">
		<td bgcolor="#FFFFFF" align="center"><%=c.getCourse()%></td>
		<td width="15%" bgcolor="#FFFFFF" align="center"><%=yn_valid%></td>
		<td width="15%" align="center" bgcolor="#FFFFFF"><input type="button" value="�����ϱ�" onClick="Course_edit()"></td>
		<td width="15%" align="center" bgcolor="#FFFFFF"><input type="button" value="�����ϱ�" onClick="Course_delete()"></td>
	</tr>
</table>

<center>
<br><br>
����� ����Ʈ&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="������߰��ϱ�" onClick="Subject_insert()">
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td width="6%" align="center" bgcolor="#DBDBDB">NO</td>
		<td align="center" bgcolor="#DBDBDB">����</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">��������</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">�������</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">��������</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">��ȿ����</td>
	</tr>
</table>