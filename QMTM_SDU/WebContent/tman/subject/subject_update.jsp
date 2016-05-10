<%
//******************************************************************************
//   ���α׷� : subject_update.jsp
//   �� �� �� : ���� ����
//   ��    �� : ������� �������� �����ϱ�
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, 
//              qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog 
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course"); // ���� ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_subject = request.getParameter("id_subject"); // ���� ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    String subject = request.getParameter("subject"); // �����
	String yn_valid = request.getParameter("yn_valid"); // ��������
	String subject_order = request.getParameter("subject_order"); // ���ļ���
	String open_year = request.getParameter("open_year");
	String open_month = request.getParameter("open_month");

	SubjectTmanBean bean = new SubjectTmanBean();

	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(Integer.parseInt(subject_order));
	bean.setYn_valid(yn_valid);
	bean.setOpen_year(open_year);
	bean.setOpen_month(open_month);

	// �������� ����
    try {
	    SubjectTmanUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("�����ڵ� : ");
	bigos.append(id_course);
	bigos.append(", �����ڵ� : ");
	bigos.append(id_subject);
	bigos.append(", ���¸� : ");
	bigos.append(subject);
	bigos.append(", ���ļ��� : ");
	bigos.append(subject_order);
	bigos.append(", ��ȿ���� : ");
	bigos.append(yn_valid);
	bigos.append(", �������ۿ��� : ");
	bigos.append(open_year);
	bigos.append(", �������ۿ� : ");
	bigos.append(open_month);

	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam("���¼���");	
	logbean.setUserid(userid);
	logbean.setGubun("���¼���");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
	    out.println(ex.getMessage());

	    if(true) return;
    }
%>

<script language="javascript">
	alert("���������� �����Ǿ����ϴ�.");
	opener.parent.fraLeft.location.reload();
	opener.parent.fraMain.location.reload();
	window.close();
</script>