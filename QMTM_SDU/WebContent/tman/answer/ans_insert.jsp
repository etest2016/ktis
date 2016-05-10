<%
//******************************************************************************
//   프로그램 : ans_insert.jsp
//   모 듈 명 : 답안지 추가 1
//   설    명 : 답안지 추가 1
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-05-20
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<html>
<head>
	<title>답안지 추가</title>
</head>

<BODY style="font: normal 12px gulim, dotum; margin: 0px; background-image: url(../../images/popup_bg.gif); padding: 5px 5px 5px 5px;" id="tman">
<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/top_left_yj1.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/top_right_yj1.gif"></TD>
		</TR>
		
		<TR style="background-color: #ffffff;">
			<TD></TD>
			<TD>
<br>
<center>
<form name="frmdata" method="post" action="ans_insert_operate.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">

<table border="0" width="350" cellpadding ="1" cellspacing="1" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<tr height="35">
		<td width="30%" align="right" style="background-color: #eefdff; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">아이디&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;<input type="text" class="input" name="userid" size="20" readonly value="<%=userid%>"></td>
	</tr>	
	<tr height="35">
		<td align="right" style="background-color: #eefdff; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">응시상태&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;<input type="radio" name="yn_end" value="Y" checked> 완료&nbsp;&nbsp;<input type="radio" name="yn_end" value="N"> 미완료</td>
	</tr>
</table>
<p>
<input type="image" value="확인하기" name="submit" src="../../images/user_static_yj1_1.gif">&nbsp;&nbsp;&nbsp;<!--input type="button" value="취소하기" onClick="window.close();"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif"></a>
</TD>
			<TD></TD>
		</TR>
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/bottom_left_yj2.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/bottom_right_yj2.gif"></TD>
		</TR>
	</TABLE>
</form>
</body>