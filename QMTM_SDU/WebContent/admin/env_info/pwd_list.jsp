<%
//******************************************************************************
//   ���α׷� : pwd_list.jsp
//   �� �� �� : ��й�ȣ ����
//   ��    �� : ��й�ȣ ���� ������
//   �� �� �� : 
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>   

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	// �ش� ������ ���� üũ	
	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

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
  <SCRIPT LANGUAGE="JavaScript">
  <!--
	function onload() {
		document.form1.qmtm_password.focus();
	}

	function Send() {
		var frm = document.form1;

		if(frm.qmtm_password.value == "") {
			alert("��й�ȣ�� �Է��ϼ���\n\n��й�ȣ�� 8�� �̻��̾�� �ϸ�, \n���� + ���� ȥ������ �����ϼž� �մϴ�.");
			frm.qmtm_password.focus();
			return;
		} else if(frm.qmtm_password.value.length < 8) {
			alert("��й�ȣ�� 8�� �̻��̾�� �ϸ�, ���� + ���� ȥ������ �����ϼž� �մϴ�.");
			frm.qmtm_password.value = "";
			frm.qmtm_password2.value = "";
			frm.qmtm_password.focus();
			return;
		} else if(frm.qmtm_password.value != frm.qmtm_password2.value) {
			alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			frm.qmtm_password2.value = "";
			frm.qmtm_password2.focus();
			return;	
		} else if(Check_AlphaNumericSpecial(frm.qmtm_password.value)) {
			alert("��й�ȣ�� ���� + ���� ȥ������ �����ϼž� �մϴ�.");
			frm.qmtm_password.value = "";
			frm.qmtm_password2.value = "";
			frm.qmtm_password.focus();
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

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onload="javascript: onload();" id="admin">
    <form name="form1" method="post" action="pwd_change.jsp">
	<div id="main">

		<div id="mainTop">
			<div class="title">��й�ȣ ����<span></span></div>
			<div class="location">ADMIN > ȯ�漳�� > <span>��й�ȣ ����</span></div>
		</div>
		
		<TABLE cellpadding="0" cellspacing="0" border="0" id="tableC" style="width: 540px;">
			<TR id="top">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
			<TR id="middle">
				<TD id="left"></TD>
				<TD id="center" style="font: normal 11px dotum; ">
					&nbsp;&nbsp;��й�ȣ�� 8�� �̻��̾�� �ϸ�,  <br>
					&nbsp;&nbsp;���� + ���� ȥ������ �����ϼž� �մϴ�.
				</TD>
				<TD id="right"></TD>
			</TR>
			<TR id="bottom">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
		</TABLE>		

		<table border="0" cellpadding ="0" cellspacing="0" id="tableB" style="width: 540px;">
			<tr>
				<td id="left"><li>���� ��й�ȣ</td>
				<td>&nbsp;&nbsp;<input type="password" class="input" name="qmtm_password" size="30" maxlength="15" tabindex="1"></td>
			</tr>
			<tr>
				<td id="left"><li>��й�ȣ Ȯ��</td>
				<td>&nbsp;&nbsp;<input type="password" class="input" name="qmtm_password2" size="30" maxlength="15" tabindex="2"></td>
			</tr>	
		</table>

		<div class="button" style="text-align: right; width: 540px;"><img src="../../images/bt4_pw.gif" tabindex="3" border="0" onclick="Send()"></div>
		
 	</div>
	<jsp:include page="../../copyright.jsp"/>
	
 </form>	
		
 </BODY>
</HTML>