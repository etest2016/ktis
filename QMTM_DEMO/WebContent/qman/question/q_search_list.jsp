<%
//******************************************************************************
//   ���α׷� : q_search_list.jsp
//   �� �� �� : ���� �˻� ���
//   ��    �� : ������ �־� ���� �˻� ����� �����ش�.
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2008-04-16
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 2008-07-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

	<table border="0" width="95%" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF" height="30">
			<td align="left">* �˻��� ����</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>
				<table border="0" width="100%" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
					<tr bgcolor="#DDDDDD" height="30" align="center">
						<td>�����ڵ�</td>
						<td>��������</td>
						<td>����</td>
					</tr>
					<tr bgcolor="#FFFFFF" height="25">
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
