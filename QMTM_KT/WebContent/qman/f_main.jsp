<%
//******************************************************************************
//   프로그램 : f_main.jsp
//   모 듈 명 : 문제관리 메인 페이지
//   설    명 : 문제관리 메인 페이지
//   테 이 블 : q, r_qtype, q_subject, r_difficulty
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.qman.question.QListBean, 
//             qmtm.qman.question,QListUtil
//   작 성 일 : 2010-06-01    
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>


<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

<HTML>      
 <HEAD>
  <TITLE> Qman Main </TITLE>
  <link rel="StyleSheet" href="../css/style.css" type="text/css">

 </HEAD>       
  
 <BODY id="tman">

	<div id="main">
		<div id="mainTop">
			<div class="title">문제관리<span>문제관리, 과목/단원관리, 문제검색 관리등을 할 수 있는 화면입니다.</span></div>
			<div class="location">문제관리 > intro</div>			
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
							· 문제 관리, 과목/단원 관리를 진행할 수 있는 화면입니다.<p>
							· 화면 왼쪽 카테고리를 선택해주시면 문제 관리를 진행할 수 있습니다.<br></b>
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