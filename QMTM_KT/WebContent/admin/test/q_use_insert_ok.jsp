<%
//******************************************************************************
//   ���α׷� : q_use_insert_ok.jsp
//   �� �� �� : �����뵵 ���
//   ��    �� : �����뵵 ����ϱ�
//   �� �� �� : r_q_use
//   �ڹ����� : qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_q_use = request.getParameter("id_q_use");
	String q_use = request.getParameter("q_use");
	String rmk = request.getParameter("rmk");

	QuseBean bean = new QuseBean();

	bean.setId_q_use(id_q_use);
	bean.setQ_use(q_use);
	bean.setRmk(rmk);

    // �����뵵���
	try {
	    QuseUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>