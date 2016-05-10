<%
//******************************************************************************
//   프로그램 : top.asp
//   모 듈 명 : 상단 프레임
//   설    명 : 상단 프레임
//   테 이 블 : 
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib
//   작 성 일 : 2010-05-30
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 :     
//	 수정사항 : 
//******************************************************************************
%>       
     
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.LoginProc, qmtm.AdminProc" %>

<%  
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // 사용자 아이디
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String usergrade = (String)session.getAttribute("usergrade"); // 권한

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
<TITLE> LG Display 온라인 평가시스템 </TITLE>
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
	<div style="height: 30px; margin-right: 40px; margin-top: 9px; float: right"><font color="green"><b>[ <%=name%> ] 님이 로그인하셨습니다.</b></font>&nbsp;&nbsp;
		<a href="logout.jsp" onfocus="this.blur();"><img src="./images/bt_top_logout.gif"></a>
	<% } else { %>
	<div style="height: 30px; margin-right: 40px; margin-top: 9px; float: right"><font color="green"><b>[ <%=name%> ] 님이 로그인하셨습니다.</b></font>&nbsp;&nbsp;
		<a href="javascript:" onClick="mypage('<%=usergrade%>');"><img src="./images/bt_top_mypage.gif" onFocus="this.blur();"></a>&nbsp;&nbsp;<a href="logout.jsp" onfocus="this.blur();"><img src="./images/bt_top_logout.gif"></a>
	<% } %>

	</div>

</BODY>
</HTML>
