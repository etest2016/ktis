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

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.*, java.sql.*" %>
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
	<title> :: ������ ���� ���� :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="javascript">
		function edits() {
			var frm = document.form1;
			
			if(frm.password.value == "") {
				alert("��й�ȣ�� �Է��ϼ���.");
				frm.password.focus();
				return;
			} else if(frm.name.value == "") {
				alert("������ �Է��ϼ���.");
				frm.name.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td id="left"></td>
				<Td id="mid"><div class="title">������ ���� <span>������������ ������ �����մϴ�</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<form name="form1" action="user_update.jsp" method="post">
	<input type="hidden" name="userid" value="<%=userid%>">
	<div id="contents">
		
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableD">
			<tr>
				<td id="left" width="80"><li>���̵�</td>
				<td>&nbsp;<%=userid%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>��й�ȣ</td>
				<td>&nbsp;<input type="text" name="password" class="input" size="15" value="<%=users.getPassword()%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td>&nbsp;<input type="text" name="name" class="input" size="15" value="<%=users.getName()%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�̸���</td>
				<td>&nbsp;<input type="text" name="email" class="input" size="50" value="<%=ComLib.nullChk(users.getEmail())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�ּ�1</td>
				<td>&nbsp;<input type="text" name="home_addr1" class="input" size="50" value="<%=ComLib.nullChk(users.getHome_addr1())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�������ּ�</td>
				<td>&nbsp;<input type="text" name="home_addr2" class="input" size="50" value="<%=ComLib.nullChk(users.getHome_addr2())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����ȭ</td>
				<td>&nbsp;<input type="text" name="home_phone" class="input" size="15" value="<%=ComLib.nullChk(users.getHome_phone())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�ڵ���</td>
				<td>&nbsp;<input type="text" name="mobile_phone" class="input" size="15" value="<%=ComLib.nullChk(users.getMobile_phone())%>">&nbsp;</td>
			</tr>						
			<tr>
				<td id="left"><li>�Ҽ�1</td>
				<td>&nbsp;<input type="text" name="sosok1" class="input" size="50" value="<%=ComLib.nullChk(users.getSosok1())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�Ҽ�2</td>
				<td>&nbsp;<input type="text" name="sosok2" class="input" size="50" value="<%=ComLib.nullChk(users.getSosok2())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�Ҽ�3</td>
				<td>&nbsp;<input type="text" name="sosok3" class="input" size="50" value="<%=ComLib.nullChk(users.getSosok3())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>�Ҽ�4</td>
				<td>&nbsp;<input type="text" name="sosok4" class="input" size="50" value="<%=ComLib.nullChk(users.getSosok4())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td>&nbsp;<input type="text" name="jikwi" class="input" size="20" value="<%=ComLib.nullChk(users.getJikwi())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td>&nbsp;<input type="text" name="jikmu" class="input" size="50" value="<%=ComLib.nullChk(users.getJikmu())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>ȸ��</td>
				<td>&nbsp;<input type="text" name="company" class="input" size="50" value="<%=ComLib.nullChk(users.getCompany())%>">&nbsp;</td>
			</tr>
		</table>
	</div>
	<div id="button">

		<img src="../../images/bt5_edit_yj1.gif" onclick="edits();" style="cursor: pointer;"> <img src="../../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: pointer;">
	</div>
	</form>
</body>

</html>
