<%
//******************************************************************************
//   ���α׷� : q_delete_ok.jsp
//   �� �� �� : ���� ����
//   ��    �� : �������� ���� ���� ����
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2008-07-09
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*" %> 

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
	
	if (id_qs.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%
	}

	try {
		QListUtil.deletes(id_qs);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<script language="JavaScript">
	alert("������ ���������� �����Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>