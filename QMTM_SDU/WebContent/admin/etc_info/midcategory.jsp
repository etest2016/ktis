<%
//******************************************************************************
//   ���α׷� : midcategory.jsp
//   �� �� �� : �ҿ��� SelectBox
//   ��    �� : �뿵�� �Ʒ��� �ҿ��� ���� ������ ����
//   �� �� �� : c_midcategory
//   �ڹ����� : qmtm.ComLib, qmtm.TreeMgrUtil, qmtm.TreeMgrBean
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.TreeMgrUtil, qmtm.TreeMgrBean" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	String id_midcategory = request.getParameter("id_midcategory");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// �ҿ������ ���������
	TreeMgrBean[] rst = null;

	try {
		rst = TreeMgrUtil.getCategory(id_category, "orders");
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>
<select name="id_midcategory" style="width:200" onChange="get_order_list(this.value);">
<% if(rst == null) { %>
	<option value="">��� �ҿ��� ����</a>
<%
	} else {
%>
	<option value="">�ҿ����� �����ϼ���</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_midcategory()%>" <% if(id_midcategory.equals(rst[i].getId_midcategory())) { %>selected<% } %>><%=rst[i].getMidcategory()%></option>
<%
		}
	}
%>
</select>