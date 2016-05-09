<%
//******************************************************************************
//   ���α׷� : pwd_change.jsp
//   �� �� �� : ��й�ȣ ����
//   ��    �� : ��й�ȣ ���� ������
//   �� �� �� : qt_settings
//   �ڹ����� : qtmm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil 
//   �� �� �� : 2008-09-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� :  
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	// �ش� ������ ���� üũ	
	String userid = (String)session.getAttribute("userid");  
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String qmtm_password = request.getParameter("qmtm_password");
	if (qmtm_password == null) { qmtm_password= ""; } else { qmtm_password = qmtm_password.trim(); }

	if (userid.length() == 0 || qmtm_password.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	

	// ������ ��й�ȣ ��ȣȭ.
	try {
		qmtm_password = CommonUtil.encrypt(qmtm_password);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// ��ȣ ����
	try {
		EnvUtil.update(userid, qmtm_password);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<script language="JavaScript">
	alert("��й�ȣ�� ���������� ����Ǿ����ϴ�.");
	location.href="pwd_list.jsp";
</script>