<%@ page contentType="text/html; charset=euc-kr" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");
%>

<HTML>      
 <HEAD>
  <TITLE> Tman Main </TITLE>
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
  <link rel="StyleSheet" href="../css/style.css" type="text/css">

 </HEAD>       
  
 <BODY id="tman">

	<div id="main">
		<div id="mainTop">
			<div class="title">�������<span>�������, ��������, �������, ����� �������� �� �� �ִ� ȭ���Դϴ�.</span></div>
			<div class="location">������� > intro</div>			
		</div>

		<TABLE cellpadding="0" cellspacing="0" border="0" id="tableC" width="100%">
			<TR id="top">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
			<TR id="middle">
				<TD id="left"></TD>
				<TD id="center" height="80" valign="top">
					<table border="0" width="100%" cellpadding="0" align="center" cellspacing="0">
						<tr height="80">							
							<td width="10%" style="background-image: url(../images/paper_bg.gif); background-repeat: no-repeat; padding-left: 3px; background-position: center;"><b>
							�� ���� �� ������ ����, ������ ����� �� ���������� ������ �� �ִ� ȭ���Դϴ�.<p>
							�� ȭ�� ���� ī�װ��� �������ֽø� ���� ������ ������ �� �ֽ��ϴ�.<br></b>
							</td>
						</tr>
						<tr height="140">							
						</tr>
					</table>
				</TD>
				<TD id="right"></TD>
			</TR>
			<TR id="bottom">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
		</TABLE>
	</div>
		
	<jsp:include page="../copyright.jsp"/>
 </BODY>
</HTML>