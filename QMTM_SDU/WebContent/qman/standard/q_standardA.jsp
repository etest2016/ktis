<%
//******************************************************************************
//   ���α׷� : q_standardA.jsp
//   �� �� �� : ��з� ����
//   ��    �� : ��з� ��� �� �߰�,����,����
//   �� �� �� : q_standard_a, t_worker_subj
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameBean, qmtm.common.NameUtil, 
//              qmtm.LoginProcBean, qmtm.LoginProc, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� :
//   �� �� �� :
//	 �������� :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, qmtm.common.NameBean, qmtm.common.NameUtil, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil" %>
<%@ include file = "/common/login_chk.jsp" %>     
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	String usergrade = (String)session.getAttribute("usergrade"); // ����
	
	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	String id_q_chapter = request.getParameter("id_q_chapter"); 
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_subject.length() == 0 || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
    NameBean names = null;

	try {
		names = NameUtil.getChapter1(id_q_chapter);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	// ����� ���� üũ	
	String pt_q_edit = "";
	String pt_q_delete = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getExam_work(names.getId_course(), userid, usergrade);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	pt_q_edit = bean.getPt_q_edit();
	pt_q_delete = bean.getPt_q_delete();
	
	// ��з� ����Ʈ ��������

	QstandardABean[] rst = null;

    try {
	    rst = QstandardAUtil.getBeans(id_q_chapter);
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
		$.posterPopup("q_standarda_insert.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>","insert","width=400, height=200, scrollbars=no, top="+(screen.height-200)/2+", left="+(screen.width-400)/2);
    }

	function edits(id_standarda) {
		$.posterPopup("q_standarda_edit.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_standarda="+id_standarda,"edits","width=400, height=240, scrollbars=no, top="+(screen.height-240)/2+", left="+(screen.width-400)/2);
    }

	function dels(id_standarda) {
		var str = confirm("**********************����**********************\n\n��з� �����ڵ带 ���� �����Ͻðڽ��ϱ�?");

		if(str) {
			$.posterPopup("q_standarda_delete.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_standarda="+id_standarda,"dels","width=1, height=1, scrollbars=no, top="+(screen.height-1)/2+", left="+(screen.width-1)/2);
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
			<tr id="bt"><Td colspan="7"><input type="button" value="��з� ���ص��" class="form6" onClick="insert();">&nbsp;&nbsp;<b>��з����� Ŭ���ϸ� �Һз� ������ ����� �� �ֽ��ϴ�.</b></td></tr>
			<tr id="tr">
				<td width="5%">NO</td>
				<td width="15%">��з��ڵ�</td>
				<td>��з���</td>
				<td width="15%">��������</td>
				<td width="15%">�������</td>
				<td width="15%">����</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="6">��ϵǾ��� ��з� ������ �����ϴ�.</td>
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
				<td><%=rst[i].getId_standarda()%></td> 
				<td><a href="q_standardB.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>&id_standarda=<%=rst[i].getId_standarda()%>"><%=rst[i].getStandarda()%></a></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getRegdate()%></td>
				<td><input type="button" value="�����ϱ�" class="form" onClick="edits('<%=rst[i].getId_standarda()%>');">&nbsp;&nbsp;<input type="button" value="�����ϱ�" class="form" onClick="dels('<%=rst[i].getId_standarda()%>');"></td>
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