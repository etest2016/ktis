<%
//******************************************************************************
//   ���α׷� : cpt2.jsp
//   �� �� �� : �ܿ�2 ����Ʈ ������
//   ��    �� : �ش� �ܿ�1 �Ʒ��� �ܿ� 2 ���� ������ ����
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

	String cpt2 = request.getParameter("cpt2");

	// �ܿ� 2 ���� ������ ����
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt2Beans(cpt2);
    } catch(Exception ex) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
    }
%>
&nbsp;&nbsp;<select name="chapter2" style="width:300" disabled onChange="get_cpt3_list(this.value);">
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