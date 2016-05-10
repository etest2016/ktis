<%
//******************************************************************************
//   ���α׷� : admin_list.jsp
//   �� �� �� : ��ü ������ ����Ʈ
//   ��    �� : ��ü ������ ����Ʈ ������
//   �� �� �� : qt_adminid
//   �ڹ����� : qmtm.ComLib, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil 
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // ��ü �����ڸ�� ���������
	AdminBean[] rst = null;

	try {
		rst = AdminUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

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
		$.posterPopup('admin_insert.jsp','insert','width=500, height=250, scrollbars=no, top='+(screen.height-250)/2+', left='+(screen.width-500)/2);
    }

	function view(userid) {
		$.posterPopup('admin_edit.jsp?userid='+userid,'view','width=500, height=250, scrollbars=no, top='+(screen.height-250)/2+', left='+(screen.width-500)/2);
   
    }

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">������ ����<span>: ������ �߰�, ����, ���� ����</span></div>
			<div class="location">ADMIN > <span>������ ����</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="8"><input type="button" value="������ ���" class="form5" onClick="insert();">&nbsp;&nbsp;<b>���̵� Ŭ���ϸ� ������ ������ ����/���� �� �� �ֽ��ϴ�.</b></td></tr>
			<tr id="tr">
				<td width="4%">NO</td>
				<td width="10%">���̵�</td>
				<td width="10%">����</td>
				<td width="18%">�̸���</td>
				<td width="10%">�޴���</td>
				<td>�����ڼҼ�</td>
				<td width="12%">������뿩��</td>
				<td width="10%">�������</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="8">��ϵǾ��� �����ڰ� �����ϴ�.</td>
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
				<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getUserid()%>');" onfocus="this.blur();"><%=rst[i].getUserid()%></a></div><div style="float: left; margin-top: 1px; margin-left: 3px;"><img src="../../images/info2.gif"></div></td>
				<td><%=rst[i].getName()%></td>
				<td><%=ComLib.nullChk2(rst[i].getEmail())%></td>
				<td><%=ComLib.nullChk2(rst[i].getHp())%></td>
				<td>&nbsp;<%=ComLib.nullChk2(rst[i].getContent1())%></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getRegdate()%></td>				
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