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
			alert("��й�ȣ�� �Է��ϼ���");
			frm.qmtm_password.focus();
			return;
		} else if(frm.qmtm_password.value != frm.qmtm_password2.value) {
			alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			frm.qmtm_password2.value = "";
			frm.qmtm_password2.focus();
			return;	
		} else {
			frm.submit();
		}
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
					&nbsp;&nbsp;��й�ȣ�� ������, Ư�����ڷ� �����Ǿ�� �ϸ�, <br>
					&nbsp;&nbsp;�ְ� 15�ڸ������Է°��� �մϴ�. (������ ��ҹ��ڸ� �����մϴ�.)
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
				<td>&nbsp;&nbsp;<input type="text" class="input" name="qmtm_password" size="30" maxlength="15" tabindex="1"></td>
			</tr>
			<tr>
				<td id="left"><li>��й�ȣ Ȯ��</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="qmtm_password2" size="30" maxlength="15" tabindex="2"></td>
			</tr>	
		</table>

		<div class="button" style="text-align: right; width: 540px;"><img src="../../images/bt4_pw.gif" tabindex="3" border="0" onclick="Send()"></div>
		
 	</div>
	<jsp:include page="../../copyright.jsp"/>
	
 </form>	
		
 </BODY>
</HTML>