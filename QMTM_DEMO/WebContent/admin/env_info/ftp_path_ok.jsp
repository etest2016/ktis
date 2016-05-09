<%
//******************************************************************************
//   ���α׷� : ftp_path_ok.jsp
//   �� �� �� : FTP ��μ���
//   ��    �� : FTP ��μ��� ������
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

	String http_files_url = request.getParameter("http_files_url");
	if (http_files_url == null) { http_files_url= ""; } else { http_files_url = http_files_url.trim(); }

	if (userid.length() == 0 || http_files_url.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	
	
	// FTP ��� ����
	try {
		EnvUtil.updateFTP(userid, http_files_url);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<script language="JavaScript">
	alert("FTP ��ΰ� ���������� ����Ǿ����ϴ�.");
	location.href="ftp_path.jsp";
</script>