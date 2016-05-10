<%
//******************************************************************************
//   ���α׷� : q_standarda_delete.jsp
//   �� �� �� : ��з����� ����
//   ��    �� : ��з����� �����ϱ�
//   �� �� �� : q_standard_a
//   �ڹ����� : qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	

	String id_chapter = request.getParameter("id_chapter"); 
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }
	
	String id_standarda = request.getParameter("id_standarda");
	if (id_standarda == null) { id_standarda= ""; } else { id_standarda = id_standarda.trim(); }

	if (id_subject.length() == 0 || id_chapter.length() == 0 || id_standarda.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

	// �Һз��� �ִ��� Ȯ�� �� �Һз��� ���� �� ����.

	int cnts = 0;

	try {
		cnts = QstandardAUtil.getCnt(id_standarda);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	if(cnts > 0) {
%>
		<script language="javascript">
			alert("��ϵǾ��� �Һз��� �־ ������ �� �����ϴ�.\n\n�Һз����� �� �����Ͻñ� �ٶ��ϴ�.");
			window.close();
		</script>
<%
		if(true) return;
	} else {
	
		// ��з����� ���� ����
		try {
			QstandardAUtil.delete(id_standarda);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		StringBuffer bigos = new StringBuffer();
	
		bigos.append("�����ڵ� : ");
		bigos.append(id_subject);

		bigos.append(", �ܿ��ڵ� : ");
		bigos.append(id_chapter);

		bigos.append(", ��з��ڵ� : ");
		bigos.append(id_standarda);
		
		// �α����� ��� ����
		WorkQLogBean logbean = new WorkQLogBean();

		logbean.setId_subject(id_subject);
		logbean.setId_chapter(id_chapter);
		logbean.setId_chapter2("-1");
		logbean.setId_chapter3("-1");
		logbean.setId_chapter4("-1");
		logbean.setUserid(userid);
		logbean.setGubun("��з�����");
		logbean.setId_q("");
		logbean.setBigo(bigos.toString());

		try {
			WorkQLog.insert(logbean);
		} catch(Exception ex) {
			out.println(ex.getMessage());

			if(true) return;
		}
		// �α����� ��� ����
%>
		<script language="javascript">
			alert("���������� �����Ǿ����ϴ�.");
			window.opener.location.reload();
			window.close();
		</script>
<%
	}
%>