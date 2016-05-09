<%@ page contentType="text/html; charset=euc-kr" %>
<%@page import="qmtm.ComLib, etest.*, java.sql.* " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = request.getParameter("user_id");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	String pwd = request.getParameter("user_id");
	if (pwd == null) { pwd = ""; } { pwd = pwd.trim(); }

	if (userid.length() == 0 || pwd.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String userName = "";	

	try {
		userName = User_QmTm.getName(userid, pwd);
	    //set_cookie(response,"userid",userid);
	    //set_cookie(response,"userName",userName);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	if (userName == null) { userName = ""; }
%>

<html>
<head>

<title>login</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="stylesheet" href="../css/indie_style.css" type="text/css">

<script language="javascript">

function LoginChk()
{
  if ("<%= userName %>" == "") {
    alert("아이디 / 비밀번호가 맞지 않습니다..!!\n\n다시 로긴 하세요..!!");
	history.back(-1);
    //document.fradate.userid.focus();    
  }
  else {
    alert("[<%= userName %>] 님의 방문을 환영합니다.");
    var frm = document.fradate;
    frm.action = 'intro/guide.jsp';
    frm.method = 'post';
    frm.submit();
  }
}

</script>

</head>

<body onload="return LoginChk();" oncontextmenu="return false">

<form name="fradate" >
<input type="hidden" name="userid" value="<%= userid %>">
<input type="hidden" name="username" value="<%= userName %>">
</form>

</body>
</html>
