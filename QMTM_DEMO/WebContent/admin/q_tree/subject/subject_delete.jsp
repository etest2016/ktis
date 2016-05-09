<%
//******************************************************************************
//   ���α׷� : subject_delete.jsp
//   �� �� �� : ���� ����
//   ��    �� : �������� ���� �����ϱ�
//   �� �� �� : q_subject, q_chapter
//   �ڹ����� : qmtm.admin.QmanTree
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);     
    request.setCharacterEncoding("EUC-KR");

    String id_q_subject = request.getParameter("id_q_subject"); // ���� ID
	if (id_q_subject == null) { id_q_subject= ""; } else { id_q_subject = id_q_subject.trim(); }

	if (id_q_subject.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

    // �����ܿ� ���� üũ
	boolean down_YN = false;

	try {
	    down_YN = QmanTree.getDownCnt(id_q_subject);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
	
	if(down_YN) {
	
		// �������� ����
		try {
			QmanTree.delete(id_q_subject);
	    } catch(Exception ex) {
		    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

			if(true) return;
	    }
%>

<script language="javascript">
	alert("������ ���������� �����Ǿ����ϴ�.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.href="../f_main.jsp"; 
	window.close();
</script>

<%
	} else {
%>
<script language="javascript">
	alert("������ �ܿ��� �־ ������ �� �����ϴ�. \n\n���� �ܿ��� ���� �� ������ �ֽñ� �ٶ��ϴ�.");	
	window.close();
</script>
<%
	}
%>