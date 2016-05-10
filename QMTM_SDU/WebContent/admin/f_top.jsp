<%
//******************************************************************************
//   프로그램 : f_top.asp
//   모 듈 명 : 프레임 상단
//   설    명 : 프레임 상단
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
<%@ page import="qmtm.CommonUtil, qmtm.ComLib" %>
   
<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // 사용자 아이디	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {   
%>
	<script type="text/javascript">
		alert("정상적으로 로그인 후 이용하시기 바랍니다.");
		location.href="../login.jsp";
	</script>
<%
	}

	String usergrade = (String)session.getAttribute("usergrade");

	int qcnt = Integer.parseInt(request.getParameter("qcnt"));    
	int tcnt = Integer.parseInt(request.getParameter("tcnt"));
%>
 
<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>  
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="tree.js"></script>
 
 <script type="text/javascript">

 	function exam_info() {		
		parent.window.fraLeft.location.href= "exam_info/e_left.jsp";
		parent.window.fraMain.location.href= "exam_info/exam_list.jsp";
	}
 
 	function q_info() {		
		parent.window.fraLeft.location.href= "q_info/e_left.jsp";
		parent.window.fraMain.location.href= "q_info/q_list.jsp";
	}
 	
 	function cheat_info() {		
		parent.window.fraLeft.location.href= "cheat_info/e_left.jsp";
		parent.window.fraMain.location.href= "cheat_info/cheat_list.jsp";
	}
 
 	function pretest_info() {		
		parent.window.fraLeft.location.href= "pretest_info/e_left.jsp";
		parent.window.fraMain.location.href= "pretest_info/pretest_list.jsp";
	}
 
 	function log_info() {		
		parent.window.fraLeft.location.href= "log_info/e_left.jsp";
		parent.window.fraMain.location.href= "log_info/subject_ing_list.jsp";
	}
	
	function static_info() {		
		parent.window.fraLeft.location.href= "static_info/e_left.jsp";
		parent.window.fraMain.location.href= "static_info/static_all_list.jsp";
	}
	
	function setting_info() {		
		parent.window.fraLeft.location.href= "setting_info/e_left.jsp";
		parent.window.fraMain.location.href= "setting_info/exam_ing_list.jsp";
	}
	
</script>
</HEAD>

<BODY id="admin">

<table width="100%" cellpadding="0" cellspacing="0" height="40" border="0">
	<tr>
		<td width="400" valign="top" align="center" style="background-image: url(img/bg_logo.gif)"><img src="img/logo.gif"></td>
		<td align="right" valign="middle" style="padding-right: 40px; background-color: #000000;">
			<INPUT TYPE="hidden" NAME="" value="<%=userid%>">

			<div style="float: right;">
				<% if(tcnt!=0 || userid.equals("qmtm") || usergrade.equals("M")) { %><a href="../tman/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/tman.gif"></a><% } %><% if(qcnt!=0 || userid.equals("qmtm") || usergrade.equals("M")) { %><a href="../qman/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/qman.gif"></a><% } %><% if(userid.equals("qmtm") || usergrade.equals("M")) { %><a href="../admin/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/admin.gif"></a><% } %>
			</div>
			<div style="float: right; padding-top: 15px; padding-right: 7px;">
			<% if(usergrade.equals("M")) { %>
				<a href="javascript:q_tree();" onfocus="this.blur();"><img src="./img/menu_1.gif"></a><a href="javascript:manager();" onfocus="this.blur();"><img src="./img/menu_3.gif"></a><a href="javascript:exam_info();" onfocus="this.blur();"><img src="./img/menu_3_1.gif"></a><a href="javascript:log_info();" onfocus="this.blur();"><img src="./img/menu_7.gif"></a>
			<% } else { %>
				<!-- <a href="javascript:q_tree();" onfocus="this.blur();"><img src="./img/menu_1.gif"></a><a href="javascript:manager();" onfocus="this.blur();"><img src="./img/menu_3.gif"></a><a href="javascript:exam_info();" onfocus="this.blur();"><img src="./img/menu_3_1.gif"></a><a href="javascript:log_info();" onfocus="this.blur();"><img src="./img/menu_7.gif"></a><a href="javascript:etc_info();" onfocus="this.blur();"><img src="./img/menu_8.gif"></a><a href="javascript:env_info();" onfocus="this.blur();"><img src="./img/menu_5.gif"></a>-->
				<a href="javascript:exam_info();" onfocus="this.blur();"><font color="#FFFFFF"><strong>퀴즈평가관리</strong></font></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:q_info();" onfocus="this.blur();"><font color="#FFFFFF"><strong>퀴즈문제관리</strong></font></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:cheat_info();" onfocus="this.blur();"><font color="#FFFFFF"><strong>부정행위이력관리</strong></font></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:pretest_info();" onfocus="this.blur();"><font color="#FFFFFF"><strong>모의퀴즈관리</strong></font></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:log_info();" onfocus="this.blur();"><font color="#FFFFFF"><strong>퀴즈출제현황및로그관리</strong></font></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:static_info();" onfocus="this.blur();"><font color="#FFFFFF"><strong>퀴즈통계관리</strong></font></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:setting_info();" onfocus="this.blur();"><font color="#FFFFFF"><strong>설정관리</strong></font></a>&nbsp;&nbsp;&nbsp;
			<% } %>
			</div>
						
		</td>
	</tr>
</table>

</BODY>
</HTML>
