<%
//******************************************************************************
//   ���α׷� : lms_index2.jsp
//   �� �� �� : ���� ��������
//   ��    �� : LMS�� ���� ��������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-11-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<html>
<head><title>LMS ������������</title></head>
<FRAMESET ROWS = 50%,* frameborder=0>
   <FRAME SRC="process.jsp" name="top">
   <FRAME SRC="lms_score_export_cancel.jsp?id_exam=<%=id_exam%>" name="main">
</FRAMESET>

