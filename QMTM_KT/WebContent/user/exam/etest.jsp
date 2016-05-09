<%@page contentType="text/html; charset=euc-kr" %>
<%@page import="qmtm.ComLib, etest.User_QmTm, etest.exam.User_ExamUnitBean, etest.exam.User_ExamUnit, java.sql.Timestamp"%>

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

	User_ExamUnitBean rst = null;

	try {
	  rst = User_ExamUnit.getBean(id_exam);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	if (rst == null) {
%>
		<Script language="JavaScript">
			alert("개설되어진 시험지 정보가 없습니다.");
			history.back();
		</Script>
<%
		if(true) return;
	}
%>

<html>
<head>
<title>시험응시상세화면</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="stylesheet" href="../css/indie_style.css" type="text/css">

<script language="JavaScript">
<!--
function frameofTest()
{
	window.open("../paper/fraTest.jsp?id_exam=<%= id_exam %>&userid=<%=userid%>", "exampaper", "fullscreen=yes, scrollbars=yes");
}

function checkwin() {
	var myWin;
	myWin = window.open("ansCheck.jsp?id_exam=<%=id_exam%>&userid=<%=userid%>", "checkwin", "menubar=no, scrollbars=no, width=300, height=150");
	myWin.focus();
}

//-->
</script>

</head>
<%@ include file="../include/include_top.jsp" %>

			<img src='../images/title_mytest.gif'>
			<br><br>			

			<div class='sub'>시험응시&nbsp;&nbsp;<font style='font-weight: normal;'>[&nbsp;기간 :&nbsp;
			<%= rst.getExam_start().toString().substring(0,16) %> ~ <%= rst.getExam_end().toString().substring(0,16) %>
			&nbsp;]</font></div>
			
			<!---------- 시험과목 테이블 ----------->
			<table cellspacing="0" cellpadding="0" class="table" border='0'>
				<tr class="tt">
					<td>시험명</td>					
					<td>시험시간(분)</td>
					<td>시험응시</td>
					<td>답안제출여부</td>
				</tr>

			<%
		        String yn_end = "";
				String title, id_exam_type, exam_type;
		        long limitTime;
				Timestamp now = new Timestamp(System.currentTimeMillis());
		        Timestamp exam_start, exam_end;
				
    			  yn_end = User_QmTm.getYn_end(userid, id_exam);
		          if (yn_end == null) { yn_end = "N"; }
					  title = rst.getTitle();
			          id_exam_type = rst.getId_exam_type();
		          if (id_exam_type.equals("1")) { exam_type = "자유모의고사<br>반복응시가능"; }
				  else { exam_type = "&nbsp;"; }
			          limitTime = rst.getLimitTime();
			          exam_start = rst.getExam_start();
			          exam_end = rst.getExam_end();
	        %>
				<tr class="td">
					<td><%= title %></td>
					<td><%= limitTime / 60 %> 분</td>
					<td>
					 <% if (exam_end.before(now)) { %>
			            시험종료
					 <% } else if (id_exam_type.equals("1")) { %><!-- 자유모의고사, 응시회수 무제한 -->
			            <a href="javascript:frameofTest();"><img src="../images/bt2_start.gif" border="0" name="Image1"></a>
					 <% } else if (yn_end.equals("N")) { %>
			            <a href="javascript:frameofTest();"><img src="../images/bt2_start.gif" border="0" name="Image1"></a>
					 <% } else { %>
			            <img src="../images/bt2_end.gif" border="0" name="Image1">
					 <% } %>
					</td>
					<td><a href="javascript:checkwin();" onfocus="this.blur();"><img src="../images/bt2_ynsubmit.gif" border="0"></a></td>
				</tr>
					
			</table>

			<!---------------- 시험 소개---------------->
			<% 
				String guide = rst.getGuide();
				if(!guide.equals("")) {
			%>
			<br><br>
			<div class='sub'>시험소개</div>
			<div class='text'><%= guide %></div>
			<%
				}	
			%>

<%@ include file="../include/include_bottom.jsp" %>
