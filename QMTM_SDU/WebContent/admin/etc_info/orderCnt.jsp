<%
//******************************************************************************
//   ���α׷� : orderCnt.jsp
//   �� �� �� : ���ļ��� SelectBox
//   ��    �� : ���ļ��� ���� ��������
//   �� �� �� : c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_midcategory = request.getParameter("id_midcategory");

	// �ҿ����� ���� ���� ���ļ���
	int order_cnt = 0;

	try {
		order_cnt = CourseKindUtil.getOrderCnt(id_midcategory);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<select name="orders">
	<option value="">����</option>
<% for(int i = 1; i <= 15; i++) { %>	
	<option value="<%=i%>" <%if(order_cnt == i) {%>selected<% } %>><%=i%></option>
<% } %>