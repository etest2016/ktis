<%
//******************************************************************************
//   ���α׷� : course_delete.jsp
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
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	
	
	if (id_node.length() == 0) { 
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%	
	}	

    // �������� ����	
	try {
	    CourseUtil.delete(id_node);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("������ ���������� �����Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>
