<%
//******************************************************************************
//   ���α׷� : group_update2.jsp
//   �� �� �� : �ҿ������� �����Ϸ�
//   ��    �� : �ҿ������� �����Ϸ� ������
//   �� �� �� : c_midcateogry
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil
//   �� �� �� : 2013-01-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_midcategory = request.getParameter("id_midcategory");
	if (id_midcategory == null) { id_midcategory= ""; } else { id_midcategory = id_midcategory.trim(); }

	if (id_midcategory.length() == 0) {
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

	String id_category = ComLib.toParamChk(request.getParameter("id_category"));
    String midcategory = request.getParameter("midcategory"); // �׷챸��
	String yn_valid = request.getParameter("yn_valid"); 
	String order_param = ComLib.toParamChk(request.getParameter("orders"));

	int orders = Integer.parseInt(order_param);
	
	MidCategoryBean bean = new MidCategoryBean();

	bean.setId_category(id_category);
	bean.setId_midcategory(id_midcategory);
	bean.setMidcategory(midcategory);
	bean.setYn_valid(yn_valid);
	bean.setOrders(orders);
	
	// �׷챸�� ����
    try {
	    MidCategoryUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));		

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("�뿵���ڵ� : ");
	bigos.append(id_category);
	bigos.append(", �ҿ����ڵ� : ");
	bigos.append(id_midcategory);
	bigos.append(", �ҿ����� : ");
	bigos.append(midcategory);
	bigos.append(", ���ļ��� : ");
	bigos.append(order_param);
	bigos.append(", �������� : ");
	bigos.append(yn_valid);
			
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("�ҿ�������");
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