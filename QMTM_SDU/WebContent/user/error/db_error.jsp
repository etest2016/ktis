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

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String error_msg = request.getParameter("err_msg");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
 <HEAD>
  <meta http-equiv="content-type" content="text/html; charset=EUC-KR">
  <TITLE> Error </TITLE>
 </HEAD>

 <BODY>
<%
	out.println("�����ͺ��̽� ���ῡ ������ �߻��߽��ϴ�.<BR><BR>�����ڿ��� �����Ͻñ� �ٶ��ϴ�.!!!!");
%>
 </BODY>
</HTML>
