<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="qmtm.ComLib, etest.exam.User_ExamListBean, etest.exam.User_ExamList" %>

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

	User_ExamListBean[] rst = null;

	try {
	  rst = User_ExamList.getBeans(userid);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>eTest</title>
	<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="../css/top.css" />
	<script type="text/javascript">
		function GoTest(id_exam){
			location.href="./etest.jsp?id_exam="+id_exam+"&userid=<%=userid%>";
		}
	</script>
</head>
<body>

	<a name="top"></a>

	<jsp:include page="../include/include_top.jsp" flush="false">
		<jsp:param name="active_menu_item" value="exam" />
    </jsp:include>

	<div class="container">

		<table class="table table-hover">
		<thead>
		<tr>
			<th>과정명</th>
			<th>평가명</th>
			<th>평가기간</th>
		</tr>
		</thead>
		<tbody>
		<% if (rst == null) { %>
		  <tr>
		    <td colspan="3">개설되어진 평가가 없습니다.</td>
		  </tr>
		<%
		   } else {
		        for (int i = 0; i < rst.length; i++) {
		%>
		  <tr>  
		    <td><%= rst[i].getCourse() %></td>
		    <td><a href="javascript:GoTest('<%= rst[i].getId_exam() %>');"><%= rst[i].getTitle() %></a></td>
		    <td><%= rst[i].getExam_start().toString().substring(0,16) %> ~ <%= rst[i].getExam_end().toString().substring(0,16) %></td> 
		  </tr>
		<%
		       }
		   }
		%>		
		</tbody>
		</table>

	</div>

	<div class="container_bottom"><!--바닥 부분 레이아웃--></div>


</body>
</html>