<%
//******************************************************************************
//   ���α׷� : id_chk.jsp
//   �� �� �� : ȸ�� ���̵� �ߺ�üũ
//   ��    �� : ȸ�� ���̵� �ߺ�üũ ������
//   �� �� �� : qt_userid
//   �ڹ����� : qmtm.ComLib, qmtm.tman.exam.ReceiptUtil
//   �� �� �� : 2013-02-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ReceiptUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String input_id = request.getParameter("input_id");

	// ���̵� �ߺ�üũ
	String idChk_res = "flase";

    try {
	    idChk_res = ReceiptUtil.getIdChk(input_id);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
<%=idChk_res.trim()%>