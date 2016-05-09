<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.ComLib, etest.score.User_ScoreUnit, etest.score.User_ScoreUnitBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	User_ScoreUnitBean beans = null;

	try {
	    beans = User_ScoreUnit.getBean(userid, id_exam);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	if (beans == null) {
%>
		<Script language="JavaScript">
			alert("시험에 응시하지 않았습니다.");
			history.back();
		</Script>
<%
		if(true) return;
	}
%>

<html>
<head>
<title>시험결과상세조회</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="stylesheet" href="../css/style.css" type="text/css">

<script language="JavaScript">
   
   function ftndetail() 
   {
	   window.open("../score/qa.jsp?userid=<%=userid%>&id_exam=<%= id_exam %>", "statistic", "status=yes,resizable=yes,scrollbars=yes,toolbar=no,width=1000,height=700");
   }

   function openStat()
   {
       window.open("multistat.jsp?id_exam=<%= id_exam %>&userid=<%=userid%>", "statistic", "status=yes,resizable=yes,scrollbars=yes,toolbar=no,width=1000,height=700");
   }

</script>

</head>

<%@ include file="../include/include_top.jsp" %>
<img src='../images/title_myscore.gif'>
<br><br>

<table cellspacing='0' cellpadding='0' class="table" border='0'>
   	<tr class="tt">          
   		<td>시험명</td>
		<td>배점</td>
		<td>성적조회일자</td>
		<td>본인점수</td>		
	<% if(beans.getYn_open_qa().equalsIgnoreCase("C") || beans.getYn_open_qa().equalsIgnoreCase("E")) { %>
  	    <td align="center">정답, 해설 및 채점</td>
	<% } %>
   	</tr>
	<tr class="td">    
		<td><%= beans.getTitle() %></td>    
	    <td><%= beans.getAllotting() %></td> 
	<% if (beans.getYn_end().equalsIgnoreCase("N")) { %>
		<td colspan=3>미완료</td>
	<% }else if(beans.getYn_end().equalsIgnoreCase("Y") && beans.getScore() == -1) {%>
		<td colspan=3>미채점</td>
	<% } else {		
		// 정답 및 해설 공개하지 않음 일경우
		if(beans.getYn_open_qa().equalsIgnoreCase("A")) {
	%> 
		<td>기간설정없음</td>
		<td>비공개</td>
	<% 
		// 답안 제출 직후 점수만 공개 일경우
		} else if(beans.getYn_open_qa().equalsIgnoreCase("B")) {
	%>
		<td>기간설정없음</td>
		<td><%=beans.getScore()%> 점</td>
	<% 
		// 답안 제출 직후 점수 정답 및 해설 공개 일경우
		} else if(beans.getYn_open_qa().equalsIgnoreCase("C")) {
	%>
		<td>기간설정없음</td>
		<td><%=beans.getScore()%> 점</td>
		<td><a href="javascript:ftndetail();"><img src="../images/view1.gif" border="0"></a></td>
	<%
		// 성적조회 기간에 점수만 공개 일경우
		} else if(beans.getYn_open_qa().equalsIgnoreCase("D")) {
			if(beans.getYn_stat_day().equalsIgnoreCase("Y")) { // 성적조회 기간내일경우 점수를 보여준다.
	%>	
		<td><%=beans.getStat_start()%> ~ <%=beans.getStat_end()%></td>
		<td><%=beans.getScore()%> 점</td>
	<%      
			} else {
	%>
		<td><%=beans.getStat_start()%> ~ <%=beans.getStat_end()%></td>
		<td>조회일자아님</td>
	<%	
		}		
		} else if(beans.getYn_open_qa().equalsIgnoreCase("E")) { // 성적조회 기간에 점수 정답 및 해설 공개 일경우 
			if(beans.getYn_stat_day().equalsIgnoreCase("Y")) { // 성적조회 기간내일경우 점수를 보여준다.
	%>	
		<td><%=beans.getStat_start()%> ~ <%=beans.getStat_end()%></td>
		<td><%=beans.getScore()%> 점</td>
		<td><a href="javascript:ftndetail();"><img src="../images/view1.gif" border="0"></a></td>
	<%      
		} else { 
	%>
		<td><%=beans.getStat_start()%> ~ <%=beans.getStat_end()%></td>
		<td colspan=2>조회일자아님</td>	
	<%
		}
		}
	}
	%>
  </tr>	

</table>

<!-- 성적통계 제공시 -->
	<% if (beans.getYn_stat().equalsIgnoreCase("Y")) { %>
	<br><br>

		<!-- 성적조회기간 -->
		  <% if (beans.getScore() > 0) { %>
		  <img onclick="openStat()" onmouseover="this.style.cursor='hand'" src="../images/data.gif" border="0" WIDTH="108" HEIGHT="24">
		  <% } else { %>
		  <img onclick="alert('시험에 응시하지 않았으므로 성적통계를 보실수 없습니다')" onmouseover="this.style.cursor='hand'" src="../images/data.gif" border="0" WIDTH="108" HEIGHT="24">
		  <% } %>

	<% } %>