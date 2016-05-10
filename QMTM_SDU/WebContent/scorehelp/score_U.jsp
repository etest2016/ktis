<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	/*
	String score = request.getParameter("score");
	if (score == null) { score = ""; } else { score = score.trim(); }

	if (score.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}
	*/

	String allot = request.getParameter("allot");
	if (allot == null) { allot = ""; } else { allot = allot.trim(); }

	if (allot.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}
%>

<html>
<head>
<title>논술형 문제 채점</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">

<script language="javascript">
	function checks(bigo) {
		var frm = document.form1;
						
		if (bigo == "0")
		{
			frm.scores.value = 0;			
		} else if(bigo == "1") {
			frm.scores.value = <%=allot%>;			
		} else {
			if(frm.scores.value == "") {
				alert("점수를 입력하세요.");
				frm.scores.focus();				
			} else if(frm.scores.value > <%=allot%>)  {
				alert("부분점수가 배점보다 높게 입력되었습니다.");
				frm.scores.value = "";
				frm.scores.focus();
			} else if(frm.scores.value < 0)  {
				alert("부분점수는 0점보다 높게 입력해야 합니다..");
				frm.scores.value = "";
				frm.scores.focus();
			} else {
				frm.submit();
			}
		}
	}
</script>

</head>

<body style="padding: 20px;" onload=>

	<form name="form1" method="post" action="score_U_result.jsp">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="id_q" value="<%=id_q%>">
	<input type="hidden" name="userid" value="<%=userid%>">

	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center">
				
				<div class="title">논술형 문제 채점</div>

				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="tableD">
					<tr>
						<td width="60%" id="left"><li>아이디</td>
						<td><%=userid%></td>
					</tr>
					<tr> 
						<td id="left"><li>점수입력(배점 : <font color=red><%=allot%></font></td>      
						<td><B><input type=text name="scores" size=3> 점</B></td> 		
					</tr>
				</table>
				<br>
				<table border='0' width='90%' >
					<tr height="30">    
						<td align="center" bgcolor="#FFFFFF"><img src="../images/bt3_true.gif" style="cursor: pointer;" onClick="checks('1');">&nbsp;&nbsp;<img src="../images/bt3_false.gif" style="cursor: pointer;" onClick="checks('0');">&nbsp;&nbsp;<img src="../images/bt3_mark.gif" style="cursor: pointer;" onClick="checks();"></td>      
					</tr>
				</table>

			</td>  
		</tr>
	</table>
	</form>

</body>
</html>
