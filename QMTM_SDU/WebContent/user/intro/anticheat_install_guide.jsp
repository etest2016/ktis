<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.DBPool, qmtm.ComLib"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>������������ ActiveX ���α׷� ��ġ������</title>
	<link href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="../css/indie_style.css" rel="stylesheet" type="text/css" />
	<script src="../js/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<style type="text/css">
		body {
			text-align: center;
		}
		#wrapper {
			width: 500px;
			margin: 50px auto;

		}
		#guideInstall {
			text-align:left;
			font-size:100%;
		}
		#header {
			text-align:center;
		}
		#headerImg {
			margin:5px auto;
		}
		#download_icon {
			text-align: center;
			
		}
		#download_icon a {
			margin:0 10px 0 10px;
		}
	</style>
	<script type="text/javascript">
	
	function activeXCheck() {
			var ret;
			ret = CheckActiveX("ANTICHEATX.AntiCheatXCtrl.1");
			if(ret)
			{
				return "true";
			}
			else {
				return "false";
			}
		}

	function CheckActiveX(pid)
	{
		try {
			var axObj;
			axObj = new ActiveXObject(pid);
			return true;
		} 
		catch (e) {
			return false;
		}
	}

	$(function(){
		var activeXCheckResult = activeXCheck();
		if(activeXCheckResult == "true") {
			window.location.href = "./anticheat_trustzone_check.jsp";
		} else {
			
		}
		
		setInterval(function(){
			var activeXCheckResult = activeXCheck();
			if(activeXCheckResult == "true") {
				window.location.href = "./anticheat_trustzone_check.jsp";
			}
		}, 3000);
	});

	</script>
</head>
<body >
	<div id="wrapper">
		<div id="guideInstall">
			<div id="header">
				<img id="headerImg" src="../images/header_activex_down.gif" alt="������������ ActiveX ���α׷� ��ġ">
			</div>
			<ul>
				<li><p style="color=red; font-weight:bold;">�򰡿� �����ϱ� ���ؼ��� �ݵ�� ������������ ActiveX�� ��ġ�Ͽ��� �մϴ�.</p></li>
				<li><p>������ ��ܿ� ������������ ActiveX���α׷��� ��ġ ���θ� ���� ������ ��Ÿ���� Ŭ���Ͽ� ��ġ���ֽñ� �ٶ��ϴ�.</p></li>
				<li><p>��ܿ� ������� ��ġ ������ ��Ÿ���� ���� ��쿡�� �Ʒ��� '������ġ'�� Ŭ���Ͽ� ��ġ������ �ٿ�޾Ƽ� ��ġ���ֽñ� �ٶ��ϴ�. </p></li>
				<li><p>��ġ�� �Ϸ�Ǹ� �ڵ����� �򰡻���Ʈ�� �̵��մϴ�.</p></li>
				<li><p>��ġ�� �Ϸ�� �Ŀ��� �ڵ����� �̵����� ������� F5Ű �Ǵ� �������� ���ΰ�ħ��ư�� �����ּ���.</p></li>
			</ul>
			<div id="download_icon">
			<a href="../anticheatx/AntiCheatX.exe"><img src="../images/btn_activex_down_exe.gif" alt="������������ AcriveX ���� ��ġ(exe)" /></a>
			<a href="../anticheatx/AntiCheatX.zip"><img src="../images/btn_activex_down_zip.gif" alt="������������ AcriveX ���� ��ġ(zip)"/></a>
			</div>
			<div id="progress_div">
				<div class="progress progress-striped active">
					<div class="bar" style="width: 100%;"></div>
				</div>
			</div>
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
		</div>
	</div>

</body>
</html>