<%
//******************************************************************************
//   ���α׷� : receipt_inwons_pwd_change.jsp
//   �� �� �� : ����� ��й�ȣ �ʱ�ȭ
//   ��    �� : ����� ��й�ȣ �ʱ�ȭ (��й�ȣ�� ���̵�� �����ϰ� �ʱ�ȭ)
//   �� �� �� : qt_userid
//   �ڹ����� : qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean
//   �� �� �� : 2013-02-14
//   �� �� �� : 
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>  
<%@ page import="qmtm.ComLib, qmtm.common.*, qmtm.CommonUtil, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam"); 
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	String id_course = request.getParameter("id_course");	
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");	
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }
	
	String inwons = request.getParameter("inwons");
	if (inwons == null) { inwons = ""; } else { inwons = inwons.trim(); }
	
	if (inwons.length() == 0) {
%>
	<script language="javascript">
		alert("������ ����ڰ� �����ϴ�.");
		window.close();
	</script>
<%
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String[] arrUserid;
	arrUserid = inwons.split(",");

	for(int i=0; i<arrUserid.length; i++) {
	
		try {
			ReceiptUtil.initPwd(arrUserid[i]);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}
	}

	// ����� ���� �α����� ����
	StringBuffer bigos = new StringBuffer();

	bigos.append("�ʱ�ȭ ����� : ");
	bigos.append(inwons);
			
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("��й�ȣ�ʱ�ȭ");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// ����� ���� �α����� ����

%>

<Script language="javascript">
	alert("���õ� ����� ��й�ȣ�� �ʱ�ȭ �Ǿ����ϴ�.");
	location.href="receipt_inwons.jsp?id_exam=<%=id_exam%>&id_course=<%=id_course%>&id_subject=<%=id_subject%>";
</Script>
