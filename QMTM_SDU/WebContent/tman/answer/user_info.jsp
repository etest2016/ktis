<%
//******************************************************************************
//   ���α׷� : user_info.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ����
//   �� �� �� : qt_userid
//   �ڹ����� : qmtm.ComLib, qmtm.tman.UserInfo, qmtm.tman.UserInfoBean
//   �� �� �� : 2013-02-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.UserInfo, qmtm.tman.UserInfoBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	UserInfoBean users = null;
	
	try {
		users = UserInfo.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));
		
		if(true) return;
	}
%>

<html>
<head>
	<title> :: ������ ���� :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

</head>

<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td id="left"></td>
				<Td id="mid"><div class="title">������ ���� <span>������������ ������ ��ȸ�մϴ�</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableD">
			<tr>
				<td id="left" width="80"><li>���̵�</td>
				<td>&nbsp;<%=userid%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td>&nbsp;<%=users.getName()%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�Ҽ�1</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getSosok1())%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�Ҽ�2</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getSosok2())%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getLevel())%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�̸���</td>
				<td>&nbsp;<%if(users.getEmail() == null) { %>&nbsp;<% } else { %><%=users.getEmail()%><% } %>&nbsp;</td>
			</tr>			
			<tr>
				<td id="left"><li>����ȭ</td>
				<td>&nbsp;<%if(users.getHome_phone() == null) { %>&nbsp;<% } else { %><%=users.getHome_phone()%><% } %>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�ڵ���</td>
				<td>&nbsp;<%if(users.getMobile_phone() == null) { %>&nbsp;<% } else { %><%=users.getMobile_phone()%><% } %>&nbsp;</td>
			</tr>			
			<tr>
				<td id="left"><li>�������</td>
				<td>&nbsp;<%=users.getRegdate()%>&nbsp;</td>
			</tr>
			
		</table>
	</div>
	<div id="button">

		<img src="../../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: pointer;">
	</div>

</body>

</html>
