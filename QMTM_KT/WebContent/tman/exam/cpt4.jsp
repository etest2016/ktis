<%
//******************************************************************************
//   ���α׷� : cpt4.jsp
//   �� �� �� : �ܿ�4 ����Ʈ ������
//   ��    �� : �ش� �ܿ�3 �Ʒ��� �ܿ� 4 ���� ������ ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.exam.ExamUtil
//   �� �� �� : 2008-04-22
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String cpt4 = request.getParameter("cpt4");

	// �ܿ� 4 ���� ������ ����
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt4Beans(cpt4);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
&nbsp;&nbsp;<select name="chapter4" style="width:300" disabled>
<% if(cpts == null) { %>
	<option value="">�ܿ����� ����</a>
<% 
	} else { 
%>
	<option value="">�����ϼ���.</a>
<%
		for(int i=0; i<cpts.length; i++) { 
%>
	<option value="<%=cpts[i].getId_q_chapter()%>"><%=cpts[i].getChapter()%></option>
<% 
		}
	} 
%>
</select>