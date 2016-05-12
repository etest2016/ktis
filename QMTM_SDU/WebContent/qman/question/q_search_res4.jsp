<%
//******************************************************************************
//   ���α׷� : q_search_res3.jsp
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
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }	

	String id_chapter2 = request.getParameter("id_chapter2");
	if (id_chapter2 == null) { id_chapter2 = ""; } else { id_chapter2 = id_chapter2.trim(); }	

	String id_chapter3 = request.getParameter("id_chapter3");
	if (id_chapter3 == null) { id_chapter3 = ""; } else { id_chapter3 = id_chapter3.trim(); }	

	String id_chapter3 = request.getParameter("id_chapter4");
	if (id_chapter4 == null) { id_chapter4 = ""; } else { id_chapter4 = id_chapter4.trim(); }	

	if (id_subject.length() == 0 || id_chapter.length() == 0 || id_chapter2.length() == 0 || id_chapter3.length() == 0 || id_chapter4.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String qtes = request.getParameter("qte");
	String qtype = request.getParameter("qtype");

	String diff = request.getParameter("diff");
	String difficultys = request.getParameter("difficulty");

	String cnts = request.getParameter("cnts");
	String cnt1 = request.getParameter("cnt1");
	String cnt2 = request.getParameter("cnt2");
	
	String id_qs = request.getParameter("id_qs");
	String id_qs1 = request.getParameter("id_qs1");

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
	bean.setId_qs(id_qs);
	bean.setId_qs1(id_qs1);
	bean.setIncorrects(incorrects);
	bean.setIncorrect1(incorrect1);

	// ���� �˻�
	QSearchListBean[] rst = null;

	try {
		rst = QSearch.getSearchBeans(bean, id_subject, id_chapter, id_chapter2, id_chapter3, id_chapter4, userid);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

	<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tableA">
		<tr id="tr3">			
			<td width="90">�����ڵ�</td>
			<td width="90">��������</td>
			<td width="90">���̵�</td>
			<td width="90">����Ƚ��</td>
			<td>����</td>
		</tr>
		<% if(rst == null) { %>
		<tr bgcolor="#FFFFFF" height="40">
			<td colspan="7" align="center"  class="blank">�˻��Ǿ��� ������ �����ϴ�.</td>
		</tr>
		<%
			} else {
				for(int i=0; i<rst.length; i++) {
					
		%>

		<tr id="td" onClick="dbl_selects('<%=rst[i].getId_qs()%>', '<%=rst[i].getId_subject()%>');">
			<td align="center"><%=rst[i].getId_qs()%></td>
			<td align="center"><%=rst[i].getQtypes()%></td>
			<td align="center"><%=rst[i].getDifficulty()%></td>			
			<td align="center"><%=rst[i].getMake_cnt()%></td>
			<td id="q_view"><%=rst[i].getQs()%></td>
		</tr>
		<%
				}
			}
		%>
	</table>