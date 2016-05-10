<%
	String chk_usergrade = (String)session.getAttribute("usergrade"); // ±ÇÇÑ
	if (chk_usergrade == null) { chk_usergrade= ""; } else { chk_usergrade = chk_usergrade.trim(); }

	String authChk = "Y";

	if(chk_usergrade.length() == 0) {
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