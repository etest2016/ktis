<%
//******************************************************************************
//   ���α׷� : paper_guide_insert.jsp
//   �� �� �� : �����ȳ��� ����
//   ��    �� : �����ȳ��� �����ϱ�
//   �� �� �� : exam_paper_guide
//   �ڹ����� : qmtm.tman.paper.ExamPaperGuide, qmtm.tman.paper.ExamPaperGuideBean
//   �� �� �� : 2008-05-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	int nr_q = Integer.parseInt(request.getParameter("nr_q"));
	String guide_msg = request.getParameter("guide_msg");

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

	ExamPaperGuideBean bean = new ExamPaperGuideBean();

	bean.setId_exam(id_exam);
	bean.setNr_q(nr_q);
	bean.setGuide_msg(guide_msg);

	// �����ȳ��� ���� ���
    try {
	    ExamPaperGuide.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	window.opener.location.reload();
	window.close();	
</script>