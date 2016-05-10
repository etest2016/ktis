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

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }

	// ���� ������ ����
	ExamUtilBean[] subjs = null;

    try {
	    subjs = ExamUtil.getSubjBeans(subj);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
&nbsp;&nbsp;<select name="id_subject" style="width:300" onChange="get_cpt_list(this.value);">
<% if(subjs == null) { %>
	<option value="" <% if(id_subject.equals("")) { %>selected<% } %>>�������� ����</a>
<%
	} else {
%>
	<option value="" <% if(id_subject.equals("")) { %>selected<% } %>>������ �����ϼ���.</a>
<%
		for(int i=0; i<subjs.length; i++) {
%>
	<option value="<%=subjs[i].getId_q_subject()%>" <% if(id_subject.equals(subjs[i].getId_q_subject())) { %>selected<% } %>><%=subjs[i].getQ_subject()%></option>
<%
		}
	}
%>
</select>