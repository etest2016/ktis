<%
//******************************************************************************
//   ���α׷� : subject_mgr.jsp
//   �� �� �� : �������
//   ��    �� : ������� ������
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree//              
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // ������ ���������
	QmanTreeBean[] rst = null;

	try {
		rst = QmanTree.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	function sub_insert() {
		window.open("subject_insert.jsp","insert","width=400, height=250, scrollbars=no");
    }

	function sub_view(id_q_subject) {
		
		window.open("subject/subject_view.jsp?id_q_subject="+id_q_subject,"view","width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="main">	
    <br>
    <TABLE width="730" border="0">
	<tr>
	<td width="30"></td>
	<td align="right">

	<TABLE width="700">
		<TR>
			<TD>���� ����Ʈ</TD>
			<!--TD align="right"><a href="javascript:sub_insert();">[�ű� ���� ���]</a></TD-->
		</TR>
	</TABLE>
	<table border="0" width="700" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" align="center">
		<tr height="30" bgcolor="#DBDBDB"  align="center">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB" align="center">�����ڵ�</td>
			<td bgcolor="#DBDBDB">�����</td>
			<td bgcolor="#DBDBDB">�������</td>
			<!--<td bgcolor="#DBDBDB">�����Ȯ��</td>-->
		</tr>
		<% if(rst == null) { %>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center" colspan="4">��ϵǾ��� ������ �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center"><%=i+1%></td>
			<td align="center"><a href="javascript:sub_view('<%=rst[i].getId_q_subject()%>');"><%=rst[i].getId_q_subject()%></a></td>
			<td align="center"><a href="subject/subject_list.jsp?id_q_subject=<%=rst[i].getId_q_subject()%>"><%=rst[i].getQ_subject()%></a></td>
			<td align="center"><%=rst[i].getRegdate()%></td>
			<!--<td align="center">[����� Ȯ��]</td>-->
		</tr>
		<%
			   }
			}
		%>
	</table>

	</td>
	</tr>
	</table>
	
 </BODY>
</HTML>