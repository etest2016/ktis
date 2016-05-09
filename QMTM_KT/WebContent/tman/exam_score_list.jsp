<%
//******************************************************************************
//   프로그램 : course_list.jsp
//   모 듈 명 : 과정아래 시험관리
//   설    명 : 시험관리 트리에서 과정 선택시 보여주는 페이지
//   테 이 블 : exam_m
//   자바파일 : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   작 성 일 : 2008-04-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.answer.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    String course_name = "";

    // 강의명 가지고오기
	try {
		course_name = ExamUtil.getCourseName(id_course);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// 과정 아래 시험정보 가지고오기
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getMarkBeans(id_course, "-1", userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

%>

<HTML>
 <HEAD>
  <TITLE> Tman Main </TITLE>
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="../js/tablesort.js"></script>

 <script language="JavaScript">

	function exam_score(id_exam) {
		window.open("answer/ans_mark.jsp?id_exam="+id_exam,"exam_score","width=950, height=640, scrollbars=yes");
    }

 </script>

 </HEAD>

 <BODY id="tman">
	<div id="main">

		<div id="mainTop">
			<div class="title"><font class="point_t_n">채점진행</font> 시험 목록 <span> 채점자로 배정된 시험 목록입니다.</span></div>
			<div class="location">시험관리 > <span><%=course_name%> </span>&nbsp;&nbsp;</div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" onclick="sortColumn(event)">
			<THEAD>
			<tr id="tr">
				<td>시험제목 ▲▼</td>
				<td>시험가능여부</td>
				<td>시험기간 ▲▼</td>
				<td>성적조회기간 ▲▼</td>
				<td>채점상태 ▲▼</td>
				<td>&nbsp;</td>
			</tr>
			</THEAD>
	<%
		if(rst == null) {
	%>
			<TBODY>
			<tr>
				<td class="blank" colspan="6">등록되어진 시험이 없습니다.</td>
			</tr>
			</TBODY>
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {

				ImsiAnswerMarkBean rst2 = null;

				try {
					rst2 = AnswerMark.getAllScoreInwon(rst[i].getId_exam());
				} catch(Exception ex) {
					out.println(ComLib.getExceptionMsg(ex, "close"));

					if(true) return;
				}
	%>
			<tr id="td" align="center">
				<td style="padding-left: 20px; text-align: left;"><%=rst[i].getTitle()%></td>
				<td><% if (rst[i].getYn_enable().equals("Y")){%><img src="../images/icon_y.gif"><%}else{%><img src="../images/icon_n.gif"><%}%></td>
				<td><%=rst[i].getExam_start1()%> 부터<br><%=rst[i].getExam_end1()%> 까지</td>
				<%if(rst[i].getYn_open_qa().equals("A")) { %>
				<td align="center">기간설정없음</td>
				<% } else { %>
				<td><%=rst[i].getStat_start()%> 부터<br><%=rst[i].getStat_end()%> 까지</td>
				<% } %>
				<td><font color=red><b>
				<% if(rst2.getAll_score() == 0) { // 미채점 상태 %>
					[미채점]
					<% 
						} else { 
							if(rst2.getNo_score() > 0 || (rst2.getAll_q() > rst2.getAll_score())) { 
					%>
					[채점진행중]
					<%		} else { %>
					[채점완료]
					<%
							}
						}
					%>
				</b></font></td>
				<td><input type="button" value="채점하기" class="form" onClick="exam_score('<%=rst[i].getId_exam()%>');"></td>
			</tr>
	<%
			}
		}
	%>
		</table>

	</div>
	<jsp:include page="../copyright.jsp"/>

 </BODY>
</HTML>