<%
//******************************************************************************
//   ���α׷� : id_chk.jsp
//   �� �� �� : ������ ���̵� �ߺ�üũ
//   ��    �� : ������ ���̵� �ߺ�üũ ������
//   �� �� �� : qt_adminid
//   �ڹ����� : qmtm.admin.admin.AdminUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.admin.AdminUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String input_id = request.getParameter("input_id");

	// ���̵� �ߺ�üũ
	String idChk_res = "flase";

    try {
	    idChk_res = AdminUtil.getIdChk(input_id);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
<%=idChk_res.trim()%>