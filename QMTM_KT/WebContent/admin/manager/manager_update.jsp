<%
//******************************************************************************
//   ���α׷� : manager_update.jsp
//   �� �� �� : ����� ����
//   ��    �� : ����� �����ϱ�
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.admin.manager.ManagerBean, qmtm.admin.manger.ManagerUtil
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.manager.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    String password = request.getParameter("password");
	String name = request.getParameter("name");
	String rmk = request.getParameter("rmk");
	String yn_valid = request.getParameter("yn_valid");

	ManagerBean bean = new ManagerBean();

	bean.setUserid(userid);
	bean.setPassword(password);
	bean.setName(name);
	bean.setContent1(rmk);
	bean.setYn_valid(yn_valid);
	
    // ����� ����
	try {
	    ManagerUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("���������� �����Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>