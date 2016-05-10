<%
//******************************************************************************
//   프로그램 : exam_list.jsp
//   모 듈 명 : 시험지 페이지
//   설    명 : 시험지 페이지
//   테 이 블 : exam_m
//   자바파일 : qmtm.tman.exam.ExamUtil
//   작 성 일 : 2008-04-17
//   작 성 자 : 이테스트 석준호
//   수 정 일 :
//   수 정 자 :
//	 수정사항 :
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String usergrade = (String)session.getAttribute("usergrade"); // 권한

	String exam_title = "";
	
	try {
		exam_title = ExamList.getExamTitle(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	int papercnt = 0;

	try {
		papercnt = ExamUtil.getPaperCnt(id_exam);
	}
	catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	String id_course = "";

	try {
		id_course = LoginProc.getId_course(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

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

	String userid = (String)session.getAttribute("userid");

	String pt_exam_edit = "";
	String pt_exam_delete = "";
	String pt_answer_edit = "";
	String pt_score_edit = "";
	String pt_static_edit = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getExam_work(id_course, userid, usergrade);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	pt_exam_edit = bean.getPt_exam_edit();
	pt_exam_delete = bean.getPt_exam_delete();
	pt_answer_edit = bean.getPt_answer_edit();
	pt_score_edit = bean.getPt_score_edit();
	pt_static_edit = bean.getPt_static_edit();

%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
	<script language="JavaScript">
	function exam_edits() {
		$.posterPopup("exam_edit.jsp?id_exam=<%=id_exam%>","edit","width=750, height=680, scrollbars=no, top="+(screen.height-640)/2+", left="+(screen.width-750)/2);
    }
	function paper_insert() {
		$.posterPopup("paper_index.jsp?id_exam=<%=id_exam%>","inserts","width=900, height=650, scrollbars=yes, top="+(screen.height-650)/2+", left="+(screen.width-900)/2);
	}

	function paper_view(nr_set) {
		$.posterPopup("paper_type.jsp?id_exam=<%=id_exam%>&nr_set="+nr_set,"paper_view","width=1000, height=700, scrollbars=yes, top="+(screen.height-700)/2+", left="+(screen.width-1000)/2);
	}

	function answer_view() {
		$.posterPopup("../answer/answer_main.jsp?id_exam=<%=id_exam%>&id_course=<%=id_course%>","answer_view","width=1200, height=750, scrollbars=yes, top="+(screen.height-750)/2+", left="+(screen.width-1200)/2);
	}
	
	function static_view() {
		$.posterPopup("../static/static_main.jsp?id_exam=<%=id_exam%>","static_view","fullscreen, scrollbars=yes, top=0, left=0");
	}

	function exam_preview() {
		$.posterPopup("web_preview.jsp?id_exam=<%=id_exam%>","web_preview","width=400, height=250, scrollbars=no, top="+(screen.height-250)/2+", left="+(screen.width-400)/2);
	}
	</script>

</head>

<BODY id="tman">

	<div id="main">

		<div id="mainTop">
			<div class="title">시험지 관리 <span>선택된 시험 편집 및 시험지 생성 그리고 응시자의 답안지를 관리합니다</span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../../images/icon_location.gif"> <%=course_name%> > <%=exam_title%></div>
		</div>

		<!--div style="margin-bottom: 7px;">
			<%if(pt_exam_edit.equals("Y")) { %><a href="javascript:exam_edits();"><% } %><img src="../../images/bt_examl_4.gif"></a>&nbsp;&nbsp;<%if(papercnt > 0) { %><a href="javascript:exam_preview();"><% } %><img src="../../images/bt_examl_5.gif"></a>&nbsp;&nbsp;<%if(pt_exam_edit.equals("Y")) { %><a href="javascript:paper_insert('<%=id_exam%>');"><% } %><img src="../../images/bt_examl_1.gif"></a>&nbsp;&nbsp;<%if(papercnt > 0) { %><%if(pt_answer_edit.equals("Y")) { %><a href="javascript:answer_view('<%=id_exam%>');"><% } %><% } %><img src="../../images/bt_examl_2.gif"></a>&nbsp;&nbsp;<%if(papercnt > 0) { %><%if(pt_static_edit.equals("Y")) { %><a href="javascript:static_view('<%=id_exam%>');"><% } %><% } %><img src="../../images/bt_examl_3.gif"></a>
		</div-->

		<div style="margin-bottom: 10px;"><!-----------------------------><%if(pt_exam_edit.equals("Y")) { %><a href="javascript:exam_edits();" onfocus="this.blur();"><% } %><img src="../../images/bt6_tman_1.gif"></a><!-----------------------------><%if(papercnt > 0) { %><a href="javascript:exam_preview();" onfocus="this.blur();"><img src="../../images/bt6_tman_2.gif"></a><% } else { %><a href="javascript:alert('시험지 생성후 이용하실 수 있습니다.');" onfocus="this.blur();"><img src="../../images/bt6_tman_2.gif"></a><%}%><!-----------------------------><%if(pt_exam_edit.equals("Y")) { %><a href="javascript:paper_insert('<%=id_exam%>');" onfocus="this.blur();"><% } %><img src="../../images/bt6_tman_3.gif"></a><!-----------------------------><%if(papercnt > 0) { %><%if(pt_answer_edit.equals("Y")) { %><a href="javascript:answer_view('<%=id_exam%>');" onfocus="this.blur();"><img src="../../images/bt6_tman_4.gif"></a><% } else { %><img src="../../images/bt6_tman_4.gif"><% } %><% } else { %><a href="javascript:alert('시험지 생성후 이용하실 수 있습니다.');" onfocus="this.blur();"><img src="../../images/bt6_tman_4.gif"></a><% } %><!-----------------------------><%if(papercnt > 0) { %><%if(pt_static_edit.equals("Y")) { %><a href="javascript:static_view('<%=id_exam%>');" onfocus="this.blur();"><img src="../../images/bt6_tman_5.gif"></a><% } else { %><img src="../../images/bt6_tman_5.gif"><% } %><% } else { %><a href="javascript:alert('시험지 생성후 이용하실 수 있습니다.');" onfocus="this.blur();"><img src="../../images/bt6_tman_5.gif"></a><% } %></div>

		<TABLE cellpadding="0" cellspacing="0" border="0" id="tableC" width="100%">
			<TR id="top">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
			<TR id="middle">
				<TD id="left"></TD>
				<TD id="center" height="180" valign="top">
				<% if(papercnt==0){%>

				<% }else{%>
					<table border="0" width="100%" cellpadding="0" align="center" cellspacing="0">
						<tr height="140">
							<% for(int i=1; i<=papercnt; i++) { %>
							<td width="10%" align="center" style="background-image: url(../../images/paper_bg.gif); background-repeat: no-repeat; padding-left: 3px; background-position: center;"><!--img src="../../images/icon_paper.gif"><br><div style="padding-top: 6px; "--><a href="javascript:paper_view(<%=i%>);"><FONT STYLE="COLOR: #0196dc; FONT: BOLD 19PT batang;"><%=i%></FONT></a></div></td>
							<% if(i % 8 == 0) { %>
						</tr>
						<tr height="140">
							<% } %>
							<% } %>
						</tr>
					</table>
				<% }%>
				</TD>
				<TD id="right"></TD>
			</TR>
			<TR id="bottom">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
		</TABLE>

	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</html>