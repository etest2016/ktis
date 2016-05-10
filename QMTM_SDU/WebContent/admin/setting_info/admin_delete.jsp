<%
//******************************************************************************
//   ���α׷� : admin_delete.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ �����ϱ�
//   �� �� �� : qt_adminid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil,
//              qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean
//   �� �� �� : 2013-02-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String userid = request.getParameter("userid"); // ������ ID
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// ������ ���� ����
	try {
		AdminUtil.delete(userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("�����ھ��̵� : ");
	bigos.append(userid);
	
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("��������������");
	logbean.setBigo(bigos.toString());

	try {
		WorkAdminLog.insert(logbean);
	} catch(Exception ex) {
	    out.println(ex.getMessage());

	    if(true) return;
    }
%>

<script language="javascript">
	alert("���������� �����Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>