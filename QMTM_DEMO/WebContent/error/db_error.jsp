<%
//******************************************************************************
//   ���α׷� : db_error.jsp
//   �� �� �� : sql�� ���ÿ���
//   ��    �� : sql�� ���ÿ��� ���� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-09-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.env.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String error_msg = request.getParameter("err_msg");
%>

<HTML>
 <HEAD>
  <TITLE> Error </TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
 </HEAD>

 <BODY>
  <%
    out.println(error_msg);
	out.println("<BR><BR>�����ڿ��� �����Ͻñ� �ٶ��ϴ�.!!!!");
  %>
 </BODY>
</HTML>
