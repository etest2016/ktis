<%
//******************************************************************************
//   ���α׷� : f_top.asp
//   �� �� �� : ������� ��� ������
//   ��    �� : ������� ��� ������
//   �� �� �� : 
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib
//   �� �� �� : 2010-06-01
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� :   
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib" %>
<%@ include file = "/common/login_chk.jsp" %>
<%     
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // ����� ���̵�
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {            
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>

  <link rel="StyleSheet" href="../css/style.css" type="text/css">

 </HEAD>

 <BODY id="tman">

 <table width="100%" cellpadding="0" cellspacing="0" height="40" border="0"> 
	<tr>
		<td width="250" valign="top" align="center" style="background-image: url(img/bg_logo.gif)"><a href="../default.jsp" target="parent" onfocus="this.blur();"><img src="img/logo.gif"></a></td>
		<td align="right" valign="middle" style="padding-right: 40px; background-color: #000000;">
			<INPUT TYPE="hidden" NAME="" value="<%=userid%>">

			<div style="float: right;">
				<a href="manager.jsp" target="main" onfocus="this.blur();"><img src="img/tman.gif"></a>
			</div>
			<div style="float: right; padding-top: 7px; padding-right: 10px;">
				<a href="m_main.jsp" target="fraMain" onfocus="this.blur();"><img src="./img/menu_1.gif"></a>
			</div>
		</td>
	</tr>
</table>

 </BODY>
</HTML>
