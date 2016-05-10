<%
//******************************************************************************
//   ���α׷� : subject_update.jsp
//   �� �� �� : ���� �����Ϸ�
//   ��    �� : ���� �����Ϸ� ������
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.ComLib, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject"); // ���� �ڵ�
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }

	if (id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    String userid = (String)session.getAttribute("userid");
	
	String subject = request.getParameter("q_subject"); // �����
	String yn_valid = request.getParameter("yn_valid"); 
	String subject_order = request.getParameter("subject_order"); // ���ļ���

	SubjectBean bean = new SubjectBean();

	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setYn_valid(yn_valid);
	bean.setSubject_order(Integer.parseInt(subject_order));
	
	// ���� ����
    try {
	    SubjectUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));		

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();
	
	bigos.append("�����ڵ� : ");
	bigos.append(id_subject);

	bigos.append(", ����� : ");
	bigos.append(subject);
	
	bigos.append(", �������� : ");
	if(yn_valid.equals("Y")) {
		bigos.append("����");
	} else {
		bigos.append("�����");
	}

	bigos.append(", ���ļ��� : ");
	bigos.append(subject_order);

	// �α����� ��� ����
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter("0");
	logbean.setId_chapter2("-1");
	logbean.setId_chapter3("-1");
	logbean.setId_chapter4("-1");
	logbean.setUserid(userid);
	logbean.setGubun("�������");
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
	opener.parent.fraLeft.location.reload(); 
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>