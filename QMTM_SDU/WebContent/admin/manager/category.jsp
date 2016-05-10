<%
//******************************************************************************
//   ���α׷� : category.jsp
//   �� �� �� : �ҿ��� SelectBox
//   ��    �� : �뿵�� �Ʒ��� �ҿ��� ���� ������ ����
//   �� �� �� : c_midcategory
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil
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
	String mid_category = request.getParameter("mid_category");
	if (mid_category == null) { mid_category = ""; } else { mid_category = mid_category.trim(); }

	// �ҿ������ ���������
	TreeMgrBean[] rst = null;

	try {
		rst = TreeMgrUtil.getCategory(id_category, "orders");
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>
<select name="mid_category" style="width:200">
<% if(rst == null) { %>
	<option value="">��� �ҿ��� ����</a>
<%
	} else {
%>
	<option value="">�ҿ����� �����ϼ���</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_midcategory()%>" <%if(mid_category.equals(rst[i].getId_midcategory())) {%> selected <% } %>><%=rst[i].getMidcategory()%></option>
<%
		}
	}
%>
</select>