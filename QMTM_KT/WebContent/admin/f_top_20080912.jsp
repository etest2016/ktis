<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
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
		parent.window.frames['fraMain'].location.href= "etc_info/q_use_list.jsp";
	}

	function env_info() {
		parent.window.frames['fraLeft'].location.href= "env_info/e_left.jsp";
		parent.window.frames['fraMain'].location.href= "env_info/class_list.jsp";
	}
</script>
</HEAD>

<BODY id="admin">


<table width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="#CCCCCC"> 
	<tr>
		<td width="40"><img src="./img/menubg_1.gif" border="0"></td>
		<td background="./img/bg_menu.gif"><img src="./img/menubg_3.gif" border="0"><img src="./img/menubg_4.gif" border="0"></td>
	</tr>
	<tr height="20">
		<td width="40"><img src="./img/menubg_2.gif" border="0"></td><td bgcolor="#000000"><a href="javascript:q_tree();" onfocus="this.blur();"><img src="./img/menu_1.gif" border="0"></a><a href="javascript:t_tree();" onfocus="this.blur();"><img src="./img/menu_2.gif" border="0"></a><a href="javascript:manager();" onfocus="this.blur();"><img src="./img/menu_3.gif" border="0"></a><a href="javascript:etc_info();" onfocus="this.blur();"><img src="./img/menu_4.gif" border="0"></a><a href="javascript:env_info();" onfocus="this.blur();"><img src="./img/menu_5.gif" border="0"></a></td>
	</tr>
</table>


</BODY>
</HTML>
