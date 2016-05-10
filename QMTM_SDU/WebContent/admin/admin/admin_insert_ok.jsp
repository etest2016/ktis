<%
//******************************************************************************
//   ���α׷� : admin_insert_ok.jsp
//   �� �� �� : ������ ���
//   ��    �� : ������ ����ϱ�
//   �� �� �� : qt_adminid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil,
//              qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean
//   �� �� �� : 2013-03-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil,java.util.Date, java.util.Calendar " %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

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

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_chk = "false";
	
	// ���̵� �ߺ�üũ
	try {
	    id_chk = AdminUtil.getIdChk(userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	if(id_chk.equals("true")) {
%>
<script language="javascript">
	alert("�ߺ��� ���̵� �����մϴ�.");
	history.back();
</script>
<%
	} else {
	
		int year;
		Calendar cal = Calendar.getInstance();
		year = cal.get(Calendar.YEAR);

		String password = request.getParameter("userid")+"6710#";

		String name = request.getParameter("name");
		String rmk = request.getParameter("rmk");
		if (rmk == null) { rmk = ""; } else { rmk = rmk.trim(); }
		String yn_valid = request.getParameter("yn_valid");
		if (yn_valid == null) { yn_valid = "Y"; } else { yn_valid = yn_valid.trim(); }
		String email = request.getParameter("email");
		if (email == null) { email = ""; } else { email = email.trim(); }
		String hp = request.getParameter("hp");
		if (hp == null) { hp = ""; } else { hp = hp.trim(); }

		AdminBean bean = new AdminBean();

		bean.setUserid(userid);
		bean.setPassword(password);
		bean.setName(name);
		bean.setContent1(rmk);
		bean.setYn_valid(yn_valid);

		bean.setEmail(email);
		bean.setHp(hp);
		
		// ������ ���
		try {
			AdminUtil.insert(bean);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		StringBuffer bigos = new StringBuffer();

		bigos.append("�����ھ��̵� : ");
		bigos.append(userid);
		bigos.append(", �����ڼ��� : ");
		bigos.append(name);
		bigos.append(", �������̸����ּ� : ");
		bigos.append(email);
		bigos.append(", �����ڿ���ó : ");
		bigos.append(hp);
		bigos.append(", �����ڼҼ����� : ");
		bigos.append(rmk);
		bigos.append(", ������뿩�� : ");
		bigos.append(yn_valid);
		
		WorkAdminLogBean logbean = new WorkAdminLogBean();

		logbean.setUserid(adm_userid);
		logbean.setGubun("�������������");
		logbean.setBigo(bigos.toString());

		try {
			WorkAdminLog.insert(logbean);
		} catch(Exception ex) {
			out.println(ex.getMessage());

			if(true) return;
		}
%>

<script language="javascript">
	alert("���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>

<%
	}
%>