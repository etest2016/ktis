<%
//******************************************************************************
//   ���α׷� : course_mgr.jsp
//   �� �� �� : ��������
//   ��    �� : �������� ������
//   �� �� �� : c_course
//   �ڹ����� : qmtm.admin.course.CourseBean,
//              qmtm.admin.course.CourseUtil 
//   �� �� �� : 2008-03-31
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


    // ������� ���������
	CourseBean[] rst = null;
   
	try {
		rst = CourseUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>

 </HEAD>

 <BODY id="admin">	
    <br>
    <TABLE width="720" border="0">
	<tr>
	<td width="30"></td>
	<td align="right">	

	<TABLE width="690">
		<TR>
			<TD>���� ���</TD>
			<TD align="right"><a href="course_create.jsp">�ű� ���� ���</a></TD>
		</TR>
	</TABLE>
	<table border="0" width="690" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" align="center">
		<tr height="30" bgcolor="#DBDBDB">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">�����ڵ�</td>
			<td bgcolor="#DBDBDB">������</td>
			<td bgcolor="#DBDBDB">��ȿ����</td>
			<td bgcolor="#DBDBDB">�������</td>
			<td bgcolor="#DBDBDB">�����Ȯ��</td>
		</tr>
		<% if(rst == null) { %>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center" colspan="6">��ϵǾ��� ������ �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center"><%=i+1%></td>
			<td align="center"><%=rst[i].getId_course()%></td>
			<td align="center"><%=rst[i].getCourse()%></td>
			<td align="center"><%=rst[i].getYn_valid()%></td>
			<td align="center"><%=rst[i].getRegdate()%></td>
			<td align="center">�����Ȯ��</td>
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