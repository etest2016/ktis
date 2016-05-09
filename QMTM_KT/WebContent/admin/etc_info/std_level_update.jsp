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

    String std_level = request.getParameter("std_level"); // �����ڵ� �ڵ�
	if (std_level == null) { std_level= ""; } else { std_level = std_level.trim(); }

	if (std_level.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

    String level_nm = request.getParameter("level_nm"); // �����ڵ�
	
	StdLevelBean bean = new StdLevelBean();

	bean.setStd_level(std_level);
	bean.setLevel_nm(level_nm);
	
	// �����ڵ� ����
    try {
	    StdLevelUtil.update(bean);
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