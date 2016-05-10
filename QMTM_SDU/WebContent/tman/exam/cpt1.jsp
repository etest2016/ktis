<%
//******************************************************************************
//   ���α׷� : cpt1.jsp
//   �� �� �� : ��� ����Ʈ ������
//   ��    �� : �ش� ���� �Ʒ��� ��� ���� ������ ����
//   �� �� �� : q_chapter
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

	String cpt1 = request.getParameter("cpt1");
	if (cpt1 == null) { cpt1= ""; } else { cpt1 = cpt1.trim(); }
	
	if (cpt1.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// ��� ������ ����
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt1Beans(cpt1);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
&nbsp;&nbsp;<select name="chapter1" style="width:300" disabled>
<% if(cpts == null) { %>
	<option value="">�ܿ����� ����</a>
<%
	} else {
%>
	<option value="">�ܿ��� �����ϼ���.</a>
<%
		for(int i=0; i<cpts.length; i++) {
%>
	<option value="<%=cpts[i].getId_q_chapter()%>"><%=cpts[i].getChapter()%></option>
<%
		}
	}
%>
</select>