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
<%@ page import="qmtm.ComLib" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");	

	String rst = null;
%>

<HTML>
 <HEAD>
  <TITLE> ���ø޽������� </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup('paper_message_edit.jsp','edit','width=800, height=550, scrollbars=no, top='+(screen.height-550)/2+', left='+(screen.width-800)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">���ø޽�������<span>: �������ÿ� ���� �޽����� �����մϴ�.</span></div>
			<div class="location">ADMIN > �������� > <span>���ø޽�������</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="8" align="right"><input type="button" value="���ø޽��������ϱ�" class="form5" onClick="insert();"></td></tr>
			<tr id="tr">				
				<td>NO</td>
				<td>�޽�������</td>
				<td>�޽�������</td>				
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="3">��ϵǾ��� �޽��� ������ �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length(); i++) {					   
			%>
			<tr id="td" align="center">
				<td></td>
				<td></td>
				<td></td>				
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