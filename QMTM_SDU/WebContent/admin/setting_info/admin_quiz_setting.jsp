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

	String rst = "";
%>

<HTML>
 <HEAD>
  <TITLE> ������ɼ��� </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup('admin_quiz_edit.jsp','edit','width=650, height=880, scrollbars=no, top='+(screen.height-880)/2+', left='+(screen.width-650)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">������ɼ���<span>: ������ ���� ��������� �����մϴ�.</span></div>
			<div class="location">ADMIN > �������� > <span>������ɼ���</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="8" align="right"><input type="button" value="������ɼ����ϱ�" class="form5" onClick="insert();"></td></tr>
			<tr id="tr">				
				<td>���������Ⱓ</td>
				<td>������ȿ�Ⱓ</td>
				<td>���ù��</td>
				<td>������Ƚ��</td>
				<td>���������ǽɾ˸�Ƚ��</td>
				<td>�������˸��ð�</td>
				<td>�������������߰��ð�</td>
				<td>�������ڵ�����ð�</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="8">��ϵǾ��� ��������� �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length(); i++) {					   
			%>
			<tr id="td" align="center">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
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