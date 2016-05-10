<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.DBPool, qmtm.ComLib"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=EUC-KR">
	<title></title>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript">
		function checkIP(strIP) {
			var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
			return expUrl.test(strIP);
		}

		function closeWindow() {
			alert("부정행위방지프로그램 설치를 위해 인터넷익스프롤러를 종료합니다. 열려져 있는 모든 인터넷 창을 닫고 다시 인터넷익스프롤러를 실행시켜주시기 바랍니다. ");
			top.window.close();
		}

		$(function(){
			var currentServerNameMethod;
			var isTrustZone;

			var currentServerName = $("#servername").val();

			if(checkIP(currentServerName)) {
				currentServerNameMethod = "IP";
			} else {
				currentServerNameMethod = "DOMAIN";
			}

			var currentServerUrl = "http://" + currentServerName;

			if(currentServerNameMethod === "IP") {
				
				isTrustZone = document.AntiCheatX.TrustzoneQueryIP(currentServerUrl);
				$("#isTrustZone").text(isTrustZone);

				if(isTrustZone == 0) {
					window.location.href = "../main.jsp";
				} else {
					var r = document.AntiCheatX.TrustzoneAddIP(currentServerUrl);
					closeWindow();
				}

			} else {
				
				isTrustZone = document.AntiCheatX.TrustzoneQueryDomain(currentServerUrl);
				$("#isTrustZone").text(isTrustZone);

				if(isTrustZone == 0) {
					window.location.href = "../main.jsp";
				} else {
					var r = document.AntiCheatX.TrustzoneAddDomain(currentServerUrl);
					closeWindow();
				}
			}

			

		});
	</script>
</head>
<body>
	<input type="hidden" id="servername" name="servername" value="<%= request.getServerName() %>">
	<OBJECT CODEBASE="<%= ComLib.getConfig("ANTICHEATX_CODEBASE") %>" classid="clsid:B74699E0-E14B-464A-A62B-F9FC17A99781" width="0" height="0" id = "AntiCheatX" >	
		<PARAM NAME="WebSandboxMode" VALUE="1">
		<PARAM NAME="ProtectKeyCheat" VALUE="1">
		<PARAM NAME="ProtectKeyList" VALUE="ALT,ALT+F4,ALT+TAB,ALT+D,ALT+ESC,ALT+Enter,ALT+HOME,ALT+Space,CTRL,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F1~F12,WIN,PRINT">
		<PARAM NAME="ProtectMouseCheat" VALUE="1">
		<PARAM NAME="ProtectAppCheat" VALUE="1">
		<PARAM NAME="ProtectAppExceptionList" VALUE="">
		<PARAM NAME="ProtectExplorerCheat" VALUE="1">
		<PARAM NAME="ProtectExplorerExceptionList" VALUE="<%= ComLib.getConfig("ANTICHEATX_EXPLORER_EXCEPTION_LIST") %>">
		<PARAM NAME="KeepAliveMillisec" VALUE="2000">
		<PARAM NAME="DebugLog" VALUE="1">
		<PARAM NAME="DebugSandbox" VALUE="1">
		<PARAM NAME="AppNotification" VALUE="0">		
	</OBJECT>
</body>
</html>