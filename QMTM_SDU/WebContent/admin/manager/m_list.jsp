<%
//******************************************************************************
//   ���α׷� : m_list.jsp
//   �� �� �� : ��ü ����ڸ���Ʈ
//   ��    �� : ��ü ����ڸ���Ʈ ������
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil 
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

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
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">

	function insert() {
		$.posterPopup('manager_insert.jsp','insert','width=500, height=450, scrollbars=no, top='+(screen.height-450)/2+', left='+(screen.width-500)/2);
    }

	function view(userid) {
		$.posterPopup('manager_view.jsp?userid='+userid,'view','width=500, height=450, scrollbars=no, top='+(screen.height-450)/2+', left='+(screen.width-500)/2);
    }

	function q_list(userid) {
		$.posterPopup('q_manager_list.jsp?userid='+userid,'q_list','width=1200, height=570, scrollbars=yes, top='+(screen.height-570)/2+', left='+(screen.width-1000)/2);
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
			<!--<tr id="bt"><Td colspan="9"><input type="button" value="����� ���" class="form5" onClick="insert();">&nbsp;&nbsp;<b>���̵� Ŭ���ϸ� ����� ������ ����/���� �� �� �ֽ��ϴ�.</b></td></tr>-->
			<tr id="tr">
				<td width="4%">NO</td>
				<td width="10%">���̵�</td>
				<td width="10%">����</td>
				<td width="18%">�̸���</td>
				<td width="10%">�޴���</td>
				<td>����ڼҼ�</td>
				<td width="12%">������뿩��</td>
				<td width="10%">�������</td>
				<td width="10%">������ȸ</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="9">��ϵǾ��� ����ڰ� �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
					   String yn_use = rst[i].getYn_valid();

					   if(yn_use.equalsIgnoreCase("Y")) {
						   yn_use = "���";
					   } else {
						   yn_use = "�̻��";
					   }
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<td><%=rst[i].getUserid()%></td>
				<td><%=rst[i].getName()%></td>
				<td><%=ComLib.nullChk2(rst[i].getEmail())%></td>
				<td><%=ComLib.nullChk2(rst[i].getHp())%></td>
				<td>&nbsp;<%=ComLib.nullChk2(rst[i].getContent1())%></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getRegdate()%></td>
				<td><input type="button" value="������ ������ȸ" class="form" onClick="q_list('<%=rst[i].getUserid()%>');"></td>
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