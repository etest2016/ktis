<%
//******************************************************************************
//   ���α׷� : q_search_res.jsp
//   �� �� �� : ���� �˻� ���
//   ��    �� : ���� �˻� ����� �����ش�.
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2008-04-16
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 2008-07-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String qtes = request.getParameter("qte");
	String qtype = request.getParameter("qtype");

	String diff = request.getParameter("diff");
	String difficultys = request.getParameter("difficulty");

	String cnts = request.getParameter("cnts");
	String cnt1 = request.getParameter("cnt1");
	String cnt2 = request.getParameter("cnt2");

	String managers = request.getParameter("managers");
	String manager1 = request.getParameter("manager1");

	String id_qs = request.getParameter("id_qs");
	String id_qs1 = request.getParameter("id_qs1");

	String updates = request.getParameter("updates");
	String update1 = request.getParameter("update1");
	String update2 = request.getParameter("update2");

	String incorrects = request.getParameter("incorrects");
	String incorrect1 = request.getParameter("incorrect1");

	QSearchBean bean = new QSearchBean();

	bean.setQtes(qtes);
	bean.setQtypes(qtype);
	bean.setDiffs(diff);
	bean.setDifficultys(difficultys);
	bean.setCnts(cnts);
	bean.setCnt1(cnt1);
	bean.setCnt2(cnt2);
	bean.setManagers(managers);
	bean.setManager1(manager1);

	bean.setId_qs(id_qs);
	bean.setId_qs1(id_qs1);

	bean.setUpdates(updates);
	bean.setUpdate1(update1);
	bean.setUpdate2(update2);

	bean.setIncorrects(incorrects);
	bean.setIncorrect1(incorrect1);

	// ���� �˻�
	QSearchListBean[] rst = null;

	try {
		rst = QSearch.getSearchBeans(bean);
	} catch(Exception ex) {
	    out.println(ex.getMessage());
	}
%>

	<table border="0" width="100%" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
		<tr bgcolor="#DDDDDD" height="30" align="center">
			<td>�����ڵ�</td>
			<td>��������</td>
			<td>��������</td>
			<td>����</td>
		</tr>
		<% if(rst == null) { %>
		<tr bgcolor="#FFFFFF" height="40">
			<td colspan="4" align="center">�˻��Ǿ��� ������ �����ϴ�.</td>
		</tr>

		<%
			} else {
				for(int i=0; i<rst.length; i++) {
		%>

		<tr bgcolor="#FFFFFF" height="25">
			<td><%=rst[i].getId_qs()%></td>
			<td><%=rst[i].getQtypes()%></td>
			<td><%=rst[i].getRefs()%></td>
			<td><%=rst[i].getQs()%></td>
		</tr>

		<%
				}
			}
		%>
	</table>