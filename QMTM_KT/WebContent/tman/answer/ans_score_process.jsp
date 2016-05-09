<%
//******************************************************************************
//   프로그램 : ans_score_process.jsp
//   모 듈 명 : 선택한 응시자 득점가감처리
//   설    명 : 선택한 응시자 득점가감처리
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   작 성 일 : 2008-05-27
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userids = request.getParameter("sel_userids");
	if (userids == null) { userids = ""; } else { userids = userids.trim(); }

	if (id_exam.length() == 0 || userids.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String[] arrUserid;
	arrUserid = userids.split(",");
%>

<HTML>
 <HEAD>
  <TITLE> 득점가감처리 </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">
		function Send()
		{
			if(document.form1.score_log.value == "") {
				alert("가감처리할 비율 또는 점수를 입력하세요.");
				return;
			} else {
				document.form1.submit();
			}
		}
	</script>
	</head>

<BODY style="font: normal 12px gulim, dotum; margin: 0px; background-image: url(../../images/popup_bg.gif); padding: 5px 5px 5px 5px;" id="tman">
<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/top_left_yj1.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/top_right_yj1.gif"></TD>
		</TR>
		
		<TR style="background-color: #ffffff;">
			<TD></TD>
			<TD>


<center>
<form name="form1" method="post" action="ans_score_process_ok.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="userids" value="<%=userids%>">

<table width="95%" border="0" cellpadding="1" cellspacing="1" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<tr bgcolor="#FFFFFF" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">
		<td width="10%"><select name="add">
		<option value="+"> +   </option>
		<option value="-"> -   </option>
		</select>
		</td>
		<td  width="10%"><input type="text" class="input" name="score_log" size="3" value="10"></td>
		<td><select name="gubun">		
		<option value="점"> 점   </option>
		<option value="%"> %   </option>
		</select>&nbsp;&nbsp;<!--input type="button" value="확인하기" onClick="Send();"--><a href="javascript:Send();"><img border="0" src="../../images/user_static_yj1_1.gif" align="absmiddle"></a>&nbsp;<!--input type="button" value="취소하기" onClick="window.close();"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif" align="absmiddle"></a>
		</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td height="5" colspan="3"></td>
	</tr>
	<tr bgcolor="#FFFFFF" height="30">
		<td colspan="3" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">처리대상자</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td colspan="3" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"><select name="inwons" multiple size="8" style="width:100%;">
		<% for(int i=0; i<arrUserid.length; i++) { %>
		<option value="<%=arrUserid[i]%>"><%=arrUserid[i]%></option>
		<% } %>
		</select></td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td height="5" colspan="3"></td>
	</tr>
	<tr bgcolor="#FFFFFF" height="50">
		<td colspan="3" valign="middle" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"> 선택한 응시자의 득점을 가감 처리합니다.<br> 대상자는 <%=arrUserid.length%> 명 입니다.</td>
	</tr>
</table>
</TD>
			<TD></TD>
		</TR>
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/bottom_left_yj2.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/bottom_right_yj2.gif"></TD>
		</TR>
	</TABLE>