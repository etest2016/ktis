<%
//******************************************************************************
//   ���α׷� : subject_insert.jsp
//   �� �� �� : ���� ���
//   ��    �� : �ش� ���� �Ʒ� �������ϱ�
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
	String subject = request.getParameter("subject"); // �����
	int subject_order = Integer.parseInt(request.getParameter("subject_order")); // �������
	String yn_valid = request.getParameter("yn_valid"); // ��ȿ����
	
    String id_subject = CommonUtil.getMakeID("S1");

	SubjectBean bean = new SubjectBean();

	bean.setId_course(id_node);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(subject_order);
	bean.setYn_valid(yn_valid);
	
	// �������� ���
    try {
	    SubjectUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("������ ���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>