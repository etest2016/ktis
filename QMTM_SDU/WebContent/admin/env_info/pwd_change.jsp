<%
//******************************************************************************
//   ���α׷� : pwd_change.jsp
//   �� �� �� : ��й�ȣ ����
//   ��    �� : ��й�ȣ ���� ������
//   �� �� �� : qt_settings
//   �ڹ����� : qtmm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil 
//   �� �� �� : 2013-01-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� :  
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.etc.EnvUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

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

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	// ��ȣ ����
	try {
		EnvUtil.update(userid, qmtm_password);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	StringBuffer bigos = new StringBuffer();

	bigos.append("�����й�ȣ : ");
	bigos.append(qmtm_password);
			
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(userid);
	logbean.setGubun("Super�����ں�й�ȣ����");
	logbean.setBigo(bigos.toString());

	try {
		WorkAdminLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>

<script language="JavaScript">
	alert("��й�ȣ�� ���������� ����Ǿ����ϴ�.");
	location.href="pwd_list.jsp";
</script>