<%
//******************************************************************************
//   ���α׷� : code_chk.jsp
//   �� �� �� : �뿵�� �ڵ� �ߺ�üũ
//   ��    �� : �뿵�� �ڵ� �ߺ�üũ ������
//   �� �� �� : c_category
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CategoryUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryUtil" %>
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
	    codeChk_res = CategoryUtil.getCodeChk(input_code);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
<%=codeChk_res.trim()%>