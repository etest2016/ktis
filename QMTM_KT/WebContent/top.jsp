<%
//******************************************************************************
//   ���α׷� : top.asp
//   �� �� �� : ��� ������
//   ��    �� : ��� ������
//   �� �� �� : 
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib
//   �� �� �� : 2010-05-30
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� :     
//	 �������� : 
//******************************************************************************
%>       
     
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib" %>

<%  
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("euc-kr");

	String userid = (String)session.getAttribute("userid"); // ����� ���̵�
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
%>

<HTML>
<HEAD>
<TITLE> ������ö��������б� �¶����� ������ �ý��� </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<STYLE>

		BODY { margin: 0px; font-size: 12px; color: #fff; }
		table, tr, td { font-size: 12px; }
		img { border: 0px; }

	</STYLE>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		function Info(){
			window.open("info.html","info","width=380,height=392");
		}
	//-->
	</SCRIPT>
</HEAD>
<BODY>
	
	<div style="float: left;">
		<img src="images/image_top.gif">
	</div>
	<div style="height: 30px; margin-right: 40px; margin-top: 9px; float: right"><font color="green"><b>[ <%=userid%> ] ���� �α����ϼ̽��ϴ�.</b></font>&nbsp;&nbsp;
		<!--<a href="javascript: Info();" onfocus="this.blur();"><img src="./images/bt_top_info.gif"></a>--><a href="logout.jsp" onfocus="this.blur();"><img src="./images/bt_top_logout.gif"></a>
	</div>

</BODY>
</HTML>
