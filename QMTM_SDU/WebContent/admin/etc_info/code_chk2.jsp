<%
//******************************************************************************
//   ���α׷� : code_chk2.jsp
//   �� �� �� : �ҿ��� �ڵ� �ߺ�üũ
//   ��    �� : �ҿ��� �ڵ� �ߺ�üũ ������
//   �� �� �� : c_midcategory
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.MidCategoryUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.MidCategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String input_code = request.getParameter("input_code");

	// �ڵ� �ߺ�üũ
	String codeChk_res = "flase";

    try {
	    codeChk_res = MidCategoryUtil.getCodeChk(input_code);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
<%=codeChk_res.trim()%>