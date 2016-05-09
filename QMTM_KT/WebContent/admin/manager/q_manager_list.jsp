<%
//******************************************************************************
//   ���α׷� : q_manager_list.jsp
//   �� �� �� : ����� ������ ����Ʈ
//   ��    �� : ����� ������ ����Ʈ ������
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerQBean, qmtm.admin.manager.ManagerQUtil 
//   �� �� �� : 2010-06-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerQBean, qmtm.admin.manager.ManagerSubjBean, qmtm.admin.manager.ManagerSubjUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// ����� ������ ��� ����������
	ManagerSubjBean[] rst = null;

	try {
		rst = ManagerSubjUtil.getBeans(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}	
%>

<HTML>
 <HEAD>
  <TITLE> :: ��� ���� ����Ʈ :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script language="JavaScript">
	function insert() {
		window.open("q_manager_insert.jsp?userid=<%=userid%>","insert","width=1050, height=600, toolbar=no, menubar=no, location=no, scrollbars=yes, status=no, resizable=no, left=0, top=0");
    }	

	function view(id_subject) {
		window.open("q_manager_view.jsp?userid=<%=userid%>&id_course="+id_subject,"view","width=450, height=400, toolbar=no, menubar=no, location=no, scrollbars=auto, status=yes, resizable=no, fullscree=no, left=0, top=0");
    }
 </script>

 </HEAD>

 <BODY id="popup2">   

   <div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">��� ���� ����Ʈ<span>������ �ο����� ���� ���</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="bt2"><td colspan="11"><a href="javascript:insert();" onfocus="this.blur();"><img src="../../images/bt_qmanagerlistyj_1.gif"></a></td></tr>
			<tr id="tr">
				<td width="7%">NO</td>
				<td>������</td>
				<td>��������</td>
				<td>��������</td>
				<td>��������</td>
				<td>�������</td>
				<td>���������</td>
				<td>ä������</td>
				<td>������</td>
				<td>�������</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="10">��ϵǾ��� �������� �����ϴ�.</td>
			</tr>
			
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
					   
					   ManagerQBean rst2 = null;

					   try {
						   rst2 = ManagerSubjUtil.getQBean(userid, rst[i].getId_course());
					   } catch(Exception ex) {
						    out.println(ComLib.getExceptionMsg(ex, "close"));

						    if(true) return;
					   }

			%>

			<tr id="td">
				<td align="center"><%=i+1%></td>
				<td align="center"><a href="javascript:view('<%=rst[i].getId_course()%>');" onfocus="this.blur();"><%=rst[i].getCourse()%></a></td>
				<td align="center"><%=rst2.getPt_q_edit()%></td>
				<td align="center"><%=rst2.getPt_q_delete()%></td>
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