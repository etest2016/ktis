<%
//******************************************************************************
//   ���α׷� : member_relation.jsp
//   �� �� �� : �������� ����
//   ��    �� : �������� ���� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2013-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");   
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">
	function stuImport() {
		var str = "";

		var str = confirm("�л� ���� ������ �����մϴ�.\n\n������ ����Ÿ�� ������쿡�� �ð��� ���� �ҿ�� �� �ֽ��ϴ�.");
	
		if(str) {
			window.open("stu_import.jsp","simport","top=0, left=0, width=1, height=1, scrollbars=no");
		}
    }

	function profImport() {
		
		var str = "";

		var str = confirm("������ ���� ������ �����մϴ�.\n\n������ ����Ÿ�� ������쿡�� �ð��� ���� �ҿ�� �� �ֽ��ϴ�.");
	
		if(str) {
			window.open("prof_import.jsp","simport","top=0, left=0, width=1, height=1, scrollbars=no");
		}
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">�������� ����</div>
			<div class="location">ADMIN > ��Ÿ�������� > <span>������������</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt">
			<TD colspan="2">&nbsp;</TD>
		</TR>
		<tr id="td" align="center">
			<td><img src="../../images/stu_import.gif" onClick="stuImport();"></td>
			<td><img src="../../images/prof_import.gif" onClick="profImport();"></td>
		</tr>
	</table>
	</div>

	<jsp:include page="../../copyright.jsp"/>
		
		
 </BODY>
</HTML>