<%
//******************************************************************************
//   ���α׷� : standard.jsp
//   �� �� �� : �Һз� SelectBox
//   ��    �� : ��з� �Ʒ��� �Һз� ���� ������ ����
//   �� �� �� : q_standard_b
//   �ڹ����� : qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_standarda = request.getParameter("id_standarda");

	String selects = request.getParameter("selects");

	// �Һз� ����Ʈ ��������

	QstandardBBean[] rst = null;

    try {
	    rst = QstandardBUtil.getSelectBeans(id_standarda);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<select name="q_to" style="width:300">
<% if(rst == null) { %>
	<option value="" <%if(selects.equals("")) {%>selected<%}%>>��� �Һз� ����</a>
<%
	} else {
%>
	<option value=" " <%if(selects.equals("")) {%>selected<%}%>>�Һз��� �����ϼ���</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_standardb()%>" <%if(selects.equals(rst[i].getId_standardb())) {%>selected<%}%>><%=rst[i].getStandardb()%></option>
<%
		}
	}
%>
</select>