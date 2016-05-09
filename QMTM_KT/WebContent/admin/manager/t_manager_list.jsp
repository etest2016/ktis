<%
//******************************************************************************
//   ���α׷� : t_manager_list.jsp
//   �� �� �� : ����� ������ ����Ʈ
//   ��    �� : ����� ������ ����Ʈ ������
//   �� �� �� : t_worker_subj, c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil
//   �� �� �� : 2010-06-10
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// ����� ������ ��� ���������
	ManagerTBean[] rst = null;

	try {
		rst = ManagerTUtil.getBeans(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	
%>

<HTML>
 <HEAD>
  <TITLE> :: [TMan] ��� ���� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script language="JavaScript">
	function insert() {
		window.open("t_manager_insert.jsp?userid=<%=userid%>","insert","top=0, left=0, width=640, height=600, scrollbars=yes");
    }	

	function view(id_course) {
		window.open("t_manager_view.jsp?userid=<%=userid%>&id_course="+id_course,"view","top=0, left=0, width=450, height=380, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="popup2">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">[TMan] ��� ���� <span>������ �ο����� ���� ���</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	
	<div id="contents" style="text-align: center;">
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="bt2"><td colspan="9"><a href="javascript:insert();" onfocus="this.blur();"><img src="../../images/bt_tmanagerlistyj_1.gif"></a></td></tr>
			<tr id="tr">
				<td width="7%">NO</td>
				<td>�����ڵ�</td>
				<td>������</td>
				<td>��������</td>
				<td>�������</td>
				<td>���������</td>
				<td>ä������</td>
				<td>������</td>
				<td>�������</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="9">��ϵǾ��� �������� �����ϴ�.</td>
			</tr>
			
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>

			<tr id="td">
				<td align="center"><%=i+1%></td>
				<td align="center"><a href="javascript:view('<%=rst[i].getId_course()%>');" onfocus="this.blur();"><%=rst[i].getId_course()%></a></td>
				<td align="center"><%=rst[i].getCourse()%></td>
				<td align="center"><%=rst[i].getPt_exam_edit()%></td>
				<td align="center"><%=rst[i].getPt_exam_delete()%></td>
				<td align="center"><%=rst[i].getPt_answer_edit()%></td>
				<td align="center"><%=rst[i].getPt_score_edit()%></td>
				<td align="center"><%=rst[i].getPt_static_edit()%></td>
				<td align="center"><%=rst[i].getRegdate()%></td>
			</tr>
			<%
				   }
				}
			%>
		</table>
	</div>

	<div id="button">
		<img src="../../images/bt_close_1.gif" onclick="javascript:window.close();" onfocus="this.blur();" style="cursor: hand;">
	</div>


		
 </BODY>
</HTML>