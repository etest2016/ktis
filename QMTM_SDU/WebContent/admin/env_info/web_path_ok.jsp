<%
//******************************************************************************
//   ���α׷� : web_path_ok.jsp
//   �� �� �� : WEB ��μ���
//   ��    �� : WEB ��μ��� ������
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

	String qmtm_web_home = request.getParameter("qmtm_web_home");
	if (qmtm_web_home == null) { qmtm_web_home = ""; } else { qmtm_web_home = qmtm_web_home.trim(); }

	if (userid.length() == 0 || qmtm_web_home.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	// WEB ��� ����
	try {
		EnvUtil.updateWEB(userid, qmtm_web_home);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	StringBuffer bigos = new StringBuffer();

	bigos.append("Web URL������ : ");
	bigos.append(qmtm_web_home);
			
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(userid);
	logbean.setGubun("Web URL��μ���");
	logbean.setBigo(bigos.toString());

	try {
		WorkAdminLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>

<script language="JavaScript">
	alert("WEB ��ΰ� ���������� ����Ǿ����ϴ�.");
	location.href="web_path.jsp";
</script>