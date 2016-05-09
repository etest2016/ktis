<%@ page contentType="text/html; charset=EUC-KR" %>

<HTML>           
 <HEAD>
  <TITLE> 온라인평가 관리자 시스템 </TITLE>   
  <style>
	
	body { margin: 0px;  }
	img { border: 0px; }

	#Top { height: 30%; }   
	#Top #L { width: 15%; }
	#Top #C { width: 200px; background-image: url(./images/e2e1cd.gif); }
	#Top #R { text-align: left; vertical-align: bottom; padding-left: 15px; padding-bottom: 10px; }

	#Mid { height: 210px; }
	#Mid #L { background-image: url(./images/f5f5e9.gif); }
	#Mid #C { background-image: url(./images/ffc43c.gif); }
	#Mid #R { background-image: url(./images/f5f5e9.gif); text-align: left; vertical-align: top; padding-top: 56px; padding-left: 40px; }

	#Bottom { }
	#Bottom #L { }
	#Bottom #C { background-image: url(./images/6c6352.gif); vertical-align: top; }
	#Bottom #R { text-align: left; vertical-align: top; padding-left: 40px; }

	input,textarea {
		font: normal 12px;
	}

	.input {
		color: #999;
		width: 180px;
		height: 19px;
		padding-top: 2px;
		padding-left: 5px;
		border-top: 1px autoset #a5a5a5;
		border-right: 1px solid #d8d8d8;
		border-bottom: 1px solid #d8d8d8;
		border-left: 1px autoset #a5a5a5;
	}

  </style>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
	<script language="JavaScript">
	<!--
	function frmDatachk()
	{
		if (document.frmData.userid.value=="") {
			alert("아이디를 입력하세요");
			document.frmData.userid.focus();
			return false;
		}

		if (document.frmData.pwd.value=="") {
			alert("비밀번호를 입력하세요");
			document.frmData.pwd.focus();
			return false;
		}
	}
	function onload(){
		document.frmData.userid.focus();
	}
	//-->
	</script>
 </HEAD>

 <BODY onload="onload();">
	
	<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR id="Top">
			<TD id="L">&nbsp;</TD>
			<TD id="C"></TD>
			<TD id="R"><img src="./images/logo.gif"></TD>
		</TR>
		<TR id="Mid">
			<TD id="L"></TD>
			<TD id="C"></TD>
			<TD id="R">
				<div>
					<form name="frmData" action="login_ok.jsp" method="POST" onSubmit="return frmDatachk();">
						<TABLE cellpadding="0" cellspacing="0" border="0" width="500">
							<TR height="25">
								<TD width="140"><img src="./images/login_id.gif"></TD>
								<TD><input type="text" class="input" name="userid" class="input" maxlength=15 tabindex=1 value="" class="input"></TD>
							</TR>
							<TR height="25">   
								<TD><img src="./images/login_pw.gif"></TD>
								<TD><input type="password" name="pwd" class="input" maxlength=15 tabindex=2 value="" class="input"></TD>
							</TR>
							<TR>
								<TD colspan="2" style="padding-top: 30px; background-image: url(./images/login_line.gif); background-repeat: repeat-x; text-align: right;"><br><input type=image src="./images/login_bt.gif" tabindex="3" onfocus="this.blur();"></TD>
							</TR>
						</TABLE>
						
					</form>
				</div>
			</TD>
		</TR>
		<TR id="Bottom">
			<TD id="L"></TD>
			<TD id="C"><!--<img src="./images/login_services.gif"><br><br><a href="http://etest.co.kr" target="_blank" onfocus="this.blur();"><img src="./images/login_sv1.gif"></a><br><img src="./images/login_sv2.gif"><br><a href="http://e-omr.com" target="_blank" onfocus="this.blur();"><img src="./images/login_sv3.gif"></a>--></TD>
			<TD id="R">
			<TABLE cellpadding="0" cellspacing="0" border="0" width="500">
			<TR height="100">
				<td align="center"><!--<a href="http://localhost:2011/guides.ppt"><img src="images/guide.gif"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--><a href="javascript:" onClick="window.open('error_guide.htm','errorPop','width=300,height=250');"><img src="images/tel.gif"></a></td>				
			</tr>
			</table>
			</TD>
		</TR>
		<TR height="60">
			<TD colspan="3" style="border-top: 2px solid #000;" style="font: normal 11px gulim; color: #727272;">
				<div style="float: left;">Copyright (c) <B><font color="#547096">Etest</font></B> All Rights Reserved.</div>
				<div style="float: right;"><img src="./images/logo.gif"></div>
			</TD>
		</TR>
	</TABLE>	

 </BODY>
</HTML>
