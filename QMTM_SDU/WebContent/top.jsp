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
     
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.LoginProc, qmtm.AdminProc" %>

<%  
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // ����� ���̵�
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String usergrade = (String)session.getAttribute("usergrade"); // ����

	String name = "";

	if(usergrade.equals("M")) {
		try {
			name = AdminProc.getLoginName(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}
	} else {
		try {
			name = LoginProc.getLoginName(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}
	}
%>

<HTML>
<HEAD>
<TITLE> LG Display �¶��� �򰡽ý��� </TITLE>
	<STYLE>

		BODY { margin: 0px; font-size: 12px; color: #fff; }
		table, tr, td { font-size: 12px; }
		img { border: 0px; }

	</STYLE>
    <script type="text/javascript" src="./js/jquery.js"></script>
    <script type="text/javascript" src="./js/jquery.etest.poster.js"></script>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		function Info() {
			$.posterPopup("info.html","info","width=380,height=392");
		}

		function mypage(grade) {
			if(grade == "M") {
				$.posterPopup("admin/admin/admin_edit2.jsp?userid=<%=userid%>","edits","width=480,height=450");
			} else {
				$.posterPopup("admin/manager/manager_edit2.jsp?userid=<%=userid%>","edits","width=480,height=450");
			}						
		}
		
	//-->
	</SCRIPT>
</HEAD>
<BODY>
	
	<div style="float: left;">
		<img src="images/image_top.gif">
	</div>
	<% if(userid.equals("qmtm")) { %>
	<div style="height: 30px; margin-right: 40px; margin-top: 9px; float: right"><font color="green"><b>[ <%=name%> ] ���� �α����ϼ̽��ϴ�.</b></font>&nbsp;&nbsp;
		<a href="logout.jsp" onfocus="this.blur();"><img src="./images/bt_top_logout.gif"></a>
	<% } else { %>
	<div style="height: 30px; margin-right: 40px; margin-top: 9px; float: right"><font color="green"><b>[ <%=name%> ] ���� �α����ϼ̽��ϴ�.</b></font>&nbsp;&nbsp;
		<a href="javascript:" onClick="mypage('<%=usergrade%>');"><img src="./images/bt_top_mypage.gif" onFocus="this.blur();"></a>&nbsp;&nbsp;<a href="logout.jsp" onfocus="this.blur();"><img src="./images/bt_top_logout.gif"></a>
	<% } %>

	</div>

</BODY>
</HTML>
