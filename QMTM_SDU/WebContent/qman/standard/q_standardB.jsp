<%
//******************************************************************************
//   ���α׷� : q_standardB.jsp
//   �� �� �� : �Һз� ����
//   ��    �� : �Һз� ��� �� �߰�,����,����
//   �� �� �� : q_standard_b, t_worker_subj
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� :
//   �� �� �� :
//	 �������� :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil" %>
<%@ include file = "/common/login_chk.jsp" %>     
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	String usergrade = (String)session.getAttribute("usergrade"); // ����

	String id_standarda = request.getParameter("id_standarda");
	if (id_standarda == null) { id_standarda = ""; } else { id_standarda = id_standarda.trim(); }	

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_standarda.length() == 0 || id_q_subject.length() == 0 || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	    
	// �Һз� ����Ʈ ��������

	QstandardBBean[] rst = null;

    try {
	    rst = QstandardBUtil.getBeans(id_standarda);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<HTML>
 <HEAD>
  <TITLE> QMAN ���� ���� ���� </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../../js/tablesort.js"></script>
  <SCRIPT LANGUAGE="JavaScript" src="../../js/Script.js"></Script>

  <script language="JavaScript">

	function insert() {
		$.posterPopup("q_standardb_insert.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_standarda=<%=id_standarda%>","insert","width=400, height=200, scrollbars=no, top="+(screen.height-200)/2+", left="+(screen.width-400)/2);
    }

	function edits(id_standardb) {
		$.posterPopup("q_standardb_edit.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_standarda=<%=id_standarda%>&id_standardb="+id_standardb,"edits","width=400, height=240, scrollbars=no, top="+(screen.height-240)/2+", left="+(screen.width-400)/2);
    }

	function dels(id_standardb) {
		var str = confirm("**********************����**********************\n\n�Һз� �����ڵ带 ���� �����Ͻðڽ��ϱ�?");

		if(str) {
			$.posterPopup("q_standardb_delete.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_standarda=<%=id_standarda%>&id_standardb="+id_standardb,"dels","width=1, height=1, scrollbars=no, top="+(screen.height-1)/2+", left="+(screen.width-1)/2);
		}
    }

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">�������� ����<span>: ��з�, �Һз� �����ڵ� ��ϰ���</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="7"><input type="button" value="�Һз� ���ص��" class="form6" onClick="insert();"></td></tr>
			<tr id="tr">
				<td width="5%">NO</td>
				<td width="12%">��з��ڵ�</td>
				<td width="12%">�Һз��ڵ�</td>
				<td>�Һз���</td>
				<td width="15%">��������</td>
				<td width="15%">�������</td>
				<td width="15%">����</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="7">��ϵǾ��� �Һз� ������ �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
					   String yn_use = rst[i].getYn_valid();

					   if(yn_use.equalsIgnoreCase("Y")) {
						   yn_use = "����";
					   } else {
						   yn_use = "�����";
					   }
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<td><%=id_standarda%></td>
				<td><%=rst[i].getId_standardb()%></td>
				<td><%=rst[i].getStandardb()%></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getRegdate()%></td>
				<td><input type="button" value="�����ϱ�" class="form" onClick="edits('<%=rst[i].getId_standardb()%>');">&nbsp;&nbsp;<input type="button" value="�����ϱ�" class="form" onClick="dels('<%=rst[i].getId_standardb()%>');"></td>
			</tr>
			<%
				   }
				}
			%>
		</table>

	</div>

	<jsp:include page="../../copyright.jsp"/>

		
 </BODY>
</HTML>