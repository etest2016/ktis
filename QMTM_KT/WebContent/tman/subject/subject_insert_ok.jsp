<%
//******************************************************************************
//   ���α׷� : subject_insert_ok.jsp
//   �� �� �� : ���� ���
//   ��    �� : ������� ���� ����ϱ�
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String subject = request.getParameter("subject");

	String id_subject = CommonUtil.getMakeID("S1");

	SubjectTmanBean bean = new SubjectTmanBean();

	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(1);
	bean.setYn_valid("Y");

    // ������
	try {
	    SubjectTmanUtil.insert(bean);
    } catch(Exception ex) {
	    //out.println(ComLib.getExceptionMsg(ex, "back"));
		out.println(ex.getMessage());

	    if(true) return;
    }
%>

<script language="javascript">	
	opener.parent.frames['fraLeft'].location.reload();
	alert("�ܿ��� ���������� ��ϵǾ����ϴ�.");
	opener.parent.frames['fraLeft'].oc('<%=id_course%>',0,'C1');
	window.close();
</script>