<%
//******************************************************************************
//   ���α׷� : subject_update.jsp
//   �� �� �� : ���� ����
//   ��    �� : ������� �������� �����ϱ�
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course"); // ���� ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // ���� ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    String subject = request.getParameter("subject"); // �����
	String yn_valid = request.getParameter("yn_valid"); // ��������
	
	// �������� ����
    try {
	    SubjectTmanUtil.update(id_course, id_subject, subject, yn_valid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">	
	opener.parent.frames['fraLeft'].location.reload();
	alert("�ܿ��� ���������� �����Ǿ����ϴ�.");
	opener.parent.frames['fraLeft'].oc('<%=id_course%>',0,'C1');
	window.close();
</script>