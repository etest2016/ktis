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

	// �Һз� ����Ʈ ��������

	QstandardBBean[] rst = null;

    try {
	    rst = QstandardBUtil.getSelectBeans(id_standarda);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<select name="q_tos" style="width:255" disabled>
<% if(rst == null) { %>
<option value="">��� �Һз� ����</a>
<%
	} else {
%>
	<option value="">�Һз��� �����ϼ���.</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_standardb()%>"><%=rst[i].getStandardb()%></option>
<%
		}
	}
%>
</select>