<%
//******************************************************************************
//   프로그램 : user_non_mark.jsp
//   모 듈 명 : 시험 논술형 문항 채점
//   설    명 : 시험 논술형 문항 채점
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   작 성 일 : 2008-09-01
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

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	PaperNonExportBean bean = null;
	
	try {
		bean = PaperNonExport.getBeans(id_exam, Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
	
	PaperNonExportBean[] beans = null;

	try {
		beans = PaperNonExport.getUserList(id_exam, Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	// 해당 시험의 시험지의 문제수를 읽어온다
	int qcount = 0;

	try {
		qcount = AnswerMarkNon.getQcount(id_exam);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

<html>
<head>
<title> :: 문항별 응시자 채점 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<Script language="JavaScript">
	
	var allottings = <%=bean.getAllotting()%>;

	function scores(userid, i) {
		
		var u_score = eval("document.forms1.scores"+i+".value");

		if(u_score == "") {
			alert("점수를 입력하세요.");
			return;
		} else {				

			if(parseInt(u_score) < 0 || parseInt(u_score) > allottings) {
				alert("문제의 배점은 " + allottings + "점 입니다\n배점보다 점수를 낮거나 또는 높게 입력할 수 없습니다");
				return;
			}
		
			location.href = "user_non_mark_up.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+userid+"&scores="+u_score;
		}
	}
	
</Script>

</head>

<body id="popup2">
	<form name="forms1">
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="98%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문항별 응시자 채점</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
	
		<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC"  width="580">
			<tr bgcolor="#FFFFFF">
				<td height="40" valign="middle">&nbsp;<b><%=bean.getQ()%></b> <BR><b>(문항코드 : <%=bean.getId_q()%>, 배점 : <%=bean.getAllotting()%>)</b></td>
			</tr>
		</table>

		<br>
		
		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="tr" align="center">
				<td width="8%"> NO </td>
				<td width="15%"> 아이디 </td>
				<td width="15%"> 성명 </td>
				<td width="15%"> &nbsp;점수 </td>
				<td width="47%"> 채점 </td>
			</tr>

			<% if(beans == null) { %>

			<tr>
				<td colspan="5" class="blank">채점할 응시자가 없습니다.</td>
			</tr>
			<% 
				} else {					
			
					double ExamAllotting = 0;
					int nr_q = 0;
				    String now_point = "";

					for(int i=0; i<beans.length; i++) { 	
						
						// 해당 논술형 문항별 수동채점 조회한다.
						AnswerMarkNonBean rst2 = null;

						try {
							rst2 = AnswerMarkNon.getBean3(id_q, beans[i].getUserid(), id_exam);
						} catch(Exception ex) {
							response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

							if(true) return;
						}

						nr_q = rst2.getNr_q();      
						String points = rst2.getPoints();

						if(points == null || points.equals("")) {

							for (int j = 0; j < qcount; j++) {
								points = points + "{:}";
							}

							points = points.substring(0, points.length()-3);
						
						} else {
							points = rst2.getPoints();
						}		

						String[] ArrPoints = points.split(QmTm.Q_GUBUN_re, -1);
						
						if(ArrPoints[nr_q - 1] == null || ArrPoints[nr_q - 1].equals("")) {
							now_point = "";
						} else {
							now_point = ArrPoints[nr_q - 1];
						}
			%>

			<tr id="td" align="center">
				<td><%=i+1%></td>
				<td><%=beans[i].getUserid()%></td>
				<td><%=beans[i].getName()%></td>
				<td>&nbsp;<%=now_point%></td>
				<td><input type="text" name="scores<%=i%>"  size="3">점&nbsp;&nbsp;<a href="javascript:scores('<%=beans[i].getUserid()%>', <%=i%>)" ><img src="../../images/bt3_mark.gif" border="0"></a></td>
			</tr>
			<%
					}
				}
			%>
		</table>
		</form>

	</div>

	<div id="button">
		
	<img src="../../images/bt5_exit_yj1.gif" style="cursor: hand;" onclick="window.close();">
		
	</div>

</body>

</html>