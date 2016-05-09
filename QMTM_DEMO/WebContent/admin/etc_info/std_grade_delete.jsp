<%
//******************************************************************************
//   ���α׷� : std_grade_delete.jsp
//   �� �� �� : �г��ڵ� ����
//   ��    �� : �г��ڵ� �����ϱ�
//   �� �� �� : r_std_grade
//   �ڹ����� : qmtm.admin.etc.StdGradeBean, qmtm.admin.etc.StdGradeUtil
//   �� �� �� : 2008-04-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String std_grade = request.getParameter("std_grade"); 
	if (std_grade == null) { std_grade= ""; } else { std_grade = std_grade.trim(); }

	if (std_grade.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	// �г��ڵ� ���� ����
	try {
		StdGradeUtil.delete(std_grade);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>

<script language="javascript">
	alert("���������� �����Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>