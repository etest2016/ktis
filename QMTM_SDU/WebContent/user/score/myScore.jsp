<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="qmtm.ComLib, etest.score.User_ScoreList, etest.score.User_ScoreListBean"%>

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

	User_ScoreListBean[] rst = null;

	try {
	  rst = User_ScoreList.getBeans(userid);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>eTest</title>
	<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="../css/top.css" />
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
				<th>과정명</th>
				<th>평가명</th>
				<th>성적조회일</th>
			</tr>
			</thead>
			<tbody>
			<%
				// No record
				if (rst == null){
			%>
				<tr>
					<td colspan="3">결과를 조회 할 평가가 없습니다.</td>  
				</tr>
			<%
				} // End of (rst.length == 0)

				// Has Record(s)
				else
				{
					// Loop for Records
					for (int i = 0; i < rst.length; i++)
					{
			%>
				<tr>    		
					<td><%= rst[i].getCourse() %></td>
				<%  
					  // 정답 및 해설공개하지 않음 옵션일경우
					  if (rst[i].getYn_open_qa().equalsIgnoreCase("A")) { 
				%>
							<td class='point_b'><%= rst[i].getTitle() %></td>
							<td>성적비공개</td> 
				<%	  } %>
			  
				<% 
					  // 답안제출 직후 점수만 공개, 답안제출 직후 점수 및 정답, 해설 공개 옵션일 경우
					  if (rst[i].getYn_open_qa().equalsIgnoreCase("B") || rst[i].getYn_open_qa().equalsIgnoreCase("C")) { 
				%>
							<td><a href="scoreinfo.jsp?id_exam=<%= rst[i].getId_exam() %>&userid=<%= userid %>"><%= rst[i].getTitle() %></a></td>
							<td>기간설정 없음</td>
				<%	  } %>
				<% 
					  // 성적조회 기간에 점수만 공개, 성적조회 기간에 점수 및 정답, 해설 공개 옵션일 경우...
					  if (rst[i].getYn_open_qa().equalsIgnoreCase("D") || rst[i].getYn_open_qa().equalsIgnoreCase("E")) { 
				%>
				<!-- 공개기간중 -->
				<%	      if (User_ScoreList.isOpenScore(rst[i].getStat_start(), rst[i].getStat_end())) { %>
							<td>
								<a href="scoreinfo.jsp?id_exam=<%= rst[i].getId_exam() %>&userid=<%= userid %>"><%= rst[i].getTitle() %></a>
							</td>
							<td >
								<%= rst[i].getStat_start().toString().substring(0,16) %> 부터<br>
								<%= rst[i].getStat_end().toString().substring(0,16) %> 까지
							</td>
							<!-- 공개기간이 아님 -->
				<%	      } else { %>
							<td >
								<a href="javascript:alert('성적 조회기간이 아닙니다');"><%= rst[i].getTitle() %></a>
							</td>
							<td>
								<%= rst[i].getStat_start().toString().substring(0,16) %> 부터<br>
								<%= rst[i].getStat_end().toString().substring(0,16) %> 까지
							</td>
				<%	      } %>
			  <%	  } %>
			 </tr>
			<%
					} // end of for loop
				}     // end of if (rst.length > 0)
			%>
			</tbody>
		</table>
	</div>

	<div class="container_bottom"><!--바닥 부분 레이아웃--></div>

</body>
</html>