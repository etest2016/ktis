<%
//******************************************************************************
//   ���α׷� : exam_paper_delete.jsp
//   �� �� �� : �����ȳ��� ����
//   ��    �� : �����ȳ��� �����ϱ�
//   �� �� �� : exam_paper_guide
//   �ڹ����� : qmtm.tman.paper.ExamPaperGuide
//   �� �� �� : 2008-05-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	int nr_q = Integer.parseInt(request.getParameter("nr_q"));

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

    // �����ȳ��� ����
	try {
	    ExamPaperGuide.delete(id_exam, nr_q);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	window.opener.location.reload();
	window.close();
</script>