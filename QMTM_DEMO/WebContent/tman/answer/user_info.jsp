<%
//******************************************************************************
//   ���α׷� : user_info.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ����
//   �� �� �� : qt_userid
//   �ڹ����� : qmtm.tman.UserInfo, qmtm.tman.UserInfoBean
//   �� �� �� : 2008-06-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	UserInfoBean users = null;
	
	try {
		users = UserInfo.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));
		
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
				<td id="left"><li>��й�ȣ</td>
				<td>&nbsp;----&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td>&nbsp;<%=users.getName()%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�̸���</td>
				<td>&nbsp;<%if(users.getEmail() == null) { %>&nbsp;<% } else { %><%=users.getEmail()%><% } %>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�ּ�</td>
				<td>&nbsp;<%if(users.getHome_addr1() == null) { %>&nbsp;<% } else { %><%=users.getHome_addr1()%><% } %><%if(users.getHome_addr1() == null) { %>&nbsp;<% } else { %><%=users.getHome_addr2()%><% } %>&nbsp;</td>
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
			<tr>
				<td id="left"><li>�Ҽ�1</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getSosok1())%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�Ҽ�2</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getSosok2())%>&nbsp;</td>
			</tr>
			<!--<tr>
				<td id="left"><li>�Ҽ�3</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getSosok3())%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�Ҽ�4</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getSosok4())%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getJikwi())%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getJikmu())%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>ȸ��</td>
				<td>&nbsp;<%=ComLib.nullChk(users.getCompany())%>&nbsp;</td>
			</tr>-->
		</table>
	</div>
	<div id="button">

		<img src="../../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: hand;">
	</div>

</body>

</html>
