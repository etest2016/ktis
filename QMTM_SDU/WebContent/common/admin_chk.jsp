<%
	String chk_userid = (String)session.getAttribute("userid"); // 권한
	if (chk_userid == null) { chk_userid= ""; } else { chk_userid = chk_userid.trim(); }

	String chk_usergrade = (String)session.getAttribute("usergrade"); // 권한
	if (chk_usergrade == null) { chk_usergrade= ""; } else { chk_usergrade = chk_usergrade.trim(); }

	String authChk = "Y";

	if(chk_userid.length() == 0 || chk_usergrade.length() == 0) {
		authChk = "N";
	} else if(!(chk_usergrade.equals("S") || chk_usergrade.equals("M"))) {
		authChk = "N";
	}

	if(authChk.equals("N")) {
%>
	<Script language="JavaScript">
		alert("Permission ERROR");
		top.window.close();
	</Script>
<%
		if(true) return;
	}
%>