<%@page contentType="text/html; charset=EUC-KR" %>
<%@page import="qmtm.*, etest.scorehelp.*, java.sql.*"%>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	Score_DanAnsBean[] rst = null;
	
	try {
		rst = Score_DanAns.userScoreDanAns(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

%>

<html>
<head>
<title> :: 문제별 응시자 득점현황 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<body id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문제별 응시자 득점현황</div></td>
				<Td id="right"></td>
			</tr>			
		</table>
				
	</div>

	<div id="contents">

	<table border="0" cellpadding="0" cellspacing="0" id="tableA" onclick="sortColumn(event)">
		<tr id="tr" align="center">
			<td width="30%">아이디</td>
			<td width="40%">성명</td>
			<td width="30%">점수</td>
		</tr>
		
		<% if(rst == null) { %>
		<tr>
			<td colspan="3" class="blank">응시자가 없습니다.</td>
		</tr>
		<% 
		   } else {
			   for(int i=0; i<rst.length; i++) { 
		%>
		<tr id="td" align="center">
			<td><%=rst[i].getUserid()%></td>
			<td><%=rst[i].getName()%></td>
			<td><%=rst[i].getScore()%></td>
		</tr>
		<%
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