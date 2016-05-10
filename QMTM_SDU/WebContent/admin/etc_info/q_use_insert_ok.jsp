<%
//******************************************************************************
//   ���α׷� : q_use_insert_ok.jsp
//   �� �� �� : �����뵵 ���
//   ��    �� : �����뵵 ����ϱ�
//   �� �� �� : r_q_use
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   �� �� �� : 2013-02-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_q_use = request.getParameter("id_q_use");
	if (id_q_use == null) { id_q_use= ""; } else { id_q_use = id_q_use.trim(); }

	if (id_q_use.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String q_use = request.getParameter("q_use");
	String rmk = request.getParameter("rmk");

	QuseBean bean = new QuseBean();

	bean.setId_q_use(id_q_use);
	bean.setQ_use(q_use);
	bean.setRmk(rmk);

    // �����뵵���
	try {
	    QuseUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();
	
	bigos.append("�����뵵�ڵ� : ");
	bigos.append(id_q_use);
	bigos.append(", �����뵵�� : ");
	bigos.append(q_use);
	bigos.append(", ��� : ");
	bigos.append(rmk);

	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("�����뵵���");
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