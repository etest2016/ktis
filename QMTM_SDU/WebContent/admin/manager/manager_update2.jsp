<%
//******************************************************************************
//   ���α׷� : manager_update2.jsp
//   �� �� �� : ����� ����
//   ��    �� : ����� �����ϱ�
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, qmtm.admin.manger.ManagerUtil
//   �� �� �� : 2013-02-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>
<%@ include file = "/common/login_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String userid = request.getParameter("userid");
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

    String password = request.getParameter("userid");

	// ��й�ȣ ��ȣȭ.
	/*try {
		password = CommonUtil.encrypt(password);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }*/

	String name = request.getParameter("name");
	String rmk = request.getParameter("rmk");
	String yn_valid = "Y";

	String email = request.getParameter("email");
	String hp = request.getParameter("hp");

	ManagerBean bean = new ManagerBean();

	bean.setUserid(userid);
	bean.setPassword(password);
	bean.setName(name);
	bean.setContent1(rmk);
	bean.setYn_valid(yn_valid);
	bean.setEmail(email);
	bean.setHp(hp);
	
    // ����� ����
	try {
	    ManagerUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));
		
	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("��������ھ��̵� : ");
	bigos.append(userid);
	bigos.append(", ��������ڼ��� : ");
	bigos.append(name);
	bigos.append(", ����������̸����ּ� : ");
	bigos.append(email);
	bigos.append(", ��������ڿ���ó : ");
	bigos.append(hp);
	bigos.append(", ��������ڼҼ����� : ");
	bigos.append(rmk);
	bigos.append(", ������뿩�� : ");
	bigos.append(yn_valid);
			
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("�����������������");
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