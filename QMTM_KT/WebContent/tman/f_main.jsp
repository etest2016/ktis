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
			<div class="title">시험관리<span>시험관리, 성적관리, 성적통계, 답안지 관리등을 할 수 있는 화면입니다.</span></div>
			<div class="location">시험관리 > intro</div>			
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
							· 시험 및 시험지 관리, 응시자 답안지 및 성적관리를 진행할 수 있는 화면입니다.<p>
							· 화면 왼쪽 카테고리를 선택해주시면 시험 관리를 진행할 수 있습니다.<br></b>
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