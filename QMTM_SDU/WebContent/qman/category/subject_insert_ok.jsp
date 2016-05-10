<%
//******************************************************************************
//   ���α׷� : subject_insert_ok.jsp
//   �� �� �� : ���� ���
//   ��    �� : �������� ���� ����ϱ�
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.SubjectBean, 
//              qmtm.qman.category.SubjectUtil, java.util.Calendar
//   �� �� �� : 2013-02-05
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.CommonUtil, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil, java.util.Calendar " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
    
	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String subject = request.getParameter("q_subject");
	if (subject == null) { subject= ""; } else { subject = subject.trim(); }

	if (subject.length() == 0 || id_course.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	
	String subject_order = request.getParameter("subject_order");
	if (subject_order == null) { subject_order = ""; } else { subject_order = subject_order.trim(); }

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);

	String years = String.valueOf(year);
 	
	String id_subject = CommonUtil.getMakeID("S1");

	SubjectBean bean = new SubjectBean();

	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setYears(years);
	bean.setSubject_order(Integer.parseInt(subject_order));

    // ������
	try {
	    SubjectUtil.insert(bean);
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
	bigos.append("����");

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
	logbean.setGubun("������");
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
	opener.parent.fraLeft.location.reload(); 
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>