<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.ComLib, etest.score.User_ScoreUnit, etest.score.User_ScoreUnitBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = "";
	userid = (String)session.getAttribute("current_userid");

	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

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
		<Script type="text/javascript">
			alert("평가에 응시하지 않았습니다.");
			history.back();
		</Script>
<%
		if(true) return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>평가결과상세조회</title>
	<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="../css/top.css" />
	<script type="text/javascript">
	   
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
<body>
	<a name="top"></a>

	<jsp:include page="../include/include_top.jsp" flush="false">
		<jsp:param name="active_menu_item" value="score" />
    </jsp:include>

	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>평가명</th>
					<th>배점</th>
					<th>성적조회일자</th>
					<th>본인점수</th>
		<% if(beans.getYn_open_qa().equalsIgnoreCase("C") || beans.getYn_open_qa().equalsIgnoreCase("E")) { %>
					<th>정답, 해설 및 채점</th>
		<% } %>
				</tr>
			</thead>
			<tbody>	
				<tr>    
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
					<td><a href="javascript:ftndetail();" class="btn">보기</a></td>
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
					<td><a href="javascript:ftndetail();" class="btn">보기</a></td>
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
			 </tbody>
		</table>

	<!-- 성적통계 제공시 -->
	<% if (beans.getYn_stat().equalsIgnoreCase("Y")) { %>
		<br><br>

		<!-- 성적조회기간 -->
		  <% if (beans.getScore() > 0) { %>
			<button onclick="openStat()" class="btn"><i class="icon-list-alt"></i> 통계자료보기</button>
		  <% } else { %>
		  	<button onclick="alert('평가에 응시하지 않았으므로 성적통계를 보실수 없습니다')" class="btn"><i class="icon-list-alt"></i> 통계자료보기</button>
		  <% } %>

	<% } %>

	</div>

	<div class="container_bottom"><!--바닥 부분 레이아웃--></div>

</body>
</html>