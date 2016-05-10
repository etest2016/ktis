<%
//******************************************************************************
//   프로그램 : exam_list.jsp
//   모 듈 명 : 모사답안 및 채점도우미
//   설    명 : 모사답안 및 채점도우미
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   작 성 일 : 2009-01-21
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*, etest.scorehelp.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	AnswerMarkBean[] beans = null;

	try {
		beans = AnswerMark.getBeans(id_exam);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<html>
<head>
<title> :: 채점도우미 :: </title>
<link rel="StyleSheet" href="../css/style.css" type="text/css">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
<script language="JavaScript">

	function ans_mark_dan(id_q) {
		$.posterPopup("score_help_Res2.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_dan","width=1100, height=780, scrollbars=yes, top=0, left=0, fullscreen=no");
	}

	function equal_exe(id_q){
		var chk = confirm("모사 답안 비교 처리하는데 응시자 인원수 및 \n답안길이에 따라 수분의 시간이 소요됩니다. \n\n지금 실행하시겠습니까?")
		if(chk == true)
		{
			$.posterPopup("ans_equal_frame.jsp?id_exam=<%=id_exam%>&id_q="+id_q, "equal_exe", "width=1100, height=780, scrollbars=yes, top=0, left=0");
		}
	}

	function score_win_non(id_q) {
		$.posterPopup("exam_ans_score_insert.jsp?id_exam=<%=id_exam%>&id_q="+id_q, "scoreNon", "width=1100, height=780, scrollbars=yes, top=0, left=0");
	}

	function equal_win_non(id_q) {
		$.posterPopup("ans_equal_result.jsp?id_exam=<%= id_exam %>&id_q="+id_q, "scoreNon2", "width=1100, height=780, scrollbars=yes, top=0, left=0");		
	}

	/*

	function comp_del(id_q) {
		var chk = confirm("*주의) 모사 답안 비교 결과가  초기화됩니다.\n\n지금 실행하시겠습니까?")
		if(chk == true)
		{
			$.posterPopup("comp_del.jsp?id_exam=<%=id_exam%>&id_q=" + id_q, "comp_del", "scorllbars=no, width=600 height=600");
		}
	}

	function ans_mark_non(id_q) {
		$.posterPopup("non_frame.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_non","width=1000, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
	}

	*/

</script>
</head>

<body id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">채점도우미 <span>문제별 채점도우미 서비스를 이용한 채점</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<img src='../images/qlistA.gif'>

		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="tr" align="center">
				<td width="10%"> 문제코드 </td>
				<td> 문제 </td>
				<td width="18%"> &nbsp; </td>
				<td width="22%">채점</td>
			</tr>

			<% if(beans == null) { %>
			<tr>
				<td colspan="4" class="blank">단답형, 논술형 문제가 없습니다.</td>
			</tr>
			<% } else {
					for(int i=0; i<beans.length; i++) { 
						if(beans[i].getId_qtype() == 4) {
			%>
			<tr id="td" align="center">
				<td id="left"><b><li><%=beans[i].getId_q()%></b>&nbsp;&nbsp;&nbsp;</td>
				<td style="text-align:left; padding: 15px 5px 18px 5px;"><%=beans[i].getQ()%></td>
				<td><% if(beans[i].getCacount() > 1) { %>정답순서구별 : <%=beans[i].getYn_caorder()%><br><% } %>
				대소문자 구별 : <%=beans[i].getYn_case()%><br>
				빈칸 체크 : <%=beans[i].getYn_blank()%></td>
				<td><a href="javascript:ans_mark_dan('<%=beans[i].getId_q()%>')"><img src="../images/bt5_mark.gif"></a></td>
			</tr>
			<%
						}
					}
				}
			%>
		</table>

		<img src='../images/qlistE.gif'>

		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr align="center" id="tr">
				<td width="10%" id="left"> 문제코드 </td>
				<td> 문제 </td>
				<td width="18%"> &nbsp; </td>
				<td width="22%">채점</td>
			</tr>

			<% if(beans == null) { %>
			<tr>
				<td colspan="4" class="blank">단답형, 논술형 문제가 없습니다.</td>
			</tr>
			<% } else {
					for(int i=0; i<beans.length; i++) { 
						if(beans[i].getId_qtype() != 4) {
			%>
			<tr id="td" align="center">
				<td id="left"><b><li><%=beans[i].getId_q()%></b>&nbsp;&nbsp;&nbsp;</td>
				<td style="text-align:left; padding: 15px 5px 18px 5px;"><%=beans[i].getQ()%></td>
				<td><% if(beans[i].getCacount() > 1) { %>정답순서구별 : <%=beans[i].getYn_caorder()%><br><% } %>
				대소문자 구별 : <%=beans[i].getYn_case()%><br>
				빈칸 체크 : <%=beans[i].getYn_blank()%></td>
				<td><img src="../images/bt5_mark.gif" onclick="javascript:score_win_non('<%=beans[i].getId_q()%>');" style="cursor: pointer;"></td>
			</tr>
			<%
						}
					}
				}
			%>
		</table>

	</div>
	<div id="button">
		
	<img src="../images/bt5_exit_yj1.gif" style="cursor: pointer;" onclick="window.close();">
		
	</div>

</body>

</html>