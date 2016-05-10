<%@page contentType="text/html; charset=EUC-KR" errorPage="../errorAll.jsp" %>
<%@page import="qmtm.*, etest.scorehelp.*, java.sql.*"%>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	//String userid =	get_cookie(request, "userid");
	////////////////////////////////////////////////
	String userid = request.getParameter("userid");
	String id_course = request.getParameter("id_course");
	String workerid = "";
	////////////////////////////////////////////////

	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }
	if (userid == "") {
	  throw new QmTmException("[exam_list.jsp] 로긴후에 사용하세요");
	}
%>
<%
	Score_ExamListBean[] rst;
	try {
	  rst = Score_ExamList.getBeans(id_course);
	}
	catch (Exception ex) {
	  throw new QmTmException("[서버접속 실패]@prev@db");
	}

	try {
	  workerid = Score_ExamList.getWorkerid(userid, id_course);
	}
	catch (Exception ex) {
	  throw new QmTmException("[서버접속 실패]@prev@db");
	}
%>

<html>
<head>
<title>단답형 및 논술형 웹채점</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
<script language="javascript">
	function ftnCourse() {
		document.frmdata.action = "./exam_list.jsp";
		document.frmdata.submit();
	}

	function p_score_win(id_exam) {
		$.posterPopup("./m_frame.jsp?id_exam="+id_exam, "p_scorewin", "menubar=no, scrollbars=yes, width=1000, height=700, fullscreen");
	}
	
	function ftnExam() {
		var frm = document.frmdata;
		
		document.frmdata.action = "exam_list.jsp";
		document.frmdata.submit();
	}	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">
</HEAD>

<BODY oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">
<TABLE cellpadding="0" cellspacing="0" border="0" class="Layout">
	<TR>
		<!-- 좌측 배경 -->
		<TD class="Left" rowspan="2">&nbsp;</TD>
		<!-- 본문 상단 타이틀 및 현재 위치 표시 -->
		<TD class="CenterTop">
			<div id="L">
			<img src="../images/title_ad_web.gif">
			</div>
		</TD>
		<TD class="Right" rowspan="2">&nbsp;</TD>
	</TR>
	<TR>		
		<TD class="CenterMain">
		<!-- 본문 시작 -->
		<form name="frmdata" method="post">

			<table border="0" cellspacing="0" cellpadding="0" class="Btype" style="margin-top: 10px;"> 
				<tr class="title"> 
					<td id="Tleft">평가명</td>
					<td>평가일정</td>
					<td>단답형 문제</td>
					<td>논술형 문제</td>
					<td>문제별 채점</td>
					<td>응시자별 채점<%= workerid %></td>
				</tr>	
			<% 
				if (rst == null) { 
			%>
				<tr class='blank'>
					<td colspan="6">채점할 시험이 없습니다.</td>
				</tr>
			<% 
				} else { 
					for (int i = 0; i < rst.length; i++) {
			%>

					<tr> 
						<td id="Tleft"><%= rst[i].getTitle() %></td>
						<td><%= rst[i].getExam_start() %> ~ <%= rst[i].getExam_end() %></td>
						<td><B><%= rst[i].getNums1() %></B> 문제</td>
						<td><B><%= rst[i].getNums2() %></B> 문제</td>
						<td><img src="../images/bt3_mark.gif" onclick="location.href('./exam_score_list.jsp?id_exam=<%= rst[i].getId_exam() %>');" class="link"></td>
						<td><img src="../images/bt3_mark.gif" class="link" onclick="javascript:p_score_win('<%= rst[i].getId_exam() %>')"></td>
					</tr>				
			<%
					}
				}
			%>
			</table>

			<TABLE class="Etype" cellpadding="0" cellspacing="0" border="0"> 
				<TR>
					<TD>
						<li>단답형 또는 논술형 문제가 출제되지 않은 평가는 웹 채점 관리 메뉴의 평가 목록에서 확인할 수 없습니다.</li>
						<li>문제별 채점은 해당 평가에 출제된 문제를 배정 받은 응시자 중 오답자들의 답안에 점수를 부여하는 방식입니다.</li>
						<li>응시자별 채점은 해당 평가의 응시자들 개개인의 단답형 혹은 논술형 문제의 답안을 개별 채점하는 방식입니다.</li>
					</TD>
				</TR>
				<TR>
					<TD id="bt"></TD>
				</TR>
			</TABLE>
			</form>
		</TD>
	</TR>
	<!-- 하단 카피라이트 -->

</TABLE>

</BODY>
</HTML>
