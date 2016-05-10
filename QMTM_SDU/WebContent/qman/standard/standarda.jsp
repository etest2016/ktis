<%
//******************************************************************************
//   ���α׷� : standarda.jsp
//   �� �� �� : ��з� SelectBox
//   ��    �� : ��� �Ʒ��� ��з� ���� ������ ����
//   �� �� �� : q_standard_a
//   �ڹ����� : qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_chapter = request.getParameter("id_chapter");

	String selects = request.getParameter("selects");

	// ��з� ����Ʈ ��������

	QstandardABean[] rst = null;

    try {
	    rst = QstandardAUtil.getSelectBeans(id_chapter);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<select name="q_ks" style="width:300" onChange="get_standardb_list(this.value);">
<% if(rst == null) { %>
	<option value="" <%if(selects.equals("")) {%>selected<%}%>>��� ��з� ����</a>
<%
	} else {
%>
	<option value=" " <%if(selects.equals("")) {%>selected<%}%>>��з��� �����ϼ���</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_standarda()%>" <%if(selects.equals(rst[i].getId_standarda())) {%>selected<%}%>><%=rst[i].getStandarda()%></option>
<%
		}
	}
%>
</select>