<%
//******************************************************************************
//   ���α׷� : exam_kind_insert_ok.jsp
//   �� �� �� : �׷챸�� ���
//   ��    �� : �׷챸�� ����ϱ�
//   �� �� �� : r_exam_kind
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil
//   �� �� �� : 2008-04-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_exam_kind = request.getParameter("id_exam_kind");
	if (id_exam_kind == null) { id_exam_kind= ""; } else { id_exam_kind = id_exam_kind.trim(); }

	if (id_exam_kind.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String exam_kind = request.getParameter("exam_kind");
	String rmk = request.getParameter("rmk");

	ExamKindBean bean = new ExamKindBean();

	bean.setId_exam_kind(id_exam_kind);
	bean.setExam_kind(exam_kind);
	bean.setRmk(rmk);

    // �׷챸�е��
	try {
	    ExamKindUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>