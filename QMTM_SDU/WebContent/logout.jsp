<%
//******************************************************************************
//   ���α׷� : logout.jsp
//   �� �� �� : �α׾ƿ� ó��
//   ��    �� : �α׾ƿ� ó��
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-06-26
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

	String chk_usergrade = (String)session.getAttribute("usergrade"); // ����

	if(chk_usergrade.equals("C")) {

		// ���� ��ü ���� �� ��ȿ�ð� 0���� �ʱ�ȭ
		session.invalidate(); 
 %>
	<script language="javascript">
		top.window.close();
	</script>
<%
	} else {
		// ���� ��ü ���� �� ��ȿ�ð� 0���� �ʱ�ȭ
		session.invalidate(); 
%>
	<script language="javascript">
		//top.window.close();
		top.location.href = "login.jsp";
	</script>
<%
	}
%>

