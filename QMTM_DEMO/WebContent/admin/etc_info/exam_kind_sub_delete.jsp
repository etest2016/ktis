<%
//******************************************************************************
//   ���α׷� : exam_kind_sub_delete.jsp
//   �� �� �� : ���豸�� ����
//   ��    �� : ���豸�� �����ϱ�
//   �� �� �� : r_exam_kind_sub
//   �ڹ����� : qmtm.admin.etc.ExamKindSubBean, qmtm.admin.etc.ExamKindSubUtil
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

    String id_exam_kind_sub = request.getParameter("id_exam_kind_sub");
	if (id_exam_kind_sub == null) { id_exam_kind_sub= ""; } else { id_exam_kind_sub = id_exam_kind_sub.trim(); }

	if (id_exam_kind_sub.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	// ���豸�� ���� ����
	try {
		ExamKindSubUtil.delete(Integer.parseInt(id_exam_kind_sub));
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