<%
//******************************************************************************
//   프로그램 : 100_rate.jsp
//   모 듈 명 : 100점 만점 비율 환산점수
//   설    명 : 100점 만점 비율 환산점수
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   작 성 일 : 2009-02-26
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	double allottings = 0;
	String score100_yn = "";
	String rate100_yn = "";

	ExamCreateBean rst = null;
	
	try {
	    rst = ExamUtil.getInfos(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	if(rst == null) {
		allottings = 0;
		score100_yn = "";
	} else {
		allottings = rst.getAllotting();
		score100_yn = rst.getScore100_yn();
		rate100_yn = rst.getRate100_yn();
	}

%>

<HTML>
 <HEAD>
  <TITLE> 100점 만점 비율점수로 처리 </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">
		function Send()
		{
			var str;

			str = confirm("100점 비율로 점수를 환산하시겠습니까? \n\n기존에 100점만점으로 환산했거나, \n100점 비율로 점수를 환산했을경우에는 초기화한후에 실행하시기 바랍니다.\n\n실행하시려면 확인하기를 클릭하세요.");
			if(str == true) {
				document.form1.submit();			
			}
		}

		function score_reset() 
		{
			var str;

			str = confirm("기존에 100점 만점으로 환산한 점수를 초기화하시겠습니까\n\n실행하시려면 확인하기를 클릭하세요.");
			if(str == true) {
				location.href="100_score_reset.jsp?id_exam=<%=id_exam%>&allott=<%=allottings%>";
			}				
		}

		function rate_reset() 
		{
			var str;

			str = confirm("기존에 100점 비율로 환산한 점수를 초기화하시겠습니까\n\n실행하시려면 확인하기를 클릭하세요.");
			if(str == true) {
				location.href="100_rate_reset.jsp?id_exam=<%=id_exam%>&allott=<%=allottings%>";
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
<form name="form1" method="post" action="100_rate_ok.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="allott" value="<%=allottings%>">

<table width="95%" border="0" cellpadding="1" cellspacing="1" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
	
	<tr bgcolor="#FFFFFF">
		<td height="5" colspan="3">* 해당 시험에 설정되어진 배점은 <%=allottings%> 입니다.</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td height="5" colspan="3"></td>
	</tr>
	<tr bgcolor="#FFFFFF" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">
		<td colspan="3"><font color="red"><b>100점 비율 환산점수 실행</b></font>&nbsp;&nbsp;&nbsp;<%if(rate100_yn.equals("Y")) { %><a href="javascript:alert('기존에 100점 비율점수로 실행을 하셨습니다.\n\n다시 실행하시려면 하단에 원점수로 복원하신 후에 실행해주시기 바랍니다.');"><% } else { %><a href="javascript:Send();"><% } %><img border="0" src="../../images/bt3_action.gif" align="absmiddle"></a>
		</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td height="5" colspan="3"></td>
	</tr>
	<tr bgcolor="#FFFFFF" height="50">
		<td colspan="3" valign="middle" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"> 실행하기를 클릭하시면 해당 시험에 응시자 점수를 100점 비율점수로 환산합니다.<br><br>ex)배점이 4점이고 응시자점수가 2점일경우에는 100점 만점 비율점수로 환산하면 50점이 됩니다.</td>
	</tr>
</table>
<br>
<table width="95%" border="0" cellpadding="1" cellspacing="1" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<tr bgcolor="#FFFFFF" height="50">
		<td colspan="3" valign="middle" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"> 기존에 100점 비율로 환산을 실행하셨을 경우 아래 [클릭하기] 를 통해서 점수를 원점수로 복원 한 후에 실행해주시기 바랍니다.</td>
	</tr>
	<tr>
		<td height="5"></td>
	</tr>
	<tr bgcolor="#FFFFFF" height="40">
		<td> <font color="red"><b>100점 비율 환산점수 원점수로 복원</b></font>&nbsp;&nbsp;&nbsp;<%if(rate100_yn.equals("Y")) { %><a href="javascript:rate_reset();"><% } else { %><a href="javascript:alert('100점 비율 환산점수로 실행을 하신후에 이용하실 수 있습니다.');"><% } %>[클릭하기]</a></td>
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