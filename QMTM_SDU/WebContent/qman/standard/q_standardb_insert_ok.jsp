<%
//******************************************************************************
//   ���α׷� : q_standarda_insert_ok.jsp
//   �� �� �� : ��з����� ��ϿϷ�
//   ��    �� : ��з����� ��ϿϷ� ������
//   �� �� �� : q_standard_a
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

	String id_standardb = ComLib.getMakeID("B");
	if (id_standardb == null) { id_standardb= ""; } else { id_standardb = id_standardb.trim(); }

	if (id_subject.length() == 0 || id_chapter.length() == 0 || id_standarda.length() == 0 || id_standardb.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

	String standardb = ComLib.toParamChk(request.getParameter("standardb"));
	if (standardb == null) { standardb = ""; } else { standardb = standardb.trim(); }
	
	QstandardBBean bean = new QstandardBBean();

	bean.setId_standardb(id_standardb);
	bean.setStandardb(standardb);
	bean.setId_standarda(id_standarda);

    // �Һз����
	try {
	    QstandardBUtil.insert(bean);
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
	bigos.append("����");
		
	// �α����� ��� ����
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter(id_chapter);
	logbean.setId_chapter2("-1");
	logbean.setId_chapter3("-1");
	logbean.setId_chapter4("-1");
	logbean.setUserid(userid);
	logbean.setGubun("�Һз����");
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
	alert("���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>