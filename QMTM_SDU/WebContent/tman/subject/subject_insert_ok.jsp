<%
//******************************************************************************
//   ���α׷� : subject_insert_ok.jsp
//   �� �� �� : ���� ���
//   ��    �� : ������� ���� ����ϱ�
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, 
//              qmtm.admin.tman.SubjectTmanUtil, qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog
//   �� �� �� : 2013-02-12
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

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String subject = request.getParameter("subject");

	String id_subject = CommonUtil.getMakeID("S1");

	String subject_order = request.getParameter("subject_order");

	String open_year = request.getParameter("open_year");
	String open_month = request.getParameter("open_month");

	SubjectTmanBean bean = new SubjectTmanBean();

	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(Integer.parseInt(subject_order));
	bean.setYn_valid("Y");
	bean.setOpen_year(open_year);
	bean.setOpen_month(open_month);

    // ���µ��
	try {
	    SubjectTmanUtil.insert(bean);
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
	bigos.append("Y");
	bigos.append(", �������ۿ��� : ");
	bigos.append(open_year);
	bigos.append(", �������ۿ� : ");
	bigos.append(open_month);

	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam("���µ��");	
	logbean.setUserid(userid);
	logbean.setGubun("���µ��");
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
	opener.parent.fraLeft.location.reload();
	opener.parent.fraMain.location.reload();
	alert("���������� ��ϵǾ����ϴ�.");	
	window.close();
</script>