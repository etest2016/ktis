<%
//******************************************************************************
//   ���α׷� : class_list.jsp
//   �� �� �� : �з��� ����
//   ��    �� : �з��� ���� ������
//   �� �� �� : qt_settings
//   �ڹ����� : qmtm.admin.env.ClassBean,
//              qmtm.admin.env.ClassUtil 
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.env.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR"); 
   
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 </HEAD>

 <BODY id="admin">

	<div id="main">

		<div id="mainTop">
			<div class="title">�з��� ����<span></span></div>
			<div class="location">ADMIN > ȯ�漳�� > <span>�з��� ����</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableB" style="width: 600px;">
			<tr>
				<td id="left" width="120"><li>ȸ���</td>
				<td><input type="text" class="input" name="company_name" value="" size="30"></td>
			</tr>
			<tr>
				<td id="left"><li>��з���</td>
				<td><input type="text" class="input" name="lb_code_a" value="" size="30"></td>
			</tr>
			<tr>
				<td id="left"><li>�ߺз���</td>
				<td><input type="text" class="input" name="lb_code_b" value="" size="30"></td>
			</tr>  
			<tr>
				<td id="left"><li>�Һз���1</td>
				<td><input type="text" class="input" name="lb_code_c" value="" size="30"></td>
			</tr>
			<tr>
				<td id="left"><li>�Һз���2</td>
				<td><input type="text" class="input" name="lb_code_d" value="" size="30"></td>
			</tr>
			<tr>
				<td id="left"><li>�Һз���3</td>
				<td><input type="text" class="input" name="lb_code_e" value="" size="30"></td>
			</tr>
		</table>
		
		<div class="button"><img src="../../images/bt5_edit.gif"></div>

	</div>
	<jsp:include page="../../copyright.jsp"/>
		
 </BODY>
</HTML>