<%
//******************************************************************************
//   ���α׷� : pt_receipt_inwon_import.jsp
//   �� �� �� : ��Ʈ��ķ�۽� ������ο�
//   ��    �� : ��Ʈ��ķ�۽� ������ο� ������
//   �� �� �� : exam_receipt, qt_userid
//   �ڹ����� : qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean
//   �� �� �� : 2013-03-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean, qmtm.*, qmtm.common.*" %>
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

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_course = request.getParameter("id_course");	
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");	
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }	
		
	try {
		ReceiptUtil.getPCBeans(id_course, id_subject, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}	

	// �������� ����� ��� �α����� ����
	StringBuffer bigos = new StringBuffer();

	bigos.append("��Ϲ�� : ");
	bigos.append("�����ý��۴���ڵ��");
			
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("����ڵ��");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// �������� ����� ��� �α����� ����
%>

<Script language="javascript">
	alert("����ڰ� ��ϵǾ����ϴ�.");
	opener.location.reload();
	window.close();
</Script>