<%
//******************************************************************************
//   ���α׷� : subject_mgr.jsp
//   �� �� �� : �������
//   ��    �� : ������� ������
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.admin.subject.SubjectBean,
//              qmtm.admin.subject.SubjectUtil 
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.subject.*, qmtm.admin.chapter.*, java.sql.*" %>

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
	
	// �������� ���������
	SubjectBean s = null;

    try {
	    s = SubjectUtil.getBean(id_node);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }

	String yn_valid = "";
	if(s.getYn_valid().equalsIgnoreCase("Y")) {
		yn_valid = "���";
	} else {
		yn_valid = "�̻��";
	}

	// �ش� ���� ���� Chapter����Ʈ ���������
	ChapterBean[] rst = null;

	try {
		rst = ChapterUtil.getBeans(id_node);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<script language="javascript">
    
	function chapter_insert() {
		window.open("../chapter/chapter_write.jsp?id_node=<%=id_node%>","insert","width=500, height=270");
	}

	function chapter_edit(id_subject) {
		window.open("../chapter/chapter_edit.jsp?id_node=<%=id_node%>&id_chapter="+id_chapter,"edit","width=500, height=270");
	}

	function subject_edit()  {
       window.open("subject_edit.jsp?id_node=<%=id_node%>","edit","width=500, height=200");
    }
	
	//--  ���� ����üũ
    function subject_delete()  {
       var st = confirm("*����* ���������� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "subject_delete.jsp?id_node=<%=id_node%>";
       }
    }

	//--  �ܿ� ����üũ
    function chapter_delete(id_chapter)  {
       var st = confirm("*����* �ܿ��� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "../chapter/chapter_delete.jsp?id_node=<%=id_node%>&id_chapter="+id_chapter;
       }
    }

</script>

<center>

�ܿ� ����Ʈ&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="�ܿ��߰��ϱ�" onClick="chapter_insert()">
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
		<td align="center" bgcolor="#DBDBDB">�ܿ���</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">�������</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">�����ϱ�</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">�����ϱ�</td>
	</tr>
	<% if(rst == null) { %>
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center" colspan="5">��ϵǾ��� �ܿ��� �����ϴ�.</td>
	</tr>
	<%
	   } else {
		   for(int i = 0; i < rst.length; i++) {
	%>
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center"><%=i+1%></td>
		<td align="center"><%=rst[i].getChapter()%></td>
		<td align="center"><%=rst[i].getRegdate()%></td>
		<td align="center"><input type="button" value="�����ϱ�" onClick="subject_edit('<%=rst[i].getId_chapter()%>')"></td>
		<td align="center"><input type="button" value="�����ϱ�" onClick="subject_delete('<%=rst[i].getId_chapter()%>')"></td>
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
		<td align="center" bgcolor="#DBDBDB">�����</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">��ȿ����</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">�����ϱ�</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">�����ϱ�</td>
	</tr>
	<tr height="30" bgcolor="#FFFFFF">
		<td bgcolor="#FFFFFF" align="center"><%=s.getSubject()%></td>
		<td width="15%" bgcolor="#FFFFFF" align="center"><%=yn_valid%></td>
		<td width="15%" align="center" bgcolor="#FFFFFF"><input type="button" value="�����ϱ�" onClick="subject_edit()"></td>
		<td width="15%" align="center" bgcolor="#FFFFFF"><input type="button" value="�����ϱ�" onClick="subject_delete()"></td>
	</tr>
</table>

</center>