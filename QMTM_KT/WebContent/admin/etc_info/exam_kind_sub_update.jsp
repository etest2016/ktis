<%
//******************************************************************************
//   ���α׷� : std_level_update.jsp
//   �� �� �� : �����ڵ� ����
//   ��    �� : �����ڵ� �����ϱ�
//   �� �� �� : r_std_level
//   �ڹ����� : qmtm.admin.etc.StdLevelBean, qmtm.admin.etc.StdLevelUtil
//   �� �� �� : 2008-04-08
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

    String id_exam_kind = request.getParameter("id_exam_kind");
	if (id_exam_kind == null) { id_exam_kind= ""; } else { id_exam_kind = id_exam_kind.trim(); }

	String id_exam_kind_sub = request.getParameter("id_exam_kind_sub");
	if (id_exam_kind_sub == null) { id_exam_kind_sub= ""; } else { id_exam_kind_sub = id_exam_kind_sub.trim(); }

	String exam_kind_sub = request.getParameter("exam_kind_sub");
	if (exam_kind_sub == null) { exam_kind_sub= ""; } else { exam_kind_sub = exam_kind_sub.trim(); }

	if (id_exam_kind.length() == 0 || id_exam_kind_sub.length() == 0 || exam_kind_sub.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}
	
	ExamKindSubBean bean = new ExamKindSubBean();

	bean.setId_exam_kind(Integer.parseInt(id_exam_kind));
	bean.setId_exam_kind_sub(Integer.parseInt(id_exam_kind_sub));
	bean.setExam_kind_sub(exam_kind_sub);

    // ���豸���ڵ���
	try {
	    ExamKindSubUtil.update(bean);
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