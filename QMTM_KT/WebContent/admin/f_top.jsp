<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>
   
<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // 사용자 아이디
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {   
%>
	<script language="JavaScript">
		alert("정상적으로 로그인 후 이용하시기 바랍니다.");
		location.href="../login.jsp";
	</script>
<%
	}

	int qcnt = Integer.parseInt(request.getParameter("qcnt"));    
	int tcnt = Integer.parseInt(request.getParameter("tcnt"));
%>
 
<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>  
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="tree.js"></script>
 
 <script language="javascript">
	function q_tree() {
		parent.window.frames['fraLeft'].location.href= "q_tree/f_left.jsp";
		parent.window.frames['fraMain'].location.href= "q_tree/f_main.jsp";
	}

	function t_tree() {
		parent.window.frames['fraLeft'].location.href= "t_tree/f_left.jsp";
		parent.window.frames['fraMain'].location.href= "t_tree/f_main.jsp";
	}

	function manager() {
		parent.window.frames['fraLeft'].location.href= "manager/m_left.jsp";
		parent.window.frames['fraMain'].location.href= "manager/m_list.jsp";
	}

	function etc_info() {
		parent.window.frames['fraLeft'].location.href= "etc_info/e_left.jsp";
		parent.window.frames['fraMain'].location.href= "etc_info/group_list.jsp";
	}

	function env_info() {
		parent.window.frames['fraLeft'].location.href= "env_info/e_left.jsp";
		parent.window.frames['fraMain'].location.href= "env_info/pwd_list.jsp";
	}

	function exam_info() {		
		parent.window.frames['fraLeft'].location.href= "bbs/b_left2.jsp";
		parent.window.frames['fraMain'].location.href= "exam_info/exam_ing_list.jsp";
	}

	function bbs() {
		parent.window.frames['fraLeft'].location.href= "bbs/b_left.jsp";
		parent.window.frames['fraMain'].location.href= "http://147.6.87.17:8089/admin_bbs2/notice_list.asp";
	}
	
</script>
</HEAD>

<BODY id="admin">

<table width="100%" cellpadding="0" cellspacing="0" height="40" border="0">
	<tr>
		<td width="250" valign="top" align="center" ><img src="img/logo.gif"></td>
		<td align="right" valign="middle" style="padding-right: 40px; background-color: #000000;">
			<INPUT TYPE="hidden" NAME="" value="<%=userid%>">

			<div style="float: right;">
				<% if(tcnt!=0 || userid.equals("qmtm")){ %><a href="../tman/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/tman.gif"></a><% } %><% if(qcnt!=0 || userid.equals("qmtm")){ %><a href="../qman/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/qman.gif"></a><% } %><% if(userid.equals("qmtm")){ %><a href="../admin/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/admin.gif"></a><% } %>
			</div>
			<div style="float: right; padding-top: 7px; padding-right: 0px;">
				<a href="javascript:q_tree();" onfocus="this.blur();"><img src="./img/menu_1.gif"></a><a href="javascript:manager();" onfocus="this.blur();"><img src="./img/menu_3.gif"></a><a href="javascript:exam_info();" onfocus="this.blur();"><img src="./img/menu_3_1.gif"></a><!--<a href="javascript:bbs();" onfocus="this.blur();"><img src="./img/menu6.gif"></a>--><a href="javascript:etc_info();" onfocus="this.blur();"><img src="./img/menu_4.gif"></a><a href="javascript:env_info();" onfocus="this.blur();"><img src="./img/menu_5.gif"></a></a>
			</div>
			
			
		</td>
	</tr>
</table>


</BODY>
</HTML>
