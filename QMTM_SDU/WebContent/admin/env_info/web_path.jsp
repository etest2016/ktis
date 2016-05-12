<%
//******************************************************************************
//   ���α׷� : web_path.jsp
//   �� �� �� : WEB ��μ���
//   ��    �� : WEB ��μ��� ������
//   �� �� �� : qt_settings
//   �ڹ����� : qtmm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil 
//   �� �� �� : 2008-09-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� :  
//	 �������� : 
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.EnvUtil" %>
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

	String web_path = "";
	
	try {
		web_path = EnvUtil.getWEB(userid);
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

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
		document.form1.qmtm_web_home.focus();
	}

	function Send() {
		var frm = document.form1;

		if(frm.qmtm_web_home.value == "") {
			alert("WEB ��θ� �Է��ϼ���.");
			frm.qmtm_web_home.focus();
			return;
		} else {
			frm.submit();
		}
	}

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onload="javascript: onload();" id="admin">
    <form name="form1" method="post" action="web_path_ok.jsp">
	<div id="main">

		<div id="mainTop">
			<div class="title">WEB ��� ����<span></span></div>
			<div class="location">ADMIN > ȯ�漳�� > <span>WEB ��� ����</span></div>
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
					&nbsp;&nbsp;���� ��Ͻ� ��Ƽ�̵�� ������ �������� ��θ� ������ �ݴϴ�.
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
				<td id="left"><li>WEB ���</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="qmtm_web_home" size="50" tabindex="1" value="<%=ComLib.nullChk(web_path)%>">
				<BR><BR>&nbsp;&nbsp;(<B>ex) http://www.etest.co.kr/files/</B>)
				</td>
			</tr>
		</table>

		<div class="button" style="text-align: right; width: 540px;"><input type="button" value="WEB��μ���" onclick="Send()"></div>
		
 	</div>
	<jsp:include page="../../copyright.jsp"/>
	
 </form>	
		
 </BODY>
</HTML>