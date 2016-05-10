<%
//******************************************************************************
//   ���α׷� : subj.jsp
//   �� �� �� : ���� ����Ʈ ������
//   ��    �� : �ش� ���� �Ʒ��� ���� ���� ������ ����
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.ComLib, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   �� �� �� : 2013-02-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String subj = request.getParameter("subj");
	if (subj == null) { subj = ""; } else { subj = subj.trim(); }
	
	if (subj.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// ���� ������ ����
	ExamUtilBean[] subjs = null;

    try {
	    subjs = ExamUtil.getSubjBeans(subj);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<select name="id_subject" style="width:300" onChange="get_cpt1_list(this.value);" disabled>
<% if(subjs == null) { %>
	<option value="">�������� ����</a>
<%
	} else {
%>
	<option value="">������ �����ϼ���.</a>
<%
		for(int i=0; i<subjs.length; i++) {
%>
	<option value="<%=subjs[i].getId_q_subject()%>"><%=subjs[i].getQ_subject()%></option>
<%
		}
	}
%>
</select>