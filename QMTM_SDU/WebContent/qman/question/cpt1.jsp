<%
//******************************************************************************
//   ���α׷� : cpt1.jsp
//   �� �� �� : ���1 ����Ʈ ������
//   ��    �� : �ش� ���� �Ʒ��� ��� 1 ���� ������ ����
//   �� �� �� : q_chapter
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String cpt1 = request.getParameter("cpt1");

	// �ܿ� 1 ������ ����
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt1Beans(cpt1);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>
<select name="chapter1" style="width:300" disabled >
<% if(cpts == null) { %>
	<option value=""></a>
<% 
	} else {
%>
	<option value="">�ܿ��� �����ϼ���</option>
<%
		for(int i=0; i<cpts.length; i++) {
%>
	<option value="<%=cpts[i].getId_q_chapter()%>"><%=cpts[i].getChapter()%></option>
<%
		}
	}
%>
</select>