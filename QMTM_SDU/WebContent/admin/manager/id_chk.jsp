<%
//******************************************************************************
//   ���α׷� : id_chk.jsp
//   �� �� �� : ���� ����� ���̵� �ߺ�üũ
//   ��    �� : ���� ����� ���̵� �ߺ�üũ ������
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.admin.manager.ManagerUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String input_id = request.getParameter("input_id");

	// ���̵� �ߺ�üũ
	String idChk_res = "flase";

    try {
	    idChk_res = ManagerUtil.getIdChk(input_id);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
<%=idChk_res.trim()%>