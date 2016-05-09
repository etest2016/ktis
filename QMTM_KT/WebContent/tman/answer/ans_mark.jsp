<%
//******************************************************************************
//   프로그램 : ans_mark.jsp
//   모 듈 명 : 답안지 조회
//   설    명 : 답안지 조회
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   작 성 일 : 2008-06-02
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

	String userid = CommonUtil.get_Cookie(request, "userid"); // 사용자 아이디
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {            
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	AnswerMarkBean[] beans = null;

	try {
		beans = AnswerMark.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

<html>
<head>
<title> :: 문항별 수동채점 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

	function ans_mark_dan(id_q) {
		window.open("../../scorehelp/score_help_Res2.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_dan","width=1100, height=780, scrollbars=yes, top=0, left=0, fullscreen=no");
		//window.open("ans_mark_dan.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_dan","width=1000, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
		//window.open("http://exam.gnu.ac.kr/score_help/exam_ans_score.asp?id_exam=<%=id_exam%>&userid=<%=userid%>&id_q="+id_q,"mark_dan","width=1100, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
	}

	function ans_mark_non(id_q) {
		window.open("non_frame.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_non","width=1000, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
		//window.open("http://exam.gnu.ac.kr/score_help/exam_ans_non_score.asp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_non","width=1100, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
	}

</script>
</head>

<body id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문항별 수동채점 <span>문항별 응시자 답안을 채점합니다. || <font color=red><b>문항별 채점이 완료되면 채점상태변경을 클릭해서 완료처리합니다.</b></font></span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="tr" align="center">
				<td width="11%"> 문항코드 </td>
				<td width="12%"> 문제유형&nbsp;&nbsp; </td>
				<td> 문제 </td>
				<td width="15%"> &nbsp; </td>
				<td width="10%">채점</td>
				<td width="10%">채점상태</td>
			</tr>

			<% if(beans == null) { %>
			<tr>
				<td colspan="6" class="blank">단답형, 논술형 문항이 없습니다.</td>
			</tr>
			<% } else {
					String qtypes = "";
					for(int i=0; i<beans.length; i++) { 
						if(beans[i].getId_qtype() == 4) {
							qtypes = "<img src='../../images/qlistA.gif'>";
						} else {
							qtypes = "<img src='../../images/qlistE.gif'>";
						}

						String scoreChk = "";
						String scoreChk_str = "";

						try {
							scoreChk = AnswerMark.getScoreChk(id_exam, beans[i].getId_q());
						} catch(Exception ex) {
							out.println(ComLib.getExceptionMsg(ex, "back"));

							if(true) return;
						}

						if(scoreChk == null) {
							scoreChk = "";
							scoreChk_str = "[채점상태변경]";
						} else {
							scoreChk_str = "[채점완료]";
						}
						
			%>
			<tr id="td" align="center">
				<td id="left"><b><li><%=beans[i].getId_q()%></b>&nbsp;&nbsp;&nbsp;</td>
				<td><%=qtypes%></td>
				<td style="text-align:left; padding: 15px 5px 18px 5px;"><%=beans[i].getQ()%></td>
				<td><% if(beans[i].getCacount() > 1) { %>정답순서구별 : <%=beans[i].getYn_caorder()%><br><% } %>
				대소문자 구별 : <%=beans[i].getYn_case()%><br>
				빈칸 체크 : <%=beans[i].getYn_blank()%></td>
				<td>
				<% if(beans[i].getId_qtype() == 4) { %>
				<a href="javascript:ans_mark_dan('<%=beans[i].getId_q()%>')">
				<% } else { %>
				<a href="javascript:ans_mark_non('<%=beans[i].getId_q()%>')">
				<% } %>
				<img src="../../images/bt_check_yj1.gif"></a>
				</td>
				<td><font color=red></b><% if(scoreChk.equals("Y")) { %><%=scoreChk_str%><% } else { %><a href="score_id_q_chk.jsp?id_exam=<%=id_exam%>&id_q=<%=beans[i].getId_q()%>"><%=scoreChk_str%></a><% } %></b></font></td>
			</tr>
			<%
					}
				}
			%>
		</table>

	</div>
	<div id="button">
		
	<img src="../../images/bt5_exit_yj1.gif" style="cursor: hand;" onclick="window.close();">
		
	</div>

</body>

</html>