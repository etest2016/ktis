<%
//******************************************************************************
//   ���α׷� : course_update.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���������ϱ�
//   �� �� �� : c_course
//   �ڹ����� : qmtm.admin.course.CourseUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.course.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // Ʈ�� ID
	String course = request.getParameter("course");
    String yn_valid = request.getParameter("yn_valid");

    // �������� ����	
	try {
	    CourseUtil.update(id_node, course, yn_valid);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("������ ���������� �����Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>