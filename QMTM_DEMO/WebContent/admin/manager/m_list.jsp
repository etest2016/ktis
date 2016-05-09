<%
//******************************************************************************
//   ���α׷� : m_list.jsp
//   �� �� �� : ��ü ����ڸ���Ʈ
//   ��    �� : ��ü ����ڸ���Ʈ ������
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil 
//   �� �� �� : 2010-06-09
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


    // ��ü ����ڸ�� ���������
	ManagerBean[] rst = null;

	try {
		rst = ManagerUtil.getBeans();
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
		window.open("q_manager_list.jsp?userid="+userid,"q_list","top=0, left=0, width=900, height=570, scrollbars=yes");
	}

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">����� ����<span>: ����� �߰�, ���� �� ���� ����</span></div>
			<div class="location">ADMIN > <span>����� ����</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="7"><a href="javascript:insert();" onfocus="this.blur();"><img src="../../images/bt_a_newworker.gif"></a></td></tr>
			<tr id="tr">
				<td width="6%">NO</td>
				<td align="left" width="15%">���̵�</td>
				<td align="left" width="15%">����</td>
				<td>����ڼҼ�</td>
				<td width="10%">��ȿ����</td>
				<td width="15%">�������</td>
				<td width="10%">������ȸ</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="7">��ϵǾ��� ����ڰ� �����ϴ�.</td>
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
				<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getUserid()%>');" onfocus="this.blur();"><%=rst[i].getUserid()%></a></div><div style="float: left; margin-top: 1px; margin-left: 3px;"><img src="../../images/info2.gif"></div></td>
				<td align="left"><%=rst[i].getName()%></td>
				<td align="left">&nbsp;<%=ComLib.nullChk(rst[i].getContent1())%></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getRegdate()%></td>
				<td><input type="button" value="������ ���ѵ��" class="form5" onClick="q_list('<%=rst[i].getUserid()%>');"></td>
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