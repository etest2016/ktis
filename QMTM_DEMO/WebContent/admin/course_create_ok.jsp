<%
//******************************************************************************
//   ���α׷� : course_create_ok.jsp
//   �� �� �� : ���� ���
//   ��    �� : ��������ϱ�
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
<%@ page import="qmtm.*, qmtm.admin.course.CourseUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String course = request.getParameter("course");
    String yn_valid = request.getParameter("yn_valid");

    String id_course = CommonUtil.getMakeID("C1");

    CourseBean bean = new CourseBean();

	bean.setId_course(id_course);
	bean.setCourse(course);
	bean.setYn_valid(yn_valid);
	
    // �������
	try {
	    CourseUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("������ ���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>