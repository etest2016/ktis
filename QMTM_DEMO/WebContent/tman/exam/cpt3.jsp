<%
//******************************************************************************
//   ���α׷� : cpt3.jsp
//   �� �� �� : �ܿ�3 ����Ʈ ������
//   ��    �� : �ش� �ܿ�2 �Ʒ��� �ܿ� 3 ���� ������ ����
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

	String cpt3 = request.getParameter("cpt3");

	// �ܿ� 3 ���� ������ ����
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt3Beans(cpt3);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
&nbsp;&nbsp;<select name="chapter3" style="width:300" disabled onChange="get_cpt4_list(this.value);">
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