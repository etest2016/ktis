<%
//******************************************************************************
//   ���α׷� : ans_equal_frame.asp
//   �� �� �� : ����� �� ������
//   ��    �� : ������ ����� �� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2009-01-21
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_exam = request.getParameter("id_exam");
	String id_q = request.getParameter("id_q");

%>
<html>
<head><title>����� ��</title></head>
<FRAMESET ROWS = "30%,*,20%" frameborder="0">
	<FRAME SRC="ans_equal_start.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>" name="top">
	<FRAME SRC="progress.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>" name="main">
	<FRAME SRC="ans_equal_res.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>" name="bottom">
</FRAMESET>