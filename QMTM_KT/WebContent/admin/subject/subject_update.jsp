<%
//******************************************************************************
//   ���α׷� : subject_update.jsp
//   �� �� �� : ���� ����
//   ��    �� : �������� �����ϱ�
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.admin.subject.SubjectUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.subject.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // �����ڵ�
    String id_subject = request.getParameter("id_subject"); // �����ڵ�
	String subject = request.getParameter("subject"); // �����
	int subject_order = Integer.parseInt(request.getParameter("subject_order")); // �������
	String yn_valid = request.getParameter("yn_valid"); // ��ȿ����
	
	SubjectBean bean = new SubjectBean();

	bean.setId_course(id_node);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(subject_order);
	bean.setYn_valid(yn_valid);
	
	// �������� ���
    try {
	    SubjectUtil.Update(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("������ ���������� �����Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>