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

    String param_exam_kind = request.getParameter("id_exam_kind"); // �׷챸�� �ڵ�
	if (param_exam_kind == null) { param_exam_kind= ""; } else { param_exam_kind = param_exam_kind.trim(); }

	if (param_exam_kind.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	int id_exam_kind = Integer.parseInt(param_exam_kind);

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

<script type="text/javascript">
	alert("���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>