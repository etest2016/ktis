<%
//******************************************************************************
//   ���α׷� : img_view.jsp
//   �� �� �� : ������ �̹��� ����
//   ��    �� : ������ �̹��� ���� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-04-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String img_view = request.getParameter("paper_img");
	if (img_view == null) { img_view = ""; } else { img_view = img_view.trim(); }

	if (img_view.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%	
	}
%>

<img src="../paper_img/qmtm_paper<%=img_view%>.jpg">