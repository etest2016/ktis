<%
//******************************************************************************
//   ���α׷� : q_list.jsp
//   �� �� �� : �������� ����ڸ���Ʈ
//   ��    �� : �������� ����ڸ���Ʈ ������
//   �� �� �� : q_worker_subj, q_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>    

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // �������� ����ڸ�� ���������
	ManagerBean[] rst = null;

	try {
		rst = ManagerUtil.getQMgrBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">
	function insert() {
		window.open("manager_insert.jsp","insert","top=0, left=0, width=500, height=370, scrollbars=no");
    }

	function view(userid) {
		window.open("manager_view.jsp?userid="+userid,"view","top=0, left=0, width=500, height=370, scrollbars=no");
    }

	function q_list(userid) {
		window.open("q_manager_list.jsp?userid="+userid,"q_list","top=0, left=0, width=800, height=570, scrollbars=yes");
	}	
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">
		
		<div id="mainTop">
			<div class="title">�������� ����� ����Ʈ</div>
			<div class="location">ADMIN > ����ڰ��� > <span>�������� �����</span></div>
		</div>

	<table border="0"cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt"><!--<Td colspan="6"><a href="javascript:insert();"><img src="../../images/bt_aqman_newworker.gif"></a></td>--></tr>

		<tr id="tr">
			<td width="7%">NO</td>
			<td align="left">���̵�</td>
			<td align="left">����</td>
			<td>��ȿ����</td>
			<td>�������</td>
			<td width="120">&nbsp;</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="6">��ϵǾ��� ����ڰ� �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
				   String yn_use = rst[i].getYn_valid();

				   if(yn_use.equalsIgnoreCase("Y")) {
					   yn_use = "����";
				   } else {
					   yn_use = "�Ұ���";
				   }
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getUserid()%>');"><%=rst[i].getUserid()%></a></div><div style="float: left; margin-top: 1px; margin-left: 3px;"><img src="../../images/info2.gif"></div></td>
			<td align="left"><%=rst[i].getName()%></td>
			<td><%=yn_use%></td>
			<td><%=rst[i].getRegdate()%></td>
			<td><a href="javascript:q_list('<%=rst[i].getUserid()%>');"><img src="../../images/bt3_qman_mn.gif"></a></td>
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