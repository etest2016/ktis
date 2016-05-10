<%
//******************************************************************************
//   ���α׷� : group_update.jsp
//   �� �� �� : �뿵������ �����Ϸ�
//   ��    �� : �뿵������ �����Ϸ� ������
//   �� �� �� : c_cateogry
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil
//   �� �� �� : 2013-01-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_category = request.getParameter("id_category"); // �׷챸�� �ڵ�
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	if (id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

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

    String category = request.getParameter("category"); // �׷챸��
	String yn_valid = request.getParameter("yn_valid"); 
	
	CategoryBean bean = new CategoryBean();

	bean.setId_category(id_category);
	bean.setCategory(category);
	bean.setYn_valid(yn_valid);
	
	// �׷챸�� ����
    try {
	    CategoryUtil.update(bean);
    } catch(Exception ex) {
	    //out.println(ComLib.getExceptionMsg(ex, "close"));
		out.println(ex.getMessage());

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("�뿵���ڵ� : ");
	bigos.append(id_category);
	bigos.append(", �뿵���� : ");
	bigos.append(category);
	bigos.append(", �������� : ");
	bigos.append(yn_valid);
			
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("�뿵������");
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