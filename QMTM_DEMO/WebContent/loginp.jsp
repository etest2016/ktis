<%
//******************************************************************************
//   ���α׷� : loginp.jsp
//   �� �� �� : 
//   ��    �� : 
//   �� �� �� : qt_workerid
//   �ڹ����� : 
//   �� �� �� : 2008-05-27
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
	
	String userid = request.getParameter("userid"); // ����� ���̵�
	String pwd = request.getParameter("pwd"); // ���� �޴�

	out.println(userid);

	// ����� ����
	try {
	    QmanTree.insert(id_q_subject, q_subject);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }

	if(���̵� ��й�ȣ�� ������ ���){
%>

<script language="javascript">
	location.href = 'default.jsp';
</script>
<%
	}	
%>
