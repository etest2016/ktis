<%
//******************************************************************************
//   ���α׷� : admin_edit2.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ���� �˾� ������
//   �� �� �� : qt_adminid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	// ������ ���������
	AdminBean rst = null;

	try {
		rst = AdminUtil.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
%>
<HTML>
<HEAD>
<TITLE> ������ ���� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Send() {
			var frm = document.frmdata;
			
			if(frm.password.value == "") {
				alert("��й�ȣ�� �Է��ϼ���\n\n��й�ȣ�� 8�� �̻��̾�� �ϸ�, \n���� + ���� ȥ������ �����ϼž� �մϴ�.");
				frm.password.value = "";
				frm.password2.value = "";
				frm.password.focus();
				return false;
			} else if(frm.password.value.length < 8) {
				alert("��й�ȣ�� 8�� �̻��̾�� �ϸ�, ���� + ���� ȥ������ �����ϼž� �մϴ�.");
				frm.password.value = "";
				frm.password2.value = "";
				frm.password.focus();
				return false;
			} else if(frm.password.value != frm.password2.value) {
				alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
				frm.password2.value = "";
				frm.password2.focus();
				return false;
			} else if(Check_AlphaNumericSpecial(frm.password.value)) {
				alert("��й�ȣ�� ���� + ���� ȥ������ �����ϼž� �մϴ�.");
				frm.password.value = "";
				frm.password2.value = "";
				frm.password.focus();
			} else if(frm.name.value == "") {
				alert("������ �Է��ϼ���");
				frm.name.focus();
				return false;
			} else {
				frm.submit();
			}
		}

		function Check_AlphaNumericSpecial(checkStr)    { 
			var checkOk = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";  
			var engChk = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
			var numChk = "0123456789";

			var engCnt = 0;
			var numCnt = 0;

		  for( i=0 ; i < checkStr.length ; i++ ) { 
			  ch = checkOk.indexOf(checkStr.charAt(i)); 
			  if( ch == -1 ) return true; 
			  
			  if(engChk.indexOf(checkStr.charAt(i)) > 0) {
				 engCnt = engCnt + 1;
			  }

			  if(numChk.indexOf(checkStr.charAt(i)) > 0) {
				 numCnt = numCnt + 1;
			  }
		  }

		  if(checkStr.length == engCnt) {
			 return true;
		  }

		  if(checkStr.length == numCnt) {
			 return true;
		  }
		  
		  return false; 

	} 


	</script>
	
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="admin_update2.jsp">
<input type="hidden" name="userid" value="<%=userid%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ �������� <span>������ �������� �� ������� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%">���̵�</td>
				<td width="70%"><%=userid%></td>
			</tr>
			<tr>
				<td id="left">��й�ȣ</td>
				<td><input type="password" name="password" size="21" ></td>
			</tr>
			<tr>
				<td id="left">��й�ȣȮ��</td>
				<td><input type="password" name="password2" size="21" ></td>
			</tr>
			<tr>
				<td id="left">����</td>
				<td><input type="text" name="name" size="20"  value="<%=rst.getName()%>" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">�޴���</td>
				<td><input type="text" name="hp" size="20"  value="<%=ComLib.nullChk(rst.getHp())%>"></td>
			</tr>
			<tr>
				<td id="left">�̸���</td>
				<td><input type="text" name="email" size="30"  value="<%=ComLib.nullChk(rst.getEmail())%>" style="ime-mode:inactive;"></td>
			</tr>			
			<tr>
				<td id="left">������ �Ҽ�</td>
				<td><textarea name="rmk" cols="35" rows="3" style="ime-mode:active;"><%=rst.getContent1()%></textarea></td>
			</tr>			
	</table>
	</div>

	<div id="button">
		<input type="button" value="�����ϱ�" class="form" onClick="Send();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>