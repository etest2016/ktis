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
     
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib" %>

<%  
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("euc-kr");

	String userid = (String)session.getAttribute("userid"); // 사용자 아이디
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
%>

<HTML>
<HEAD>
<TITLE> 포항제철공업고등학교 온라인평가 관리자 시스템 </TITLE>
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
	<div style="height: 30px; margin-right: 40px; margin-top: 9px; float: right"><font color="green"><b>[ <%=userid%> ] 님이 로그인하셨습니다.</b></font>&nbsp;&nbsp;
		<!--<a href="javascript: Info();" onfocus="this.blur();"><img src="./images/bt_top_info.gif"></a>--><a href="logout.jsp" onfocus="this.blur();"><img src="./images/bt_top_logout.gif"></a>
	</div>

</BODY>
</HTML>
