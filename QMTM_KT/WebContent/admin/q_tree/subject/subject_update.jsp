<%
//******************************************************************************
//   ���α׷� : subject_update.jsp
//   �� �� �� : ���� ����
//   ��    �� : �������� �������� �����ϱ�
//   �� �� �� : q_subject
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

    String id_q_subject = request.getParameter("id_q_subject"); // �����ڵ�
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	
	
	if (id_q_subject.length() == 0) { 
		out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}	

    String q_subject = request.getParameter("q_subject"); // �����
	String yn_valid = request.getParameter("yn_valid"); // ��������
	
	// �������� ����
    try {
	    QmanTree.update(id_q_subject, q_subject, yn_valid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("������ ���������� �����Ǿ����ϴ�.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.reload(); 
	window.close();
</script>