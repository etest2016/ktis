<%
//******************************************************************************
//   ���α׷� : page_error.jsp
//   �� �� �� : ������ ���ѿ���
//   ��    �� : ������ ���ѿ��� ���� ������
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
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
 <HEAD>
  <TITLE> Error </TITLE>
  <meta http-equiv="content-type" content="text/html; charset=EUC-KR">
 </HEAD>

 <BODY>
  <%
	out.println("�ش� ȭ�鿡 ������ ������ �����ϴ�.<BR><BR>�����ڿ��� �����Ͻñ� �ٶ��ϴ�.!!!");
  %>
 </BODY>
</HTML>
