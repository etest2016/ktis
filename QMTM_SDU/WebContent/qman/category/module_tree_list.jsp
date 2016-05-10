<%
//******************************************************************************
//   ���α׷� : module_tree_list.jsp
//   �� �� �� : ��� ���
//   ��    �� : ��� ��� �� �߰�,����,����
//   �� �� �� : q_module, t_worker_subj
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameUtil, qmtm.common.NameBean,
//              qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� :
//   �� �� �� :
//	 �������� :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameUtil, qmtm.common.NameBean, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil" %>
<%@ include file = "/common/login_chk.jsp" %>     
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// ���� Depth ��������
	NameBean names = null;

	try {
		names = NameUtil.getModule(id_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	   
	// ��� ����Ʈ ��������
	ModuleBean[] rst = null;

    try {
	    rst = ModuleUtil.getBeans(id_subject);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<HTML>
 <HEAD>
  <TITLE> QMAN �ܿ� ���� ���� </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../../js/tablesort.js"></script>
  <SCRIPT LANGUAGE="JavaScript" src="../../js/Script.js"></Script>

  <script language="JavaScript">

	function insert() {
		$.posterPopup('module_insert.jsp?id_subject=<%=id_subject%>','insert','width=350, height=250, scrollbars=no, top='+(screen.height-250)/2+', left='+(screen.width-350)/2);
    }

	function edits(id_module) {
		$.posterPopup('module_edit.jsp?id_subject=<%=id_subject%>&id_module='+id_module,'edits','width=350, height=280, scrollbars=no, top='+(screen.height-280)/2+', left='+(screen.width-350)/2);
    }
	function dels(id_module) {
		var str = confirm("**********************����**********************\n\n�ܿ� ������ ���� �����Ͻðڽ��ϱ�?");

		if(str) {
			$.posterPopup('module_delete.jsp?id_subject=<%=id_subject%>&id_module='+id_module,'dels','width=1, height=1, scrollbars=no, top='+(screen.height-1)/2+', left='+(screen.width-1)/2);
		}
    }

	function q_search() {
	   location.href = "../question/q_c_list.jsp?id_q_subject=<%=names.getId_course()%>&id_q_chapter=0";
    }

	function q_standard() {
	   location.href = "subject_list.jsp?id_course=<%=names.getId_course()%>";
    }

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
				
		<div id="mainTop">
			<div class="title">�ܿ� ����<span>: �ܿ��� ��� �� ���� ���� �� �� �ֽ��ϴ�.</span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../../images/icon_location.gif"> <%=names.getCourse()%> > <%=names.getSubject()%></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="7"><input type="button" value="�ܿ����" class="form6" onClick="insert();">&nbsp;&nbsp;<b>�ܿ����� Ŭ���ϸ� �ش� �ܿ��� ��ϵ� ��������Ʈ�� Ȯ���� �� �ֽ��ϴ�.</b></td></tr>
			<tr id="tr">
				<td width="4%">NO</td>
				<td width="15%">�ܿ��ڵ�</td>
				<td>�ܿ���</td>
				<td width="12%">��������</td>
				<td width="12%">���ļ���</td>
				<td width="12%">�������</td>
				<td width="15%">����</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="7">��ϵǾ��� �ܿ� ����Ʈ�� �����ϴ�.</td>
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
				<td><%=rst[i].getId_chapter()%></td>
				<td><a href="../question/q_list1.jsp?id_q_subject=<%=id_subject%>&id_q_chapter=<%=rst[i].getId_chapter()%>"><%=rst[i].getChapter()%></a></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getChapter_order()%></td>
				<td><%=rst[i].getRegdate()%></td>
				<td><input type="button" value="�����ϱ�" class="form" onClick="edits('<%=rst[i].getId_chapter()%>');">&nbsp;&nbsp;<input type="button" value="�����ϱ�" class="form" onClick="dels('<%=rst[i].getId_chapter()%>');"></td>
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