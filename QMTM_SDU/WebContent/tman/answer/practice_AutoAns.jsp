<%
//******************************************************************************
//   ���α׷� : practice_AutoAns.jsp
//   �� �� �� : �Ǳ��� ��� �ϰ�����
//   ��    �� : �Ǳ��� ��� �ϰ�����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.PracticeUtil
//   �� �� �� : 2013-05-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.PracticeUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	try {
	    PracticeUtil.deleteAns(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

%>

<Script type="text/javascript">
	alert("�Ǳ��� ����� �ϰ������Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</Script>