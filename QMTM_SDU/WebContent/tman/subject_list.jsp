<%
//******************************************************************************
//   프로그램 : subject_list.jsp
//   모 듈 명 : 강좌아래 시험관리
//   설    명 : 시험관리 트리에서 강좌 선택시 보여주는 페이지
//   테 이 블 : exam_m, t_worker_subj, c_course, c_subject
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, 
//              qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil,
//              qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList
//   작 성 일 : 2013-02-12
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil,qmtm.LoginProcBean, qmtm.LoginProc, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	

	String id_subject = "-1";
	
	if (id_course.length() == 0 || id_subject.length() ==0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	String usergrade = (String)session.getAttribute("usergrade"); // 권한

	String course_name = "";

    // 과정명 가지고오기
	try {
		course_name = ExamUtil.getCourseName(id_course);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

    // 강좌 아래 시험정보 가지고오기
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getBeans(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	String pt_exam_edit = "";
	String pt_exam_delete = "";
	String pt_answer_edit = "";
	String pt_score_edit = "";
	String pt_static_edit = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getExam_work(id_course, userid, usergrade);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	pt_exam_edit = bean.getPt_exam_edit();
	pt_exam_delete = bean.getPt_exam_delete();
	pt_answer_edit = bean.getPt_answer_edit();
	pt_score_edit = bean.getPt_score_edit();
	pt_static_edit = bean.getPt_static_edit();
%>

<HTML>
 <HEAD>
  <TITLE> Tman Main </TITLE>
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="../js/jquery.js"></script>
  <script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../js/tablesort.js"></script>

  <script language="JavaScript">
	function insert() {
		$.posterPopup("exam/exam_write.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>","insert","width=750, height=680, scrollbars=no, top="+(screen.height-680)/2+", left="+(screen.width-750)/2);
    }

	function edits(id_exam) {
		$.posterPopup("exam/exam_edit.jsp?id_exam="+id_exam,"edit","width=750, height=680, scrollbars=no, top="+(screen.height-680)/2+", left="+(screen.width-750)/2);
    }

	function exam_copy() {
		$.posterPopup("exam/exam_copy.jsp?org_id_course=<%=id_course%>&org_id_subject=<%=id_subject%>","copys","width=650, height=550, scrollbars=yes, top="+(screen.height-550)/2+", left="+(screen.width-650)/2);
    }

	function exam_copy_edit() {
		$.posterPopup("exam/exam_copy_edit.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>","copys","width=650, height=450, scrollbars=yes, top="+(screen.height-450)/2+", left="+(screen.width-650)/2);
    }

	function exam_delete() {
		$.posterPopup("exam/exam_deletes.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>","deletes","width=650, height=450, scrollbars=yes, top="+(screen.height-450)/2+", left="+(screen.width-650)/2);
    }

	function cpt_edit() {
		$.posterPopup("subject/subject_view.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>","insert","width=400, height=250, scrollbars=no, top="+(screen.height-250)/2+", left="+(screen.width-400)/2);
    }
 </script>

 </HEAD>

 <BODY id="tman">

	<div id="main">

		<div id="mainTop">
			<div class="title">강좌 시험 리스트<span></span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../images/icon_location.gif"> <%=course_name%></div>
		</div>
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" >
			<tr id="bt"><td align="left"><%if(pt_exam_edit.equals("Y")) { %><img src="../images/bt_subj_list_1.gif" onclick="javascript:insert();" style="cursor: pointer;"><% }else { %><img src="../images/bt_subj_list_1.gif"><% } %><%if(pt_exam_edit.equals("Y")) { %><img src="../images/bt_subj_list_2.gif" onclick="javascript:exam_copy();" style="cursor: pointer; margin-left: 5px;"><% } else { %><img src="../images/bt_subj_list_2.gif" style="margin-left: 5px;"><% } %></td>
			</tr>
		</table>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" onclick="sortColumn(event)">
			<THEAD>
			
			<tr id="tr">
				<td>시험제목 ▲▼</td>
				<td>시험가능여부</td>
				<td>시험기간 ▲▼</td>
				<td>성적조회기간 ▲▼</td>
				<td>&nbsp;</td>
			</tr>
			</THEAD>
	<%
		if(rst == null) {
	%>
			<TBODY>
			<tr>
				<td class="blank" colspan="5">등록되어진 시험이 없습니다.</td>
			</tr>
			</TBODY>
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {

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
				<td><%if(pt_exam_edit.equals("Y")) { %><a href="javascript:edits('<%=rst[i].getId_exam()%>');" onfocus="this.blur();"><% } %><img src="../images/bt3_exam_edit.gif"></a>&nbsp;<a href="exam/exam_list.jsp?id_exam=<%=rst[i].getId_exam()%>" onfocus="this.blur();"><img src="../images/bt3_exam_info.gif"></a></td>
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