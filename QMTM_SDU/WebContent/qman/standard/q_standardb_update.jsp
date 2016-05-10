<%
//******************************************************************************
//   ���α׷� : q_standardb_update.jsp
//   �� �� �� : �Һз����� �����Ϸ�
//   ��    �� : �Һз����� �����Ϸ� ������
//   �� �� �� : q_standard_b
//   �ڹ����� : qmtm.ComLib, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	
	
	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }

	String id_standarda = request.getParameter("id_standarda"); // �з����� �ڵ�
	if (id_standarda == null) { id_standarda= ""; } else { id_standarda = id_standarda.trim(); }

	String id_standardb = request.getParameter("id_standardb");
	if (id_standardb == null) { id_standardb= ""; } else { id_standardb = id_standardb.trim(); }
	
	if (id_subject.length() == 0 || id_chapter.length() == 0 || id_standarda.length() == 0 || id_standardb.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

    String standardb = request.getParameter("standardb"); // �з�����
	String yn_valid = request.getParameter("yn_valid"); 
	
	QstandardBBean bean = new QstandardBBean();

	bean.setId_standardb(id_standardb);
	bean.setStandardb(standardb);
	bean.setYn_valid(yn_valid);
	
	// �з����� ����
    try {
	    QstandardBUtil.update(bean);
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

	bigos.append(", �Һз��ڵ� : ");
	bigos.append(id_standardb);

	bigos.append(", �Һз��� : ");
	bigos.append(standardb);

	bigos.append(", �������� : ");
	if(yn_valid.equals("Y")) {
		bigos.append("����");
	} else {
		bigos.append("�����");
	}
		
	// �α����� ��� ����
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter(id_chapter);
	logbean.setId_chapter2("-1");
	logbean.setId_chapter3("-1");
	logbean.setId_chapter4("-1");
	logbean.setUserid(userid);
	logbean.setGubun("�Һз�����");
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