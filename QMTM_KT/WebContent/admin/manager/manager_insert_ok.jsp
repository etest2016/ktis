<%
//******************************************************************************
//   ���α׷� : manager_insert_ok.jsp
//   �� �� �� : ����� ���
//   ��    �� : ����ڵ���ϱ�
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, 
//             qmtm.admin.manager.ManagerUtil
//   �� �� �� : 2010-06-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>

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
	
    // ����� ���
	try {
	    ManagerUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>